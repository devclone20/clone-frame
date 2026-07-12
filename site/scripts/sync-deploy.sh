#!/bin/sh
# CLONE FRAME — sync canónico -> ficheiros publicados.
#   cloneframe.html (canónico, o que editamos) -> deploy/index.html
#   atlas.html                                 -> deploy/atlas.html
#   (deploy/ é o que se carrega no Hostinger / cloneframe.io)
#
# Corre sempre que os canónicos mudam. Um daemon launchd NÃO consegue fazer
# isto porque ~/Desktop é protegido pelo TCC do macOS (cp = "Operation not
# permitted"). Por isso o sync vive no fluxo de escrita: é chamado após cada
# edição, ou manualmente (ver sync-deploy.command para duplo-clique).
set -e
SITE="$(cd "$(dirname "$0")/.." && pwd)"

sync_one() {
  SRC="$SITE/$1"; DST="$SITE/deploy/$2"
  [ -f "$SRC" ] || { echo "erro: falta $SRC" >&2; exit 1; }
  if cmp -s "$SRC" "$DST" 2>/dev/null; then
    echo "já sincronizado: deploy/$2 ($(stat -f%z "$SRC") bytes)"
  else
    cp -p "$SRC" "$DST"
    echo "sincronizado: $1 -> deploy/$2 ($(stat -f%z "$SRC") bytes)"
  fi
}

mkdir -p "$SITE/deploy"
sync_one cloneframe.html index.html
sync_one atlas.html atlas.html
