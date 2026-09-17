#!/bin/sh
# Publish the site.
#
#   .deploy/deploy.sh "short description of what changed"
#
# TEMPORARY TRANSITIONAL VERSION (2026-09-17).
# It does BOTH things: it saves your changes to GitHub, and it also uploads
# them to Netlify directly. That way publishing works whether or not the
# automatic GitHub-to-Netlify connection has been switched on yet.
# Once that connection is live, this goes back to the simple push-only version.
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SITE_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
cd "$SITE_DIR"

if [ "$#" -lt 1 ] || [ -z "$*" ]; then
  echo "Usage: .deploy/deploy.sh \"short description of the changes\"" >&2
  exit 2
fi
DESCRIPTION=$*

git add --all
if git diff --cached --quiet; then
  echo "No changes to publish. The site is already up to date."
  exit 0
fi
git commit -m "$DESCRIPTION"

# 1. save to GitHub (this is what will eventually publish on its own)
echo "Saving to GitHub..."
if git push; then
  echo "  Saved."
else
  echo "" >&2
  echo "  Could not reach GitHub. Continuing to publish anyway." >&2
  echo "  Your changes are saved on this computer. Tell Kevin." >&2
fi

# 2. publish to Netlify directly (the original method, still the one that goes live today)
if [ ! -f "$SITE_DIR/.env" ]; then
  echo "Missing $SITE_DIR/.env - cannot publish." >&2
  exit 1
fi
set -a
. "$SITE_DIR/.env"
set +a
: "${NETLIFY_AUTH_TOKEN:?NETLIFY_AUTH_TOKEN is missing from .env}"

if ! command -v npx >/dev/null 2>&1 && [ -x "$HOME/.local/node-v24.19.0/bin/npx" ]; then
  PATH="$HOME/.local/node-v24.19.0/bin:$PATH"; export PATH
fi
command -v npx >/dev/null 2>&1 || { echo "npx is not available. Install Node.js first." >&2; exit 1; }

STAGING_DIR=$(mktemp -d "${TMPDIR:-/tmp}/flourish-netlify.XXXXXX")
cleanup() { rm -rf -- "$STAGING_DIR"; }
trap cleanup EXIT HUP INT TERM

rsync -a \
  --exclude '.env' --exclude '.git/' --exclude '.gitignore' --exclude '.netlify/' \
  --exclude '.deploy/' --exclude 'node_modules/' --exclude '.DS_Store' \
  --exclude 'START-HERE.md' --exclude 'README-DEPLOY.md' --exclude 'brand-book.html' \
  "$SITE_DIR/" "$STAGING_DIR/"

echo "Publishing to Netlify..."
npx --yes netlify-cli deploy --dir "$STAGING_DIR" --no-build --prod --message "$DESCRIPTION"

echo ""
echo "Done. Live at https://flourish-counseling.co"
