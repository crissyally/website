#!/bin/sh
# Publish the site.
#
#   .deploy/deploy.sh "short description of what changed"
#
# How this works now: this saves your changes and sends them to GitHub.
# Netlify is watching GitHub, so it picks them up and puts them live by itself,
# usually in well under a minute. There is no password or token involved.
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SITE_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
cd "$SITE_DIR"

if [ "$#" -lt 1 ] || [ -z "$*" ]; then
  echo "Usage: .deploy/deploy.sh \"short description of the changes\"" >&2
  exit 2
fi
DESCRIPTION=$*

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "This folder is not set up for publishing. Ask Kevin." >&2
  exit 1
fi
if ! git remote get-url origin >/dev/null 2>&1; then
  echo "This folder is not connected to GitHub yet, so nothing can be published." >&2
  echo "Ask Kevin to run the one-time setup." >&2
  exit 1
fi

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
  echo "Your changes are saved safely on this computer. Nothing is lost." >&2
  echo "Check your internet, then run this same command again." >&2
  echo "If it keeps failing, send Kevin this message." >&2
  exit 1
fi

echo ""
echo "Done. Netlify is publishing now, usually under a minute."
echo "  Your site:  https://flourish-counseling.co"
echo "  Progress:   https://app.netlify.com  (open the site, then the Deploys tab)"
