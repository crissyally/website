#!/bin/sh
# How many times the website can still be published this month.
#
#   .deploy/budget.sh
#
# Read-only. Run it BEFORE deciding to publish, and tell Crissy (or Kevin) the number.
# Her plan allows 300 credits a month, 15 per publish, and the site goes OFFLINE at 0.
set -eu
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SITE_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)

[ -f "$SITE_DIR/.env" ] && { set -a; . "$SITE_DIR/.env"; set +a; }

if [ -z "${NETLIFY_AUTH_TOKEN:-}" ]; then
  echo "No Netlify key is set up on this computer, so the budget cannot be checked here." >&2
  echo "" >&2
  echo "Crissy can see it herself at https://app.netlify.com under Billing (credits used)." >&2
  echo "Do not publish until someone has looked." >&2
  exit 1
fi

export NETLIFY_AUTH_TOKEN
exec python3 "$SCRIPT_DIR/_budget.py"
