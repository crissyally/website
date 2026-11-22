# Next publish (one deploy for everything below)

This branch collects every site change waiting for the next publish, so the site deploys once
(Netlify builds only `main`; this branch costs no deploy credits). Nothing here is live.

## What is in it

1. **EMDR page, search fix** (MoCo's Pixel, Sun 11/22): "EMDR therapy in Winter Park, FL" becomes the
   page's main heading and "EMDR Therapist in Winter Park, FL" its title, so the page can rank for the
   search people use (it sits around page 7 today). The about page links "EMDR" to the EMDR page.
   No new claims or credentials; her words otherwise unchanged. Files: `services/emdr.html`, `about.html`.
2. **Sexology Explained listener guides** (Sun 11/22): the three free listener's guide PDFs, one per
   episode, at `/assets/podcasts/guides/sexology-explained-01-guide.pdf` (and `-02-`, `-03-`), plus a
   "Free listener's guides" box on the Sexology Explained card linking all three. sexologyexplained.com
   forwards to this page, and every episode's closing sends listeners there, so this must be live before
   the episodes go out on Tue 12/01. The card keeps "Coming to Spotify" until Crissy has the show's
   Spotify link (the "Listen on Spotify" button gets added here then). Files: `podcasts.html`,
   `assets/podcasts/guides/` (3 PDFs).
3. **Footer services column** (MoCo's Pixel, Sun 11/22): every page's footer lists the six service
   pages by name, so visitors and Google can reach them from anywhere on the site. Files: every page.
4. ~~**Homepage service cards** (MoCo's Pixel, Sun 11/22): the six service cards from the services page,~~ *(dropped Sun 11/22 by Kevin: visual change to her homepage; the footer covers the links)*
   same wording, now also sit under "Care shaped to where you are." on the homepage, each linking to its
   page. Files: `index.html`.
5. **Blog posts link their service page** (MoCo's Pixel, Sun 11/22): five posts link words already in
   them to the matching page (C-PTSD and healing after trauma to trauma recovery, grief or depression to
   grief counseling, abusive relationship to trauma therapy for women, somatic to EMDR). No sentences
   added. Files: those five `post-*.html`.
6. **Page titles** (MoCo's Pixel, Sun 11/22): browser tab and search result titles now start with the
   topic, then the place, then the practice name, and the long dashes are gone. "Women's Counseling"
   stays on the homepage. Files: 18 pages (titles only).
7. **Google Maps and podcast in the homepage's search data** (MoCo's Pixel, Sun 11/22): the hidden
   practice details that search engines read now include her Google Maps listing and The Art of
   Flourishing on Spotify, so Google can tie them to the practice. Nothing visible changes. Files:
   `index.html`.

## How to add a change

Commit on `drafts/next-publish` (pull first). Keep each change its own commit with a plain message,
and add one line to the list above.

## How Crissy reviews it (for her Codex)

Read this whole file first. Then, one change at a time, unhurried (she may be between clients; it is fine
to stop after any change and pick up later):

1. Show her the before and after in plain words (`git diff main..drafts/next-publish -- <file>`): what a
   visitor will see differently, and why it helps people find her.
2. Ask: keep it, change the wording, or drop it. Her words and her facts only.
3. Commit any edit she wants on this branch, message ending `[skip ci]`, and push this branch.

Never publish, merge into `main`, open a pull request, or deploy from this branch. When she is done,
tell her Claude and Kevin will publish everything together in one deploy.
