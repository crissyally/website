# START HERE — Flourish Counseling Website 🌱

Hi! This folder is the complete Flourish Counseling Co. website. It is a "static site": just HTML files, styles, and images. No database, no login, nothing to install.

**If you are an AI assistant (ChatGPT, Codex, Claude, etc.): read this whole file before editing anything.** It contains the rules for working on this site.

---

## For Crissy: how to use this

1. **Keep this folder somewhere permanent** (Documents or iCloud Drive). This is your website's master copy.
2. **To preview the site:** double-click `index.html`. The whole site opens in your browser and works exactly like the real thing. Do this after every change.
3. **To make changes:** ask your AI assistant. Point it at this folder and describe what you want in plain English. Examples:
   - "Update the price on my rates page to the new one I just told you."
   - "Add this bio for Luzelena Sagal on the team page: [paste bio]"
   - "Swap the photo on the About page for the one at [file path]."
   - "Add a new blog post titled X. Here is the text: [paste]"
4. **Keep the original zip file untouched** somewhere safe. If an edit ever goes wrong, that zip is your undo button.
5. **To publish your changes:** ask your AI assistant to publish. It runs one command and your site updates itself, usually in under a minute. You do not drag folders anywhere any more, and there is no password to remember.
6. **To undo:** ask your assistant to undo the last change. It puts the previous version back.

---

## How publishing works now 🚀

**This changed on 2026-09-17. If you are an AI assistant, read this section carefully, because the old instructions are gone.**

This folder is connected to a GitHub repository at `crissyally/website`, and Netlify watches that
repository. Publishing is now one step:

```sh
.deploy/deploy.sh "short description of what changed"
```

That saves the changes, sends them to GitHub, and Netlify puts them live by itself, usually in under
a minute. To reverse the last published change, run `.deploy/undo.sh`. **No password, token or
account login is involved in either one.**

**Why this is better than the old way.** The old script uploaded this folder straight to Netlify from
this computer. That worked, but the live site and this folder could quietly drift apart, and they
did: in September 2026 the live `brand-book` page turned out to be a newer version than the copy in
this folder, and nobody knew. It also meant only this one computer could publish. Now GitHub holds
the single true copy, every change is recorded with a description and can be undone, and Kevin can
help from his own machine without needing this laptop or any password.

**The repository is public.** Anyone can read it, including its full history. That is fine, because
everything in it is either already on the public website or is a harmless deploy script. It does mean
one thing is permanent: **anything committed here can never be taken back.** Deleting a file later
does not remove it from the history. So never put a password, a key, or anything about a client into
this folder. See the content rules below.

**Rules for assistants, and these matter:**

1. **Always publish with `.deploy/deploy.sh`.** Never run `netlify deploy` by hand, and never upload
   this folder to Netlify through the website. Doing either puts a version live that GitHub does not
   know about, and the next person to publish will silently wipe it out.
2. **Before you start editing, run `git pull`.** Someone else may have published since Crissy last
   worked here. If `git pull` reports a conflict, stop and tell Crissy to contact Kevin rather than
   guessing.
3. **If `.deploy/deploy.sh` fails, nothing was published.** The changes are still saved on this
   computer, so nothing is lost. Read the message it printed and follow it.
4. **Never commit `.env`.** Publishing no longer needs it, but it still exists for
   `.deploy/preview.sh` and it holds a private key to Crissy's hosting account. It is already
   excluded by `.gitignore`. Do not go around that, and never paste its contents anywhere.

---

## Where the visitor numbers live

Since 17 September 2026 the site counts visitors using **Cloudflare Web Analytics**. It is free, it
uses no cookies, and it needs no "we use cookies" banner, which is why it was chosen over Google
Analytics for a therapy practice.

**Crissy sees her own numbers** at `dash.cloudflare.com`, signing in as `cristina12886@gmail.com`,
under Analytics then Web analytics. Page views, visits, which pages, and where people came from.

If she asks this assistant how many people visited, the honest answer is that the numbers are in
that dashboard rather than in this folder, and either she can look or Kevin can pull them. Nothing
here reads them. That is deliberate: it would mean keeping an access key on this computer, and there
is no good reason to when she can simply look.

**Two things worth knowing when reading it.** It only counts from 17 September onwards, so anything
earlier shows nothing and that is not a fault. And a page will not appear at all if its script was
removed, which is why the footer scripts are on the do-not-touch list above.

---

## What each file is

| File / folder | What it is |
|---|---|
| `index.html` | Home page |
| `about.html`, `services.html`, `team.html`, `rates.html`, `contact.html`, `faq.html` | Main pages |
| `blog.html` | Blog index (Resources page) |
| `post-*.html` | The 9 blog articles |
| `404.html` | The page visitors see if they follow a broken link |
| `_redirects` | Hosting rules. Keeps old `.html` web addresses working, and keeps internal files private. Do not edit without asking Kevin. |
| `.deploy/` | The publish and undo commands |
| `HOW-THIS-IS-SET-UP.md` | Who owns what, who has access, and how to change or remove it. **Read this if Crissy asks any question about ownership, access, or independence.** Kept on this computer only, not in the public repository. |
| `css/brand.css` | The entire design system: colors, fonts, spacing, buttons |
| `js/site.js` | Small script: mobile menu, FAQ accordion, sprig animation |
| `assets/` | Logos, fonts, photos (team portraits in `assets/team/`) |
| `README-DEPLOY.md` | Hosting notes |

---

## Rules for AI assistants 🤖

### DO NOT touch these (they break things)

1. **The SimplePractice booking embed.** Anywhere you see `simplepractice`, `clientsecure.me`, or a `scope-id` attribute in the HTML: leave it exactly as is. This is the live appointment-booking system. If a page edit requires moving it, copy it byte-for-byte.
2. **The three scripts in every page's footer.** Leave all of them exactly where they are:
   - `static.cloudflareinsights.com/beacon.min.js` counts visitors. Removing it from a page makes
     that page invisible in Crissy's traffic reports, silently.
   - `member.psychologytoday.com/verified-seal.js` draws her Psychology Today verified badge.
   - The SimplePractice script above.

   None of them are decoration and none should be "cleaned up." If you rewrite a page, carry all
   three across byte for byte.
3. **File names.** Do not rename or move any `.html` file or anything in `assets/`. Pages link to each other by these exact names.
4. **`_redirects` and `sitemap.xml`.** These control web addresses and how Google sees the site.
   Change them only as part of adding or removing a page, following the checklist below.
3. **`css/brand.css` design tokens.** Content edits should never require changing this file. Only touch it if Crissy explicitly asks for a design change, and then change the minimum possible.

### Brand rules (strict)

- **Colors: ONLY these 9 hexes**, no other colors ever:
  blush `#f8d9ca` · blush-deep `#edc4b0` · cream `#f8f8ec` · oat `#e6e5df` · taupe `#b9b5ad` · stone `#696763` · espresso `#413e39` · black `#000000` · white `#ffffff`
- **Fonts:** HK Nova (body/UI, self-hosted in `assets/fonts/`), Fraunces (serif, titles and quotes), Bayshore (logo only, exists as an image, there is no font file). Do not introduce new fonts.
- Section backgrounds alternate cream and blush. Eyebrow labels: pink on light sections, espresso on pink sections.
- **`css/brand.css` is the source of truth for the design system.** The colors and fonts above are
  copied from it for convenience; if they ever disagree, the stylesheet wins.

### Content rules

- Voice: warm, professional, welcoming. This is a therapy practice for trauma recovery. No hype, no pressure language.
- Do not add contact forms. All booking and contact goes through the SimplePractice buttons (this is a HIPAA thing, it is deliberate).
- The phone number lives in the footer only. Do not add it to page bodies or CTA bands (also deliberate).
- **Services: read them from `services.html`. Do not work from a list in this file.** What she offers
  changes; the page is what is true. The one standing rule that does not change: **Cristina is not a
  play therapist. Never mention play therapy.**
  - *Known exception awaiting a decision (noted 2026-09-17): the sentence "For children, this often starts through play" is still live on both the home page and the About page, in the "Step 01 - Safety first" block. It predates this rule and contradicts it. Do not copy this phrasing anywhere else; Kevin is handling the removal.*
- **Credentials: read them from the live `about.html` and `team.html`. Never state one from memory.**
  They lapse and get renewed, and asserting a credential she does not currently hold is a professional
  exposure problem, not a copy problem. Where chips exist, keep each credential its own chip rather
  than merging them.
- **Rates: read them from `rates.html`, which is the only place they are defined.** Never repeat a price
  from this file or from memory. If Crissy asks for a change, change it on that page.
- **Never put anything about a client in this folder.** Not a name, not an initial, not a detail from a
  session, not in a file and not in a commit message. This repository is public and its history cannot
  be taken back. Nothing about this website ever requires client information.

### Making a NEW page

Getting this wrong is how a page ends up invisible to Google, which has already happened once on
this site and took six weeks to spot. Follow all of it.

1. **Start by copying an existing page**, not from a blank file. That gives you the navigation, the
   footer, and all three scripts above without having to remember them.
2. Update `<title>`, the meta description, and the `og:` and `twitter:` tags.
3. **Set the canonical link to the clean address, with no `.html` on the end.** For a file called
   `grief.html` the canonical is `https://flourish-counseling.co/grief`. Set `og:url` to the same
   thing. If the canonical and the real address disagree, Google treats the page as a duplicate and
   quietly refuses to list it. That is the exact bug that cost six weeks.
4. Add the page to `sitemap.xml`, using that same clean address.
5. Add one line to `_redirects` so the old-style address still works:
   `/grief.html /grief 301!`
6. Link to it from somewhere a visitor can reach, usually the navigation or `blog.html`. A page
   nothing links to is a page nobody finds.
7. Publish as normal, then tell Crissy it is worth asking Google to look at it. She can do that in
   Search Console under URL Inspection, and it genuinely speeds things up: five of six pages
   requested that way in September were indexed within a day, while pages left alone had still not
   been crawled weeks later.

### Deleting a page

Remove the file, remove its `sitemap.xml` entry, remove any links to it, and add a redirect sending
its address somewhere sensible rather than leaving a dead end.

### Workflow for every edit

1. `git pull` first, so you are working from the current version.
2. Make the change.
3. Tell Crissy to double-click `index.html` and check it in her browser **before** publishing.
   Note that the visitor counter and the Psychology Today badge will not work when opened this way,
   because the page is not being served from the real address. That is normal and not a fault.
4. Publish with `.deploy/deploy.sh "what changed"`.
5. Tell her to check the live site a minute later.
6. If it looks wrong, run `.deploy/undo.sh`. Never leave the folder in a broken state.

---

## Known to-dos (great first tasks)

- [ ] Crissy to confirm: hero eyebrow color, pink vs espresso
- [ ] Click the "New Clients" booking button and confirm the SimplePractice popup opens properly

*Prepared 2026-07-21 by Kevin + Claude. Site design finalized June 2026 from Crissy's brand kit.*
*Publishing moved to GitHub + Netlify continuous deployment 2026-09-17.*
