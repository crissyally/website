#!/usr/bin/env python3
"""How many publishes are left this month. Called by budget.sh and deploy.sh; read-only.

Her Netlify Free plan has 300 credits a month. A publish costs 15. Visitors use a tiny amount
too. At 0 credits Netlify takes the website OFFLINE until the next billing period, so this keeps
a safety reserve that normal publishing never touches.

Exit codes: 0 = at least one publish is safe, 3 = publishing now would dip into the reserve,
1 = could not check.
"""
import json, os, sys, urllib.request, urllib.error
from datetime import datetime, timezone

API = "https://api.netlify.com/api/v1"
SITE = "flourish-counseling.co"
PER_DEPLOY = 15   # credits per production publish (Netlify Free, verified 2026-09-17)
RESERVE = 30      # never spent on normal publishing: covers visitor usage plus one emergency fix
TRAFFIC = 15      # allowance for visitor usage; measured 6.6 credits in the first 18 days of Sep 2026


def get(path):
    token = os.environ.get("NETLIFY_AUTH_TOKEN", "").strip()
    req = urllib.request.Request(API + path, headers={"Authorization": "Bearer " + token})
    with urllib.request.urlopen(req, timeout=30) as f:
        return json.load(f)


def counted_use(deploys, period_start):
    """Credits spent by publishes this period, counted from the deploy list itself.
    Only successful production publishes are charged; failed ones are free."""
    n = sum(1 for d in deploys
            if d.get("context") == "production" and d.get("state") == "ready"
            and (d.get("created_at") or "") >= period_start)
    return n, n * PER_DEPLOY + TRAFFIC


def summarize(acct, deploys=None):
    """Work out the numbers. Returns a dict, or None if the account record has no credit
    information (which would mean Netlify changed its API).

    Netlify's own "used" figure cannot be trusted on its own: on 2026-09-26 it read 0 while
    the same account had 12 charged publishes this period (the dashboard had shown 172 used
    on 09-17). So the higher of Netlify's figure and our own count wins."""
    credits = (acct.get("capabilities") or {}).get("credits") or {}
    if "included" not in credits or "used" not in credits:
        return None
    included, reported = float(credits["included"]), float(credits["used"])
    start = acct.get("current_usage_period_start") or ""
    publishes, counted = counted_use(deploys or [], start_utc(start)) if start else (0, 0.0)
    used = max(reported, counted)
    left = included - used
    usable = max(0.0, left - RESERVE)
    return {
        "included": included, "used": used, "left": left, "publishes": publishes,
        "estimated": counted > reported,
        "deploys_left": int(usable // PER_DEPLOY),
        "resets": (acct.get("next_usage_period_start") or "")[:10],
        "exceeded": bool(acct.get("usages_exceeded")),
    }


def start_utc(iso):
    """Netlify gives the period start with an offset (-07:00); deploy times are UTC ("Z")."""
    try:
        return datetime.fromisoformat(iso).astimezone(timezone.utc).strftime("%Y-%m-%dT%H:%M:%S")
    except ValueError:
        return iso[:19]


def find_account():
    """Returns (account record, this period's deploys)."""
    site = get("/sites/" + SITE)
    acct = None
    for a in get("/accounts"):
        if a.get("id") == site.get("account_id"):
            acct = a
    deploys, page = [], 1
    while page <= 5:
        batch = get("/sites/%s/deploys?per_page=100&page=%d" % (site["id"], page))
        deploys += batch
        if len(batch) < 100:
            break
        page += 1
    return acct, deploys


def nice_date(iso):
    try:
        return datetime.strptime(iso, "%Y-%m-%d").strftime("%B %-d")
    except ValueError:
        return "the next billing period"


def main():
    try:
        acct, deploys = find_account()
    except urllib.error.HTTPError as e:
        print("  Could not reach Netlify (HTTP %s). The key may have expired." % e.code); return 1
    except Exception as e:
        print("  Could not reach Netlify: %s" % e); return 1
    if not acct:
        print("  Could not tell which Netlify account holds the website."); return 1
    s = summarize(acct, deploys)
    if not s:
        print("  Netlify did not report credit numbers, so the budget is unknown."); return 1

    print("Publishing budget for %s\n" % SITE)
    print("  Credits used:    %g of %g%s" % (s["used"], s["included"],
          "  (estimated: %d publishes x %d + %d for visitors)" % (s["publishes"], PER_DEPLOY, TRAFFIC)
          if s["estimated"] else ""))
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
