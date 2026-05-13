# ELABORATION PHASE — Supporting Documents
**RUP Phase:** Elaboration | **Weeks:** 6–10 | **Dates:** December 2024

---

## Phase Objective

Refine requirements through structured client engagement, produce the system architecture and all design artefacts, validate high-risk integrations through proof-of-concept prototypes (SuperTokens, eSewa, WebRTC), and deliver the Interim Report. Deliverables feed Chapter 2 (Background), Chapter 3 (Development), and the Appendices of the final report.

---

## Documents in This Folder

| File | Contents | Report Reference |
|---|---|---|
| `Client_and_Stakeholder_Documents.md` | Client profiles (Ms. Sushana Karki, Dr. Dibyandra Singh), interview guides, verbatim quotes, prototype review feedback, UAT summaries, requirements traceability matrix | Chapter 3, Section 3.2; Appendix F |
| `Database_Schema.md` | All 20 PostgreSQL tables — full column definitions, types, constraints, RLS policies, key indexes, 4-tier RLS summary | Chapter 3, Section 3.4; Appendix M |
| `API_Reference.md` | All REST endpoints with method, path, auth requirement, and JSON request/response examples; error format; auth middleware pattern | Chapter 3, Section 3.5; Appendix M |

---

## Key Artefacts Produced in Elaboration

| Artefact | Status | Evidence Location |
|---|---|---|
| Interim Report | Done | `FYP Report Writing/Interim Report/` |
| Software Requirements Specification (SRS) | Done | Appendix M |
| Use case diagrams (Customer, Therapist, Admin) | Done | Appendix J.5 |
| Entity-Relationship Diagram | Done | Appendix J.8 |
| System Architecture Diagram (3-tier) | Done | Appendix J.4 |
| Activity diagrams (booking, video call, content) | Done | Appendix J.6 |
| Sequence diagrams (OTP login, booking, WebRTC) | Done | Appendix J.7 |
| Data Flow Diagrams (Level 0 + Level 1) | Done | Appendix J.9 |
| Wireframes (7 screens) | Done | Appendix J.10 |
| Figma high-fidelity mockups | Done | Appendix J.11 |
| SuperTokens OTP prototype | Done | `Project Artefact/02 Requirement Analysis/Week - 08/` |
| WebRTC peer connection prototype | Done | `Project Artefact/02 Requirement Analysis/Week - 09/` |
| eSewa payment prototype | Done | `Project Artefact/02 Requirement Analysis/Week - 08/` |
| Database schema (all 20 tables) | Done | `Database_Schema.md` (this folder) |

---

## Key Decisions Made

| Decision | Rationale |
|---|---|
| Feature-first Clean Architecture | Enables parallel development of Customer/Therapist/Admin modules with clear domain boundaries |
| BLoC/Cubit state management | Predictable unidirectional data flow; mature Flutter ecosystem support |
| PostgreSQL RLS (4-tier policy) | Enforce data isolation at the database level, not just application level — clinical data requires this |
| Cloudinary for media | Free tier, CDN delivery, Dart SDK available; avoids Supabase storage bandwidth limits |
| SQLite + Protobuf for offline | Binary serialisation (vs JSON) reduces SQLite storage size for offline mood entries |
