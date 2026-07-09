# COMP4020 skills

Claude Code skills for students in
[COMP4020/COMP8020 Agentic Coding Studio](https://comp.anu.edu.au/courses/comp4020-agentic-coding-studio/)
at the ANU. This repo is a
[Claude Code plugin marketplace](https://docs.anthropic.com/en/docs/claude-code/plugins):
you subscribe once, and skill updates flow to you automatically.

## Install

From any Claude Code session:

```
/plugin marketplace add comp4020-agentic-coding-studio/core
/plugin install comp4020@comp4020
```

Or from the shell:

```sh
claude plugin marketplace add comp4020-agentic-coding-studio/core
claude plugin install comp4020@comp4020
```

To pick up updates later: `/plugin marketplace update comp4020`.

## What's in the plugin

### course-info

Answers course-admin questions — "when is assignment 3 due and how much is it
worth?", "what's the extension policy?", "what does the week 4 lecture cover?" —
by querying the live course website (its JSON content-graph API and `llms.txt`
endpoints). The skill holds no course facts itself, only knowledge of where to
look, so its answers are always as current as the site. It triggers
automatically on questions about the course, or invoke it directly with
`/comp4020:course-info`.

### check-balance

Answers "check my balance", "how much budget do I have left?", "why is my key
not working?" by querying the course proxy's `/api/me` endpoint with the same
key Claude Code is already using — no extra setup or login. Reports weekly spend
against the cap and when the budget resets, explains the common failure modes
(off-campus without the ANU VPN, revoked key), and knows what to suggest when
the budget runs out. Triggers automatically on budget/usage questions, or invoke
it directly with `/comp4020:check-balance`.

### quickstart

Walks a first-time student through getting their strproxy key working in Claude
Code: checks whether it's already set, points them at the key on Canvas, merges
it safely into `~/.claude/settings.json` (never clobbering existing settings,
never echoing the key), and verifies the round-trip. Invoke with
`/comp4020:quickstart` or ask to "set up my key".

### doctor

A smart setup check. Reads the course's required-tools list live from the site,
then checks the student's machine — Git, the GitHub CLI (`gh`) and its auth,
flyctl and its auth/org membership, the Claude Code proxy config and a live
`/api/me` probe (which doubles as an "am I on the VPN?" check), Chrome version,
mise — and **offers to fix** what's broken, confirming each step. Invoke with
`/comp4020:doctor` or ask "is my setup right?".

### deadline-radar

The proactive view of the schedule: reads today's date and the live course
schedule and tells the student what's due this week and next, sorted by date
with weights, leading with the single most urgent thing. Invoke with
`/comp4020:deadline-radar` or ask "what's due?" / "what should I work on?".

### new-week

Sets up the repo for a new weekly crit prototype: creates it (private) from that
week's starter template, then **merges the student's `CLAUDE.md` / `AGENTS.md`
harness forward** from last week's repo rather than resetting them to
boilerplate, keeping the rules they've accreted and taking the template's new
material. Asks whether they're keeping their stack or switching, and refuses to
carry the prototype source, `spec/` or reflections across. Knows which weeks
don't start a fresh prototype (the retro crits, and weeks 9–11, which run on the
final-project repo). Invoke with `/comp4020:new-week` or ask to "start this
week's prototype".

### submission-preflight

Checks that work is actually submittable before a crit or assignment deadline:
cross-references the assessment spec (from the site) with the local repo — clean
tree, everything pushed to GitHub, marker can see it, required structure present
— and, in the full-stack half, that the deploy is healthy and reachable. Offers
to run the safe fixes (commit, push), but leaves the actual submission to the
student. Invoke with `/comp4020:submission-preflight` or ask "am I ready to
submit?".

### help

Lists everything above and routes to the right skill. Invoke with
`/comp4020:help`.
