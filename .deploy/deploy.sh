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

if [ "$#" -lt 1 ] || [ -z "$*" ]; then
  echo "Usage: .deploy/deploy.sh \"short description of the changes\"" >&2
  exit 2
fi
DESCRIPTION=$*

cd "$SITE_DIR"
git add --all
if git diff --cached --quiet; then
  echo "There are no changes to commit or publish." >&2
  exit 1
fi
git commit -m "$DESCRIPTION"

STAGING_DIR=$(mktemp -d "${TMPDIR:-/tmp}/flourish-netlify.XXXXXX")
cleanup() {
  rm -rf -- "$STAGING_DIR"
}
trap cleanup EXIT HUP INT TERM

rsync -a \
  --exclude '.env' \
  --exclude '.git/' \
  --exclude '.gitignore' \
  --exclude '.netlify/' \
  --exclude '.deploy/' \
  --exclude 'node_modules/' \
  --exclude '.DS_Store' \
  "$SITE_DIR/" "$STAGING_DIR/"

npx --yes netlify-cli deploy \
  --dir "$STAGING_DIR" \
  --no-build \
  --prod \
  --message "$DESCRIPTION"
