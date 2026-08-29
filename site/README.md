# CLONE FRAME — site (cloneframe.io)

The public site: single-file pages in the CLONE FRAME design grammar (dark-first,
token-driven, standalone HTML).

```
cloneframe.html          # canonical hub/landing + whitepaper (edit THIS, never deploy/index.html)
deploy/                  # what gets uploaded to Hostinger (cloneframe.io)
│  .htaccess             # CSP + per-page overrides
│  acptracer.html        # ACP Tracer shell (canonical lives here)
│  index.html            # BUILD ARTIFACT — generated from cloneframe.html (gitignored)
scripts/
│  sync-deploy.sh        # canonical → deploy sync (run after every edit)
│  sync-deploy.command   # double-click wrapper for Finder
│  build-desktop-preview.js  # standalone offline preview with inlined assets
assets/                  # local images + GLB models used by the preview builder
```

Workflow: edit `cloneframe.html` → `sh scripts/sync-deploy.sh` → upload `deploy/`
to Hostinger → purge the CDN cache. `deploy/index.html` is a build artifact and
stays out of git.

## What the page carries

One file, several surfaces:

- **Alex Rider hub** — portfolio: projects, scientific papers, school tools, social.
- **CLONE FRAME landing** — the animated product story (scrollytelling, 3D robot,
  OG PASS, mint CTA — mint not open yet, buttons disabled on purpose).
- **Whitepaper** — GitBook-style docs describing the product as it actually ships:
  the **CLONE FRAME HUB** is a local, double-click, open-source app (one
  `index.html` + a local HUB Bridge daemon on `127.0.0.1`) — the iT terminal,
  a private in-app browser, CODE driving the user's own model (BYOK, no embedded
  assistant), the MATRIX local cluster, and keyless read-only wallet reads.
  App repo: [devclone20/cloneframe_app_executable](https://github.com/devclone20/cloneframe_app_executable).
- **AI Agents** — the fleet, one page per agent, each linking to its GitHub
  monorepo. Every agent is an iNFT forged from the
  [inft-i01](https://github.com/devclone20/inft-i01) template: a
  [Hermes Agent](https://github.com/NousResearch/hermes-agent) (Nous Research, MIT)
  under its own neural soul, fused with an NFT.

## History

- **2026-07-26** — whitepaper rewritten for the local-first HUB app (the "hosted
  platform / thousands of Harnesses" story was retired); AI Agents section now
  lists the whole fleet with repo links; ATLAS page removed from this site
  (ATLAS's own code lives in
  [devclone20/atlas_corporation_okx_ai](https://github.com/devclone20/atlas_corporation_okx_ai)).
