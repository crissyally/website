# Next publish (one deploy for everything below)

This branch collects every site change waiting for the next publish, so the site deploys once
(Netlify builds only `main`; this branch costs no deploy credits). Nothing here is live.

## What is in it

*Published Sun 11/22 (commit 0505d5c): the EMDR search fix, the Sexology Explained listener guides,
and Batch A (footer services, blog links, titles, search data). The list starts fresh below.*

1. **Publish checker fix** (Sun 11/22): `.deploy/verify-live.sh` built the wrong address for pages in
   a folder (`services/sand-tray.html` became `/sand-tray`), so after every publish it falsely reported
   service pages as "not updated yet". It now keeps the folder and follows redirects. Tested against
   the 11/22 publish: every page confirmed live. Tooling only; visitors see no change.
   File: `.deploy/verify-live.sh`.
2. **Episode 3 listener's guide wording** (Mon 11/23): the timeline no longer says DSM-5 "merges"
   women's desire and arousal (the DSM-5 authors call that a misconception); it now says the manual
   replaced both diagnoses with one new diagnosis. Same layout, same pages. The episode audio is
   unchanged (already on Spotify). File: `assets/podcasts/guides/sexology-explained-03-guide.pdf`.

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
