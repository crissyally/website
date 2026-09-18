# How this website is set up

Written for Crissy, and for whichever AI assistant she is working with. Nothing here is a secret.
There are no passwords or keys in this file, and there never should be.

The point of this document is that **Crissy owns all of this and can change any part of it without
asking anyone.** If she ever wants to remove someone's access, hand the site to a different
developer, or just understand what she is paying for and where it lives, the answer is here.

---

## The four pieces

| Piece | What it is | Who owns it |
|---|---|---|
| **This folder** | The website itself. Every page, image and style. | Crissy, on her Mac |
| **GitHub** | `github.com/crissyally/website`. The master copy and the full history of every change. | Crissy's GitHub account |
| **Netlify** | The service that serves the site to visitors. Watches GitHub and republishes automatically. | Crissy's Netlify account |
| **The domain** | `flourish-counseling.co`. Registered at GoDaddy, pointed at Netlify. | Crissy's GoDaddy account, under `cristina12886@gmail.com` |

Publishing works like this: you edit files in this folder, run `.deploy/deploy.sh "what changed"`,
it sends the change to GitHub, Netlify notices within seconds and republishes. The whole loop is
usually under a minute. No password is typed at any point.

---

## Who has access, and how to change it

**Crissy owns the GitHub account, the Netlify account and the domain.** Everything else is a
permission she has granted and can revoke.

**Kevin (`niveknus` on GitHub) is a collaborator on the repository.** That lets him push changes.
It does not let him delete the repository, change its settings, or remove her.

To remove his access, she goes to `github.com/crissyally/website`, then **Settings**, then
**Collaborators**, and removes `niveknus`. That takes effect immediately. Nothing about the website
breaks. Publishing from this folder continues to work exactly as before, because her ability to
publish comes from owning the account, not from him.

**Kevin can also work on this Mac directly** when he is on the home network, which is how he fixes
things without Crissy having to hand over the laptop. It never works from outside the house. If she
wants that access gone, any assistant working in this folder can remove it in a few seconds; just
ask for it plainly.

**Her school system, Sage, is separate.** It lives in `~/IICS Sage` and uses a different repository,
`crissyally/sage`, where Kevin is also a collaborator. Removing him from one does not remove him from
the other. Both are under her account.

---

## If Crissy ever wants someone else to work on this

Point them at `START-HERE.md` in this folder. It explains the whole setup, the brand rules, and how
publishing works. A competent developer or any capable AI assistant can pick it up from there
without talking to anyone.

To give them access: **Settings**, then **Collaborators**, then add their GitHub username.

---

## Worth knowing

**The repository is public.** Anyone can read the code and the history. That is deliberate and it is
why publishing is free: Netlify charges for private repositories with more than one person working
on them. Nothing sensitive is in here. Never put a password, a key, or anything about a client into
this folder, in a file or in a description of a change, because the history cannot be taken back.

**Crissy owns every piece of this.** The domain, the GitHub account, the Netlify account and this
computer are all hers. Kevin bought the domain for $18 in June 2026, when the previous one was lost,
and then transferred it into her GoDaddy account. Nothing here depends on his goodwill or his
continued involvement.

She reaches the domain by signing in to GoDaddy as **cristina12886@gmail.com**. It renews annually,
and letting it lapse is the one genuinely unrecoverable mistake available here, because the last
domain was lost that way. Keeping auto-renew on and the payment card current matters more than
anything else in this document.

**Her hosting key** lives in a file called `.env` in this folder. It is deliberately excluded from
GitHub and has never been uploaded. Publishing does not use it any more. It is only needed by
`.deploy/preview.sh`. If it were ever exposed, the fix is to generate a new one in Netlify under
user settings, which takes about thirty seconds.

**There is a full history of every change ever made.** Any version of the site can be restored. To
undo the most recent change, run `.deploy/undo.sh`. For anything older, ask an assistant to look
through the history.
