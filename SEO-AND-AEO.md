# SEO and AEO playbook for the Flourish website

**If you are an AI assistant: read this before you create a new page or rewrite an existing one.**
`START-HERE.md` covers the technical checklist for a new page (canonical, sitemap, redirect). This
file covers the rest: how a page gets found by Google (SEO) and how it gets quoted by AI answer tools
such as ChatGPT, Google's AI Overviews and Perplexity (AEO, "answer engine optimization").

These rules come from research Kevin and Claude did on this site in September and October 2026: an
audit of every page, Search Console data, and a teardown of the eight Orlando and Winter Park
practices that outrank Flourish. Each rule says why, so you can apply the reasoning to cases this
file does not list.

The short version: **say plainly what the page is about, answer the questions people actually ask,
and tell search engines who Cristina is in a format they can read.** Warmth stays. It goes in the
second line, not instead of the first.

---

## 1. Titles, headings and descriptions

- **Title: topic first, place second, brand last.** `EMDR Therapy in Winter Park, FL | Flourish
  Counseling Co.` Keep it under about 60 characters. Every competitor that outranks Flourish does
  this; brand-first titles were one of the reasons the site was invisible for non-brand searches.
- **Exactly one `<h1>` per page, and it carries the plain search phrase** a person would type
  ("Podcasts on healing and sexuality", "Grief counseling in Winter Park"). Put the warm, poetic line
  directly underneath as the subtitle or first `<h2>`. A lovely H1 such as "Room to listen." reads
  well but tells Google nothing. The homepage once had no H1 at all.
- **Meta description: 140 to 160 characters**, plain sentences: what the page offers, for whom,
  where, and the next step. It is the snippet people read in search results.
- **Use real heading and list tags.** Sub-sections are `<h2>` and `<h3>`, lists are `<ul>`/`<li>`.
  When the old blog was migrated, headings and lists were flattened into paragraphs, which made the
  posts unreadable to search engines. Never build a heading out of a styled `<p>`.
- **No long dashes** (the em dash or en dash) anywhere in page copy. Use a comma, a colon, or
  parentheses.

## 2. Writing for AI answers (AEO)

AI tools quote pages that answer a question directly, in a sentence or two they can lift whole.

- **Phrase section headings as the real questions people ask.** "What is EMDR?", "Is online
  therapy available in Florida?", "How much does a session cost?"
- **Answer in the first one or two sentences under each heading**, then add detail. The first
  sentence should make sense on its own, quoted out of context.
- **Add a short FAQ block (three to six questions) to every service page and resource page**, with
  matching `FAQPage` structured data (section 3). Pull questions from what clients ask and from
  Search Console queries when available.
- **Be specific and checkable.** Name the city (Winter Park, Orlando), whether telehealth is
  offered, who the service is for, and link to `/rates` rather than restating a price. Vague pages
  are not quoted.
- **Never make outcome claims.** No "proven", "guaranteed", "cure", success rates, or testimonials.
  These are professional-ethics rules for a counselor, not style choices, and AI tools favor
  measured, factual sources anyway.

## 3. Structured data (JSON-LD)

Structured data is a block of machine-readable facts in the page's `<head>`. Google and AI tools use
it to understand that the page, Cristina, the practice, and her profiles elsewhere are one entity.
Most of the site had none until October 2026, while every top competitor had it.

**Do not write it from scratch.** Copy the block from the closest existing page and adapt it. The
specialty pages in `services/` (for example `services/emdr.html`) carry the most complete version:
`ProfessionalService`, `Person` with credentials, `Service`, `FAQPage` and `BreadcrumbList`.

| Page type | Structured data to include |
|---|---|
| Service page | `ProfessionalService` (provider), `Service`, `FAQPage`, `BreadcrumbList` |
| Blog article | `Article` with `author` (Person), `datePublished`, `dateModified`; plus `FAQPage` if it has a Q&A section |
| Podcast page | `PodcastSeries` per show (plus `PodcastEpisode` if episodes are listed), `BreadcrumbList` |
| Events page | `Event` for each event shown, `BreadcrumbList` |
| FAQ page | `FAQPage` |

Rules that apply to all of it:

- **Every question and answer in `FAQPage` must match the visible text on the page word for word.**
  Google treats hidden or mismatched FAQ markup as spam.
- **Credentials, services, address and phone come from the live pages, never from memory.** Read
  credentials from `about.html` and `team.html`, and the address and phone from the existing schema
  on `index.html`, so the name, address and phone match everywhere exactly.
- **Use `sameAs` to connect profiles** (Psychology Today, TherapyDen, Google Business Profile,
  Spotify, Instagram). That is how search engines learn these all belong to the same practice.
- **Articles show a real date.** A visible "Published" date plus `datePublished` set to the original
  publication date, never today's date for an old post, and `dateModified` when it changes.
- **Check that it parses before publishing.** Copy each JSON-LD block into a file and run
  `python3 -m json.tool file.json`. One stray comma silently disables the whole block. After
  publishing, Google's Rich Results Test (search.google.com/test/rich-results) confirms Google can
  read it.

## 4. Links and images

- **Every new page links to two or three related pages inside its body text**, and at least one
  existing page links to it (beyond the navigation). Blog posts link to the matching service page
  and to `/contact` or `/rates`. When the audit ran, no post linked to any service page, so the blog
  passed no visitors to anything that leads to booking.
- **Link text describes the destination** ("our EMDR page", not "click here").
- **Use clean outbound links.** Strip tracking junk such as `utm_source=...` or `request_id=...` from
  links copied out of an app or a chat assistant.
- **Every image has `alt` text** that describes it in plain words, plus `width` and `height`
  attributes. Compress photos before adding them.

## 5. Copy rules that protect the practice

- **Never use the words "free", "no charge" or "complimentary"** for a consultation or anything
  else. Under Florida law (section 456.062) those words require a special legal notice on the page.
  Say "consultation" or "10-minute consultation" instead.
- **No testimonials, client reviews or outcome stories** on the site, and never ask clients for
  reviews. Counseling ethics codes prohibit it.
- **Never mention play therapy.** Cristina is not a play therapist.
- **Nothing about any client, ever**, in a page, a file or a commit message. The repository is public.

## 6. After a new page goes live

1. Ask Crissy to request indexing in Search Console (URL Inspection, then "Request indexing"). On
   this site, requested pages were indexed within a day; pages left alone waited weeks.
2. Tell Bing and other IndexNow search engines about it (no login needed):
   `curl "https://api.indexnow.org/indexnow?url=https://flourish-counseling.co/PAGE&key=998b6356533da8393162a64f31671d20"`
   The key file `998b6356533da8393162a64f31671d20.txt` at the top of this folder must stay there.

## Quick checklist for any new or rewritten page

- [ ] Title: topic, place, brand; under about 60 characters
- [ ] One H1 with the plain search phrase; warm line underneath
- [ ] Meta description, 140 to 160 characters
- [ ] Question-style headings, each answered in its first sentence or two
- [ ] FAQ block with matching `FAQPage` JSON-LD (service and resource pages)
- [ ] JSON-LD copied from an existing page, adapted, and parses cleanly
- [ ] Two or three in-body links out, and at least one existing page links in
- [ ] Alt text on every image; clean outbound links
- [ ] No "free", no outcome claims, no testimonials, no long dashes
- [ ] The `START-HERE.md` new-page checklist (canonical, sitemap, redirect, the three footer scripts)
