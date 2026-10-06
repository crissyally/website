# Draft specialty pages (for Crissy and her assistant)

**Status: drafts only. Nothing here is live.** This is a separate branch called
`drafts/specialty-pages`. The live site only changes when these pages are merged into `main` and
published with `.deploy/deploy.sh`, and that happens only when Crissy is happy with them.

## What's here

Seven pages, one per service, so Google and AI assistants (ChatGPT, Claude, Gemini, Perplexity) have a
page to show when someone searches for that service in Winter Park:

| File | Becomes |
|---|---|
| `services/emdr.html` | /services/emdr |
| `services/trauma-recovery.html` | /services/trauma-recovery |
| `services/individual-therapy.html` | /services/individual-therapy |
| `services/grief-counseling.html` | /services/grief-counseling |
| `services/sand-tray.html` | /services/sand-tray |
| `services/recovery-groups.html` | /services/recovery-groups (held back unless a group is running or forming) |
| `services/christian-counseling.html` | /services/christian-counseling (only if Crissy wants it) |
| `services.html` | /services, rewritten as a menu that links to the seven pages |

`drafts-notes/` holds the questions (`PRE-PUBLISH-QUESTIONS.md`, and the same thing as a readable page,
`questions-for-crissy.html`) and the redirect and sitemap lines to add when publishing.

## For Crissy

1. Read each page and change anything that doesn't sound like you. Your words beat ours every time.
2. Answer the questions in `drafts-notes/PRE-PUBLISH-QUESTIONS.md`, section A. A few are about how you
   practice (sand tray, groups, the Christian counseling page), so only you can answer them.
3. When you're happy, ask your assistant to publish them.

## For the assistant helping her

Read `START-HERE.md` first; every rule there still applies (one publish per session, check the budget,
publish only with `.deploy/deploy.sh`).

These drafts were built on 2026-09-11, before later site changes. Before publishing:

1. **Match the current header and footer** from `index.html`: the menu now has an **Events** link, and the
   footer links changed. Copy them across exactly; keep the Psychology Today verification seal block.
2. **Match the current structured data pattern** (each page's `<script type="application/ld+json">`), as on
   `about.html` and `index.html`.
3. **Consult wording:** the free phone consult is **10 minutes** ("Initial Phone Consultation - No
   Charge"). Use 10 minutes everywhere. If a page offers the consult as free or no-charge, Florida
   statute 456.062 requires this exact notice in capital letters, set apart from the text:
   THE PATIENT AND ANY OTHER PERSON RESPONSIBLE FOR PAYMENT HAS A RIGHT TO REFUSE TO PAY, CANCEL PAYMENT, OR
   BE REIMBURSED FOR PAYMENT FOR ANY OTHER SERVICE, EXAMINATION, OR TREATMENT THAT IS PERFORMED AS A RESULT
   OF AND WITHIN 72 HOURS OF RESPONDING TO THE ADVERTISEMENT FOR THE FREE, DISCOUNTED FEE, OR REDUCED FEE
   SERVICE, EXAMINATION, OR TREATMENT.
   Simplest: say "a short phone consultation" without "free", or add the notice once near the button.
4. **Keep "Women's Counseling"** in titles where it already appears; Crissy's preferred clients are women.
5. **Each page should answer a few real questions** near the bottom, in the words people type into
   ChatGPT or Google (for example "Do you offer EMDR in Winter Park?", "Can I book online?", "Is
   telehealth available anywhere in Florida?"). Short, direct first sentences help AI assistants quote them.
6. **Add the lines in `drafts-notes/_redirects-additions.txt` and `drafts-notes/sitemap-additions.xml`**
   to `_redirects` and `sitemap.xml`, then delete `drafts-notes/` and this README before publishing.
7. **Preview:** the pages use root paths (`/assets/...`), so double-clicking a file shows it unstyled. Run
   `python3 -m http.server 8000` in this folder and open `http://localhost:8000/services/emdr.html`.
8. **Publish:** merge this branch into `main` (`git checkout main && git merge drafts/specialty-pages`), check
   `.deploy/budget.sh`, then `.deploy/deploy.sh "Add specialty pages"`. Pages left out (groups or Christian
   counseling) should be removed from `services/`, `services.html`, `_redirects` and `sitemap.xml` first.
