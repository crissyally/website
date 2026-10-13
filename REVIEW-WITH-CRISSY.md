# Reviewing the new pages with Crissy

This file is for Crissy's Codex. Read all of it before you start, then walk Crissy through the review
one page at a time. Keep it light and unhurried: she may be doing this between clients, so it's fine
to stop after any page and pick up later.

## Why these pages exist

Kevin and Mo drafted these pages so Crissy shows up better when people look for help, on Google and
when they ask AI assistants like ChatGPT ("who does EMDR for women in Winter Park?"). Each page is
about one way she works, so a search engine or an assistant has one clear page to point people to.

Each page has two layers:
- **The words people read.** These should sound like Crissy: warm, plain, first person. This is what
  she's reviewing.
- **Hidden facts for search engines and AI** (the `<script type="application/ld+json">` blocks in each
  page's code, plus the small "The practical details" box near the end). These hold the facts
  (address, fees, credentials, how to start) so the rest of the page can stay warm. Crissy doesn't
  need to read these. If she changes a fact in the visible text, update the same fact in the hidden
  block and in the details box so they still match.

## Before you start

1. If the folder has unsaved changes, stop and ask Crissy what they are before doing anything else.
2. Get the drafts: `git fetch origin` then `git switch drafts/specialty-pages`.
3. To show her a page the way it will look, run `python3 -m http.server 8000` in this folder and open
   the address listed below in her browser (double-clicking a file shows it without its styling).

## The review, one page at a time

For each page: tell her what the page is for (one sentence, from the list below), open it, and ask:
**"Does this sound like you? Anything you'd say differently, or anything that isn't true?"** Make her
changes in her words. Photos are welcome: if she'd like one on a page, help her pick it and add it with
a short description in the `alt` text.

| # | Page | Open | What it's for |
|---|---|---|---|
| 1 | Trauma therapy for women | http://localhost:8000/services/trauma-therapy-for-women.html | The page for a woman searching for trauma help in Winter Park or Orlando. The most important one. |
| 2 | EMDR | http://localhost:8000/services/emdr.html | For people searching for an EMDR therapist nearby. |
| 3 | Trauma recovery | http://localhost:8000/services/trauma-recovery.html | For people who know something old is still affecting them, before they know the word "trauma" fits. |
| 4 | Grief counseling | http://localhost:8000/services/grief-counseling.html | For people looking for help after a loss. |
| 5 | Individual therapy | http://localhost:8000/services/individual-therapy.html | For people looking for a therapist in general, not a specific method. |
| 6 | Sand tray | http://localhost:8000/services/sand-tray.html | For people curious about a way to work that doesn't rely only on talking. |

Two more are on the branch but on hold, so only open them if Crissy asks: recovery groups (waits until
a group is forming) and Christian counseling (only if she wants that page at all).

## Four quick questions only Crissy can answer

Each one guards a sentence on a page (look for the `CONFIRM` note in that page's code). Ask them as you
reach the page, and change or remove the sentence to match her answer.

1. **EMDR page:** do you offer EMDR by telehealth, or only in person?
2. **Grief page:** has Flourish ever run a grief support group? If not, that sentence comes out.
3. **Sand tray page:** is it adults only, in person only, during regular sessions, with nothing
   photographed or kept?
4. **Recovery groups page (only if she opens it):** do you still offer women's recovery groups, do you
   lead them yourself, and would you like an interest list?

## Rules for any edits (these keep her license safe under Florida rules)

- Don't use the words "free", "no charge" or "complimentary" for the consultation or anything else.
  Call it "a 10-minute phone consultation".
- No client stories, quotes, reviews or testimonials, even made-up or anonymous ones.
- No promises of results ("you will heal", "proven to work"). Describe what the work is like instead.
- Credentials as they are: LMHC, NCC, Qualified Supervisor, EMDR trained, ART trained. Don't call any
  method "certified", and don't use "Dr." or "sex therapist".
- No long dashes (em dash or en dash) as punctuation. Use a comma, period or parentheses instead.

## Saving her changes

This part matters most: her website publishes automatically whenever `main` changes, and her hosting
plan has a small monthly publish limit.

- Save only on this branch, `drafts/specialty-pages`. **Never merge into `main`, never push to `main`,
  and never run anything in `.deploy/`.**
- End every save message with `[skip ci]`, so the host doesn't build or spend a publish. For example:
  `git commit -am "Crissy's review: EMDR page [skip ci]"` then `git push origin drafts/specialty-pages`.
- Save after each page, so nothing is lost if she stops partway.
- When she's done (or done for now), switch back with `git switch main`, so her next normal website
  edit doesn't land on the drafts.

## When she's finished

Tell Crissy: "Thank you! Kevin and Mo will take it from here. They'll check everything against the
publishing rules and publish it with you when it's ready." Then stop. Publishing happens later, together,
after those checks.
