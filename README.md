# LinkedIn Auto-Apply: a Claude Skill

Say **"apply to 10 jobs"**. Claude finds jobs on LinkedIn that match you, fills out the applications (inside LinkedIn, and on company career sites with the long forms), and keeps a spreadsheet of everything it did.

## Setup (a couple of minutes)

You need the **Claude desktop app** and the **[Claude Chrome extension](https://claude.com/chrome)**, with Chrome logged into LinkedIn. (Claude Code with the Chrome extension works too.)

1. Download [`linkedin-auto-apply.skill`](./linkedin-auto-apply.skill).
2. Drag it into a Claude chat and click **Save skill**.
3. Start a new chat and say: `apply to 3 jobs`

## What you'll be asked the first time

- Your resume (a PDF). Claude reads it so you never retype what is already on it.
- A folder on your computer to keep your profile and spreadsheet in.
- A few mostly multiple-choice questions: what jobs you want, where, how much, what to never apply to, and the answers that applications always ask (years of experience, licenses, work authorization).

That takes one conversation. After that, every run starts right away.

## When it stops and asks you

- Your first two applications, so you can check every answer before anything is sent.
- Any LinkedIn security check. It never clicks through those.
- Logins, account sign-ups, and verification codes on company sites.
- Any question it cannot answer truthfully from your resume and profile.
- A cover letter, the first few times, so you can approve the style.
- A great match that wants a skill you have but your resume does not mention. It holds the job and tells you the one-line fix.

## What it will never do

Invent answers. Edit your resume. Type or store passwords. Click through LinkedIn security checks. Enter your Social Security number, date of birth, or bank details. Apply faster than a person would.

## Things you can say

| Say | It does |
|---|---|
| `apply to 10 jobs` | Runs a batch |
| `show me matching jobs` | Lists matches, applies to nothing |
| `apply to this job: <link>` | Applies to one job you found yourself |
| `apply to my saved jobs` | Applies to the jobs you saved on LinkedIn |
| `continue` | Picks up where the last batch stopped |
| `I updated my resume, retry the held jobs` | Applies to jobs it held for you |
| `update my profile: ...` / `add <company> to my exclusions` | Changes your profile, no re-interview |
| `I got an interview at <company>` / `<company> rejected me` | Updates your spreadsheet |
| `show my pipeline` | Where everything stands |

Your spreadsheet lives in the folder you chose (or a Google Sheet if you prefer), one row per job with the status.

## Keeping it cheap

Screenshots are the expensive part. Connecting the free **Dice** or **ZipRecruiter** connector lets Claude search as plain text, which is much cheaper; only the applying itself uses the browser. Keep batches to 3-5 jobs on a smaller plan, 10-15 on a larger one. Company-site applications cost about two to three times a LinkedIn one.

## Good to know

Some company sites make you create an account for each company; Claude pauses for you to do that. Your profile and resume stay in the folder you chose on your own computer. Automating LinkedIn may go against [their User Agreement](https://www.linkedin.com/legal/user-agreement), and accounts that apply too fast can be restricted; the skill paces itself and stops on any security check, but use it at your own risk. Not affiliated with LinkedIn. MIT licensed.
