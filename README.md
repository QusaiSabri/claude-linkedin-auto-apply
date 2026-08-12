# LinkedIn Auto-Apply: a Claude Skill

Say **"apply to 10 jobs"**. Claude finds jobs on LinkedIn matching your criteria, applies for you (Easy Apply inside LinkedIn; external sites like Greenhouse and Workday filled with your own resume), and logs everything to a tracker.

## Setup (a couple of minutes)

Needs the **Claude desktop app** (with Cowork) and the **[Claude Chrome extension](https://claude.com/chrome)**, with Chrome logged into LinkedIn.

1. Download [`linkedin-auto-apply.skill`](./linkedin-auto-apply.skill).
2. Drag it into a Claude chat, click **Save skill**.
3. New chat: `apply to 3 jobs`

The first run interviews you once (mostly multiple-choice): it reads your resume PDF and only asks what's not on it. After that, every run starts instantly, and your first two applications pause for your approval so you can check every answer before anything is sent.

## What it does

- Reads each job description; skips excluded companies, duplicates, and bad fits.
- **Never invents anything.** Answers come only from your resume and interview; anything it can't truthfully answer, it asks you. Captchas and logins are handed to you too.
- **Resume-gap holds:** if a great match wants a skill that's on your LinkedIn but not your resume, it holds the job and tells you the one-line fix. You edit, it applies.
- Paces itself like a human, respects your daily cap, stops cold on any LinkedIn verification screen.
- Ends each batch honestly: submitted, skipped and why, held jobs, and which keywords keep appearing in JDs that your resume is missing.

## Commands

| Say | It does |
|---|---|
| `apply to 10 jobs` | Runs a batch |
| `show me matching jobs` | Dry run, applies to nothing |
| `I updated my resume, retry the held jobs` | Applies to held jobs |
| `update my profile: ...` | Edits your profile, no re-interview |
| `add <company> to my exclusions` | Never applies there again |

## Keeping it cheap

Browser screenshots are the expensive part. Connect the free **Dice** or **ZipRecruiter** connector (no account needed) and the skill searches jobs as plain text instead, ~10x cheaper; only applying uses the browser. Keep batches at 3-5 jobs on a Pro plan, 10-15 on Max (external applications cost ~2-3x an Easy Apply). Sonnet is the recommended model; step up a tier only if forms keep getting misread.

## Privacy & safety

Your profile and resume live only in a folder you choose on your own computer; passwords are never stored or typed. The `.gitignore` keeps personal files out of git if you fork. Automating LinkedIn may violate [their User Agreement](https://www.linkedin.com/legal/user-agreement) and fast-applying accounts can be restricted; the skill paces itself and stops on verification challenges, but use at your own risk. Not affiliated with LinkedIn.

## License

MIT
