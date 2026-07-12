# Alex Rider — Hub & CLONE FRAME — Build Plan

> Flagship personal + project hub. English, dark/light, Apple-product-grade scroll animation.
> Deploy: Hostinger (static) → later sync to GitBook. Author: Alex Rider — MEng Computer
> Science & Engineering, Instituto Superior Técnico (U. Lisboa). Built within the Virtuals
> Protocol society of AI agents (Base).

## Output
- `~/Desktop/clone-frame-site/` — deployable static site.
  - `index.html` — the hub (single-file, no build step).
  - `assets/img/` — staged images (hero/action/avatar/mint-card/hud×2).
  - `PLAN.md` — this file (also a GitBook seed).

## Tech (decided)
- **GSAP 3.13 + ScrollTrigger** (free, runs from `file://` + Hostinger) as the animation backbone.
- Native fallback: IntersectionObserver + `prefers-reduced-motion` gate.
- Fonts: Inter (UI) + JetBrains Mono (technical labels).
- Animate **only** `transform`/`opacity`. Reveal-once. Parallax disabled <1024px.

## Information architecture (nav)
Home · Projects in Development · Scientific Papers · AI Agents · Engines · Harness ·
School Tools · Social Media · GitHub (↗ github.com/devclone20) · **Settings** (bottom-left, MIT).

### Home
Alex hero (avatar) → Future Vision → Projects in Production (3 cards) → Mint template
(→ CLONE FRAME mint + OpenSea).

### Projects in Development → CLONE FRAME (centerpiece)
Apple-style scrollytelling, 10 scenes (storyboard locked):
1 Cold open · 2 Concept (iNFT) · 3 **Meet iCLONE** (iclone-hero, the ONE robot reveal) ·
4 Abilities (iclone-action) · 5 Three Frames · 6 Mechanics (5%/1%/Free) ·
7 Reserve (30% → BTC/VIRTUAL/$ICLONE) · 8 **Card minting soon** (mint-card) ·
9 Provenance · 10 CTA (Mint on CLONE FRAME · View on OpenSea).
Robot appears only in 3–4. HUD images = motion vocabulary (scanlines, terminal reveals), not pasted.

### Scientific Papers (Virtuals-whitepaper-grade)
Three-column docs shell: left collapsible sidebar tree · content · right anchor rail.
Groups: Overview · CLONE FRAME Whitepaper · Scientific Papers · Research Notes · Engineering/Specs ·
Community Updates · Resources · About. Content-first articles/papers feed (type pills:
PAPER/ARTICLE/UPDATE, filters by topic, pinned featured paper). Maps 1:1 to GitBook groups/pages.

### School Tools
IST LEIC+MEIC curriculum (300 ECTS) as filterable cards by area; specialization spine =
Distributed Systems & Cloud + AI/Deep Learning. Data-driven from a JS array.

### AI Agents / Engines / Harness / Social / Settings
Professional section intros + structured cards. Settings: theme, motion toggle, MIT/no-data statement.

## Design tokens (from design-system spec)
Dark: bg #08090C, surface #0E1014/#14171D, text #ECEEF3, focal **teal #2DD4BF**, amber #F5B544,
violet #8B7CF6. Light: bg #FBFBFD, text #0C0E12, teal #0D9488. One focal hue; amber/violet = data only.
Type display→64px/600/-0.03em; motion ease-out `cubic-bezier(.16,1,.3,1)`, reveal 640ms, stagger 70ms.

## Verification loop (after build)
Render → screenshot → critique (beauty, coherence, animation, copy) → fix. Repeat ~10×.

## Status
- [x] Assets staged · [x] 10-agent research team · [x] Architecture locked
- [ ] Foundation (shell + Home) · [ ] CLONE FRAME scrollytelling · [ ] Papers/School/other sections
- [ ] Verification loop · [ ] Hostinger deploy + base.dev meta tag + GitBook sync
