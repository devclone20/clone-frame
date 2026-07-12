# CLONE FRAME — site (cloneframe.io)

The public site, single-file pages in the CLONE FRAME design grammar (dark-first,
token-driven, standalone HTML).

```
cloneframe.html          # canonical hub/landing (edit THIS, never deploy/index.html)
atlas.html               # ATLAS whitepaper v2 — the Harness Architect
deploy/                  # what gets uploaded to Hostinger (cloneframe.io)
│  .htaccess             # CSP + per-page overrides
│  acptracer.html        # ACP Tracer shell (canonical lives here)
│  index.html            # BUILD ARTIFACT — generated from cloneframe.html (gitignored)
│  atlas.html            # BUILD ARTIFACT — copy of ../atlas.html (gitignored)
scripts/
│  sync-deploy.sh        # canonical → deploy sync (run after every edit)
│  sync-deploy.command   # double-click wrapper for Finder
│  build-desktop-preview.js  # standalone offline preview with inlined assets
assets/                  # local images + GLB models used by the preview builder
```

Workflow: edit the canonical files → `sh scripts/sync-deploy.sh` → upload `deploy/`
to Hostinger. The deploy copies of the two big pages are build artifacts and stay
out of git.

ATLAS's own code lives in its monorepo:
[devclone20/atlas_corporation_okx_ai](https://github.com/devclone20/atlas_corporation_okx_ai).
