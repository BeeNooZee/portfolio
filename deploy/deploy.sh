#!/usr/bin/env bash
# Déploie le site statique (dossier site/) vers la racine web nginx.
# Lancé par le runner GitHub Actions sur la VM 192.168.1.117.
# Usage : bash deploy/deploy.sh [dossier_source]   (défaut : dossier courant)
set -euo pipefail

WEB_DIR="${WEB_DIR:-/var/www/portfolio}"
SRC="${1:-$(pwd)}"

echo "→ Déploiement du portfolio depuis $SRC/site vers $WEB_DIR"
mkdir -p "$WEB_DIR"

# Synchronise le contenu de site/ (miroir exact).
rsync -a --delete "$SRC/site/" "$WEB_DIR/"

# Fichiers statiques : pas besoin de redémarrer nginx, mais on recharge si dispo.
if command -v nginx >/dev/null 2>&1; then
  nginx -t >/dev/null 2>&1 && systemctl reload nginx 2>/dev/null || true
fi

echo "✓ Déployé ($(find "$WEB_DIR" -type f | wc -l | tr -d ' ') fichiers) — https://portfolio.teladsiuol.com"
