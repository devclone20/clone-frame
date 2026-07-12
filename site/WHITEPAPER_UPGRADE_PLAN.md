# CLONE FRAME — Whitepaper Upgrade Plan
*Prepared for approval · 2026-07-02 · grounded in 10 parallel research digests + hacker audit*

## Part 1 — Already done this session (no approval needed)
1. **Auto-sync `cloneframe.html → deploy/index.html`.** macOS TCC blocks any daemon from touching `~/Desktop`, so sync lives in the write-path: `scripts/sync-deploy.sh` (+ double-clickable `.command`). Verified md5-identical.
2. **IST name → English.** 8× "Instituto Superior Técnico" → **"Técnico Lisboa"** (the institution's own English branding), "U. Lisboa" → "University of Lisbon".
3. **Security hardening** (hacker audit — no CRITICAL): removed the **Fénix personal-profile link** that deanonymized the "Alex Rider" pseudonym; added **SRI** to GSAP; neutralized the dead `[OPENSEA_SLUG]` mint-surface link; shipped `deploy/.htaccess` (HTTPS force, CSP, HSTS, nosniff, no directory listing); removed `.DS_Store`.
4. **New whitepaper pages** (house style, verified rendering, 0 console errors): **Plaza Place**, **HUB** (with `neural_soul.md` architecture + the four-lobe faculties + why it needs the iNFT + the **Genesis Engine**), and **Quantum Computer Update Protocol**. Five new diagrams added in the existing SVG grammar.

## Part 2 — Proposed content upgrades (needs your approval)
The whitepaper is already strong. These are the gaps worth closing, ranked by leverage:

**A. Accuracy/credibility hardening (recommended — high value, low effort)**
- **Neural-soul disclaimer.** Add one explicit line: the agent *recognizes and responds to* human affect — it does **not feel** and is not conscious. This is what separates a credible claim from the Replika/LaMDA failure mode. (Already softened in the new HUB copy; propose making it a standing callout.)
- **Quantum: no hype.** Keep "2029 = readiness deadline, not doomsday." Cite NIST FIPS 204/205 + Ethereum's PQ roadmap. Avoid "millions of qubits" (superseded) and any "breaks by 2029" claim.
- **Irys phrasing.** Say "sealed on Irys, an L1 datachain" — drop any Arweave lineage; hedge permanence as economically-enforced (staking/slashing), not physically absolute.

**B. Two new short pages (recommended)**
- **How ownership works (ERC-6551 in plain words).** Research found *no* project explains "an NFT that owns an agent" visually — a genuine white-space we can own. One diagram: NFT → token-bound account → agent, "the backpack that carries the agent's wallet, skills and memory."
- **Fees & royalties, in one place.** The 5% (in-contract, enforced on Plaza / honored elsewhere), the 1% skill fee, the 30%→reserves — stated once as named levers. Buyers expect this explicit.

**C. Polish (recommended)**
- **Full spelling/grammar pass** across every page (EN), consistent terminology (iNFT, Plaza Place, HUB, `neural_soul.md`).
- **Cross-links**: the CLONE FRAME platform page should link into the new Plaza and HUB pages.

**D. Optional (your call)**
- Generalize the "DigitalOcean + acp-cli" line on the Infrastructure page to "a hardened dedicated server" (reduces free recon; low severity).
- Self-host three.js/GSAP under `assets/vendor/` instead of CDN (removes third-party trust entirely).

## Part 3 — GitHub repo sync (needs approval to push)
Mirror the new material into the repos, README/docs only:
- **clone-frame** — Plaza Place + HUB sections; link the Genesis Engine.
- **iclone** — Genesis Engine + neural_soul faculties.
- **iIrysframe** — the Engine as the consumer of its `tokenURI`.
- **New:** a `QUANTUM.md` (Quantum Update Protocol) in clone-frame.
Branch per repo, PR for your review — nothing force-pushed to `main`.

## Decision
**APPROVED & IMPLEMENTED — 2026-07-02.** A (neural claim callout, Irys phrasing, quantum framing kept) ·
B (new Ownership/ERC-6551 page with diagram; Revenue page strengthened instead of a duplicate fees page) ·
C (full EN spelling pass: reunites→brings together, UK→US forms, iNFT-page royalty honesty, Plaza 6551 precision, Hostinger generalized; cross-links CLONE FRAME→Plaza/HUB/Ownership) ·
D (DigitalOcean generalized; GSAP+ScrollTrigger inlined = self-hosted; three.js pinned with SRI on modulepreload + importmap integrity; CSP tightened — cdnjs removed).
Note: three.js stays on jsdelivr (pinned+SRI) because ES modules do not load over file:// — full self-host would break the double-click preview.
Repo PRs: clone-frame#3 · iclone#9 · iIrysframe#2.
