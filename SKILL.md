---
name: linkedin-auto-apply
description: Find and apply to jobs for the user, using LinkedIn as the search engine. Auto-submits LinkedIn Easy Apply jobs AND external company-site applications (Greenhouse, Workday, Lever, etc.), uploading the user's local resume file where needed, then logs each to a tracker. Use when the user asks to apply to jobs, run a job batch, "apply to N jobs", find and apply to roles, top up applications, do a dry run of job matches, or update their job-application profile. On first use it interviews the user to build a reusable candidate profile (identity, criteria, exclusions, screening answers, resume files), then reuses it. Includes resume-gap holds, warm-up approvals, pacing to protect the user's LinkedIn account, and the LinkedIn UI workarounds and Sheets-logging tricks that otherwise waste many retries.
---

# LinkedIn auto-apply

Submit N real job applications for the user, discovered on LinkedIn, vetted against their rules, then log each. LinkedIn **Easy Apply** jobs are submitted inside LinkedIn; **external** jobs ("Apply" opens the company's own site) are filled on that site screenshot by screenshot, uploading the user's local resume file. Works for any user: the profile is collected on first use, not hardcoded. **This skill ships with zero personal data and zero assumed preferences.** Salary, roles, locations, exclusions, caps: every value comes from THIS user's interview answers. Never carry over, guess, or reuse values from examples, other users, or prior conversations.

Two principles above everything else:

1. **Never fabricate.** No invented experience, no guessed answers, no rounded-up years, and never edit the user's resume yourself. A wrong answer submitted to an employer cannot be taken back.
2. **Protect the user's accounts.** Applying too fast or clicking through verification screens can get a LinkedIn account restricted. A restricted account costs the user far more than a slower batch.

## Step 0 — Load or create the candidate profile

Profile file: `candidate-profile.md`.

**Where it lives:** the profile, resume copies, and tracker hold PII (phone, address, salary) and must survive across sessions. On first use, ask the user for a folder on their computer to keep them in (a connected folder if running in Cowork; any stable folder otherwise). Record that location inside the profile itself and reuse it. If a previously recorded folder is unreachable, ask rather than silently recreating the profile.

- If the profile exists, read it and use it. Skip the interview.
- If not, interview the user, then write it.

### The interview

**Resume first, questions second.** Ask for the local resume file (PDF preferred) before anything else, read it, and extract every fact it contains: name, email, phone, city/state/ZIP, LinkedIn and GitHub/portfolio URLs, current employer and title, education, and the skills list. Keep the extracted text in the profile folder (`resume-text.md`) for the resume-gap check. Then show the user what was extracted in ONE confirmation round ("here is what I read from your resume, correct anything wrong") and ask only the questions the resume cannot answer. A user should never be asked to type their phone number when it is printed at the top of their resume.

Use the AskUserQuestion tool (multiple-choice / form UI) if it is available: batch related questions into option sets so setup takes 3-4 rounds, not twenty free-text messages. Multiple-choice changes only the FORMAT of the questions, never the coverage: every fact below must end up in the profile, for every new user, from their resume or from their answer. Common answers may appear as selectable options (e.g. "prefer not to answer" for self-ID, "remote only" for location), but the user always chooses; skip nothing and prefill nothing except resume-extracted facts the user confirms. If the tool is unavailable, fall back to batched plain-text questions.

**Identity & contact** (mostly extractable from the resume; confirm, then ask only gaps)
- Full name, email, phone (+ country code).
- Home city/state/country and ZIP (ZIP is required by many ATS forms; resumes often omit it, so it usually needs asking).
- LinkedIn profile URL, GitHub/portfolio URL (optional).
- Current employer, current title.
- Work authorization: authorized in target country? need sponsorship? (Never guess this from a resume; always ask.)

**Resume (both copies matter)**
- **Local resume file:** already collected above; this file is uploaded on external company sites.
- **LinkedIn saved resume:** confirm the same resume is uploaded/saved on LinkedIn and get its exact filename; Easy Apply selects the saved copy, it never uploads files inside LinkedIn.
- **Variants (optional):** if they keep more than one version tuned to different role types, record each local path, the matching LinkedIn saved filename, and a simple rule for which variant fits which job type. Selection between real variants is allowed; generating or editing resumes is not.

**Targeting**
- Roles / titles / keywords to search.
- Their core skills, tools, and domain (so nothing gets wrongly dismissed as off-profile). This skill is profession-agnostic: engineering, healthcare, trades, finance, design, education, logistics, whatever the user does. Use THEIR vocabulary from the interview and resume, never a default industry's.
- Location rule: remote regions, acceptable metros/hybrid, relocation yes/no.
- Salary floor and target. If they target multiple seniority levels (e.g. senior AND staff, or open to mid-level), ask whether the floor differs by level and record each; vetting compares a job against the floor for THAT job's level.
- Full-time only, or also contract?

**Application types**
- Easy Apply only, or also external company sites? (Default to offering both; external takes more steps per job.) Both count toward the same cap.

**Hard exclusions**
- Industries/companies to never apply to (e.g. defense, gambling, specific employers, companies they already interview with).
- Any "ask me first" gray areas.

**Screening answers** (so questions don't need re-deriving each apply)
- Years of experience overall and per key skill, tool, or specialty the user named (only real numbers).
- Willing: background check / drug test / relocation?
- Licenses, certifications, and clearances, with license numbers, issuing state/body, and expiry where they apply (PE/EIT, RN, CDL, CPA, teaching credential, security clearance, trade licenses). Many applications require these and they cannot be guessed. Ask which are current versus in progress.
- Any other question their field asks routinely (portfolio link, AI-tooling questions in software, shift availability in healthcare, travel percentage in field work).
- Demographic self-ID preference (default: "prefer not to answer").

**Limits**
- Daily application cap: ask the user for their number (suggest 15 as a safe starting option, but it is their call). Store it in the profile.

Write all of it to `candidate-profile.md`. Treat it as the single source of truth. **If a form later needs a fact not in the profile, do not invent it: ask the user, or save the draft and report which field is missing.** When the user supplies a new fact mid-batch, append it to the profile so it never has to be asked again.

### Updating the profile

When the user says things like "update my profile", "my salary floor changed", "add Y to my exclusions", edit `candidate-profile.md` directly and confirm the change. Never re-run the full interview unless the user asks for it. If they say their resume changed, re-read the file and refresh `resume-text.md`.

## Modes

**Dry run** — "show me matching jobs", "what would you apply to". Search and vet as usual, present the list (company, role, salary, Easy Apply or external, why it matches or would be skipped), apply to nothing.

**Warm-up (default for a user's first-ever batch, and after major profile changes)** — for the first 2 applications, plus the user's first-ever external application, stop at the final review step BEFORE submitting. Show the user: company, role, and every answer filled into the form. Submit only after they approve; fold any corrections into the profile. Then continue autonomously. The point: a wrong screening answer caught here is caught once, not sent to 10 employers.

**Autonomous** — the normal mode once the profile is proven. Submit without per-application confirmation.

If a batch is running unattended (nobody responding), do not stall on warm-up approvals: save drafts, report, and let the user approve later.

## Resume-gap check (hold, don't fabricate)

Before applying to a strong match, compare the job description's top requirements against `resume-text.md` and what the profile/LinkedIn shows the user actually has. If a requirement that would materially improve their chances is missing from the resume but the user really has it (it is on their LinkedIn or in their profile), **do not apply yet**:

- Log the job as `Held - resume gap` with the URL.
- Tell the user exactly what and why, naming the actual requirement from THIS job: "This JD leads with <requirement>. Your LinkedIn shows it but your resume never mentions it. One line under your <relevant experience> would fix it."
- Continue the batch with other jobs; return to held jobs when the user says the resume is updated (then re-read the file, refresh `resume-text.md`, and apply).

Reserve holds for genuinely significant gaps on genuinely good matches. If more than 2-3 jobs in a batch are getting held, the bar is too low; apply with the resume as-is and put the observation in the end-of-batch keyword report instead. Never edit the resume yourself, and never claim the missing skill in form answers while the resume is silent on it unless the profile confirms it truthfully.

## Core rules (apply to everyone)

- Full-time unless the user allowed contract. Skip hourly / C2C / 1099 / "Contract" tags otherwise.
- Read the job description before submitting, **especially recruiter posts** — that is how you catch an excluded employer hiding behind a neutral title.
- Skip anything already in the tracker.
- Uncheck any "Follow company" checkbox before submitting.
- **Consent checkboxes:** a REQUIRED acknowledgment (privacy policy, terms of use, data-processing consent for recruitment) is a precondition of submitting; the user asked to apply, so accept it without asking, no confirmation needed. OPTIONAL opt-ins are the opposite: marketing emails, newsletters, "keep me in your talent pool", "share my data with partners" all stay unchecked, same as "Follow company". The test is whether the form will submit without it.
- Never fabricate. If a role is gated on specialist depth the user lacks (and the profile can't truthfully answer), discard and note it rather than inventing.
- Only count an application after an explicit confirmation (LinkedIn's "Your application was sent to X!" toast, or an external site's confirmation page/message — screenshot it).
- Never use the em dash character; use a comma or period.

### Account safety and pacing

- Pause 30-90 seconds (vary it, don't use a fixed interval) between applications. LinkedIn rate-limits and flags accounts that submit at machine speed.
- Respect the daily cap the user chose in their profile. Easy Apply and external both count. Count only confirmed submissions against it. If the requested batch would exceed the cap, say so and stop at the cap.
- If **LinkedIn** shows a captcha, a "verify it's you" screen, an unusual-activity warning, or logs the user out: **stop the batch immediately and report.** Never attempt to click through it; that is an account-risk signal and the user's decision to handle by hand.
- A captcha on an **external** company site is routine, not an account-risk signal: pause, ask the user to solve it, and continue when they have. Same for login/account walls (see External applications).

### Token economy

Screenshots are the dominant token cost of a batch; each one costs many times what reading the page as text does. Users on smaller plans burn through their usage fast, so waste matters:

- Prefer reading the page as text (`get_page_text`, `read_page`, `find`) whenever you only need to KNOW something. Screenshot only when you need coordinates to act on, or when text extraction fails.
- Do not re-screenshot after every click; re-screenshot when the layout has plausibly changed or a click did not take effect.
- An external application costs roughly 2-3x an Easy Apply. If the user asks for a large batch and their usage seems constrained (they mention limits, or a batch was cut off before), suggest 3-5 jobs per batch, Easy Apply-heavy, rather than silently burning their quota.

### Job-board MCPs (cheaper discovery)

Before searching in the browser, check whether a job-board connector is available (Dice, Indeed, and ZipRecruiter MCPs expose `search_jobs`; Dice and ZipRecruiter need no login). If one is connected, use it for DISCOVERY: query it with the profile's keywords/location/salary and get title/company/URL as plain text at a fraction of browser-search cost. Then open each result's URL in the browser to vet the JD and apply as usual — no MCP can submit an application, so vetting and applying always stay in the browser. MCP-discovered jobs usually route through the external-application workflow (their URLs point at company sites), while LinkedIn browser search feeds Easy Apply; a mixed batch is normal and good. If no job MCP is connected, search in the browser as below, and mention ONCE (not every batch) that connecting the free Dice or ZipRecruiter connector cuts the cost of future batches.

## Search recipes

Base: `https://www.linkedin.com/jobs/search/?f_JT=F&sortBy=DD` (add `&f_AL=true` to restrict to Easy Apply only, when the user chose Easy Apply only).

Add params: `&keywords=<term>` `&f_WT=2` (remote) `&f_SB2=<n>` (minimum salary bucket) `&f_TPR=r604800` (past week) / `r2592000` (past month) `&geoId=<metro>` `&start=25` (page 2). Find the user's metro geoId once and store it in the profile.

**Salary filter is derived, never copied.** LinkedIn's `f_SB2` buckets step up in roughly $20K increments starting around 1 = $40K+. Pick the bucket at or just below THIS user's salary floor from their profile, verify the label once in the LinkedIn filter UI (the mapping shifts), and store the verified bucket number in the profile. If the user targets multiple seniority levels with different floors (junior vs senior), filter at the LOWEST acceptable floor, or omit `f_SB2` entirely and enforce salary per-JD during vetting, so higher-level roles are not filtered out and lower-level ones are still caught by the vet step.

Rotate keywords to escape duplicate results. Build the rotation from the user's own titles and skills, not from any fixed list: vary seniority prefixes they accept (Junior/Mid/Senior/Lead/Principal or their field's equivalents), synonyms for the same role, and adjacent titles they said they would take. A civil engineer might rotate Civil Engineer, Structural Engineer, Project Engineer, Site Engineer; a nurse might rotate RN, Staff Nurse, Charge Nurse. Never inject titles from a field the user is not in.

Pull candidate IDs in one call:
```js
JSON.stringify([...document.querySelectorAll('li[data-occludable-job-id]')].map(li=>{
  const t=li.innerText.split('\n').map(s=>s.trim()).filter(Boolean);
  return {id:li.getAttribute('data-occludable-job-id'), i:t.slice(0,4).join(' | ')};
}).slice(0,16))
```
Open each directly: `https://www.linkedin.com/jobs/view/<id>/`

## Per-application workflow (Easy Apply)

1. Open by id. Confirm: Easy Apply present, employment type ok, location ok, salary in range, not excluded, not a duplicate.
2. Read the JD (screenshot if it won't load as text). Enforce exclusions and run the resume-gap check here. While reading, add the JD's required skills to the batch keyword tally (see Reporting).
3. Click Easy Apply (often needs **two clicks** to open the modal).
4. Step through pages: Contact, Resume (select the saved resume, or the matching saved variant), Questions, Work authorization, Review.
5. Answer from the profile only. Uncheck "Follow company".
6. **Warm-up mode:** pause at Review and get the user's approval before Submit (see Modes).
7. Submit; confirm the success toast before counting it. Dismiss the popup ("Not now").
8. Append to the tracker, then take the randomized pacing pause before the next job.

## External applications (company career sites)

When a vetted match is not Easy Apply and the user enabled external applies:

1. Click Apply on the job page; it opens the company site in a new tab. Work there. Identify the ATS if possible (Greenhouse, Lever, Ashby, Workday, iCIMS, SmartRecruiters, custom) to anticipate the flow.
2. Proceed **screenshot by screenshot**: screenshot, one action, verify. External sites vary wildly; never assume a layout carried over from the last one.
3. **Resume upload:** upload the user's local resume file (or the matching variant) with the browser file-upload tool. This is the whole reason setup collects the local path.
4. Fill every field from the profile and resume only. Same never-fabricate rule: a required fact the profile lacks means ask the user, or abandon and log as a draft with the missing field named.
5. **Login or account-creation walls:** pause and ask the user to log in or create the account themselves, then continue filling. Never invent, reuse, or store passwords; credentials are the user's to manage.
6. **Captchas:** pause, ask the user to solve, continue after.
7. Short free-text questions ("years with X", "notice period") answer from the profile. Essay questions ("why do you want to work here?") are the user's voice: draft 2-4 plain sentences strictly from profile facts and, in warm-up mode or when the answer feels load-bearing, show the user before submitting. Never paste generic enthusiasm.
8. Budget roughly 15-25 steps per external application (multi-page ATS run 5-9 pages: work history, education, self-ID). If a site loops, errors repeatedly, or demands assessments/tests, stop, log as `External - blocked` with the URL, and move to the next job rather than burning the batch.
9. Only count it after an explicit confirmation page or message; screenshot it. Log with Apply Type `External`.
10. Same pacing pause afterward; external submissions count toward the daily cap.

## LinkedIn UI pitfalls (cause most wasted retries)

- Easy Apply usually needs a second click to open. But if it already opened, a stray click triggers "Save this application?" — dismiss with that dialog's X, do not click Discard.
- Location field autofill doubles (e.g. "<City>, <State>, <Country><City>" — the city name gets appended twice). Fix: click field, ctrl+a, Delete, retype the user's city, then pick the dropdown option.
- Required questions are often scrolled ABOVE the visible area. If Next/Review does nothing, scroll the modal up and look for "This field is required".
- Radio rows shift as validation errors clear. Click bottom-to-top so earlier coordinates stay valid, or re-screenshot between clicks.
- Renderer freezes on screenshot, or "Cannot access a chrome-extension:// URL": wait a few seconds and retry, or navigate to reset focus. `find` often works when screenshots do not.
- JD frequently fails to load via innerText on the standalone view; fall back to a screenshot.

## Logging

Ask the user once where to log (create a local spreadsheet and/or a Google Sheet), in the same conversation as the profile-folder question. Store the path/URL in the profile. Columns:
`Company | Role | Location | Work Type | Apply Type | Salary | Job URL | Resume | Date Added | Status`

Apply Type: `Easy Apply` or `External`. Status values: `Applied`, `Held - resume gap`, `Draft - missing field`, `External - blocked`.

Local xlsx append:
```python
import openpyxl
wb=openpyxl.load_workbook(PATH); ws=wb.active
ws.append([company,role,location,worktype,applytype,salary,url,resume_used,date,status])
wb.save(PATH)
```

Google Sheet append — the reliable method (write to it in bulk, do not hand-type):
1. `navigator.clipboard.writeText` **silently fails** in Sheets. Use a hidden `<textarea>` + `document.execCommand('copy')`.
2. Click a column-A data cell, ctrl+Down (jumps to last filled row), Down, ctrl+V.
3. The **first paste often does not land** — verify with ctrl+Down and repeat once. Confirm the Name Box shows the expected range.

## Reporting

Be honest. Only count confirmed submissions. State clearly what was skipped and why (excluded, external disabled, contract, duplicate, blocked site, or a required field you could not fill without inventing). If blocked on a missing profile fact, ask for it or save the draft and move on.

End every batch with:

**Stats** (from the tracker)
- Submitted this batch (Easy Apply vs external) / today vs the daily cap / total in tracker.
- Skipped or held this batch, grouped by reason, with URLs for held and drafted jobs.
- Anything needing the user: resume-gap holds, drafts awaiting a missing answer, warm-up approvals pending, or a safety stop.

**Keyword report** (from the JD tally collected during vetting)
- Skills/keywords that appeared in 3+ of this batch's JDs but are absent from `resume-text.md`, e.g. "React Native: 8 of 12 JDs, not on your resume. Do you have it? If yes, one bullet would strengthen every future application."
- Ask before acting: if the user confirms they have a listed skill, add it to the profile's screening answers; the resume edit itself is theirs to make. Never add anything the user did not confirm.
