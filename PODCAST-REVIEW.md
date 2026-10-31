# Podcast audience updates for review

Website changes are on `codex/podcast-audience-updates`. They are not approved for production.

## Review without a Netlify deploy

- Commit review work with `[skip ci]` in every pushed commit message. Netlify documents this marker as preventing branch and production deploys for those commits.
- Push only this review branch. Do not push or merge into `main` until Crissy approves publishing and the deploy budget has been checked.
- Preview locally with `python3 -m http.server 8765 --bind 127.0.0.1`.
- No pull request was opened as part of this branch setup, avoiding an automatic Deploy Preview.
- For release, follow `AGENTS.md` and `START-HERE.md`: check `.deploy/budget.sh`, report the remaining publishes and reset date, agree on publication, then use the documented deployment workflow. A GitHub merge can trigger production, so treat merging as a publishing step. Review-only skip markers must not accidentally suppress the eventual approved production release.
- Official Netlify source: https://docs.netlify.com/deploy/manage-deploys/manage-deploys-overview/

## Podcast page changes

All three show covers, softer buttons, Instagram links, per-show signup anchors, Kit first name and interest choices, and a listener question/story form link are included. Shared footer social links and the Contact social section are included.

Sex on the Couch uses `https://www.instagram.com/sexonthecouchpodcast/`.

The `#podcast-updates` anchor now belongs to the actual Kit form wrapper. Phone (390 by 844) and desktop (1280 by 900) clicks landed the form about 110 pixels from the top, clear of the sticky header. The corresponding interest remained selected. No horizontal overflow was observed.

## SEO and answer-engine review

Checked on this podcast page, not a claim about a complete site-wide audit:

- Unique title and description; clean canonical URL and matching Open Graph URL.
- Social preview metadata and descriptive image alt text.
- One H1, descriptive show headings, crawlable HTML descriptions and links.
- Existing sitemap entry, forced `.html` redirect, and crawlable robots settings retained.
- Breadcrumb structured data retained. CollectionPage, ItemList and PodcastSeries data added, matching the visible show names, artwork, status and links. Only the live show has a listening URL and RSS feed. Upcoming shows have no invented episodes or dates.
- JSON parses, and the three show fragment targets exist.
- Mobile form navigation and responsive layout tested.

This is a sound technical foundation. Search ranking, indexing, rich results and AI citations are not guaranteed. The next content improvement after launch would be substantive episode notes and accurate transcripts, rather than more decorative content on this page.

The referenced vault notes were not available in the local memory files searched during this session. This review uses the repository rules and current official guidance, not an assumed vault checklist.

Sources:
- https://developers.google.com/search/docs/fundamentals/ai-optimization-guide
- https://schema.org/PodcastSeries

## Google Form behavior

The form is managed separately from Git. Its branding and confirmation changes are saved in Google Forms immediately; a website branch does not stage Google Forms or Kit changes.

Header composition uses the existing unchanged wordmark, cream/blush accents and an original vector layout. `assets/brand/podcast-listener-header.svg` is the editable source, and its PNG render is the uploaded 1600 by 400 header. Fraunces is used for the form heading, with espresso as the native accent. Google Forms limits the remaining body font and background choices.

The form shows an on-screen confirmation, not an automatic email. The confirmation names the Flourish podcast team, explains that features and replies are not guaranteed, gives `podcast@flourish-counseling.co` for questions about submissions, and links to podcast updates.

Automatic response receipts remain off. Native Google Forms does not offer a custom From/Reply-To setting for submissions. A branded automatic email from the podcast address would need a separate verified email workflow. Form ownership remains the account Crissy selected; no ownership or mailbox permissions were changed.
