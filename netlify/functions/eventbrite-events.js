const API_ROOT = 'https://www.eventbriteapi.com/v3';
const ORGANIZER_ID = '27704105675';
const CACHE_MS = 5 * 60 * 1000;

let memoryCache = { expires: 0, payload: null };

function response(statusCode, body) {
  return {
    statusCode,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Cache-Control': statusCode === 200 ? 'public, max-age=60' : 'no-store',
      'Netlify-CDN-Cache-Control': statusCode === 200
        ? 'public, s-maxage=300, stale-while-revalidate=3600'
        : 'no-store',
      'X-Content-Type-Options': 'nosniff'
    },
    body: JSON.stringify(body)
  };
}

function textFromHtml(value) {
  return String(value || '')
    .replace(/<script[\s\S]*?<\/script>/gi, ' ')
    .replace(/<style[\s\S]*?<\/style>/gi, ' ')
    .replace(/<[^>]+>/g, ' ')
    .replace(/&nbsp;/gi, ' ')
    .replace(/&amp;/gi, '&')
    .replace(/&quot;/gi, '"')
    .replace(/&#39;|&apos;/gi, "'")
    .replace(/&lt;/gi, '<')
    .replace(/&gt;/gi, '>')
    .replace(/\s+/g, ' ')
    .trim();
}

function publicEvent(event, description) {
  const availability = event.ticket_availability || {};
  const venue = event.venue || null;
  const minimumPrice = availability.minimum_ticket_price || {};
  return {
    id: String(event.id || ''),
    name: event.name && event.name.text ? event.name.text : '',
    summary: event.summary || (event.description && event.description.text) || '',
    description: textFromHtml(description || ''),
    url: event.url || '',
    start: event.start || null,
    end: event.end || null,
    timezone: event.start && event.start.timezone ? event.start.timezone : 'America/New_York',
    online: Boolean(event.online_event),
    venue: venue ? {
      name: venue.name || '',
      address: venue.address && venue.address.localized_address_display
        ? venue.address.localized_address_display
        : ''
    } : null,
    image: event.logo && event.logo.original && event.logo.original.url
      ? event.logo.original.url
      : (event.logo && event.logo.url ? event.logo.url : ''),
    free: Boolean(event.is_free),
    price: minimumPrice.display || '',
    soldOut: Boolean(availability.is_sold_out),
    available: availability.has_available_tickets !== false,
    status: event.status || ''
  };
}

async function api(path, token) {
  const result = await fetch(API_ROOT + path, {
    headers: {
      Authorization: `Bearer ${token}`,
      Accept: 'application/json'
    }
  });
  if (!result.ok) {
    const message = await result.text();
    throw new Error(`Eventbrite request failed (${result.status}): ${message.slice(0, 240)}`);
  }
  return result.json();
}

async function listOrganizationEvents(organizationId, token) {
  const params = new URLSearchParams({
    status: 'live',
    time_filter: 'current_future',
    organizer_filter: ORGANIZER_ID,
    order_by: 'start_asc',
    page_size: '50',
    expand: 'organizer,venue,ticket_availability'
  });
  let path = `/organizations/${encodeURIComponent(organizationId)}/events/?${params}`;
  const events = [];

  for (let page = 0; page < 4 && path; page += 1) {
    const data = await api(path, token);
    events.push(...(data.events || []));
    const pagination = data.pagination || {};
    if (!pagination.has_more_items || !pagination.continuation) break;
    params.set('continuation', pagination.continuation);
    path = `/organizations/${encodeURIComponent(organizationId)}/events/?${params}`;
  }
  return events;
}

exports.handler = async function handler(event) {
  if (event.httpMethod !== 'GET') return response(405, { error: 'Method not allowed' });

  const token = process.env.EVENTBRITE_PRIVATE_TOKEN;
  if (!token) return response(503, { error: 'Event service is not configured' });

  if (memoryCache.payload && Date.now() < memoryCache.expires) {
    return response(200, memoryCache.payload);
  }

  try {
    const organizationData = await api('/users/me/organizations/', token);
    const organizations = organizationData.organizations || [];
    const eventLists = await Promise.all(
      organizations.map((organization) => listOrganizationEvents(organization.id, token))
    );

    const uniqueEvents = Array.from(
      new Map(eventLists.flat().map((item) => [String(item.id), item])).values()
    ).filter((item) => String(item.organizer_id || (item.organizer && item.organizer.id) || '') === ORGANIZER_ID);

    const now = Date.now();
    const upcoming = uniqueEvents
      .filter((item) => item.status === 'live' && item.end && Date.parse(item.end.utc) >= now)
      .sort((a, b) => Date.parse(a.start.utc) - Date.parse(b.start.utc));

    const descriptions = await Promise.all(upcoming.map(async (item) => {
      try {
        const data = await api(`/events/${encodeURIComponent(item.id)}/description/`, token);
        return data.description || '';
      } catch (_) {
        return item.description && item.description.html ? item.description.html : '';
      }
    }));

    const payload = {
      organizerId: ORGANIZER_ID,
      syncedAt: new Date().toISOString(),
      events: upcoming.map((item, index) => publicEvent(item, descriptions[index]))
    };
    memoryCache = { expires: Date.now() + CACHE_MS, payload };
    return response(200, payload);
  } catch (error) {
    console.error('Eventbrite sync failed:', error.message);
    return response(502, { error: 'Upcoming events are temporarily unavailable' });
  }
};
