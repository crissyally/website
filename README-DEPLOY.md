# Flourish reference site — how to publish (Netlify, free)

This `publish/` folder is a **self-contained, ready-to-host copy** of the v3 site plus a brand-book one-pager. It's a design reference for Crissy to recreate in Squarespace — every page is set to `noindex` so Google won't list it, and each page has a small "Design reference · Brand book" tab linking to `brand-book.html`.

## Deploy to Netlify (no account strictly needed to start)

1. Go to **https://app.netlify.com/drop**
2. **Drag this entire `publish/` folder** onto the page.
3. ~20 seconds later you get a live URL like `https://random-name-1234.netlify.app`.
   - Homepage → `…/` (the site)
   - Brand book → `…/brand-book.html`
4. To rename it: create a free Netlify account (the drop will prompt), then **Site settings → Change site name** to something like `flourish-reference` → `https://flourish-reference.netlify.app`.

That URL is what you send Crissy. Re-drag the folder anytime to update it.

## What's in here
- `index.html` + page files — the full v3 site (Home, About, Services, Team, Rates, Blog + posts, FAQ, Contact)
- `brand-book.html` — colors/hexes, fonts, logo usage, section looks, site architecture, photo direction, practice details
- `css/`, `js/`, `assets/` — all styles, fonts, photos, logos (nothing loads from outside except Google Fonts + the booking links)

## Notes
- Booking buttons point to the real SimplePractice portal (`flourish-counseling.clientsecure.me`) — fine for a reference, they just open the live booking page.
- Source of truth for the build remains `../v3/` and `../Squarespace Build Guide.md`. This folder is the **published copy** (assets flattened, `../assets/` → `assets/`, noindex added). If you edit v3, rebuild this folder rather than editing here by hand.
