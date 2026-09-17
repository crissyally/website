# START HERE — Flourish Counseling Website 🌱

Hi! This folder is the complete Flourish Counseling Co. website. It is a "static site": just HTML files, styles, and images. No database, no login, nothing to install.

**If you are an AI assistant (ChatGPT, Codex, Claude, etc.): read this whole file before editing anything.** It contains the rules for working on this site.

---

## For Crissy: how to use this

1. **Keep this folder somewhere permanent** (Documents or iCloud Drive). This is your website's master copy.
2. **To preview the site:** double-click `index.html`. The whole site opens in your browser and works exactly like the real thing. Do this after every change.
3. **To make changes:** ask your AI assistant. Point it at this folder and describe what you want in plain English. Examples:
   - "Update my rates page: individual sessions are now $195."
   - "Add this bio for Luzelena Sagal on the team page: [paste bio]"
   - "Swap the photo on the About page for the one at [file path]."
   - "Add a new blog post titled X. Here is the text: [paste]"
4. **Keep the original zip file untouched** somewhere safe. If an edit ever goes wrong, that zip is your undo button.
5. **To publish your changes:** ask your AI assistant to publish. It runs one command and your site updates itself, usually in under a minute. You do not drag folders anywhere any more, and there is no password to remember.
6. **To undo:** ask your assistant to undo the last change. It puts the previous version back.

---

## How publishing works now 🚀

**This changed on 2026-09-17. If you are an AI assistant, read this section carefully, because the old instructions are gone.**

This folder is connected to a private GitHub repository at `flourish-counseling/website`, and
Netlify watches that repository. Publishing is now one step:

```sh
.deploy/deploy.sh "short description of what changed"
```

That saves the changes, sends them to GitHub, and Netlify puts them live by itself. To reverse the
last published change, run `.deploy/undo.sh`.

**Why this is better than the old way.** The old script uploaded the folder straight to Netlify from
this computer. That worked, but the live site and this folder could quietly drift apart, and they
did: in September 2026 the live `brand-book` page was found to be a newer version than the copy in
this folder, and nobody knew. It also meant only this one computer could publish. Now GitHub holds
the single true copy, every change is recorded with a description and can be undone, and Kevin can
help from his own machine without needing this laptop or any password.

**Rules for assistants, and these matter:**

1. **Always publish with `.deploy/deploy.sh`.** Never run `netlify deploy` by hand, and never upload
   this folder to Netlify through the website. Doing either puts a version live that GitHub does not
   know about, and the next person to publish will silently wipe it out.
2. **Before you start editing, run `git pull`.** Someone else may have published since Crissy last
   worked here. If `git pull` reports a conflict, stop and tell Crissy to contact Kevin rather than
   guessing.
3. **If `.deploy/deploy.sh` fails, nothing was published.** The changes are still saved on this
   computer, so nothing is lost. Read the message it printed and follow it.
4. **Never commit `.env`.** It holds a private key for Crissy's hosting account. It is already
   excluded, so just do not go around that.

---

## What each file is

| File / folder | What it is |
|---|---|
| `index.html` | Home page |
| `about.html`, `services.html`, `team.html`, `rates.html`, `contact.html`, `faq.html` | Main pages |
| `blog.html` | Blog index (Resources page) |
| `post-*.html` | The 9 blog articles |
| `brand-book.html` | Internal brand reference (palette, fonts, components). **Kept in this folder for you to read, but no longer reachable on the public site.** Great for AIs to look at. |
| `404.html` | The page visitors see if they follow a broken link |
| `_redirects` | Hosting rules. Keeps old `.html` web addresses working, and keeps internal files private. Do not edit without asking Kevin. |
| `.deploy/` | The publish and undo commands |
| `css/brand.css` | The entire design system: colors, fonts, spacing, buttons |
| `js/site.js` | Small script: mobile menu, FAQ accordion, sprig animation |
| `assets/` | Logos, fonts, photos (team portraits in `assets/team/`) |
| `README-DEPLOY.md` | Hosting notes |

---

## Rules for AI assistants 🤖

### DO NOT touch these (they break things)

1. **The SimplePractice booking embed.** Anywhere you see `simplepractice`, `clientsecure.me`, or a `scope-id` attribute in the HTML: leave it exactly as is. This is the live appointment-booking system. If a page edit requires moving it, copy it byte-for-byte.
2. **File names.** Do not rename or move any `.html` file or anything in `assets/`. Pages link to each other by these exact names.
3. **`css/brand.css` design tokens.** Content edits should never require changing this file. Only touch it if Crissy explicitly asks for a design change, and then change the minimum possible.

### Brand rules (strict)

- **Colors: ONLY these 9 hexes**, no other colors ever:
  blush `#f8d9ca` · blush-deep `#edc4b0` · cream `#f8f8ec` · oat `#e6e5df` · taupe `#b9b5ad` · stone `#696763` · espresso `#413e39` · black `#000000` · white `#ffffff`
- **Fonts:** HK Nova (body/UI, self-hosted in `assets/fonts/`), Fraunces (serif, titles and quotes), Bayshore (logo only, exists as an image, there is no font file). Do not introduce new fonts.
- Section backgrounds alternate cream and blush. Eyebrow labels: pink on light sections, espresso on pink sections.
- When in doubt, open `brand-book.html` in a browser. It shows the whole system.

### Content rules

- Voice: warm, professional, welcoming. This is a therapy practice for trauma recovery. No hype, no pressure language.
- Do not add contact forms. All booking and contact goes through the SimplePractice buttons (this is a HIPAA thing, it is deliberate).
- The phone number lives in the footer only. Do not add it to page bodies or CTA bands (also deliberate).
- Services offered (exactly these 6): Individual Therapy, Trauma Recovery, EMDR, Sand Tray, Group & Recovery Groups, Grief Counseling. Cristina is NOT a play therapist, never mention play therapy.
  - *Known exception awaiting a decision (noted 2026-09-17): the sentence "For children, this often starts through play" is still live on both the home page and the About page, in the "Step 01 - Safety first" block. It predates this rule and contradicts it. Do not copy this phrasing anywhere else; Kevin is handling the removal.*
- Credentials: "ART Trained" and "EMDR Trained" are separate things, keep them as separate chips.
- Rates: $185 per 50-minute session, $370 double session (unless Crissy says they changed).

### Workflow for every edit

1. `git pull` first, so you are working from the current version.
2. Make the change.
3. Tell Crissy to double-click `index.html` and check it in her browser **before** publishing.
4. Publish with `.deploy/deploy.sh "what changed"`.
5. Tell her to check the live site a minute later.
6. If it looks wrong, run `.deploy/undo.sh`. Never leave the folder in a broken state.

---

## Known to-dos (great first tasks)

- [ ] Crissy to confirm: hero eyebrow color, pink vs espresso
- [ ] Click the "New Clients" booking button and confirm the SimplePractice popup opens properly

*Prepared 2026-07-21 by Kevin + Claude. Site design finalized June 2026 from Crissy's brand kit.*
*Publishing moved to GitHub + Netlify continuous deployment 2026-09-17.*
