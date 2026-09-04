# LinkedIn: search, Saved Jobs, Easy Apply, UI pitfalls

## Search URL

Assemble once from the profile and store the result under "Verified LinkedIn filters". Base: `https://www.linkedin.com/jobs/search/?sortBy=DD` (newest first). Add:

| Param | Meaning | From profile |
|---|---|---|
| `keywords=<term>` | search term | one title or keyword per rotation |
| `geoId=<n>` | metro or country | find once in the LinkedIn location filter, store it |
| `distance=<miles>` | radius around geoId | location rule |
| `f_WT=1` / `2` / `3` | onsite / remote / hybrid; comma-join, e.g. `f_WT=2,3` | location rule |
| `f_JT=F` | full-time only. Omit when the user accepts contract, temp, or part-time (C = contract, T = temporary, P = part-time, comma-join) | employment types |
| `f_E=<n>` | experience level: 1 intern, 2 entry, 3 associate, 4 mid-senior, 5 director, 6 executive; comma-join | seniority accepted |
| `f_TPR=r86400` / `r604800` / `r2592000` | past day / week / month | default past week; widen if results run dry |
| `f_SB2=<n>` | minimum salary bucket (see below) | salary floor |
| `f_AL=true` | Easy Apply only | application types |
| `f_C=<company id>` | one company's postings ("apply to everything at X") | on request |
| `start=25` | page 2 (25 per page) | paging |

**Salary bucket is derived, never copied.** `f_SB2` buckets step up in roughly $20K increments starting around 1 = $40K+. Pick the bucket at or just below THIS user's floor, verify the label once in the LinkedIn salary filter UI (the mapping shifts), store the number. Postings with no listed or estimated salary are dropped by this filter, so when the profile says "no salary listed: apply", run every rotation twice, once with `f_SB2` and once without, and dedupe. Multiple seniority floors: filter at the LOWEST floor, or omit `f_SB2`, and enforce salary per job during vetting.

**Keyword rotation.** Build it from the user's own titles and skills: seniority prefixes they accept, synonyms for the same role, adjacent titles they said they would take. A civil engineer might rotate Civil Engineer, Structural Engineer, Project Engineer, Site Engineer; a nurse might rotate RN, Staff Nurse, Charge Nurse. Rotate when a page returns mostly duplicates. Never inject titles from a field the user is not in.

## Collecting job IDs from a results page

The list is virtualized: items that have not been scrolled into view have empty text. Scroll the results pane to the bottom first, then:

```js
JSON.stringify([...document.querySelectorAll('li[data-occludable-job-id]')].map(li=>{
  const t=li.innerText.split('\n').map(s=>s.trim()).filter(Boolean);
  return {id:li.getAttribute('data-occludable-job-id'), i:t.slice(0,4).join(' | ')};
}).slice(0,25))
```

LinkedIn renames attributes every few months. If the selector returns nothing, fall back to reading the page as text and taking job IDs from the `/jobs/view/<id>` links. Open each job directly: `https://www.linkedin.com/jobs/view/<id>/`.

## Saved Jobs and Applied

- Saved: `https://www.linkedin.com/my-items/saved-jobs/`. "Apply to my saved jobs" reads this list, collects IDs, then vets and applies exactly like search results (exclusions, duplicates, per-company limit, cap all still apply). Tell the user which saved jobs were skipped and why.
- Applied: `https://www.linkedin.com/my-items/saved-jobs/?cardType=APPLIED`. Use it during pre-flight to confirm whether an interrupted application went through.
- A job page shows "Applied <time> ago" under the title once submitted. Treat that as a duplicate even if the tracker missed it.

## Easy Apply, step by step

1. Open the job by ID. Confirm: Easy Apply button present, employment type OK, location OK, salary in range or "not listed" allowed, not excluded, not a duplicate, per-company limit OK.
2. Read the job description as text (screenshot if it will not load). Enforce exclusions, run the resume-gap check, add the JD's required skills to the batch keyword tally.
3. Click Easy Apply. It often needs a second click to open the modal.
4. Step through: Contact, Resume, Questions, Work authorization, Review.
5. Resume: select the saved copy named in the profile (or the matching variant). If no saved copy exists, upload the local file once; LinkedIn keeps up to 4 saved resumes and reuses them, so never upload a fresh copy per application.
6. Answer every question from the profile only. Integers in numeric fields. Uncheck "Follow company".
7. Warm-up mode: stop at Review, show the user every answer, submit only after approval.
8. Submit. Count it only after the "Your application was sent to X" toast. Dismiss the follow-up popup with "Not now".
9. Log to the tracker, then move to vetting the next job (this is the pacing gap).

## UI pitfalls (cause most wasted retries)

- Easy Apply needs a second click to open. If the modal is already open, a stray click triggers "Save this application?": dismiss with that dialog's X, never Discard.
- Location autofill doubles the city ("<City>, <State>, <Country><City>"). Fix: click the field, select all (cmd+A on Mac, ctrl+A on Windows), Delete, retype the city, pick the dropdown option.
- Required questions are often scrolled ABOVE the visible area. If Next or Review does nothing, scroll the modal up and look for "This field is required".
- Radio rows shift as validation errors clear. Click bottom-to-top so earlier coordinates stay valid, or re-screenshot between clicks.
- Numeric fields reject decimals and blanks; type a whole number.
- Renderer freezes on screenshot, or "Cannot access a chrome-extension:// URL": wait a few seconds and retry, or navigate to reset focus. Text extraction often works when screenshots do not.
- The JD frequently fails to load as text on the standalone view; fall back to a screenshot.
- Returning to LinkedIn after an external site shows a "Did you apply?" prompt. Answer honestly; it feeds LinkedIn's Applied list, which helps deduping later.
- The "You're leaving LinkedIn" interstitial before an external site is routine; continue.
