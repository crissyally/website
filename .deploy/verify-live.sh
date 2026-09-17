#!/bin/sh
# Wait until the live site actually matches what was just published.
#
#   .deploy/verify-live.sh
#
# Works out which files the last commit changed, then checks the live site for
# each one until it matches, or until it gives up. Exits 0 if everything
# matched, 1 if it timed out, so the caller can report honestly.
set -eu
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SITE_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
cd "$SITE_DIR"
SITE="https://flourish-counseling.co"
DEADLINE=$(( $(date +%s) + 150 ))

# map a file in the repo to the address it is served at
url_for() {
  case "$1" in
    index.html) echo "$SITE/" ;;
    *.html)     echo "$SITE/$(basename "$1" .html)" ;;
    *)          echo "$SITE/$1" ;;
  esac
}

CHANGED=$(git diff --name-only HEAD~1 HEAD 2>/dev/null \
          | grep -E '\.(html|css|js|xml|txt|png|jpg|jpeg|svg|webp)$' \
          | grep -v '^\.' || true)

if [ -z "$CHANGED" ]; then
  printf "Checking the site is up... "
  code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 20 "$SITE/" || echo 000)
  [ "$code" = "200" ] && { echo "yes."; exit 0; } || { echo "NO (got $code)"; exit 1; }
fi

echo "Waiting for the site to update..."
while :; do
  PENDING=""
  for f in $CHANGED; do
    u=$(url_for "$f")
    if [ -f "$f" ]; then
      # file should exist live and match this computer's copy
      if ! curl -s --max-time 20 "$u" -o /tmp/.flourish-live 2>/dev/null \
         || ! cmp -s "$f" /tmp/.flourish-live; then PENDING="$PENDING $f"; fi
    else
      # file was deleted, so the address should now be gone
      code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 20 "$u" || echo 000)
      [ "$code" = "404" ] || PENDING="$PENDING $f"
    fi
  done

  if [ -z "$PENDING" ]; then
    echo ""
    echo "Confirmed live. Every changed page is now showing the new version."
    exit 0
  fi
  if [ "$(date +%s)" -ge "$DEADLINE" ]; then
    echo ""
    echo "Gave up waiting after two and a half minutes." >&2
    echo "These have not updated yet:" >&2
    for f in $PENDING; do echo "    $f" >&2; done
    echo "" >&2
    echo "Your changes ARE saved and sent. Netlify may just be slow, or the" >&2
    echo "publish may have failed. Check https://app.netlify.com, or send Kevin this." >&2
    exit 1
  fi
  printf "."
  sleep 10
done
