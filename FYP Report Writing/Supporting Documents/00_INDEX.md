# RESILIO — FYP SUPPORTING DOCUMENTS INDEX

**Student:** Milan Shrestha | **ID:** 23057135
**Institution:** Islington College / London Metropolitan University
**Project:** Resilio — Mobile Mental Health Platform for Nepal
**Methodology:** Rational Unified Process (RUP)
**Academic Year:** 2024–2025

---

## Folder Structure

Documents are organised by RUP phase. Each phase folder has its own `README.md` summarising the phase objective, artefacts, and decisions. The `Research/` folder holds cross-cutting documents that span multiple phases.

```
Supporting Documents/
├── 00_INDEX.md                         ← This file
│
├── 01_Inception/                       ← Weeks 1–5 | November 2024
│   ├── README.md                       ← Phase overview and key decisions
│   └── Risk_Register.md
│
├── 02_Elaboration/                     ← Weeks 6–10 | December 2024
│   ├── README.md                       ← Phase overview and key decisions
│   ├── Client_and_Stakeholder_Documents.md
│   ├── Database_Schema.md
│   └── API_Reference.md
│
├── 03_Construction/                    ← Weeks 11–19 | January–March 2025
│   ├── README.md                       ← 7 iterations summary and key decisions
│   ├── Technology_Documentation.md
│   ├── Development_Tools_and_Environment.md
│   ├── WebRTC_Signalling_Architecture.md
│   ├── Project_Structure_and_Artefacts.md
│   └── Learning_Resources.md
│
├── 04_Transition/                      ← Week 20 | March–April 2025
│   ├── README.md                       ← Phase overview, outcomes, bug log
│   ├── Testing_Strategy.md
│   └── Deployment.md
│
└── Research/                           ← Cross-cutting (all phases)
    ├── README.md                       ← Why these are cross-cutting
    ├── RUP_Phase_Artefacts.md
    ├── Research_Papers_and_Journals.md
    ├── Survey_Instruments_and_Analysis.md
    └── Weekly_Progress_Log.md
```

---

## Quick Reference by Document

| Document | Folder | Contents Summary |
|---|---|---|
| `Risk_Register.md` | `01_Inception/` | 21 risks — technical, schedule, domain, legal; likelihood × impact; all resolved |
| `Client_and_Stakeholder_Documents.md` | `02_Elaboration/` | Client profiles, interview notes, verbatim quotes, prototype feedback, traceability matrix |
| `Database_Schema.md` | `02_Elaboration/` | All 20 PostgreSQL tables, RLS policies, indexes, 19 SQL migration files mapped |
| `API_Reference.md` | `02_Elaboration/` | All REST endpoints, JSON examples, auth middleware, error format |
| `Technology_Documentation.md` | `03_Construction/` | Every Flutter + Node.js package with version, purpose, documentation URL |
| `Development_Tools_and_Environment.md` | `03_Construction/` | IDEs, CLI tools, Git branching, Postman, DBeaver, Figma, hardware |
| `WebRTC_Signalling_Architecture.md` | `03_Construction/` | Socket.IO event table, signalling flow, STUN/TURN config, Flutter code references |
| `Project_Structure_and_Artefacts.md` | `03_Construction/` | Annotated Flutter `lib/` tree, Node.js backend tree, SQL sequence, Protobuf list, RUP folder map |
| `Learning_Resources.md` | `03_Construction/` | YouTube channels, tutorials, official docs used during development |
| `Testing_Strategy.md` | `04_Transition/` | Three-level approach, traceability matrix (24 FRs → test cases), defects log (5 bugs) |
| `Deployment.md` | `04_Transition/` | vercel.json, env vars, Socket.IO Railway setup, CORS, production checklist |
| `RUP_Phase_Artefacts.md` | `Research/` | Master artefact inventory across all 4 RUP phases |
| `Research_Papers_and_Journals.md` | `Research/` | 50+ academic sources organised by theme |
| `Survey_Instruments_and_Analysis.md` | `Research/` | Pre-survey (166 responses) + post-survey (132 responses); full question breakdowns |
| `Weekly_Progress_Log.md` | `Research/` | Week-by-week task log across all 20 weeks |

---

## How This Maps to the FYP Report

| Report Chapter | Primary Supporting Documents |
|---|---|
| Chapter 1 — Introduction | `Research/Survey_Instruments_and_Analysis.md`, `Research/Research_Papers_and_Journals.md` |
| Chapter 2 — Background | `Research/Research_Papers_and_Journals.md`, `03_Construction/Technology_Documentation.md` |
| Chapter 3 — Development | `02_Elaboration/API_Reference.md`, `02_Elaboration/Database_Schema.md`, `02_Elaboration/Client_and_Stakeholder_Documents.md`, `03_Construction/Project_Structure_and_Artefacts.md`, `03_Construction/WebRTC_Signalling_Architecture.md` |
| Chapter 4 — Testing | `04_Transition/Testing_Strategy.md`, `Research/Survey_Instruments_and_Analysis.md` |
| Chapter 5 — Conclusion | `Research/Research_Papers_and_Journals.md`, `Research/RUP_Phase_Artefacts.md` |
| Appendix K — Test Cases | `04_Transition/Testing_Strategy.md` |
| Appendix M — SRS | `02_Elaboration/API_Reference.md`, `02_Elaboration/Database_Schema.md` |

---

## Appendix Cross-Reference (Appendix.md — Sections A to O)

| Appendix | Title | Primary Supporting Doc |
|---|---|---|
| A | Detailed Mental Health Statistics in Nepal | `Research/Research_Papers_and_Journals.md` |
| B | Extended Problem Analysis | `Research/Survey_Instruments_and_Analysis.md` |
| C | Detailed App Comparison | `Research/Research_Papers_and_Journals.md` |
| D | Detailed Solution Features | `02_Elaboration/Client_and_Stakeholder_Documents.md` |
| E | Methodology Details | `Research/RUP_Phase_Artefacts.md` |
| F | Client Approval Letters | `02_Elaboration/Client_and_Stakeholder_Documents.md` |
| G | Pre-Survey (166 respondents) | `Research/Survey_Instruments_and_Analysis.md` |
| H | Post-Survey (132 respondents) | `Research/Survey_Instruments_and_Analysis.md` |
| I | Sample Code | `03_Construction/Project_Structure_and_Artefacts.md` |
| J | Designs and Diagrams | `02_Elaboration/Database_Schema.md`, `03_Construction/WebRTC_Signalling_Architecture.md` |
| K | Full Test Case Tables (85+ cases) | `04_Transition/Testing_Strategy.md` |
| L | User Feedback Forms | `Research/Survey_Instruments_and_Analysis.md` |
| M | Software Requirements Specification (SRS) | `02_Elaboration/API_Reference.md`, `02_Elaboration/Database_Schema.md` |
| N | Future Work: Supporting Research | `Research/Research_Papers_and_Journals.md` |
| O | Screenshots of the System (83 labelled placeholders) | `04_Transition/Deployment.md` |

---

## PDF Exports

All documents in this folder are available as professionally formatted PDFs in:

```
Supporting Documents/PDF_Exports/
```

PDFs are auto-generated from the markdown source files using WeasyPrint with Arial font, organised tables, and page headers/footers. Re-run `md_to_pdf.py` to regenerate after any edits.

---

## RUP Phase Timeline

| Phase | Folder | Dates | Weeks |
|---|---|---|---|
| Inception | `01_Inception/` | November 2024 | 1–5 |
| Elaboration | `02_Elaboration/` | December 2024 | 6–10 |
| Construction | `03_Construction/` | January – March 2025 | 11–19 |
| Transition | `04_Transition/` | March – April 2025 | 20 |
