#!/usr/bin/env python3
"""Fetch and print Crissy's website traffic. Called by traffic.sh; read-only."""
import json, os, sys, urllib.request, urllib.error
from datetime import datetime, timedelta, timezone

TOKEN = os.environ.get("CLOUDFLARE_ANALYTICS_TOKEN", "").strip()
ACCOUNT = "a32c900cce8930ff1e7d1d68e2454678"
SITE = "flourish-counseling.co"
DAYS = int(sys.argv[1]) if len(sys.argv) > 1 else 7

end = datetime.now(timezone.utc)
since, until = (end - timedelta(days=DAYS)).strftime("%Y-%m-%dT%H:%M:%SZ"), end.strftime("%Y-%m-%dT%H:%M:%SZ")

def ask(dims, limit):
    d = "dimensions{%s}" % dims if dims else ""
    q = ('query{viewer{accounts(filter:{accountTag:"%s"}){rumPageloadEventsAdaptiveGroups('
         'filter:{datetime_geq:"%s",datetime_leq:"%s",requestHost:"%s"},limit:%d,orderBy:[count_DESC])'
         '{count sum{visits} %s}}}}' % (ACCOUNT, since, until, SITE, limit, d))
    req = urllib.request.Request("https://api.cloudflare.com/client/v4/graphql",
        data=json.dumps({"query": q}).encode(),
        headers={"Authorization": "Bearer " + TOKEN, "Content-Type": "application/json"})
    try:
        with urllib.request.urlopen(req, timeout=40) as f:
            out = json.load(f)
    except urllib.error.HTTPError as e:
        print("  Could not reach Cloudflare (HTTP %s)." % e.code); sys.exit(1)
    except Exception as e:
        print("  Could not reach Cloudflare: %s" % e); sys.exit(1)
    if out.get("errors"):
        print("  Could not read the numbers: %s" % out["errors"][0].get("message")); sys.exit(1)
    return out["data"]["viewer"]["accounts"][0]["rumPageloadEventsAdaptiveGroups"]

print("%s - last %d day%s\n" % (SITE, DAYS, "" if DAYS == 1 else "s"))
tot = ask("", 1)
if not tot:
    print("  No visits recorded in this period."); sys.exit(0)
print("  %d visits, %d page views" % (tot[0]["sum"]["visits"], tot[0]["count"]))

print("\nMost visited pages:")
for r in ask("requestPath", 10):
    print("  %5d visits   %s" % (r["sum"]["visits"], r["dimensions"]["requestPath"]))

print("\nWhere they came from:")
for r in ask("refererHost", 10):
    src = r["dimensions"]["refererHost"] or "typed the address, or a bookmark"
    print("  %5d visits   %s" % (r["sum"]["visits"], src))
