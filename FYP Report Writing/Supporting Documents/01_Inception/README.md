# INCEPTION PHASE — Supporting Documents
**RUP Phase:** Inception | **Weeks:** 1–5 | **Dates:** November 2024

---

## Phase Objective

Establish the business case, validate the problem through primary research, identify and engage stakeholders, assess feasibility, estimate risk, and set up the development environment. Deliverables feed Chapter 1 (Introduction) and Chapter 3 (Methodology) of the final report.

---

## Documents in This Folder

| File | Contents | Report Reference |
|---|---|---|
| `Risk_Register.md` | 21 project risks (technical, schedule, domain, legal); likelihood × impact scoring; mitigation strategy; outcome for each risk | Chapter 3, Section 3.3; Appendix N |

---

## Key Artefacts Produced in Inception

| Artefact | Status | Evidence Location |
|---|---|---|
| Project proposal | Done | `Project Artefact/01 Feasibility Study/Week - 01/` |
| Vision document | Done | Chapter 1 of FYP report |
| Feasibility study | Done | `Project Artefact/01 Feasibility Study/Week - 03/` |
| Stakeholder register | Done | Chapter 3, Section 3.2 |
| Pre-survey instrument (166 responses) | Done | `Research/Survey_Instruments_and_Analysis.md` |
| Risk register | Done | `Risk_Register.md` (this folder) |
| Initial Gantt chart | Done | Appendix J.1 |
| Work Breakdown Structure | Done | Appendix J.2 |
| Technology selection rationale | Done | `Project Artefact/01 Feasibility Study/Week - 05/` |

---

## Key Decisions Made

| Decision | Rationale |
|---|---|
| RUP over Agile/Waterfall | Clinical domain requires upfront risk management and architecture stability before iterative build |
| SuperTokens over Firebase Auth | OTP passwordless flow suited for Nepal's low-credential-familiarity market; Firebase Auth lacked combined OTP + social recipe |
| eSewa as sole payment gateway | Nepal-only market; international cards have low penetration; eSewa is the dominant mobile wallet |
| Android-first deployment | iOS App Store compliance timeline incompatible with FYP submission; deferred to post-submission |
| Supabase over Firebase Firestore | PostgreSQL Row Level Security provides clinical-grade data isolation; better relational modelling for therapy session data |
