# PHASE 4: TRANSITION — TESTING AND IMPLEMENTATION
**RUP Phase:** Transition | **Week:** 20 | **Dates:** 19 March – 30 April 2025

---

## Phase Objective

Deploy the complete system to production (Vercel), conduct system testing and user acceptance testing, gather post-survey data, obtain client approval letters, and finalise the FYP report.

---

## Artefacts in This Phase

| Artefact | Location |
|---|---|
| System test results (TC-S001–S015) | `Week - 20/` + Chapter 4 |
| UAT plan and results (TC-UAT001–025) | `Week - 20/` + Chapter 4 |
| Post-survey (132 responses) | `Week - 20/Research/` + Appendix H |
| User feedback forms | `Week - 20/Customer Validation/` + Appendix L |
| Client approval letters | Appendix F |
| System screenshots (all screens) | Appendix J.12 |
| Deployment evidence (Vercel) | `Supporting Documents/14_Deployment.md` |
| Final Gantt chart | Appendix J.1 |
| FYP report (final) | `FYP Report Writing/` |

---

## Deployment Summary

| Component | Platform | URL |
|---|---|---|
| Node.js / Express REST API | Vercel | https://resilio-api.vercel.app |
| Socket.IO signalling server | Separate persistent host | https://resilio-signalling.up.railway.app |
| Database | Supabase (PostgreSQL) | Managed cloud |
| Authentication | SuperTokens managed service | Managed cloud |
| Media storage | Cloudinary | Managed CDN |
| Push notifications | Firebase Cloud Messaging | Managed cloud |

Full deployment documentation: `Supporting Documents/14_Deployment.md`

---

## Test Results Summary

| Level | Cases | Passed | Partial | Failed |
|---|---|---|---|---|
| Unit Tests | 40 | 40 | 0 | 0 |
| System Tests | 40 | 40 | 0 | 0 |
| UAT | 25 | 24 | 1 | 0 |
| **Total** | **105** | **104** | **1** | **0** |

**Overall pass rate: 99.05%**
**Partial: TC-UAT011** — PHQ-9 questionnaire discoverability (3 min vs 2 min target — UX improvement noted)
