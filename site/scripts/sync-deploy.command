#!/bin/sh
# Duplo-clique no Finder para sincronizar cloneframe.html -> deploy/index.html.
# (Na 1ª vez o macOS pode pedir para autorizar o Terminal a aceder à Secretária.)
cd "$(dirname "$0")" || exit 1
sh ./sync-deploy.sh
echo ""
echo "Feito. Podes fechar esta janela."
