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
5. When you are happy with everything, the site gets uploaded to Netlify (free hosting) and connected to flourish-counseling.co. Kevin has the steps.

---

## What each file is

| File / folder | What it is |
|---|---|
| `index.html` | Home page |
| `about.html`, `services.html`, `team.html`, `rates.html`, `contact.html`, `faq.html` | Main pages |
| `blog.html` | Blog index (Resources page) |
| `post-*.html` | The 9 blog articles |
| `brand-book.html` | Internal brand reference (palette, fonts, components). Not linked from the site. Great for AIs to look at. |
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
- Credentials: "ART Trained" and "EMDR Trained" are separate things, keep them as separate chips.
- Rates: $185 per 50-minute session, $370 double session (unless Crissy says they changed).

### Workflow for every edit

1. Make the change.
2. Tell Crissy to refresh the page in her browser and check it.
3. If it looks wrong, revert or fix. Never leave the folder in a broken state.

---

## Known to-dos (great first tasks)

- [ ] Crissy to confirm: hero eyebrow color, pink vs espresso
- [ ] Click the "New Clients" booking button and confirm the SimplePractice popup opens properly

*Prepared 2026-07-21 by Kevin + Claude. Site design finalized June 2026 from Crissy's brand kit.*
