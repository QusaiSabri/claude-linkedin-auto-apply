# First-run interview

Goal: build `candidate-profile.md` once, completely, in 3-4 rounds, so no later batch ever has to ask a question the profile could have answered. Write the result using the headings in `profile-template.md` so every profile has the same shape.

## Order of operations

1. **Ask for the resume file first** (PDF preferred). Read it and extract everything it contains (list below). Save the plain text to `resume-text.md` in the profile folder.
2. **Read the user's LinkedIn profile once.** Open `https://www.linkedin.com/in/<their handle>/` (ask for the URL if the resume does not list it), read it as text, and save the skills, headline, and experience section to `linkedin-profile-text.md`. This is what makes the resume-gap check honest: it can only claim "your LinkedIn shows X" if it has actually read the LinkedIn profile.
3. **Confirm the saved resume on LinkedIn.** Open `https://www.linkedin.com/jobs/application-settings/`, read the saved resume filenames, and ask the user which one matches the local file. If none is saved, tell the user Easy Apply will upload the local file once and reuse it after that.
4. **One confirmation round**: show what was extracted ("here is what I read from your resume, correct anything wrong"), and in the same round ask only the identity gaps (usually ZIP, street address, phone country code, work authorization).
5. **Remaining rounds**: targeting, application types, exclusions and preferences, screening and boilerplate answers, limits and storage. Use AskUserQuestion (multiple-choice form) when available and batch related questions into option sets. Multiple choice changes the FORMAT, never the COVERAGE: every item in the checklist below must end up in the profile, from the resume or from an answer. Prefill nothing except resume-extracted facts the user confirms.
6. **Write the profile**, then read it back once to confirm nothing is missing. If AskUserQuestion is unavailable, fall back to batched plain-text questions.

A user should never be asked to type something that is printed on their resume.

## Extract from the resume

- Full name, email, phone, city, state, country, ZIP if present, LinkedIn URL, portfolio or GitHub URL.
- Current employer and title.
- **Work history table**, one row per position: employer, title, location, start (MM/YYYY), end (MM/YYYY or "Present"), 1-2 line summary. Workday, iCIMS, Taleo and SuccessFactors forms require these field by field, and their resume autofill garbles dates; the table is what you verify against.
- **Education table**: school, degree, field of study, start and end years, GPA only if printed.
- Skills list, in the user's own words.
- Licenses, certifications, clearances printed on the resume (numbers and expiry are usually missing; ask).
- Languages, if listed.

## Coverage checklist (every item, every user)

**Identity and contact**
- Full name, email, phone with country code.
- Street address, city, state, country, ZIP. Explain that some company forms require the street address; the user may decline and those forms will be logged as `Draft - missing field`.
- LinkedIn URL. Portfolio or GitHub URL (optional).
- Preferred name or pronouns: only if the user volunteers them; optional form fields for these are left blank.

**Work authorization** (never inferred from a resume)
- Authorized to work in the target country: yes or no.
- Need sponsorship now: yes or no. Need sponsorship in the future (visa expiry): yes or no.

**Documents**
- Local resume path. LinkedIn saved resume filename.
- Variants (optional): path, matching LinkedIn saved filename, and a one-line rule for which variant fits which role type. Choosing between real variants is allowed; generating or editing resumes is not.
- Cover letter: does the user have a file or a template they want used? Otherwise the skill drafts short letters from profile facts and shows them for approval the first three times (see `screening-answers.md`).

**Targeting**
- Titles and keywords to search, in the user's vocabulary. This skill is profession-agnostic (engineering, healthcare, trades, finance, education, logistics, whatever the user does); never inject titles from another field.
- Core skills, tools, specialties, so nothing gets wrongly dismissed as off-profile.
- Seniority levels they will accept (maps to LinkedIn experience-level filter).
- Location rule: remote regions, acceptable metros, hybrid yes/no and max onsite days per week, relocation yes/no.
- Salary floor and target, per seniority level if they differ. Whether pay is thought of as annual or hourly (convert hourly to annual at 2080 hours for comparisons).
- Jobs with no salary listed: apply, ask me each time, or skip. Recommend "apply"; most postings omit it.
- Full-time only, or also contract, temp, part-time. Hourly full-time roles are still full-time.
- Earliest start date or notice period. Currently employed: yes or no.

**Application types**
- Easy Apply only, or Easy Apply plus external company sites. Offer both; external takes 2-3x the steps per job. Both count toward the same cap.

**Exclusions and preferences**
- Industries and companies never to apply to (defense, gambling, specific employers, companies already in interview).
- Staffing agencies and third-party recruiters: apply, ask me, or never.
- "Ask me first" gray areas.
- Per-company limit: default 1 application per company per batch and 2 per 30 days; the user may raise it.

**Screening answers** (only real numbers, only true statements)
- Years of experience overall, and per key skill, tool, or specialty the user named.
- Background check, drug test, relocation, travel percentage: willing or not.
- Licenses, certifications, clearances: name, number, issuing state or body, expiry, current versus in progress (PE/EIT, RN, CDL, CPA, teaching credential, security clearance, trade licenses).
- Field-specific routine questions: shift availability in healthcare, portfolio link in design, AI-tooling questions in software, physical requirements in trades.
- Demographic self-identification: default "decline to answer" for gender, race, veteran, disability. The user may choose to answer.

**Boilerplate answers** (see `screening-answers.md` for the full map)
- How did you hear about us: the actual source (LinkedIn, Dice, ZipRecruiter, company site). Never "referral".
- 18 or older: ask once.
- Previously employed by, or previously applied to, a company: derive from the work history table and the tracker; ask when unsure.
- Relatives or acquaintances at the company: default "no" only after the user confirms it as their default.
- Non-compete or restrictive agreement in force: ask once.
- Current salary: "prefer not to say" unless the user opts in to giving a number.

**Limits and storage**
- Daily application cap (suggest 15 as a safe starting point; the user decides).
- Profile folder location (a connected folder in Cowork, any stable folder otherwise). Record it inside the profile.
- Tracker: local spreadsheet, Google Sheet, or both. Record path or URL. See `tracker.md` for the default filename and columns.

## Updating the profile

"Update my profile", "my salary floor changed", "add X to my exclusions", "I got my PE license": edit `candidate-profile.md` directly, confirm the change in one line, and re-run one warm-up application if the change touched salary, roles, location, work authorization, or any screening answer. Never re-run the full interview unless asked. "I updated my resume": re-read the file, refresh `resume-text.md` and the work-history and education tables, and confirm what changed. When a form asks for a fact the profile lacks and the user supplies it mid-batch, append it to the profile so it is never asked again.
