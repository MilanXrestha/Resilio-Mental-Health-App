# CHAPTER 4: TESTING AND ANALYSIS

---

## 4.1 Test Plan

Testing for Resilio was conducted at three levels: unit testing of individual business logic components, system testing of the integrated end-to-end application, and user acceptance testing with real users and clients.

### 4.1.1 Unit Testing

Unit tests target the Flutter domain layer use cases and Node.js backend service classes. Tools used include `flutter_test` with `mockito` for Dart and `jest` for Node.js. Each use case is tested in isolation with mocked repository interfaces. All unit tests are required to pass before a feature is merged. The full set of 40 unit test cases is provided in Appendix K, Section K.1.

### 4.1.2 System Testing

System tests validate the complete integrated application across all user roles and external services. Tools include Postman for API testing, Android emulator and physical device for UI testing, and manual exploratory testing for user acceptance. The full set of 40 system test cases is provided in Appendix K, Section K.2.

---

## 4.2 Unit Testing

Five representative unit test cases are presented below. The remaining 35 are provided in Appendix K, Sections K.1 and K.4.

---

**Table 4.1: Test Case TC-U001: Valid User Registration via SuperTokens OTP**

| Field | Detail |
|---|---|
| Test Case ID | TC-U001 |
| Description | Valid user registration creates a user record via SuperTokens OTP |
| Input / Steps | Valid email submitted; OTP verified; role = 'user' |
| Expected Result | User record inserted; SuperTokens session token issued; role assigned |
| Actual Result | User created with correct role and session token |
| Status | **PASS** |

---

**Table 4.2: Test Case TC-U002: Duplicate Email Registration Rejected**

| Field | Detail |
|---|---|
| Test Case ID | TC-U002 |
| Description | Registering with an existing email is rejected |
| Input / Steps | OTP requested for an already-registered email |
| Expected Result | Duplicate email error returned |
| Actual Result | Error returned correctly |
| Status | **PASS** |

---

**Table 4.3: Test Case TC-U003: Appointment Creation with Valid Data**

| Field | Detail |
|---|---|
| Test Case ID | TC-U003 |
| Description | Valid appointment data creates a record with status = pending |
| Input / Steps | POST /appointments with valid patient_id, therapist_id, scheduled_time |
| Expected Result | Appointment created with status = pending and payment_status = pending |
| Actual Result | Appointment created correctly |
| Status | **PASS** |

---

**Table 4.4: Test Case TC-U004: Booking Rejected for Unverified Therapist**

| Field | Detail |
|---|---|
| Test Case ID | TC-U004 |
| Description | Booking against a therapist with is_verified = false is rejected |
| Input / Steps | Patient attempts to book an unverified therapist |
| Expected Result | Error returned: therapist not verified |
| Actual Result | Booking rejected with correct error |
| Status | **PASS** |

---

**Table 4.5: Test Case TC-U005: Mood Entry Saved with Valid Data**

| Field | Detail |
|---|---|
| Test Case ID | TC-U005 |
| Description | A mood entry with valid score, label, and note is persisted correctly |
| Input / Steps | mood_score = 3; mood_label = 'Neutral'; note = 'Average day' |
| Expected Result | Entry inserted with correct user_id and all submitted fields |
| Actual Result | Entry saved with all fields correct |
| Status | **PASS** |

---

## 4.3 System Testing

### 4.3.1 Black Box Testing

Black box testing was conducted from the user's perspective with no knowledge of the internal implementation. Five representative cases are presented below. The full set of 40 system test cases is provided in Appendix K, Sections K.2 and K.5.

---

**Table 4.11: Test Case TC-S001: Customer Completes Registration and Onboarding**

| Field | Detail |
|---|---|
| Test Case ID | TC-S001 |
| Steps | Enter email; receive OTP; complete preference selection |
| Expected Result | Account created; preferences saved; home screen displayed |
| Actual Result | Registration and onboarding completed successfully |
| Status | **PASS** |

---

**Table 4.12: Test Case TC-S002: Therapist Directory Filter by Specialty**

| Field | Detail |
|---|---|
| Test Case ID | TC-S002 |
| Steps | Navigate to therapist list; apply filter specialty = 'Anxiety' |
| Expected Result | Only matching therapists displayed |
| Actual Result | Filtered results correct |
| Status | **PASS** |

---

**Table 4.13: Test Case TC-S003: Full Booking and eSewa Payment**

| Field | Detail |
|---|---|
| Test Case ID | TC-S003 |
| Steps | Select therapist; choose slot; tap Book; complete eSewa payment |
| Expected Result | Appointment confirmed; push notification sent to both parties |
| Actual Result | Booking and notification delivered correctly |
| Status | **PASS** |

---

**Table 4.14: Test Case TC-S004: Customer Joins Live Video Consultation**

| Field | Detail |
|---|---|
| Test Case ID | TC-S004 |
| Steps | Customer taps Join Session on confirmed appointment |
| Expected Result | WebRTC peer connection established; audio and video active |
| Actual Result | Clear audio and video confirmed on both devices |
| Status | **PASS** |

---

**Table 4.15: Test Case TC-S005: Therapist Views Patient Mood Data**

| Field | Detail |
|---|---|
| Test Case ID | TC-S005 |
| Steps | Therapist opens consultation interface before session |
| Expected Result | Patient mood log entries and PHQ-9/GAD-7 scores displayed |
| Actual Result | Mood data visible to therapist |
| Status | **PASS** |

---

### 4.3.2 Integration Testing

Integration testing verified all five external service connections. SuperTokens OTP flow, session token issuance, and role assignment all passed across 12 test cases. eSewa sandbox success and failure callbacks were tested against 8 cases including tampered payload injection, all of which passed. Firebase Cloud Messaging delivery was confirmed for all 8 notification types defined in the schema. Cloudinary media delivery averaged 1.2 seconds latency on 4G, within the 2-second NFR threshold. WebRTC peer connections averaged 3.1 seconds establishment time on 4G between two physical devices.

### 4.3.3 User Acceptance Testing

UAT was conducted in two sessions: first with Ms. Sushana Karki and Dr. Dibyandra Singh evaluating the therapist and admin workflows, then with five target users evaluating the customer journey. Four of five customers completed all tasks without assistance; one required guidance to locate the questionnaire feature, noted as a UX improvement. Both clients confirmed the therapist workflow met their professional requirements. Three representative UAT cases are shown below; all 25 are in Appendix K, Section K.3.

---

**Table 4.26: Test Case TC-UAT001: New Customer Registers Without Assistance**

| Field | Detail |
|---|---|
| Tester | Target user, female, age 22 |
| Task | Register a new account without instruction |
| Expected Outcome | Registration completed independently |
| Actual Outcome | Completed without assistance |
| Status | **PASS** |

---

**Table 4.27: Test Case TC-UAT012: Client Views Patient Mood Before Session**

| Field | Detail |
|---|---|
| Tester | Ms. Sushana Karki |
| Task | Access patient mood history from consultation interface |
| Expected Outcome | Mood log and questionnaire scores visible; found clinically useful |
| Actual Outcome | Confirmed as clinically useful |
| Status | **PASS** |

---

**Table 4.28: Test Case TC-UAT025: Participants Would Recommend Resilio**

| Field | Detail |
|---|---|
| Tester | All 5 target user participants |
| Task | Would you recommend Resilio to someone with mental health difficulties? |
| Expected Outcome | Minimum 4 of 5 respond affirmatively |
| Actual Outcome | All 5 confirmed they would recommend Resilio |
| Status | **PASS** |

---

## 4.4 Critical Analysis

### 4.4.1 System Performance

| NFR | Target | Measured Result | Status |
|---|---|---|---|
| API response time | Under 500ms | Average 287ms | Met |
| Screen load time on 4G | Under 2 seconds | Average 1.4 seconds | Met |
| Audio delivery latency | Under 2 seconds | Average 1.2 seconds via Cloudinary | Met |
| Offline mood log write | Immediate | Under 100ms (SQLite) | Met |
| Offline to online sync | Under 5 seconds | Average 2.3 seconds | Met |

### 4.4.2 Issues Encountered and Resolutions

**WebRTC NAT traversal:** Peer connections failed under certain NAT configurations. Resolved by adding a TURN server to the WebRTC configuration to relay connections that could not be established peer-to-peer.

**eSewa sandbox delays:** Callback delays up to 8 seconds caused the app to show a pending state longer than expected. Resolved by implementing a 2-second polling mechanism on the frontend checking payment status for up to 30 seconds post-initiation.

**SQLite/PostgreSQL sync conflict:** Offline edits and online edits to the same mood entry conflicted. Resolved using a last-write-wins strategy with `updated_at` timestamps.

**SuperTokens session expiry:** Long-inactive users experienced auth failures. Resolved with a Dio HTTP interceptor that refreshes session tokens automatically before expiry.

### 4.4.3 Comparison of Outcomes Against Objectives

| Objective | Status |
|---|---|
| Flutter and Node.js Clean Architecture application | Achieved |
| Offline functionality via SQLite and local caching | Achieved |
| EMA-based mood tracking | Achieved |
| Multimedia content hub | Achieved |
| Wellness games with gamification | Achieved |
| Therapist booking with WebRTC sessions | Achieved |
| eSewa payment integration | Achieved |
| Role-specific dashboards | Achieved |
| Data protection compliance | Achieved |

All nine development objectives were fully achieved.

### 4.4.4 Lessons Learned

Early WebRTC prototyping during the Elaboration phase proved its worth precisely when NAT traversal failures emerged in testing; discovering this late would have been significantly more costly. eSewa sandbox behaviour differs from production in undocumented ways; characterising sandbox limitations earlier would have allowed the polling mechanism to be designed proactively rather than reactively. Offline-first architecture introduces data consistency challenges that require explicit design attention. More time allocated to sync conflict resolution logic in the construction phase would have reduced late-stage rework.

---

## References

Beck, K., Beedle, M., van Bennekum, A., Cockburn, A., Cunningham, W., Fowler, M. and others (2001) *Manifesto for Agile Software Development*. Available at: https://agilemanifesto.org (Accessed: 15 April 2026).

Martin, R.C. (2017) *Clean Architecture: A Craftsman's Guide to Software Structure and Design*. Upper Saddle River: Prentice Hall.

Sommerville, I. (2016) *Software Engineering*. 10th edn. Harlow: Pearson Education.
