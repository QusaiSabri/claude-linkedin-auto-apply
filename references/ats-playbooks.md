# External applications: ATS playbooks

Read this before the first external application of a batch. External sites vary wildly; proceed screenshot by screenshot (screenshot, one action, verify) and never assume a layout carried over from the last site. Identify the ATS from the URL or page footer, then follow its playbook.

## Universal flow

1. Click Apply on the LinkedIn job page; the company site opens in a new tab. Work there.
2. Identify the ATS. Unknown or custom site: treat it as the "Other" playbook.
3. Resume upload first when offered; many sites autofill from it. Then verify every autofilled field against the profile; autofill garbles dates, titles, and phone formats.
4. Fill remaining fields from the profile only (`screening-answers.md` has the map). Missing required fact: ask the user, or log `Draft - missing field` with the URL and the field name, then move on.
5. Cover letter and essay fields: rules in `screening-answers.md`.
6. Self-ID pages: choose the decline options unless the profile says otherwise.
7. Review page: in warm-up mode, or on the user's first external application ever, show the user every answer before Submit.
8. Submit. Count only after an explicit confirmation page or message ("Thank you for applying", "Application submitted"); screenshot it.
9. Log with Apply Type `External`, close the ATS tab, and move to vetting the next job.

## Walls

- **Login or account creation:** pause and ask the user to log in or create the account themselves. Never invent, reuse, type, or store passwords. Continue once they say it is done.
- **Email verification code (OTP):** ask the user to paste the code. Fetch it from a connected mail tool only if the user has explicitly said that is OK.
- **Captcha:** on an external site this is routine, not an account-risk signal. Ask the user to solve it, then continue. (A captcha or "verify it's you" on LinkedIn itself is different: stop the batch.)
- **Assessments, timed tests, video interviews, personality questionnaires:** do not attempt them. Log `External - blocked` with the reason and URL so the user can do it by hand.
- **Requests for SSN, date of birth, ID numbers, bank details, or a fee:** stop, log `External - blocked`, tell the user. See the sensitive-data rule.

## Step budgets

Set expectations per ATS, and scale down when the user's plan is constrained. If a site exceeds its budget by half, loops, or errors twice on the same step, log `External - blocked` and move on rather than burning the batch.

| ATS | Typical steps | Notes |
|---|---|---|
| Greenhouse | 10-15 | single page, no account |
| Lever | 8-12 | single page, no account |
| Ashby | 10-15 | single page, no account |
| SmartRecruiters | 15-25 | may require email verification |
| iCIMS | 20-30 | account plus multi-page |
| Workday | 30-45 | account per company, 5-7 pages, verify parsed entries |
| Taleo / SuccessFactors / Oracle | 30-45 | old multi-page flows, frequent session timeouts |
| Other / custom | 15-30 | screenshot every step |

## Workday

Recognize: URL contains `myworkdayjobs.com` or `wd1`/`wd3`/`wd5.myworkday`. Flow: "Apply" > "Autofill with Resume" or "Apply Manually" > account creation or sign-in (every company has its own Workday account; ask the user) > My Information > My Experience > Application Questions > Voluntary Disclosures > Self Identify > Review.
- Choose Autofill with Resume, then on My Experience compare each parsed job and school against the work-history and education tables. Fix wrong dates, split merged entries, remove duplicates, add missing rows. Do not accept a garbled entry to save steps.
- "How did you hear about us" is usually a searchable dropdown; type the real source and pick it.
- Phone requires a country code selector plus digits without punctuation.
- Skills section: add only skills from the profile.
- Voluntary Disclosures and Self Identify: decline options, then the CC-305 name and date attestation.
- Confirmation shows as "Congratulations" or "Thank you" plus an email; the "My Applications" tab (candidate home) lists submitted ones, useful for pre-flight checks.

## Greenhouse

Recognize: `boards.greenhouse.io` or `job-boards.greenhouse.io`, or an embedded form with a "Powered by Greenhouse" footer. Single page. Resume upload accepts PDF; "Enter manually" is the fallback. Cover letter is a separate optional upload or paste. Custom questions sit below the standard fields, self-ID (EEO, veteran, disability) at the bottom. Some boards add a captcha before submit. Confirmation: "Thank you for applying" banner on the same URL.

## Lever

Recognize: `jobs.lever.co`. Single page. Resume upload autofills name, email, links; verify. "Additional information" is the free-text field, optional. Some postings require a LinkedIn URL. Confirmation: "Application submitted" page.

## Ashby

Recognize: `jobs.ashbyhq.com`. Single page, modern form; questions are often required and phrased as short essays, so the essay rules apply. Confirmation: inline success message.

## iCIMS

Recognize: `icims.com` in the URL. Account required (ask the user), then multi-page: profile, resume upload, work history, education, questions, EEO. Autofill from resume is unreliable; verify against the tables. Session timeouts are common; if the form resets, log `External - blocked` rather than starting over more than once.

## SmartRecruiters

Recognize: `jobs.smartrecruiters.com`. Resume upload then a single scrolling form, sometimes with email verification before submit (OTP wall). Confirmation: "Thanks for applying" page.

## Taleo, SuccessFactors, Oracle Recruiting, other

Multi-page, account-based, old UI, frequent timeouts. Same rules as iCIMS. Budget conservatively; if the user's plan is constrained, prefer skipping these and telling the user which jobs they are so they can apply by hand.
