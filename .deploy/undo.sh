#!/bin/sh
# Undo the last published change and put the previous version back.
#
#   .deploy/undo.sh
#
# This does not delete history. It adds a new change that reverses the last one,
# so you can always undo the undo.
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SITE_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
cd "$SITE_DIR"

if [ -n "$(git status --porcelain --untracked-files=normal)" ]; then
  echo "Undo stopped: you have unsaved edits in this folder." >&2
  echo "Publish them first, or set them aside, then try again." >&2
  exit 1
fi
if ! git rev-parse --verify HEAD^ >/dev/null 2>&1; then
  echo "Undo stopped: there is no earlier version to go back to." >&2
  exit 1
fi

REVERTED=$(git log -1 --pretty=%s)
git revert --no-edit HEAD

echo "Sending to GitHub..."
if ! git push; then
  echo "Could not reach GitHub, so the site was NOT changed." >&2
  echo "The undo is saved on this computer. Run .deploy/deploy.sh \"undo\" when you are back online." >&2
  exit 1
fi

echo ""
echo "Undone: $REVERTED"
echo "Netlify is republishing the previous version now."
