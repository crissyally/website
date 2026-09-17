#!/bin/bash
# Flourish Counseling website — one-time setup for Crissy's MacBook.
#
# AirDrop this file over, then double-click it. If macOS refuses to open it,
# right-click the file, choose Open, then click Open again.
#
# It connects this Mac's website folder to GitHub so that publishing works.
# It changes nothing about the website itself and publishes nothing.

REPO_SSH="git@github.com:flourish-counseling/website.git"
CRISSY_EMAIL="315077283+callyiics@users.noreply.github.com"

say()  { printf "\n\033[1m%s\033[0m\n" "$*"; }
ok()   { printf "  \033[32m✓\033[0m %s\n" "$*"; }
bad()  { printf "  \033[31m✗\033[0m %s\n" "$*"; }
stop() { printf "\n\033[31m%s\033[0m\n\nSend this whole window to Kevin.\n\n" "$*"; echo "Press Return to close."; read -r _; exit 1; }

clear
say "Flourish website setup — one time only"
echo "Nothing here changes the website or publishes anything."

# ---------------------------------------------------------------- 1. the folder
say "Step 1 of 5 — finding the website folder"

# 1) a path passed in on the command line always wins
SITE="${1:-}"

# 2) the known location, plus the iCloud-synced variant of it
if [ -z "$SITE" ]; then
  for guess in \
    "$HOME/Documents/Flourish Rebrand/flourish-counseling-site" \
    "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/Flourish Rebrand/flourish-counseling-site" \
    "$HOME/Desktop/Flourish Rebrand/flourish-counseling-site"
  do
    if [ -f "$guess/index.html" ] && [ -d "$guess/.git" ]; then SITE="$guess"; ok "Found it in the usual place."; break; fi
  done
fi

# 3) otherwise search, following symlinks, because iCloud turns Documents into one
if [ -z "$SITE" ]; then
  echo "  Looking... (this can take a few seconds)"
  CANDS=()
  while IFS= read -r hit; do
    d=$(dirname "$hit")
    [ -f "$d/index.html" ] && [ -d "$d/.git" ] && CANDS+=("$d")
  done < <(find -L "$HOME/Documents" "$HOME/Desktop" "$HOME" -maxdepth 7 -type f -name "_redirects" 2>/dev/null)
  if [ "${#CANDS[@]}" -eq 1 ]; then
    SITE="${CANDS[0]}"
  elif [ "${#CANDS[@]}" -gt 1 ]; then
    echo "  Found more than one copy. Pick the one Crissy actually works in:"
    i=1; for c in "${CANDS[@]}"; do echo "     $i) $c"; i=$((i+1)); done
    printf "%s" "  Type the number and press Return: "
    read -r PICK
    SITE="${CANDS[$((PICK-1))]}"
  fi
fi

# 4) last resort: let a human point at it
if [ -z "$SITE" ]; then
  echo ""
  echo "  Could not find it automatically."
  echo "  This is usually because Terminal has not been allowed to read Documents yet."
  echo "  Drag the 'flourish-counseling-site' folder from Finder into this window, then press Return:"
  read -r DROPPED
  # Terminal escapes spaces with a backslash when you drag; undo that, and any quoting
  SITE=$(printf '%s' "$DROPPED" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//" -e "s/^'//" -e "s/'$//" -e 's/^"//' -e 's/"$//' -e 's/\\ / /g')
fi

[ -n "$SITE" ] || stop "No folder given."
[ -d "$SITE" ] || stop "That is not a folder: $SITE"
[ -f "$SITE/index.html" ] || stop "No index.html inside: $SITE"
cd "$SITE" || stop "Could not open: $SITE"
ok "Using: $SITE"
git rev-parse --git-dir >/dev/null 2>&1 || stop "This folder has no saved history. Kevin needs to look."
ok "Saved history found: $(git log --oneline -1 2>/dev/null)"

if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
  echo ""
  echo "  Heads up: this folder has edits that were never published:"
  git status --short | head -10 | sed 's/^/     /'
  echo ""
  echo "  That is fine, they will be kept. Press Return to continue, or Ctrl-C to stop."
  read -r _
fi

# ---------------------------------------------------------------- 2. the key
say "Step 2 of 5 — giving this Mac an identity key"
if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
  ok "This Mac already has one, reusing it."
else
  ssh-keygen -t ed25519 -C "crissy-macbook" -f "$HOME/.ssh/id_ed25519" -N "" >/dev/null 2>&1 \
    || stop "Could not create the key."
  ok "Created a new key."
fi

# ---------------------------------------------------------------- 3. register
say "Step 3 of 5 — add this key to GitHub"
echo "  1. Open  https://github.com/settings/keys   (signed in as callyiics)"
echo "  2. Click  New SSH key"
echo "  3. Title:  Crissy MacBook"
echo "  4. Paste EXACTLY the block between the lines below, then Add SSH key"
echo ""
echo "------------------------------------------------------------------"
cat "$HOME/.ssh/id_ed25519.pub"
echo "------------------------------------------------------------------"
echo ""
printf "%s" "  Tip: triple-click that line to select it, then Command-C. Press Return when added: "
read -r _

say "Checking GitHub recognises this Mac"
for attempt in 1 2 3; do
  OUT=$(ssh -o StrictHostKeyChecking=accept-new -o ConnectTimeout=10 -T git@github.com 2>&1)
  case "$OUT" in
    *successfully\ authenticated*) ok "${OUT%%,*} — recognised."; break ;;
    *) bad "Not recognised yet."
       [ "$attempt" = 3 ] && stop "GitHub still does not recognise this Mac. Key may not be saved, or it was pasted incompletely."
       printf "%s" "  Double-check the key was added, then press Return to retry: "; read -r _ ;;
  esac
done

# ---------------------------------------------------------------- 4. connect
say "Step 4 of 5 — connecting this folder to GitHub"
git config user.name "Cristina Ally"
git config user.email "$CRISSY_EMAIL"
ok "Publishing name set."
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REPO_SSH"; ok "Connection updated."
else
  git remote add origin "$REPO_SSH"; ok "Connection added."
fi
git fetch origin >/dev/null 2>&1 || stop "Could not reach the website repository on GitHub."
ok "Reached the repository."

BR=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
[ "$BR" = "main" ] || stop "Unexpected branch '$BR'. Kevin needs to look."
git branch --set-upstream-to=origin/main main >/dev/null 2>&1

say "Step 5 of 5 — getting the latest version"
if git pull --ff-only 2>&1 | sed 's/^/     /'; then
  ok "Up to date: $(git log --oneline -1)"
else
  stop "Could not update cleanly. Nothing was broken, but Kevin needs to look."
fi

[ -f .deploy/deploy.sh ] && ok "New publish command is in place." || bad "deploy.sh missing — tell Kevin."

printf "\n\033[32m\033[1mAll set.\033[0m\n\n"
echo "Crissy publishes from now on with:"
echo "     .deploy/deploy.sh \"what changed\""
echo "and undoes the last change with:"
echo "     .deploy/undo.sh"
echo ""
echo "Kevin: Netlify still needs linking to the repo. Do that next, same sitting."
echo ""
echo "Press Return to close."
read -r _
