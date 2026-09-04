# Screening answers, boilerplate questions, consent, cover letters

Read this before the first application of a batch. Every answer comes from `candidate-profile.md`. If the profile lacks the fact, the answer is "ask the user" or "log `Draft - missing field` and move on", never a guess.

## Question map

| Form asks | Profile field | If missing |
|---|---|---|
| Name, email, phone | Identity | ask |
| Street address | Identity (street address) | log draft if required; leave blank if optional |
| City, state, ZIP, country | Identity | ask |
| LinkedIn URL, portfolio | Identity | leave blank if optional |
| Authorized to work in country | Work authorization | ask, never infer |
| Need sponsorship (now / future) | Work authorization | ask |
| Years of experience overall | Screening answers | ask |
| Years with a named skill | Screening answers, else resume dates | if not in profile and not derivable from resume dates, ask; never round up |
| Current employer / title | Identity | from resume |
| Currently employed | Identity | ask |
| Earliest start date / notice period | Targeting | ask |
| Desired salary | Boilerplate (see below) | ask |
| Current salary | Boilerplate: "prefer not to say" unless the user gave a number | use the decline option, or leave blank |
| Willing to relocate / travel % / background check / drug test | Screening answers | ask |
| Onsite days per week | Targeting (hybrid max) | ask |
| How did you hear about us | Boilerplate: the real source (LinkedIn, Dice, ZipRecruiter, company site) | use the real source; never "referral" or "employee" |
| 18 or older | Boilerplate | ask once |
| Previously worked here / applied here | Work history table + tracker | derive; ask if unsure |
| Relatives or acquaintances at company | Boilerplate default | ask if no default set |
| Non-compete or restrictive covenant | Boilerplate | ask once |
| Licenses, certifications, clearances | Licenses table | ask; never claim a license not in the table |
| Education fields | Education table | from resume |
| Work history fields | Work history table | from resume; verify autofilled dates against the table |
| Languages | Resume | leave blank if not listed |
| Gender, race, ethnicity, veteran, disability | Screening answers (self-ID) | choose the explicit "decline" / "I don't wish to answer" option |
| Preferred name, pronouns | Only if the user volunteered them | leave blank |
| Field-specific (shift availability, portfolio, AI tooling, physical requirements) | Screening answers | ask |

**Numeric fields:** LinkedIn Easy Apply and most ATS forms reject decimals in years-of-experience fields ("enter a whole number between 0 and 99"). Use the integer from the profile; round DOWN if the profile holds a fraction.

## Desired salary

- Single-number field: the target for that job's seniority level.
- Range or two fields: floor to target.
- Free-text field: the target as a number; write "negotiable" only if the user said that is acceptable.
- Hourly field: annual figure divided by 2080, rounded to the dollar.
- Never enter a number below the floor to "get through" a form.

## Self-identification forms

EEO, veteran (VEVRAA), and disability (form CC-305) pages are standard in US applications. Choose the explicit decline option unless the profile says otherwise. The CC-305 form requires a typed name and today's date as an attestation; completing it with the user's name is fine, it is not a fabrication. If a form forces a substantive answer with no decline option, ask the user.

## Consent checkboxes and attestations

The test: will the form submit without it?

- **Required acknowledgments** (privacy policy, terms of use, data-processing consent for recruitment, "I certify my answers are true"): the user asked you to apply, so accept them without asking.
- **Optional opt-ins** (marketing emails, newsletters, talent pool, share my data with partners, "Follow company"): always leave unchecked.
- **Attestations that go beyond the application:** background-check or credit-check authorization is answered from the profile's background-check field; if the profile says no, stop and ask. E-signature of an arbitration agreement, non-compete, or any contract at application stage: ask the user, do not sign on their behalf.

## Sensitive data: never enter

Social Security or national ID number, date of birth, driver's license number, passport number, bank or payment details, mother's maiden name, or any application fee. Legitimate employers ask for these after an offer, through HR onboarding, not on an application form. If a form requires one, stop, log the job as `External - blocked` with the reason, and tell the user. A request for money is a scam; say so.

## Cover letters and essays

Applies to cover-letter upload or paste fields, and to essay questions ("why do you want to work here", "describe a time you...").

1. If the profile lists a cover-letter file or template, use it (upload the file, or fill the template with the company and role name only).
2. Otherwise draft 3-5 plain sentences strictly from profile facts and the resume, tailored to 2-3 requirements named in THIS job description. State what the user has done, not how excited they are. No generic enthusiasm, no claims the profile does not support, no em dash characters, no phrases that read as machine-written.
3. Show the draft for approval: always in warm-up mode, always for the user's first three cover letters ever, and whenever an essay answer feels load-bearing. After the first approval, save the approved text to `cover-letter-style.md` in the profile folder and match its tone and length afterwards. Fold the user's edits into the style file.
4. Optional cover-letter field, past the first three approvals: draft and attach without pausing.
5. Required cover letter with nobody available to approve during the first three: draft it, log `Draft - cover letter` with the URL, move on; the user approves later.
6. Short free-text questions ("years with X", "notice period", "salary expectations") are answers, not essays: one line from the profile.
