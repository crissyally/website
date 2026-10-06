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
| `services/trauma-therapy-for-women.html` | /services/trauma-therapy-for-women (new 10/06: the page her ideal client's searches should land on) |
| `services.html` | /services, rewritten as a menu that links to the pages |
| `post-when-talking-to-chatgpt-isnt-enough.html` | a new blog post (also added to the top of `blog.html`) |

`drafts-notes/` holds the questions (`PRE-PUBLISH-QUESTIONS.md`, and the same thing as a readable page,
`questions-for-crissy.html`) and the redirect and sitemap lines to add when publishing.

## What was added on Tue 10/06 (for search engines and AI assistants)

Every page keeps its original writing. Added, in the same look:
- **"At a glance" box** near the top: who it's for, where, who you'll see, fees, and the first step. AI
  assistants quote facts like these almost word for word.
- **A short FAQ** near the bottom, written the way people ask, with matching hidden FAQ labels for search
  engines. The EMDR FAQ cites the WHO (2013) and VA/DoD (2023) guidelines.
- **A gentle women-first framing** in "Who it's for" and in one FAQ answer, matching the site title.
- **The Events link** in each page's menu and footer, to match the live site.
- **New: "Trauma Therapy for Women"**, and **new: the ChatGPT post**, including a weekly AI-journal summary
  prompt clients can bring to sessions.

**Please check these assumptions** (they're in the new boxes and FAQs): sand tray is in person only; groups
are small, closed groups for women and fees are shared when a group opens; on the Christian counseling page,
faith is welcome but never required; "Who it's for" on each page; every FAQ answer. Change anything that
isn't true or doesn't sound like you.

## For Crissy

1. Read each page and change anything that doesn't sound like you. Your words beat ours every time.
2. Answer the questions in `drafts-notes/PRE-PUBLISH-QUESTIONS.md`, section A. A few are about how you
   practice (sand tray, groups, the Christian counseling page), so only you can answer them.
3. When you're happy, ask your assistant to publish them.

## For the assistant helping her

Read `START-HERE.md` first; every rule there still applies (one publish per session, check the budget,
publish only with `.deploy/deploy.sh`).

These drafts were built on 2026-09-11, before later site changes. Before publishing:

1. **Header and footer:** the Events link was added on 10/06. Still compare once against `index.html` and keep
   the Psychology Today verification seal block.
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
5. **Each page already has a short FAQ (added 10/06).** Keep answers short and direct, and keep the matching
   FAQ labels in the page head in sync if you edit them. Original note: near the bottom, in the words people type into
   ChatGPT or Google (for example "Do you offer EMDR in Winter Park?", "Can I book online?", "Is
   telehealth available anywhere in Florida?"). Short, direct first sentences help AI assistants quote them.
6. **Add the lines in `drafts-notes/_redirects-additions.txt` and `drafts-notes/sitemap-additions.xml`**
   to `_redirects` and `sitemap.xml`, then delete `drafts-notes/` and this README before publishing.
7. **Preview:** the pages use root paths (`/assets/...`), so double-clicking a file shows it unstyled. Run
   `python3 -m http.server 8000` in this folder and open `http://localhost:8000/services/emdr.html`.
8. **Publish:** merge this branch into `main` (`git checkout main && git merge drafts/specialty-pages`), check
   `.deploy/budget.sh`, then `.deploy/deploy.sh "Add specialty pages"`. Pages left out (groups or Christian
   counseling) should be removed from `services/`, `services.html`, `_redirects` and `sitemap.xml` first.
