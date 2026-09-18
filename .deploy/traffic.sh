#!/bin/sh
# How many people visited the website.
#
#   .deploy/traffic.sh          last 7 days
#   .deploy/traffic.sh 30       last 30 days
#
# Read-only. This cannot change anything, on the website or in Cloudflare.
set -eu
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SITE_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)

[ -f "$SITE_DIR/.env" ] && { set -a; . "$SITE_DIR/.env"; set +a; }

if [ -z "${CLOUDFLARE_ANALYTICS_TOKEN:-}" ]; then
  echo "No traffic key is set up on this computer, so the numbers are not available here." >&2
  echo "" >&2
  echo "Crissy can always see them herself at https://dash.cloudflare.com" >&2
  echo "signed in as cristina12886@gmail.com, under Analytics then Web analytics." >&2
  echo "" >&2
  echo "To make this command work instead, see HOW-THIS-IS-SET-UP.md." >&2
  exit 1
fi

export CLOUDFLARE_ANALYTICS_TOKEN
exec python3 "$SCRIPT_DIR/_traffic.py" "${1:-7}"
