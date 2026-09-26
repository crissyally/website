# For AI assistants working on this website

Read `START-HERE.md` in full before changing anything. It holds every rule for this folder.

The one rule that can take the website offline if it is broken:

**Publishing is rationed.** The hosting plan allows 300 credits a month, each publish costs 15, and
at 0 credits the site goes offline until the monthly reset. So:

1. Make all of Crissy's changes first and let her check them locally. Publish once per session, never per edit.
2. Before deciding to publish, run `.deploy/budget.sh` and tell Crissy how many publishes are left
   and when the budget resets. Decide together whether this change is worth one now.
3. Publish only with `.deploy/deploy.sh`. It re-checks the budget and refuses if publishing would
   touch the 30-credit safety reserve. Never work around a refusal.
4. Changes that never need to reach the live site (documentation like this file) go in with
   `[skip ci]` in the commit message, which costs nothing.
