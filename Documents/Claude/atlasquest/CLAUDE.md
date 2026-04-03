# AtlasQuest

Geography learning and quiz game. Single HTML file, deployed via Netlify.

## Project Structure

- `practice.html` — the entire app (HTML, CSS, JS in one file)
- `deploy.sh` — deploys to Netlify staging or production

## Deployment

```bash
./deploy.sh staging   # → staging.atlasquest.io
./deploy.sh prod      # → atlasquest.io
```

Use `/sync` to deploy staging to prod, commit, and push to GitHub in one step.

## Netlify Sites

| Environment | URL | Netlify Site ID |
|---|---|---|
| Production | atlasquest.io | d097be82-9a5e-4260-8b05-42687b30434a |
| Staging | staging.atlasquest.io | 5aed47ac-f35a-4249-92e4-e7aa2be1ba3c |

DNS is managed via Netlify DNS (nameservers: dns1-4.p03.nsone.net).
Domain purchased on Namecheap.

## GitHub

Repo: https://github.com/adyophd/maplearn (name not yet updated)
Branch: `staging` (main working branch — push here)

## App Architecture

- **No build system** — edit `practice.html` directly
- **No server** — pure static HTML/CSS/JS
- **Map library**: Leaflet.js (satellite imagery tiles from Esri)
- **Leaderboard**: localStorage only (per-device, not shared)

## Game Modes

- **Learn Mode** — tap stars to reveal city names + fingerprint facts
- **Names Mode** — all city names visible on map
- **Quiz Mode** — guess city locations by tapping the map, graded A+ to F

## Countries & Difficulties

| Country | Difficulties |
|---|---|
| France, Germany, Russia, Japan, Canada, India | Easy (5), Medium (10), Hard (15), Very Hard (20) |
| USA | Capitals (50 state capitals), Capitals Plus (82 cities: capitals + largest non-capital per state) |

## Grading Scale (miles off)

A+ <40, A <80, A- <120, B+ <160, B <200, B- <240, C+ <280, C <320, C- <360, D+ <400, D <440, D- <480, F ≥480

## Key Design Decisions

- City facts ("fingerprint facts") are written to be surprising and memorable — one per city
- **Fact rules (enforce strictly when writing or revising facts):**
  - Max 200 characters
  - Prefer a fact about a highly famous person associated with the city; only use a different type of fact if no such person exists
  - Surprising, memorable, and consistent in tone across all cities
  - **Facts must be mutually coherent — no two facts may make contradictory claims.** Before writing any comparative claim (e.g. "the only," "the smallest," "the second-least"), verify it doesn't conflict with another city's fact. Known violation to fix: Pierre (SD) and Augusta (ME) both currently claim to be the second-least-populous state capital — only one can be true (Pierre at ~14k is smaller; Augusta at ~19k is third).
  - **Famous person coverage is currently inconsistent.** When the full fact set is next revised, audit each fact: if a city is associated with a famous person and the current fact doesn't mention one, replace it.
- Portland disambiguated as "Portland (ME)" and "Portland (OR)" in USA data
- Inspect button on quiz feedback collapses the modal so the map is visible with guess/answer markers still showing
- `adamyoungphd.com` is decommissioned — serves a blank page via a separate Netlify site (adamyoungphd-decommissioned)
