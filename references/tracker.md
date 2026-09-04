# Tracker, pipeline, pre-flight, reporting

The tracker is the batch's memory. Every outcome goes in it, including skips that the user may want to revisit (holds, drafts, blocked sites). It is also how a batch resumes after a cut-off.

## Columns

`Company | Role | Location | Work Type | Apply Type | Source | Salary | Job URL | Resume | Date Applied | Status | Last Updated | Notes`

- Work Type: Remote, Hybrid, Onsite. Apply Type: `Easy Apply` or `External`. Source: LinkedIn search, Saved Jobs, Link, or the job board's name.
- Salary: the employer's number as written, or `Not listed`. Resume: the filename or variant used.
- Date Applied: the submission date, blank for holds and drafts. Last Updated: any status change. Notes: the reason for a hold, the missing field, the ATS name, the interview date, whatever the user says.

## Status lifecycle

Set at apply time: `Applied`, `Held - resume gap`, `Draft - missing field`, `Draft - cover letter`, `Needs approval`, `External - blocked`.
Set later from what the user says: `Interview`, `Rejected`, `Offer`, `Withdrawn`.

## Files

- Local spreadsheet default: `job-applications-tracker.xlsx` in the profile folder. Create it with the header row if missing. If saving fails because the file is open in Excel or Numbers, ask the user to close it and retry once.
- Google Sheet: the URL stored in the profile. Prefer a connected Sheets tool if one exists. Otherwise use the clipboard method below.

Local append:
```python
import openpyxl, os
COLS=["Company","Role","Location","Work Type","Apply Type","Source","Salary","Job URL","Resume","Date Applied","Status","Last Updated","Notes"]
if not os.path.exists(PATH):
    wb=openpyxl.Workbook(); wb.active.append(COLS); wb.save(PATH)
wb=openpyxl.load_workbook(PATH); ws=wb.active
ws.append([company,role,location,worktype,applytype,source,salary,url,resume_used,date_applied,status,today,notes])
wb.save(PATH)
```

Google Sheet append without a connector (write in bulk, do not hand-type cells):
1. `navigator.clipboard.writeText` silently fails in Sheets. Put the tab-separated rows in a hidden `<textarea>` and use `document.execCommand('copy')`.
2. Click a column-A data cell, jump to the last filled row (cmd+Down on Mac, ctrl+Down on Windows), press Down once, paste (cmd+V or ctrl+V).
3. The first paste often does not land. Verify by jumping to the last row again and repeat once. Confirm the Name Box shows the expected range.

## Pre-flight (start of every batch, and on "continue" or "resume")

1. Read the profile and the tracker.
2. Count today's rows with Status `Applied`; compare with the daily cap. Say how many remain.
3. List open items: `Held - resume gap`, `Draft - *`, `Needs approval`. Ask once whether to handle any of them first; do not block on the answer.
4. If the last row was written today and is not `Applied` or a deliberate skip, the previous batch may have been cut off mid-application. Open that job: LinkedIn shows "Applied" under the title, an ATS lists it under My Applications. If it went through, correct the row to `Applied`; if not, treat it as a fresh candidate.
5. Continue from where the batch stopped: the remaining links the user gave, the next saved job, or the next search page and keyword rotation.

## Pipeline updates from the user

- "I got an interview at X", "X rejected me", "offer from X", "withdraw my application to X": find the row by company (ask which role if there is more than one), set Status, Last Updated, and a Note with whatever the user said (date, stage, recruiter name). Confirm in one line.
- "I applied to X myself": add a row with Source `Manual`.
- "Show my pipeline", "how is my job search going", "how many jobs this week": report counts by status, this week's and this month's submissions, open items needing the user, and the last five status changes. Two short tables, no commentary beyond one sentence.

## End-of-batch report

Be honest. Count only confirmed submissions.

**Stats** (from the tracker)
- Submitted this batch (Easy Apply vs External), today vs the daily cap, total in tracker.
- Skipped or held this batch, grouped by reason, with URLs for held, drafted, blocked, and "ask me" jobs.
- Anything needing the user: resume-gap holds, drafts awaiting a fact or a cover letter, warm-up approvals pending, staffing-agency or no-salary jobs awaiting a decision, or a safety stop.

**Keyword report** (from the JD tally collected during vetting)
- Skills that appeared in at least half of this batch's job descriptions (and at least 3) but are absent from `resume-text.md`: "<skill>: <n> of <m> postings, not on your resume. Do you have it? If yes, one bullet would strengthen every future application."
- Ask before acting: if the user confirms a skill, add it to the profile's screening answers. The resume edit is theirs to make. Never add anything the user did not confirm.
