#!/bin/sh
# Publish the site.
#
#   .deploy/deploy.sh "short description of what changed"
#
# This saves your changes and sends them to GitHub. Netlify watches GitHub and
# puts them live by itself, usually in under a minute. There is no password,
# token or account login involved anywhere in this.
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SITE_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
cd "$SITE_DIR"

if [ "$#" -lt 1 ] || [ -z "$*" ]; then
  echo "Usage: .deploy/deploy.sh \"short description of the changes\"" >&2
  exit 2
fi
DESCRIPTION=$*

git remote get-url origin >/dev/null 2>&1 || {
  echo "This folder is not connected to GitHub, so nothing can be published. Ask Kevin." >&2; exit 1; }

echo "Getting any changes other people published first..."
git pull --ff-only -q || {
  echo "" >&2
  echo "Could not update cleanly, so NOTHING was published." >&2
  echo "Your changes are safe on this computer. Send Kevin this message." >&2
  exit 1; }

git add --all
if git diff --cached --quiet; then
  echo "No changes to publish. The site is already up to date."
  exit 0
fi
git commit -m "$DESCRIPTION"

echo "Sending to GitHub..."
if ! git push; then
  echo "" >&2
  echo "Could not reach GitHub, so NOTHING was published." >&2
  echo "Your changes are saved on this computer. Nothing is lost." >&2
  echo "Check your internet, then run this same command again." >&2
  exit 1
fi

echo ""
if "$SCRIPT_DIR/verify-live.sh"; then
  echo "  Your site: https://flourish-counseling.co"
  exit 0
else
  exit 1
fi
