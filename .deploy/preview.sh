#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SITE_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)

if [ ! -f "$SITE_DIR/.env" ]; then
  echo "Missing $SITE_DIR/.env" >&2
  exit 1
fi

set -a
. "$SITE_DIR/.env"
set +a
: "${NETLIFY_AUTH_TOKEN:?NETLIFY_AUTH_TOKEN is missing from .env}"

if ! command -v npx >/dev/null 2>&1 && [ -x "$HOME/.local/node-v24.19.0/bin/npx" ]; then
  PATH="$HOME/.local/node-v24.19.0/bin:$PATH"
  export PATH
fi
if ! command -v npx >/dev/null 2>&1; then
  echo "npx is not available. Install Node.js first." >&2
  exit 1
fi

cd "$SITE_DIR"
STAGING_DIR=$(mktemp -d "${TMPDIR:-/tmp}/flourish-netlify.XXXXXX")
cleanup() {
  rm -rf -- "$STAGING_DIR"
}
trap cleanup EXIT HUP INT TERM

# Upload only public website files. Local credentials and deployment tooling
# are deliberately left out of the staging copy.
rsync -a \
  --exclude '.env' \
  --exclude '.git/' \
  --exclude '.gitignore' \
  --exclude '.netlify/' \
  --exclude '.deploy/' \
  --exclude 'node_modules/' \
  --exclude '.DS_Store' \
  "$SITE_DIR/" "$STAGING_DIR/"

echo "Creating a draft preview. Production will not be changed."
npx --yes netlify-cli deploy \
  --dir "$STAGING_DIR" \
  --no-build \
  --message "Draft preview"
