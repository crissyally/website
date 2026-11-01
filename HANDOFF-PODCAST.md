# Start here: podcast website and audience setup handoff

Last updated: October 31, 2026, evening (America/New_York), by Kevin's Claude after Codex reached its usage limit.

This is the current continuation record for Crissy and Kevin's Claude, Codex, or another assistant. It supersedes older chat summaries and local draft documents outside this repository. It contains no account credentials, client details or listener response contents.

## 1. Current state and the next conversation

- Repository: https://github.com/crissyally/website
- Continue this branch: `codex/podcast-audience-updates`.
- Everything in this handoff is committed and pushed with `[skip ci]`. Use `git log -1` for the latest handoff commit, rather than relying on a hash copied into this file.
- Website changes have NOT been published. Crissy has not approved production publication of this batch.
- Google Forms and Kit changes ARE saved in their respective services. Git only versions the website and this documentation; it does not stage or roll back those services.
- Kevin's new main documentation (commit `33dbe8f`) was merged into the review branch with merge commit `4e2e359`. Later headline/search wording refinements are also on this branch.
- No pull request has been opened. Do not open one.

Crissy wants to work through ONE TOPIC AT A TIME, with an explanation and concrete proposed wording before moving to the next decision. Do not dump a whole SEO checklist on her or implement unapproved optional copy/design changes in bulk. After she approves a specific edit, apply it and back it up to this branch without publishing.

The currently active topic is finishing SEO/AEO item 1 from her remaining-work list. She has finalized the search title and description. Kevin's Claude has since proposed the exact wording for the contextual internal links (section 12). NEXT: show Crissy that wording, get her approval or tweaks, then apply it on this branch. The FAQ is decided: skip it for now (section 12). Then move to item 2 in section 9. Do not jump straight to publication.

## 2. Read these before work

Read `AGENTS.md`, all of `START-HERE.md` (including "Working on a branch"), and `SEO-AND-AEO.md`. `PODCAST-REVIEW.md` maps this page to the playbook and lists remaining recommendations.

User preferences:
- Concise, warm, concrete explanations. One topic per message for this review.
- No em dashes or en dashes in new copy or replies.
- Exact approved wording and user preferences take precedence over generic style/SEO guidance.
- Palette: blush #f8d9ca, blush-deep #edc4b0, cream #f8f8ec, oat #e6e5df, taupe #b9b5ad, stone #696763, espresso #413e39, black #000000, white #ffffff. No sage green.
- Website fonts: HK Nova body/UI, Fraunces serif, original image wordmark only.
- Preserve the SimplePractice booking markup and its script, Cloudflare analytics script, and Psychology Today verification script exactly. All care requests go through SimplePractice. Podcast/marketing forms are authorized and kept separate from therapy intake.
- Never commit `.env`, authentication files, client data, or listener submissions. The repository is public.

## 3. Resume safely on another device

If the repository is already cloned and the working tree is clean:

```sh
git fetch origin
git switch codex/podcast-audience-updates
git pull --ff-only origin codex/podcast-audience-updates
```

If the branch only exists remotely:

```sh
git fetch origin
git switch --track origin/codex/podcast-audience-updates
```

Inspect `git status` before changing branches or pulling. Preserve any existing local work. If another person has updated main, fetch and merge `origin/main` into THIS branch with a merge message containing `[skip ci]`. If there is a conflict, follow the repository instruction to stop and ask Kevin rather than guessing.

At natural stopping points:

```sh
git add --all
git commit -m "Describe the change [skip ci]"
git push origin codex/podcast-audience-updates
```

Every branch commit, including merges, must contain `[skip ci]`. Netlify builds main only per the new repository documentation; the skip marker is the second safeguard. Never open a PR, because a Netlify Deploy Preview would cost credits.

Preview on any device running the checkout:

```sh
python3 -m http.server 8765 --bind 127.0.0.1
```

Open http://127.0.0.1:8765/podcasts.html . This localhost address only works on the device running the server. On Crissy's Mac the checkout is `/Users/crissycru/Documents/Flourish Rebrand/flourish-counseling-site`.

Do not assume browser logins transfer to the new device. Kit/Google admin work requires the account owner's normal signed-in session; do not extract cookies or copy browser credentials. Reuse the existing forms and tags rather than creating substitutes when not signed in.

## 4. Exact current approved wording

Visible large black H1:

> Cozy. Comfortable. Authentic.

Smaller line immediately underneath:

> Podcasts exploring mental health and authentic sexuality

Crissy explicitly chose this hierarchy after seeing the plain-topic H1 in large type. Do not revert it to satisfy the playbook's general plain-topic H1 preference. The topic remains visible directly underneath.

Search title (also Open Graph and Twitter title):

> Mental Health & Sexuality Podcasts | Flourish Counseling Co.

Search description (also Open Graph and Twitter description), exactly as Crissy requested:

> Explore mental health and authentic sexuality with Cristina Ally, LMHC. Listen to The Art of Flourishing, Sexology Explained, and Sex on the Couch.

Description length: 147 characters. LMHC was verified against both the current local `about.html` and public https://flourish-counseling.co/about . Do not add other credentials from memory. The search title prioritizes topics over a local city at Crissy's approval because podcasts can be heard anywhere.

Only The Art of Flourishing is currently live. The two other show cards are explicitly "Coming soon" and "Currently in development. Coming to Spotify." Preserve that distinction. Do not invent episode listings, launch dates or listening URLs for upcoming shows. The latest search description is the user's exact wording.

## 5. Website changes completed in this branch

Main page: `podcasts.html`; form behavior: `js/podcast-signup.js`; shared social styles: `css/brand.css`.

- All three shows have their supplied cover art. New files are `assets/podcasts/the-art-of-flourishing.png` and `assets/podcasts/sexology-explained.png`; Sex on the Couch art already existed.
- Podcast buttons use softer cream/blush treatments. Podcast-page New Clients styling is CSS only; booking markup stays unchanged.
- Official dark Spotify player is collapsed behind an accessible details/summary, "Play the latest episode here". Spotify controls its player colors.
- All three show cards have subscribe anchors and Instagram links (external links open a new tab).
- `#podcast-updates` is on `.podcast-signup-form`, not the containing section or its introductory paragraph. It has a 110-pixel scroll margin to clear the sticky header.
- Show-specific subscribe clicks select that show's native Kit interest checkbox and preserve other selections. No automatic All Podcasts tag is added.
- Kit signup shows optional first name, required email, initially unselected interests, and a small fallback link to the hosted form. At least one interest is required by the site's validation before Kit handles submission.
- The signup script sets name/email autocomplete, orders name before email, removes an inappropriate role=button wrapper around Kit's checkbox fieldset, and disconnects its observer after setup.
- Kit embed script uses `index.js?v=2` for cache refresh. Kit's CSS compiler prefixes selectors, so the website has explicit form-root style overrides. Do not remove those as redundant.
- Listener invitation "What's on your mind?" opens the Google Form in a new tab, keeping a second long form off the page.
- Six accessible social icons are in 26 existing page footers. Contact also has labeled social buttons. Sprite: `assets/icons/social.svg`.
- Shared stylesheet links use `brand.css?v=4` to avoid stale cached icon styles. Without it, an earlier cached page temporarily rendered huge icons.
- Podcast canonical, sitemap entry and `.html` redirect already existed and remain. JSON-LD includes BreadcrumbList and CollectionPage/ItemList/PodcastSeries for the three shows, with accurate existing links and upcoming status. No fake PodcastEpisode records.

Earlier podcast tab and Events spacing work was published before this branch, in `9d42918`. Current Events changes in this branch are the shared footer/styles. Do not claim a fresh Eventbrite connection check was performed during this batch.

## 6. Verified public links

| Destination | URL |
| --- | --- |
| The Art of Flourishing on Spotify | https://open.spotify.com/show/67eiyIkdiSftBkrirGnDyy |
| The Art of Flourishing RSS | https://anchor.fm/s/118ee14e8/podcast/rss |
| Art of Flourishing/practice Instagram | https://www.instagram.com/flourishcounseling.co/ |
| Sexology Explained Instagram | https://www.instagram.com/sexologyexplained/ |
| Sex on the Couch Instagram, corrected by Crissy | https://www.instagram.com/sexonthecouchpodcast/ |
| Practice Facebook | https://www.facebook.com/flourishcounseling.co/ |
| Practice YouTube | https://www.youtube.com/channel/UCExF19qUDZXvj4r_ivNf2Ww |
| Practice LinkedIn | https://www.linkedin.com/in/flourishcounselingco/ |
| Practice Google Business, supplied by Crissy | https://share.google/cGf8UyFInybLpTWXj |
| Practice Yelp, supplied by Crissy | https://m.yelp.com/biz/flourish-counseling-winter-park-4 |

The four other practice social URLs came from the practice's own https://linktr.ee/flourishcounseling.co . Do not revert the corrected Sex on the Couch handle to @sexonthecouch.

## 7. Kit: existing setup, do not duplicate

Account: Flourish Counseling Co. Kit was administered through Safari; no Kit connector was available in this session.

- Form name: `Flourish | Podcast and Practice Updates`
- Form ID: `10125230`
- Public/embed UID: `0fb829734d`
- Editor: https://app.kit.com/forms/designers/10125230/edit?iframe=false
- Hosted form: https://flourish-counseling-co.kit.com/0fb829734d
- Embed: https://flourish-counseling-co.kit.com/0fb829734d/index.js
- Existing verified sender: `podcast@flourish-counseling.co`. No sender-display-name change to "Cristina at Flourish" was made; that was only an early draft idea.
- Field names: `fields[first_name]` (optional), `email_address` (required), `tags[]`.
- Double opt-in enabled. Auto-confirm is OFF.

| Existing Kit tag | Native checkbox value |
| --- | --- |
| Interest: All Podcasts | 25237705 |
| Interest: The Art of Flourishing | 25237706 |
| Interest: Sexology Explained | 25237709 |
| Interest: Sex on the Couch | 25237711 |
| Interest: Flourish Counseling | 25237712 |

All five subscriber preference topics were created and mapped to these tags. Use one subscriber list with interests, not separate lists/forms per show. All Podcasts is an explicit preference, not a tag to apply automatically to people selecting one show.

Suggested future audience targeting: show-specific email = All Podcasts OR that show's tag; practice news = practice tag only. Use one matching audience filter per email to avoid sending duplicates. No broadcast or sequence was sent.

Saved confirmation email:
- Subject: `Your Flourish updates are almost here 🌿`
- Original Flourish wordmark image, 260 px, caption off, alt text Flourish Counseling Co.
- Eyebrow: A LITTLE FLOURISH FOR YOUR INBOX.
- H2: A little connection starts here.
- Warm welcome explaining confirmation and selected interests; signoff Cristina / Flourish Counseling Co. | Flourish Family of Podcasts.
- Native confirmation button retained, labeled `Confirm your subscription`, rounded fully, blush #f8d9ca background and espresso #413e39 text. Do not replace its dynamic confirmation URL with a static link.
- Unsubscribe, preferences, required address and Built with Kit footer retained.
- Overall email background was not changed to a custom cream panel; do not claim that draft styling was applied.
- The post-confirmation redirect still uses Kit's standard https://app.kit.com/confirm-subscription page. This generic landing page has not been redesigned.

One user-authorized signup test was completed, including the user clicking the confirmation email. Kit showed the first name saved, confirmed status, and only All Podcasts selected. Empty-interest validation was also tested. The redesigned email was saved and reopened to verify persistence, but was NOT resent after branding because the test subscriber was already confirmed. Do not claim end-to-end delivery testing of the revised design. No new email send is authorized by this handoff alone.

## 8. Google Form: existing setup, do not duplicate

- Owner account selected by Crissy and verified in the UI: `cristina@flourish-counseling.co`.
- Document name: `Flourish Podcasts | Questions and Listener Stories`.
- Visible title: `A little conversation, from you to us.`
- Editor: https://docs.google.com/forms/d/12er80ooyGFf1HKifK2ec7V0b7oXx9gbmPrDLvoBPQe4/edit
- Public form: https://docs.google.com/forms/d/e/1FAIpQLSfv30Grlya9VW-ow5CYBo6oj9GSqFKPQPQiT_gL--Qj7-p_Qg/viewform
- Published for anyone with the link to respond. Owner/editor response data is NOT public.

Section 1 asks which podcast, what kind of submission (question, topic suggestion, listener story/podcast impact, private team feedback), a required paragraph, and explicit permission to share publicly. No permission choice is preselected.

- Private-only choice skips to section 3.
- Public permission allows reading/quoting on the selected podcast and related site/social channels, editing for length/clarity without changing meaning, and proceeds to section 2.

Section 2 asks public credit choice (Anonymous, Pen name, First name only, First name and general location). Public name and general city/region fields are optional and may be blank.

Section 3 asks optional follow-up email, explicitly never public and not newsletter consent. A required acknowledgement says no guaranteed answer, feature, shout-out or reply; podcast education is not individual care; no private treatment or third-party identifying details. The final implemented acknowledgement is a one-option required radio choice, not the checkbox originally proposed in a draft. Its required validation was tested.

Settings verified: no automatic email collection, no Google sign-in/one-response restriction, no uploads, no public response summaries, responder draft autosave disabled, response receipts off, progress indicator on, submit-another-response link off. No spreadsheet was linked and no additional response editors were added.

Branding saved and verified publicly:
- Correct 1600 by 400 banner with unchanged original wordmark, cream/blush accents and an original speech-bubble layout.
- Editable composition: `assets/brand/podcast-listener-header.svg`; uploaded render: `assets/brand/podcast-listener-header.png`.
- Fraunces for headings and espresso native theme accent. Google Forms controls the remaining generated background shades and body-font options; HK Nova was not installed there.
- An earlier attempt to use the bare wordmark was removed because Google cropped it. The later padded banner above IS now applied. Older local notes saying "logo removed" are obsolete.

Exact currently saved on-screen confirmation:

> Thank you for adding your voice to the conversation. Your submission is with the Flourish podcast team. We cannot promise a feature or personal reply, but we appreciate you being here.
>
> Questions about your submission? You can reach our podcast team at podcast@flourish-counseling.co.
>
> Want to hear what is next? Choose your email updates at https://flourish-counseling.co/podcasts#podcast-updates

This is an ON-SCREEN confirmation, not an automatic email. Native Google Forms does not provide a custom From/Reply-To setting for this workflow. The business email is now visible in the confirmation, but the owner account remains Cristina's selected account. Google controls the Contact form owner footer. No Gmail alias, mailbox access, Apps Script trigger, autoresponder or third-party automation was configured.

Both public/private routes were tested without sign-in. One clearly synthetic TEST ONLY response was submitted, and receipt was verified in the owner's Responses tab. It was left as a labeled test record, not deleted. No real listener data is stored in this repository.

## 9. What remains, in review order

1. Finish SEO/AEO item 1: walk Crissy through the proposed link wording in section 12, apply what she approves, commit with `[skip ci]` and push this branch. No FAQ (decided, section 12).
2. Walk Crissy through the Google Form branding, privacy/credit choices and thank-you message one topic at a time. They work, but the guided review is not finished.
3. Clarify whether Crissy wants an automatic podcast submission thank-you email, or simply the ability to reply manually as the podcast address. Explain required account/alias/automation setup before building it. Kit newsletter confirmation is already separate. No automatic form email was built.
4. Final review of the full batch on phone/desktop, followed only by an explicitly approved, budget-checked release.
5. Later ideas, NOT approved scope now: a dedicated accessible Subscribe page/footer signup link, real episode notes and transcripts, new-show Spotify links after launch, custom post-confirmation Kit landing page. Do not treat this list as permission to build everything.

No counseling testimonials or treatment outcome stories should be published. The listener form is about podcast content, not therapy reviews. Do not make credentials, legal guarantees, outcome claims, or new medical-content promises from memory.

## 10. Verification already completed

- Actual per-show subscribe clicks selected the expected tags and preserved other selections.
- Phone 390x844 and desktop 1280x900 landed the form about 110 px below top, clear of the sticky header; no horizontal overflow observed.
- First name order/autocomplete and required email checked; empty-interest validation checked.
- Spotify player disclosure opened/closed and correct show loaded.
- Actual listener CTA opened the correct form in a separate tab.
- Google public/private branching, optional identity fields, required acknowledgement and synthetic response arrival verified.
- Kit double opt-in and initial tag/first-name persistence verified; updated branded email persistence verified but not resent.
- All 26 footer rows include supplied Google/Yelp links; social SVG parses and Contact icons render at 20 px.
- Protected booking/analytics/verification scripts were compared with HEAD during the batch and remained unchanged.
- JSON-LD parses; all three show fragment targets exist; canonical/sitemap/redirect/robots checked.
- `git diff --check` passed; `node --check js/podcast-signup.js` passed using the Mac's Node installation when needed.
- On-page headline and later swaps were checked in the browser for exact text, a single H1, black color and no overflow.

Relevant Mac screenshots live outside Git in `/Users/crissycru/Documents/Flourish Rebrand/`: `google-form-branded-preview.png`, `kit-confirmation-branded-preview.png`, `podcast-mobile-direct-signup-preview.png`, `podcast-simple-headline-preview.png`, and others. These screenshots are not required to resume elsewhere; use the source and service URLs. Old screenshots may show earlier approved versions of copy.

## 11. Publication, only after Crissy approves

Do NOT publish as part of reading or continuing this handoff. Do not run Netlify draft deploys or open a PR for a preview. Use the exact branch workflow in `START-HERE.md`:

- Preview all changes locally and obtain Crissy's publication decision.
- Run `.deploy/budget.sh`, report remaining publishes and reset date, agree the release is worth one.
- Update main, squash-merge this branch without committing, and use `.deploy/deploy.sh` for one final release commit. The release description must not contain `[skip ci]`.
- Keep the 30-credit reserve. Never bypass a failed budget check/refusal. Preserve the branch after publication unless Kevin asks to delete it.
- Only after release: live checks, Search Console/IndexNow steps from `SEO-AND-AEO.md`.

No deployment budget was spent during this branch work. No final budget check or release approval has occurred for this batch.

## 12. Added October 31 evening by Kevin's Claude: link wording and the FAQ decision

**FAQ: skip it on the podcast page for now.** Kevin agreed on October 31. The page already answers
"where can I listen" with its Spotify buttons, an FAQ would mostly add length, and Crissy wants the
page uncluttered. FAQ blocks pay off on service pages, which already have them. Revisit once the two
new shows launch and listeners ask real questions. Do not add an FAQ or `FAQPage` schema here.

**Contextual links: proposed, NOT yet approved by Crissy.** Present them one at a time in plain
words, then apply only what she approves. All targets are existing pages; use the clean addresses.

Podcast page, The Art of Flourishing description (two links in one sentence):

> Conversations about mental health and **trauma recovery** with **Cristina Ally, LMHC**. Listen at your own pace, wherever you are in your journey.

- "Cristina Ally, LMHC" links to `/about` (lets a curious listener learn who the host is).
- "trauma recovery" links to `/services/trauma-recovery` (ties the show to the main thing she treats).
- Keep "LMHC" only because it was verified on `about.html` today; do not add other credentials.

Podcast page, a new sentence directly after "For podcast conversations, not therapy or urgent support.":

> Looking for support of your own? **Explore therapy at Flourish.**

- "Explore therapy at Flourish" links to `/services` (the bridge for a listener who does want therapy).

About page, a new last sentence of the paragraph beginning "I'm passionate about walking alongside trauma survivors":

> I also host **The Art of Flourishing**, a podcast about mental health and trauma recovery.

- "The Art of Flourishing" links to `/podcasts` (the one incoming link from an existing page; the About page is in Cristina's first person, so the sentence is too).

Internal links open in the same tab (no `target="_blank"`). Style them with the site's existing in-body
link style; do not add new colors. After applying, check phone and desktop, run `git diff --check`,
confirm the three protected scripts are unchanged on both pages, then commit with `[skip ci]` and push.

## 13. November 1: first contextual links approved and applied

Crissy approved the Art of Flourishing description in section 12. It now links "trauma recovery" to `/services/trauma-recovery` and "Cristina Ally, LMHC" to `/about`, in the same tab. Only this first proposal is applied. The therapy-support sentence and incoming About-page sentence remain proposed, awaiting review one at a time. Next: present the therapy-support sentence for approval. Nothing published.

## 14. November 1: remaining contextual-link decisions

Crissy declined the proposed therapy-support link on the podcast page. Do not add it. She approved a broader About-page invitation, now appended to the trauma-survivor paragraph: "I also host podcasts exploring mental health and authentic sexuality. Check out our latest episodes on our podcast page!" The second sentence links to `/podcasts` in the same tab. About-page scripts are unchanged. Contextual-link review is complete. Next: review Google Form branding, submission choices and thank-you message together. Crissy now prefers seeing more related items at a time, rather than approving every tiny item separately. Nothing published.

## 15. November 1: Google Form feedback applied

Crissy requested a microphone instead of the speech bubble, direct signup links, guidance about multiple questions, and clearer optional-email expectations. These changes are saved in the existing Google Form service and the new header assets are backed up here. No website deploy occurred.

- Header SVG and 1600x400 PNG now show a simple blush/espresso microphone. Existing wordmark retained. PNG uploaded and saved in Google Forms. Upload auto-selected a gray accent; restored espresso #413e39 and verified on the public form.
- Intro now asks for one question, idea or story per submission, and another submission for another question/podcast. Enabled native "Show link to submit another response". The show stays single choice so each item has its own routing/permission.
- Intro ends: "Sharing here does not subscribe you to emails. Want podcast updates? Join our email list". Last phrase is a native clickable link to https://flourish-counseling-co.kit.com/0fb829734d . Click tested: opens a NEW TAB (Google click handler, no HTML target attribute), leaves form open, and arrives at existing Kit form with first name, email and interest choices. No signup submitted. Standalone Kit form does not use website JS enhancements; website embed remains preferred for onsite visitors.
- Section 3 description: "You may leave your email if you are open to a follow-up about this submission. We may or may not contact you, and a personal reply is not guaranteed. Your email is never shared publicly. Leaving it here does not subscribe you to updates." Followed by "Want podcast news and new episode updates? Join our email list." Last phrase links to the same standalone Kit form.
- Three sections retained: submission/sharing permission, public credit (skipped for private submissions), optional follow-up/acknowledgement. Explained this reasoning to Crissy. She has not requested collapsing them.
- Revised confirmation message, saved in Presentation settings:

> Thank you for adding your voice to the conversation! We cannot promise a feature or personal reply, but we appreciate you being here.
>
> Have more to share? Submit another response using the link below.
>
> Questions? podcast@flourish-counseling.co
>
> This submission does not subscribe you to emails. Join our podcast updates here: https://flourish-counseling-co.kit.com/0fb829734d

QA: public intro/banner inspected; direct signup click tested in new tab; private route with synthetic unsubmitted text reaches section 3 and displays reminder/link; test answers cleared and clean public form left open. No new test response submitted and no email sent. Confirmation text and submit-another toggle checked in editor; new end screen has not been submitted again to verify. Proof screenshots outside repo: google-form-microphone-preview.png and google-form-follow-up-preview.png in workspace parent. Next: Crissy reviews these changes; automatic submission email versus manual replies remains undecided and unbuilt. Do not publish website yet.

## 16. November 1: larger mic, pink form and podcast answer artwork

Crissy requested a doubled microphone, pale pink background, artwork to identify the podcast, and clarification of response storage/confirmation.

Applied and saved in Google Forms:
- Doubled microphone with `translate(-246 -70) scale(2)` in header SVG, rendered 1600x400 native PNG and uploaded. Mic is now roughly the height of the central wordmark/text block.
- Native theme accent changed to brand blush #f8d9ca. Background uses Google-generated pale shade #fcf0ea (native "Dark" variant, still very pale). Google Forms ties background choices to accent; espresso accent with independent pink background is not exposed. Website CSS unchanged. Header upload resets accent; restored blush and pink after upload.
- Each of the three existing multiple-choice podcast answers now has its corresponding cover image, uploaded from assets/podcasts. "Not sure, you choose" retained. Required single-choice behavior and all other questions preserved. Logos satisfy recognition request without inventing show descriptions for upcoming shows.
- Confirmation now reads:

> Your voice is part of the conversation. Thank you!
>
> With appreciation,
> Cristina + the Flourish podcast team
>
> We cannot promise a feature or personal reply. Have more to share? Submit another response below.
>
> Questions? podcast@flourish-counseling.co
>
> This submission does not subscribe you to emails. Join our podcast updates: https://flourish-counseling-co.kit.com/0fb829734d

Storage/receipts verified in signed-in editor: Responses tab has one existing synthetic test record. Button says "Link to Sheets", so no linked spreadsheet. Responses live in Google Form owned by cristina@flourish-counseling.co, accessible via Drive or editor Responses tab. Native automatic email collection remains "Do not collect" and response copies "Off" (disabled, requires email collection). Optional follow-up question is separate from Google email-collection setting. No new sheet, notification, email automation or required email collection enabled. Native confirmation supports text and shared header/theme, limited layout control; no custom thank-you page built.

QA: public header/pink background and all three images verified; selection works. Confirmation saved and re-read in editor, not test-submitted again. No emails or new responses sent. Proof screenshots outside repo: google-form-pink-header-preview.png, google-form-podcast-choices-preview.png. Website remains unpublished. Next: Crissy reviews refinements; decide about optional response-copy email only if she wants it, preserving separation from Kit subscriptions.
