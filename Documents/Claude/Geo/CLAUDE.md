# AtlasQuest

Geography learning and quiz game. Single HTML file, deployed via Netlify.

## Project Structure

- `france_cities.html` — the entire app (HTML, CSS, JS in one file)
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

- **No build system** — edit `france_cities.html` directly
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

A+ <20, A <40, A- <60, B+ <80, B <100, B- <120, C+ <140, C <160, C- <180, D+ <200, D <220, D- <240, F ≥240

## Key Design Decisions

- City facts ("fingerprint facts") are written to be surprising and memorable — one per city
- Portland disambiguated as "Portland (ME)" and "Portland (OR)" in USA data
- Inspect button on quiz feedback collapses the modal so the map is visible with guess/answer markers still showing
- `adamyoungphd.com` is decommissioned — serves a blank page via a separate Netlify site (adamyoungphd-decommissioned)
