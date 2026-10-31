# Podcast audience updates for review

Website changes are on `codex/podcast-audience-updates`. They are not approved for production.

## Review without a Netlify deploy

Follow the "Working on a branch" section of `START-HERE.md`, merged from `origin/main` on October 31, 2026.

- All review commits include `[skip ci]`. Push only `codex/podcast-audience-updates`.
- Never open a pull request, because the repository instructions say Netlify Deploy Previews cost credits.
- Preview locally. No production merge or deploy is authorized.
- When Crissy approves publication, update `main`, squash-merge the review branch without committing, check `.deploy/budget.sh`, report the remaining publishes/reset date, and agree before running `.deploy/deploy.sh` with a release description that does not contain `[skip ci]`.
- Keep the branch as the review history. Delete it only if Kevin asks.

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

Kevin added the missing guidance to `SEO-AND-AEO.md` and `START-HERE.md` on main. Both files have now been read in full and merged into this review branch. The approved H1 and subtitle below have been applied. Other proposed copy changes remain recommendations.

### Changes recommended against SEO-AND-AEO.md

1. **Completed after approval:** H1 is **Podcasts exploring mental health and authentic sexuality**, followed by **Cozy, comfortable, authentic conversations.** This replaces the poetic-only H1 with a plain topic phrase and retains the approved warm tone.
2. Reorder the title to topic, place, brand, for example **Podcasts | Winter Park, FL | Flourish Counseling Co.** The existing title puts the brand before the place.
3. Expand the current 135-character description to 140 to 160 characters, naming the audience/topic, host/location and next action. Suggested draft: **Explore mental health and sexuality podcasts with Cristina Ally in Winter Park, Florida. Listen to The Art of Flourishing and subscribe for new show updates.**
4. Add two or three useful in-body links to relevant existing pages, such as Cristina's About page, educational Resources, and Contact for practice information. Current internal body links only jump to signup. Add one contextual incoming link from an existing page, such as About or the homepage. Navigation/footer links alone do not meet the playbook.
5. Add a small, optional three-question accordion answering where to listen, which shows are live, and how to submit a question. A podcast page is not explicitly required to have the service/resource FAQ block, but direct answers would help here. If added, FAQPage JSON-LD must match the visible questions and answers word for word.

Already passing: canonical and Open Graph URL, sitemap/redirect, descriptive image alt text and dimensions, clean outbound links, PodcastSeries data for every show, BreadcrumbList, parsable JSON-LD, no invented episodes or dates, and preserved protected scripts. Do not add PodcastEpisode records until actual episodes are listed in page content. Keep listener feedback about podcast content separate from counseling reviews or treatment-outcome testimonials.

After an approved release, use the playbook's Search Console and IndexNow steps. Those steps have not been run for this unpublished batch.

Sources:
- https://developers.google.com/search/docs/fundamentals/ai-optimization-guide
- https://schema.org/PodcastSeries

## Google Form behavior

The form is managed separately from Git. Its branding and confirmation changes are saved in Google Forms immediately; a website branch does not stage Google Forms or Kit changes.

Header composition uses the existing unchanged wordmark, cream/blush accents and an original vector layout. `assets/brand/podcast-listener-header.svg` is the editable source, and its PNG render is the uploaded 1600 by 400 header. Fraunces is used for the form heading, with espresso as the native accent. Google Forms limits the remaining body font and background choices.

The form shows an on-screen confirmation, not an automatic email. The confirmation names the Flourish podcast team, explains that features and replies are not guaranteed, gives `podcast@flourish-counseling.co` for questions about submissions, and links to podcast updates.

Automatic response receipts remain off. Native Google Forms does not offer a custom From/Reply-To setting for submissions. A branded automatic email from the podcast address would need a separate verified email workflow. Form ownership remains the account Crissy selected; no ownership or mailbox permissions were changed.
