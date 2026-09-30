process.env.EVENTBRITE_PRIVATE_TOKEN = 'dummy-test-token';

const calls = [];

global.fetch = async function fetchMock(url, options) {
  calls.push({ url, authorization: options.headers.Authorization });

  let payload;
  if (url.endsWith('/users/me/organizations/')) {
    payload = { organizations: [{ id: 'org-test' }] };
  } else if (url.includes('/organizations/org-test/events/')) {
    payload = {
      events: [{
        id: 'evt-1',
        status: 'live',
        organizer_id: '27704105675',
        name: { text: 'Test Event' },
        summary: 'Summary',
        url: 'https://www.eventbrite.com/e/test',
        start: { utc: '2099-10-17T14:00:00Z', timezone: 'America/New_York' },
        end: { utc: '2099-10-17T16:00:00Z', timezone: 'America/New_York' },
        online_event: true,
        is_free: true,
        ticket_availability: { has_available_tickets: true, is_sold_out: false }
      }],
      pagination: { has_more_items: false }
    };
  } else if (url.includes('/events/evt-1/description/')) {
    payload = { description: '<p>Full &amp; safe description</p>' };
  } else {
    throw new Error(`Unexpected URL: ${url}`);
  }

  return {
    ok: true,
    status: 200,
    json: async () => payload,
    text: async () => JSON.stringify(payload)
  };
};

const { handler } = require('../netlify/functions/eventbrite-events.js');

handler({ httpMethod: 'GET' }).then((result) => {
  const body = JSON.parse(result.body);
  if (result.statusCode !== 200) throw new Error('Unexpected response status');
  if (body.events.length !== 1 || body.events[0].name !== 'Test Event') {
    throw new Error('Event mapping failed');
  }
  if (body.events[0].description !== 'Full & safe description') {
    throw new Error('Description sanitizing failed');
  }
  if (calls.some((call) => call.authorization !== 'Bearer dummy-test-token')) {
    throw new Error('Authorization header was not applied');
  }
  if (result.body.includes('dummy-test-token')) throw new Error('Token leaked into response');
  console.log(`Mock Eventbrite sync test passed (${calls.length} API calls).`);
}).catch((error) => {
  console.error(error);
  process.exit(1);
});
