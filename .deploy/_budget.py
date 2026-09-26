#!/usr/bin/env python3
"""How many publishes are left this month. Called by budget.sh and deploy.sh; read-only.

Her Netlify Free plan has 300 credits a month. A publish costs 15. Visitors use a tiny amount
too. At 0 credits Netlify takes the website OFFLINE until the next billing period, so this keeps
a safety reserve that normal publishing never touches.

Exit codes: 0 = at least one publish is safe, 3 = publishing now would dip into the reserve,
1 = could not check.
"""
import json, os, sys, urllib.request, urllib.error
from datetime import datetime

API = "https://api.netlify.com/api/v1"
SITE = "flourish-counseling.co"
PER_DEPLOY = 15   # credits per production publish (Netlify Free, verified 2026-09-17)
RESERVE = 30      # never spent on normal publishing: covers visitor usage plus one emergency fix


def get(path):
    token = os.environ.get("NETLIFY_AUTH_TOKEN", "").strip()
    req = urllib.request.Request(API + path, headers={"Authorization": "Bearer " + token})
    with urllib.request.urlopen(req, timeout=30) as f:
        return json.load(f)


def summarize(acct):
    """Work out the numbers from Netlify's account record. Returns a dict, or None if the
    account record has no credit information (which would mean Netlify changed its API)."""
    credits = (acct.get("capabilities") or {}).get("credits") or {}
    if "included" not in credits or "used" not in credits:
        return None
    included, used = float(credits["included"]), float(credits["used"])
    left = included - used
    usable = max(0.0, left - RESERVE)
    return {
        "included": included, "used": used, "left": left,
        "deploys_left": int(usable // PER_DEPLOY),
        "resets": (acct.get("next_usage_period_start") or "")[:10],
        "exceeded": bool(acct.get("usages_exceeded")),
    }


def find_account():
    try:
        site = get("/sites/" + SITE)
        acct_id = site.get("account_id")
    except urllib.error.HTTPError:
        acct_id = None
    accounts = get("/accounts")
    for a in accounts:
        if acct_id and a.get("id") == acct_id:
            return a
    return accounts[0] if len(accounts) == 1 else None


def nice_date(iso):
    try:
        return datetime.strptime(iso, "%Y-%m-%d").strftime("%B %-d")
    except ValueError:
        return "the next billing period"


def main():
    try:
        acct = find_account()
    except urllib.error.HTTPError as e:
        print("  Could not reach Netlify (HTTP %s). The key may have expired." % e.code); return 1
    except Exception as e:
        print("  Could not reach Netlify: %s" % e); return 1
    if not acct:
        print("  Could not tell which Netlify account holds the website."); return 1
    s = summarize(acct)
    if not s:
        print("  Netlify did not report credit numbers, so the budget is unknown."); return 1

    print("Publishing budget for %s\n" % SITE)
    print("  Credits used:    %g of %g" % (s["used"], s["included"]))
    print("  Credits left:    %g" % s["left"])
    print("  Safety reserve:  %d (never spent, so the site never goes offline)" % RESERVE)
    print("  Publishes left:  %d  (each one costs %d)" % (s["deploys_left"], PER_DEPLOY))
    if s["resets"]:
        print("  Resets on:       %s" % nice_date(s["resets"]))
    if s["exceeded"]:
        print("\n  WARNING: Netlify reports this account over a usage limit. Do not publish; tell Kevin.")
        return 3
    if s["deploys_left"] < 1:
        print("\n  No publishes left without touching the safety reserve. Wait for the reset.")
        return 3
    return 0


if __name__ == "__main__":
    sys.exit(main())
