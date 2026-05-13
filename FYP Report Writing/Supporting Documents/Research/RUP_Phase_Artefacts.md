# RUP PHASE ARTEFACTS

## Overview

Resilio followed the Rational Unified Process (RUP) methodology across four phases. This document lists every artefact produced in each phase, its purpose, and where it appears in the project record. Cross-references to the weekly artefact logs in `Project Artefact/` are provided for each item.

---

## PHASE 1: INCEPTION (Weeks 1–4, November 2024)

**Objective:** Establish the business case, define the scope, identify stakeholders, assess feasibility, and set up the project environment.

### Artefacts Produced

| Artefact | Description | Evidence Location |
|---|---|---|
| Project Proposal | Formal project proposal defining the problem, proposed solution, and project scope | `Project Artefact/01 Feasibility Study/` |
| Vision Document | High-level statement of what Resilio is, who it is for, and what success looks like | Chapter 1 of FYP report |
| Feasibility Study | Technical, economic, operational, and schedule feasibility assessment | `Project Artefact/01 Feasibility Study/` |
| Stakeholder Register | Identification of all stakeholders: students, therapists, admin users, external clients | Chapter 3, Section 3.2 |
| Pre-Survey Instrument | 10-question Google Forms survey distributed to 166 respondents | Appendix G; `Surveys.md` |
| Pre-Survey Results | Aggregated findings from 166 responses validating the problem domain | Chapter 1, Section 1.3; Appendix G |
| Risk Register | Identification of technical, schedule, and domain risks and mitigation strategies | Chapter 3, Section 3.3 |
| Initial Gantt Chart | Planned project schedule across all four RUP phases | Appendix J.1 |
| Work Breakdown Structure | Top-level decomposition of all project tasks | Appendix J.2 |
| Client Identification | Identified Ms. Sushana Karki and Dr. Dibyandra Singh as external clients | Appendix F |
| Technology Selection | Initial selection of Flutter, Node.js, Supabase, SuperTokens based on feasibility | Chapter 3, Section 3.4 |
| Mind Map | Full project scope visualisation | Appendix J.3 |

### Key Decisions Made in Inception

- **Methodology:** RUP selected over Agile, Waterfall, and Prototype (see Appendix E for comparison matrix)
- **Authentication:** SuperTokens OTP selected over Firebase Auth for passwordless local-friendly authentication
- **Payment:** eSewa selected as the only payment gateway due to Nepal market accessibility
- **Platform:** Android-first deployment; iOS deferred to post-submission due to App Store compliance timeline

---

## PHASE 2: ELABORATION (Weeks 5–8, December 2024)

**Objective:** Refine requirements through stakeholder engagement, produce the system architecture, create design artefacts, identify and mitigate high-risk components through prototyping, and deliver the Interim Report.

### Artefacts Produced

| Artefact | Description | Evidence Location |
|---|---|---|
| Interim Report | Full academic report covering background, requirements, initial design, and methodology | `FYP Report Writing/Interim Report/` |
| Software Requirements Specification (SRS) | Complete functional and non-functional requirements in SRS format | Appendix M |
| Use Case Diagrams (x3) | Customer, Therapist, and Admin use case diagrams | Appendix J.5; `UML Diagrams (Mermaid Code).md` |
| Entity-Relationship Diagram | Full database schema with all entities and relationships | Appendix J.8 |
| System Architecture Diagram | Three-tier architecture: Flutter → Node.js → Supabase | Appendix J.4 |
| Activity Diagrams (x3) | Appointment booking, WebRTC consultation, content publication flows | Appendix J.6 |
| Sequence Diagrams (x3) | OTP login, appointment booking, WebRTC session establishment | Appendix J.7 |
| Data Flow Diagrams (Level 0 + Level 1) | Context diagram and detailed customer/therapist/admin flows | Appendix J.9 |
| Wireframes (x7 screens) | Hand/tool-drawn wireframes for all major screen categories | Appendix J.10 |
| Figma UI Mockups | High-fidelity UI designs for all screens | Appendix J.11 |
| SuperTokens Integration Prototype | Proof-of-concept validating OTP authentication flow | Week 6 artefact log |
| WebRTC Integration Prototype | Proof-of-concept validating peer-to-peer video connection via Socket.IO signalling | Week 7 artefact log |
| eSewa Integration Prototype | Proof-of-concept validating payment initiation and callback verification | Week 8 artefact log |
| Client Requirement Sessions | Structured interviews with Ms. Sushana Karki and Dr. Dibyandra Singh | Appendix F; `05_Client_and_Stakeholder_Documents.md` |
| Database Schema (PostgreSQL) | Full table definitions, constraints, RLS policies | Appendix M; `08_Database_Schema.md` |

### Key Decisions Made in Elaboration

- **Clean Architecture:** Feature-first Clean Architecture adopted for Flutter codebase (Martin, 2017) to enable scalable parallel development of Customer, Therapist, and Admin modules
- **State Management:** Flutter BLoC selected for predictable state management across all modules
- **Offline Strategy:** SQLite (sqflite) selected for local persistence; Protocol Buffers for serialisation; LRU cache for content
- **Signalling:** Socket.IO selected for WebRTC signalling due to mature Flutter SDK and reliability
- **Content delivery:** Cloudinary selected for media hosting due to free tier and CDN delivery

---

## PHASE 3: CONSTRUCTION (Weeks 9–19, January–March 2025)

**Objective:** Implement all features iteratively across seven planned development iterations. Each iteration produces tested, integrated software incrementally.

### Development Iterations

| Iteration | Weeks | Features Implemented |
|---|---|---|
| Iteration 1 | 9–10 | SuperTokens OTP auth; Google/Facebook Sign-In; role-based routing; user onboarding |
| Iteration 2 | 11 | Supabase database schema live; Row Level Security policies; base API structure |
| Iteration 3 | 12–13 | Therapist directory; therapist profile; admin verification workflow |
| Iteration 4 | 13–14 | Appointment booking; real-time availability; eSewa payment integration |
| Iteration 5 | 15–16 | WebRTC video consultation; Socket.IO signalling; admin dashboard |
| Iteration 6 | 17–18 | Mood tracking; PHQ-9/GAD-7 questionnaires; content hub; Cloudinary integration |
| Iteration 7 | 18–19 | Wellness games; achievement system; subscriptions; push notifications (FCM); offline sync |

### Artefacts Produced Per Iteration

| Artefact Type | Description | Evidence Location |
|---|---|---|
| Working software increments | Fully integrated, tested feature increments after each iteration | Git commits; `Project Artefact/04 Development/` |
| Unit test results | Test results for each unit test as features were completed | `Project Artefact/05 Testing/` |
| Debugging evidence | Screenshots and logs of bugs found and fixed during development | `Project Artefact/04 Development/` |
| API endpoint documentation | Updated API reference as new endpoints were added | `07_API_Reference.md` |
| Code review notes | Self-review notes and refactoring decisions | Weekly artefact logs |

### Key Technical Decisions Made in Construction

- **GetIt + Injectable:** Dependency injection framework selected to support Clean Architecture layer separation
- **GoRouter:** Navigation with route guards for role-based access control
- **Freezed + json_serializable:** Code generation for immutable state models and JSON parsing
- **Dio:** HTTP client for all API calls with interceptor-based auth token injection
- **flutter_webrtc:** Official WebRTC package for peer connection management
- **Protocol Buffers:** Binary serialisation format for offline-synced mood entries

---

## PHASE 4: TRANSITION (Week 20, March–April 2025)

**Objective:** Deploy the system, conduct system testing and UAT, gather post-survey data, and complete the final report.

### Artefacts Produced

| Artefact | Description | Evidence Location |
|---|---|---|
| System Test Results (TC-S001–S015) | Results of 15 integration/system test cases | Chapter 4; Appendix K |
| UAT Plan | Structured UAT plan with 5 target users + 2 external clients | Chapter 4, Section 4.3 |
| UAT Results (TC-UAT001–025) | All 25 UAT test case results including the one partial pass | Chapter 4; Appendix K |
| Post-Survey (132 responses) | Satisfaction and outcome survey distributed after Transition | Appendix H; `Surveys.md` |
| User Feedback Forms | UAT feedback forms from all five target user participants | Appendix L |
| Final Gantt Chart | Actual timeline with deviations noted | Appendix J.1 |
| Client Approval Letters | Signed approval from Ms. Sushana Karki and Dr. Dibyandra Singh | Appendix F |
| System Screenshots | Captured screenshots of all major screens in deployed state | Appendix J.12 |
| Final FYP Report | Complete academic report submitted for assessment | `FYP Report Writing/` |
| Post-Survey Analysis | 100% positive outcomes on all ten post-survey questions | Chapter 4, Section 4.4; Appendix H |
