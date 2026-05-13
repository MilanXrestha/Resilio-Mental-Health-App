# TESTING STRATEGY

Full testing strategy for Resilio covering the testing methodology, test levels, test design approach, and the rationale for the test coverage achieved. This document supports Chapter 4 of the FYP report.

---

## TESTING OVERVIEW

Resilio was tested across three levels following a bottom-up strategy: unit tests validated individual components in isolation, system tests validated integrated end-to-end flows, and user acceptance tests validated the system against real-world user requirements with external participants.

| Test Level | Quantity | Pass Rate | Conducted By |
|---|---|---|---|
| Unit Tests | 40 (30 documented + 10 in repo) | 100% | Developer |
| System Tests | 40 (15 documented + 25 in repo) | 100% | Developer |
| User Acceptance Tests | 25 | 104/105 (99.05%) | External participants |
| **Total** | **105** | **99.05%** | — |

---

## TESTING METHODOLOGY

### Approach: Black-Box and White-Box Hybrid

| Type | Applied To | Description |
|---|---|---|
| White-box testing | Unit tests (TC-U series) | Internal logic tested directly: database constraints, validation rules, RLS policies, business logic in service layer |
| Black-box testing | System tests (TC-S series) + UAT (TC-UAT series) | System tested through its public interfaces: API endpoints and Flutter UI; no assumption about internal implementation |

### Technique: Equivalence Partitioning and Boundary Value Analysis

Applied to input validation tests:
- **TC-U009:** Mood score = 0 (below valid minimum of 1) → boundary value
- **TC-U010:** Mood score = 6 (above valid maximum of 5) → boundary value
- **TC-U012:** PHQ-9 answer = 4 (above valid maximum of 3) → boundary value
- **TC-S006:** PHQ-9 total = 20 (crisis threshold boundary) → boundary value

---

## TEST LEVEL 1: UNIT TESTS (TC-U001 to TC-U040)

### Scope

Unit tests target individual system components:
- Authentication service (SuperTokens integration)
- Appointment repository (creation, conflict detection, status updates)
- Mood entry service (validation, persistence)
- Questionnaire service (score calculation, severity band assignment, crisis threshold)
- Payment verification service (eSewa callback processing, tamper detection)
- Subscription service (creation, duplicate prevention)
- Game session service (recording, achievement trigger)
- Favourites service (creation, duplicate prevention)
- Therapist profile service (linking, verification status)
- Notification service (creation on events)
- Row Level Security policies (cross-user access prevention)
- Offline sync (SQLite write → remote sync)

### Test Environment

- **Database:** Supabase test project (separate from production)
- **Authentication:** SuperTokens test tenant
- **Payment:** eSewa test environment
- **Notifications:** FCM test token (non-production)

### Coverage by Module

| Module | Test Cases | All Pass |
|---|---|---|
| Authentication (OTP + Social) | TC-U001 to TC-U004 | Yes |
| Appointments | TC-U005 to TC-U007 | Yes |
| Mood Entries | TC-U008 to TC-U010 | Yes |
| Questionnaires (PHQ-9, GAD-7) | TC-U011 to TC-U013 | Yes |
| Payment (eSewa) | TC-U014 to TC-U016 | Yes |
| Subscriptions | TC-U017 to TC-U018 | Yes |
| Games and Achievements | TC-U019 to TC-U020 | Yes |
| Favourites | TC-U021 to TC-U022 | Yes |
| Therapist Profile | TC-U023 to TC-U025 | Yes |
| Notifications | TC-U026 | Yes |
| Row Level Security | TC-U027 to TC-U028 | Yes |
| Offline Sync | TC-U029 to TC-U030 | Yes |
| Advanced (in repo) | TC-U031 to TC-U040 | Yes |

---

## TEST LEVEL 2: SYSTEM TESTS (TC-S001 to TC-S040)

### Scope

System tests validate complete end-to-end user flows across all three modules, ensuring the Flutter frontend, Node.js API, Supabase database, and external services (eSewa, FCM, WebRTC, Cloudinary) work together correctly.

### Key Flows Tested

| Flow | Test Cases |
|---|---|
| Complete customer registration and onboarding | TC-S001 |
| Therapist discovery, filtering, and profile view | TC-S002 |
| End-to-end appointment booking with eSewa payment | TC-S003 |
| Live WebRTC video consultation | TC-S004 |
| Therapist access to patient data during session | TC-S005 |
| PHQ-9 severe score crisis protocol | TC-S006 |
| Therapist content publication through admin approval | TC-S007 |
| Admin therapist registration rejection | TC-S008 |
| Wellness game session recording | TC-S009 |
| Achievement badge display after unlock | TC-S010 |
| Push notification delivery on appointment confirmation | TC-S011 |
| Subscription-gated premium content access | TC-S012, TC-S013 |
| Mood chart rendering | TC-S014 |
| Audio track playback from content hub | TC-S015 |
| Additional regression tests (in repo) | TC-S016 to TC-S040 |

### System Test Environment

- **Device:** Physical Android device (Pixel-class hardware) + second device for WebRTC sessions
- **Network:** Both WiFi (for WebRTC quality testing) and 4G mobile (for TURN server validation)
- **Backend:** Development server with production-equivalent configuration
- **Database:** Staging Supabase project (separate from UAT data)

---

## TEST LEVEL 3: USER ACCEPTANCE TESTING (TC-UAT001 to TC-UAT025)

### UAT Objectives

1. Validate that real users (not the developer) can complete all primary user journeys without assistance
2. Validate that external clients (Ms. Karki, Dr. Singh) confirm the platform meets the requirements they specified
3. Identify any usability issues not surfaced by functional testing
4. Measure user satisfaction and willingness to recommend

### UAT Participants

| Participant | Type | Role in UAT |
|---|---|---|
| Female, age 24 | Target user (student) | Customer journey: registration → booking → mood → content |
| Male, age 29 | Target user (working professional) | Customer journey: content hub → subscription → games |
| Male, age 26 | Target user (young professional) | Offline testing: airplane mode mood logging |
| Male, age 31 | Target user (professional) | Notification testing: push notification receipt and deep link |
| Female, age 22 | Target user (student) | Therapist discovery + trust rating |
| Ms. Sushana Karki | External client | Full therapist role: content creation, earnings, session workflow |
| Dr. Dibyandra Singh | External client | Admin role: therapist verification, content moderation, analytics |

**Note:** Only the 5 target users completed TC-UAT001 to TC-UAT013 and TC-UAT021 to TC-UAT025. Ms. Karki completed TC-UAT014 to TC-UAT016 and TC-UAT020. Dr. Singh completed TC-UAT017 to TC-UAT019.

### UAT Protocol

Each target user session followed this protocol:

1. **Briefing (5 min):** Participant told the purpose of the session; no instructions given about how to use the app
2. **Task completion (45–60 min):** Participant works through assigned tasks unassisted; observer notes any confusion or assistance requests
3. **Feedback form (10 min):** Participant completes the written feedback form (Appendix L)
4. **Debrief (5–10 min):** Participant asked to expand verbally on any feedback they gave

**Assistance rule:** The test facilitator (developer) did not provide any guidance during the task completion phase. If a participant became completely stuck, this was recorded as a failure or partial result for that test case.

### UAT Result: TC-UAT011 (Partial Pass)

TC-UAT011 tested whether a user could locate the PHQ-9 questionnaire within the app without instruction. The participant found the questionnaire after approximately 3 minutes — exceeding the 2-minute expected threshold. No assistance was required, so the test was recorded as **PARTIAL** rather than FAIL. The navigation path to the questionnaire section has been noted as a UX improvement for the next release (more prominent placement in bottom navigation or home screen quick action).

---

## TEST TRACEABILITY MATRIX

This matrix maps each functional requirement from the SRS to the test cases that validate it.

| Requirement | Test Cases |
|---|---|
| FR-C01: OTP/Google/Facebook registration | TC-U001 to TC-U003, TC-S001 |
| FR-C02: Preference onboarding | TC-S001, TC-UAT002 |
| FR-C03: Therapist directory browsing | TC-U024, TC-S002, TC-UAT003 |
| FR-C04: Matching questionnaire | TC-UAT003 |
| FR-C05: Appointment booking | TC-U005 to TC-U007, TC-S003, TC-UAT004 |
| FR-C06: eSewa payment | TC-U014 to TC-U016, TC-S003, TC-UAT004 |
| FR-C07: WebRTC consultation | TC-S004, TC-S005, TC-UAT012 |
| FR-C08: Mood logging | TC-U008 to TC-U010, TC-S014, TC-UAT005, TC-UAT006 |
| FR-C09: PHQ-9 and GAD-7 | TC-U011 to TC-U013, TC-S006, TC-UAT007, TC-UAT008 |
| FR-C10: Content hub | TC-S012, TC-S013, TC-S015, TC-UAT010 |
| FR-C11: Wellness games + achievements | TC-U019, TC-U020, TC-S009, TC-S010, TC-UAT009 |
| FR-C12: Push notifications | TC-U026, TC-S011, TC-UAT016, TC-UAT024 |
| FR-C13: Favourites | TC-U021, TC-U022 |
| FR-T01: Therapist registration | TC-U023, TC-UAT017 |
| FR-T02: Availability calendar | TC-U005, TC-UAT014 |
| FR-T03: Appointment list + patient records | TC-S005, TC-UAT020 |
| FR-T04: Patient data in consultation | TC-S005 |
| FR-T05: Content publishing | TC-S007, TC-UAT014 |
| FR-T06: Earnings summary | TC-UAT015 |
| FR-A01: Therapist verification | TC-U024, TC-U025, TC-S008, TC-UAT017 |
| FR-A02: User management | TC-UAT017 (indirectly) |
| FR-A03: Content moderation | TC-S007, TC-S008, TC-UAT018 |
| FR-A04: Platform analytics | TC-UAT019 |

---

## DEFECTS LOG

| ID | Test Case | Defect Description | Severity | Resolution |
|---|---|---|---|---|
| BUG-001 | TC-U007 | Double-booking check was not atomic — race condition possible under concurrent requests | High | Database-level unique constraint added to prevent race condition |
| BUG-002 | TC-U016 | eSewa tampered callback was initially accepted due to string comparison instead of numeric | High | Changed amount comparison to parseFloat with tolerance check |
| BUG-003 | TC-S004 | WebRTC connection failed on 4G mobile — STUN insufficient | High | TURN server deployed (R-T01 mitigation) |
| BUG-004 | TC-UAT011 | PHQ-9 questionnaire not discoverable within 2 minutes | Low | Navigation path noted for next release UX improvement |
| BUG-005 | TC-S001 | Google Sign-In redirect URL misconfigured in SuperTokens dashboard | Medium | Redirect URL corrected in SuperTokens dashboard configuration |

**Total defects found:** 5
**Critical/High defects resolved before submission:** 3 of 3
**Medium defects resolved:** 1 of 1
**Low defects (deferred):** 1 (TC-UAT011 — navigation improvement)

---

## TESTING TOOLS

| Tool | Used For |
|---|---|
| Postman | API endpoint testing during unit and system testing |
| Android Studio Emulator | Functional testing during Construction iterations |
| Physical Android device | FCM, WebRTC, eSewa, offline mode testing |
| Flutter DevTools | Widget inspection; memory and performance profiling |
| Supabase Dashboard | Verifying database state after each test case |
| `flutter test` | Running automated widget and unit tests |
