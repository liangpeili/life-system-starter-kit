---
name: morning
description: "Daily journaling, reflection, and planning using the Johnny.Decimal life-system structure."
user-invocable: true
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, AskUserQuestion
---

# Morning Journaling, Reflection & Planning

Use a direct, curious tone. Push back when the plan is vague, overloaded, or disconnected from the user's goals.

## Step 1: Load Context

Read these in parallel:

1. Yesterday's daily journal at `~/Documents/YOURNAME/20-29-journal/21-daily/YYYY/MM/YYYY-MM-DD.md`. If it does not exist, look back up to 7 days.
2. Today's daily journal using the same pattern.
3. Annual goals at `~/Documents/YOURNAME/10-19-planning/12-annual-goals/YYYY.md`.
4. Life plan at `~/Documents/YOURNAME/10-19-planning/11-life-plan/plan.md`.
5. Inbox at `~/Documents/YOURNAME/50-59-capture/51-inbox/inbox.md`.
6. Active decisions in `~/Documents/YOURNAME/30-39-knowledge/32-decisions/` with status `Open` or `Active`.
7. The JD index at `~/Documents/YOURNAME/00-09-system/00-index.md` when structure context would help.

## Step 2: Review Yesterday

Present what was planned, what happened, and what seems unresolved.

Then ask the user to walk through yesterday. Use AskUserQuestion when available. Push past vague narratives. Name avoidance or overcommitment when you see it.

Update yesterday's journal if needed:

- fill in missing log items
- add an evening reflection if missing
- mark completed todos
- keep the user's voice

## Step 3: Review Today

Open or create today's daily journal.

Clean it up:

- remove stale carry-over items
- keep only still-relevant commitments
- surface inbox items worth promoting today
- refresh active decisions if they matter this week

Ask what matters most today. Offer options, but do not let the list become bloated.

## Step 4: Alignment Check

Check whether today's work ladders up:

1. Do the main todos connect to annual goals?
2. Are there neglected annual goals with no recent action?
3. Do active decisions need action this week?
4. If priorities drift, should the goals or life plan be updated?

Use the Johnny.Decimal structure to orient the user. If something has no obvious home, point that out.

## Step 5: Finalize Today's Journal

Make sure today's note includes:

- morning priorities
- log section
- active projects
- active decisions
- carried-over items only if still relevant

Keep the number of key outcomes realistic. Three is usually enough.

## Step 6: Close

Before finishing:

- challenge plans that are too ambitious
- name anything important being avoided
- add non-today actions to `~/Documents/YOURNAME/50-59-capture/51-inbox/inbox.md`

End with a short summary of the 1-3 things that matter most.

## During the Day

When something log-worthy happens:

- add a timestamped line to today's log
- say `Added to log: ...`

When follow-up actions emerge but are not for today, add them to the inbox.

## Evening

If invoked for evening reflection:

- read today's journal
- summarize what got done vs planned
- ask Franklin's closing question
- append a brief reflection
- carry forward unfinished items thoughtfully, not automatically

