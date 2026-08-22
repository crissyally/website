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

cd "$SITE_DIR"
if [ -n "$(git status --porcelain --untracked-files=normal)" ]; then
  echo "Undo stopped: commit or set aside your current changes first." >&2
  exit 1
fi
if ! git rev-parse --verify HEAD^ >/dev/null 2>&1; then
  echo "Undo stopped: there is no earlier commit to restore." >&2
  exit 1
fi

REVERTED_DESCRIPTION=$(git log -1 --pretty=%s)
git revert --no-edit HEAD

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
  --message "Undo: $REVERTED_DESCRIPTION"
