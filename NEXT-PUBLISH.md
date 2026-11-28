# Next publish (one deploy for everything below)

This branch collects every site change waiting for the next publish, so the site deploys once
(Netlify builds only `main`; this branch costs no deploy credits). Nothing here is live.

## What is in it

*Sun 11/22's batch published (commit 0505d5c). Fri 11/27: the Episode 3 guide wording fix and the
publish checker fix were folded into `main` (commit 6ae90e8, not live yet); they go out with the
next publish from `main`. The list starts fresh below.*

Nothing waiting.

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
