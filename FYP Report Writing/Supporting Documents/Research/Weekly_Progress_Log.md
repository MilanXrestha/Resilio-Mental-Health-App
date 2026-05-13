# WEEKLY PROGRESS LOG

Summary of work completed each week across all four RUP phases. This log provides evidence of continuous engagement with the project and maps development progress to the planned schedule.

---

## PHASE 1: INCEPTION (Weeks 1–4)

### Week 1 — Project Setup and Problem Framing

**Dates:** 1–8 November 2024

| Task | Status | Notes |
|---|---|---|
| Project proposal drafted and submitted | Done | Defined problem, proposed solution, initial scope |
| Initial background reading on Nepal mental health statistics | Done | MoHP 2020 survey; WHO 2021 situational assessment |
| SuperTokens and eSewa feasibility research | Done | Identified SuperTokens as viable passwordless auth option |
| Pre-survey questions drafted | Done | 10-question Google Form prepared |
| Technology stack initial selection | Done | Flutter, Node.js, Supabase, SuperTokens, eSewa |
| GitHub repository created | Done | Private repo; initial Flutter and Node.js project scaffolded |

**Artefacts:** Project proposal; pre-survey draft; technology selection notes

---

### Week 2 — Stakeholder Interviews and Survey Launch

**Dates:** 9–15 November 2024

| Task | Status | Notes |
|---|---|---|
| Interview with Ms. Sushana Karki conducted | Done | 45-minute semi-structured interview; see 05_Client_Documents |
| Video interview with Dr. Dibyandra Singh (Zoom) | Done | 60-minute call; clinical workflow requirements documented |
| Pre-survey distributed | Done | WhatsApp groups, university social media, personal network |
| Risk register drafted | Done | 21 risks identified; prioritised by likelihood × impact |
| Competitor analysis begun | Done | BetterHelp, Headspace, Wysa, HamroPatro review |

**Artefacts:** Interview notes (see 05_Client_Documents); risk register draft; competitor notes

---

### Week 3 — Feasibility Study and Methodology Selection

**Dates:** 16–22 November 2024

| Task | Status | Notes |
|---|---|---|
| Pre-survey results collected (166 responses) | Done | Google Forms auto-aggregation; pie chart exports |
| Feasibility study written | Done | Technical, economic, operational, schedule feasibility |
| Methodology comparison: Agile vs Waterfall vs RUP vs Prototype | Done | Comparison matrix created; RUP selected |
| Initial Gantt chart created in Lucidchart | Done | Covers all four RUP phases |
| Work Breakdown Structure created | Done | Five top-level areas; full task decomposition |

**Artefacts:** Feasibility study; methodology comparison matrix (Appendix E); initial Gantt chart; WBS

---

### Week 4 — Project Environment and Inception Wrap-Up

**Dates:** 23–30 November 2024

| Task | Status | Notes |
|---|---|---|
| Flutter project structure established (Clean Architecture) | Done | Feature-first folder structure; placeholder modules created |
| Node.js project scaffolded | Done | Express app; folder structure; dotenv configured |
| Supabase project created | Done | Database instance provisioned; initial environment variables set |
| SuperTokens managed service account created | Done | Passwordless recipe configured in dashboard |
| Pre-survey findings analysed and documented | Done | Key findings table prepared for report |
| Inception phase review | Done | All planned artefacts completed |

**Artefacts:** Project scaffolding; environment configuration; survey analysis

---

## PHASE 2: ELABORATION (Weeks 5–8)

### Week 5 — Architecture Design and SRS

**Dates:** 1–7 December 2024

| Task | Status | Notes |
|---|---|---|
| System architecture diagram created | Done | Three-tier: Flutter → Node.js → Supabase; all external services mapped |
| SRS drafted | Done | All functional and non-functional requirements documented |
| Entity-Relationship Diagram drafted | Done | 20 tables identified; relationships mapped |
| Use case diagrams (Customer, Therapist, Admin) | Done | Three separate diagrams; Mermaid source code written |

**Artefacts:** System architecture diagram; SRS (Appendix M); ERD; use case diagrams

---

### Week 6 — SuperTokens and Google Sign-In Prototype

**Dates:** 8–14 December 2024

| Task | Status | Notes |
|---|---|---|
| SuperTokens OTP three-step flow prototype built | Done | createCode → consumeCode → /auth/passwordless/complete |
| Google Sign-In integration prototyped | Done | ThirdParty provider configured in SuperTokens dashboard |
| Facebook Sign-In integration prototyped | Done | Facebook app credentials configured |
| JWT middleware for Node.js tested | Done | SuperTokens verifySession() middleware validating tokens |
| Supabase RLS initial policies written | Done | User self-access policies tested |
| Wireframes begun in Figma | Done | Onboarding and authentication screens wireframed |

**Artefacts:** SuperTokens prototype; middleware proof-of-concept; initial wireframes

---

### Week 7 — WebRTC Prototype and Figma Mockups

**Dates:** 15–21 December 2024

| Task | Status | Notes |
|---|---|---|
| WebRTC peer connection prototype built | Done | flutter_webrtc + Socket.IO signalling; two-device video call achieved |
| Socket.IO signalling server implemented | Done | join-room, offer, answer, ice-candidate events |
| STUN server tested with Google STUN | Done | Works on WiFi; fails on some mobile networks — TURN noted as needed |
| eSewa payment SDK prototype | Done | Test environment payment; success callback handler tested |
| Figma UI mockups completed | Done | All screens for all three user roles |
| Client prototype review — Ms. Karki and Dr. Singh | Done | Feedback incorporated; see 05_Client_Documents |
| Activity diagrams created | Done | Booking, WebRTC, content publication flows |
| Sequence diagrams created | Done | OTP login, booking, WebRTC session |

**Artefacts:** WebRTC prototype; eSewa prototype; Figma mockups; activity diagrams; sequence diagrams

---

### Week 8 — Interim Report and Elaboration Wrap-Up

**Dates:** 22–31 December 2024

| Task | Status | Notes |
|---|---|---|
| Data Flow Diagrams created | Done | Level 0 and Level 1 for all three user roles |
| Database schema finalised | Done | All 20 tables; column types; constraints; foreign keys |
| RLS policies written for all tables | Done | Tested in Supabase dashboard |
| Interim report written and submitted | Done | Full academic report covering Chapters 1–3 |
| Elaboration phase review | Done | All high-risk components prototyped; architecture validated |

**Artefacts:** DFDs; final database schema; RLS policies; Interim Report submitted

---

## PHASE 3: CONSTRUCTION (Weeks 9–19)

### Week 9 — Iteration 1: Authentication Module

**Dates:** 1–7 January 2025

| Task | Status | Notes |
|---|---|---|
| SuperTokens OTP flow integrated into Flutter | Done | createCode screen → OTP verification screen → complete |
| Google Sign-In integrated | Done | flutter_webrtc_google_sign_in package configured |
| Facebook Sign-In integrated | Done | flutter_facebook_auth configured |
| Role-based GoRouter navigation guards | Done | 'user', 'therapist', 'admin' routes protected |
| User onboarding preference screens | Done | 5-question preference flow; stored in Supabase |
| GetIt + Injectable DI setup | Done | Service locator registered; all layers wired |
| Unit tests: TC-U001 to TC-U004 written and passed | Done | OTP registration, duplicate email, Google login, role assignment |

---

### Week 10 — Iteration 2: Database Layer and Backend Structure

**Dates:** 8–14 January 2025

| Task | Status | Notes |
|---|---|---|
| All 20 database tables created in Supabase | Done | SQL migration scripts written |
| RLS policies deployed on all tables | Done | Tested with Postman using multiple user tokens |
| Node.js API structure established | Done | Controllers, services, repositories pattern |
| Authentication middleware deployed | Done | verifySession() + requireRole() on all protected routes |
| Base repository classes written | Done | Supabase client queries with error handling |
| TC-U027, TC-U028 (RLS cross-user tests) written and passed | Done | Confirmed RLS prevents cross-user data access |

---

### Week 11 — Iteration 3: Therapist Directory and Admin Verification

**Dates:** 15–21 January 2025

| Task | Status | Notes |
|---|---|---|
| Therapist profile creation API | Done | POST /therapists/profile |
| Admin verification workflow API | Done | PUT /admin/therapists/:id/verify |
| Therapist directory API with filters | Done | GET /therapists?specialisation=&language= |
| Flutter: Therapist directory screen | Done | Filterable card list with fee, specialisation, language |
| Flutter: Therapist profile page | Done | Full profile with booking button |
| Flutter: Admin therapist verification screen | Done | Pending applications queue |
| Unit tests: TC-U023 to TC-U025 written and passed | Done | Profile linking, unverified exclusion, admin verification |

---

### Week 12 — Iteration 4: Appointment Booking

**Dates:** 22–28 January 2025

| Task | Status | Notes |
|---|---|---|
| Availability slot management API | Done | POST/DELETE /therapists/availability |
| Appointment creation API | Done | POST /appointments |
| Real-time slot availability display | Done | Calendar with available/unavailable slots |
| Double-booking prevention constraint | Done | Unique constraint + backend check |
| Flutter: Booking calendar screen | Done | Date picker → slot selector → confirm |
| Unit tests: TC-U005 to TC-U007 written and passed | Done | Valid creation, unverified block, double-booking |

---

### Week 13 — Iteration 4 (continued): eSewa Payment Integration

**Dates:** 29 January – 4 February 2025

| Task | Status | Notes |
|---|---|---|
| eSewa Flutter SDK integrated | Done | EsewaFlutterSdk.initPayment() wired to booking flow |
| Payment verification endpoint | Done | POST /payment/verify with HMAC check |
| Tamper detection for payment callbacks | Done | Amount validation; rejecting modified values |
| Transaction recording | Done | transactions table populated on confirmed payment |
| FCM notification on booking confirmation | Done | Patient and therapist both notified |
| Unit tests: TC-U014 to TC-U016 written and passed | Done | Success callback, failed callback, tampered callback |

---

### Week 14 — Iteration 5: WebRTC Video Consultation

**Dates:** 5–11 February 2025

| Task | Status | Notes |
|---|---|---|
| Socket.IO signalling server deployed | Done | join-room, offer, answer, ice-candidate events |
| Flutter WebRTC peer connection | Done | RTCPeerConnection; getUserMedia; remote stream rendering |
| TURN server deployed | Done | Required for mobile network NAT traversal (R-T01 resolved) |
| Flutter: Consultation screen (patient view) | Done | Video streams, mute, camera toggle, end session |
| Flutter: Consultation panel (therapist view) | Done | Video + patient mood chart + PHQ-9/GAD-7 panel |
| System test: TC-S004, TC-S005 written and passed | Done | Live video call; therapist patient data view |

---

### Week 15 — Iteration 5 (continued): Admin Dashboard

**Dates:** 12–18 February 2025

| Task | Status | Notes |
|---|---|---|
| Admin analytics API | Done | GET /admin/analytics — user counts, session stats |
| Admin user management API | Done | GET/DELETE /admin/users |
| Admin content moderation queue | Done | GET /admin/content/pending; approve/reject actions |
| Flutter: Admin home dashboard | Done | Statistics cards, recent activity |
| Flutter: Admin users screen | Done | User list with role filters |
| Flutter: Content moderation queue screen | Done | Pending articles with approve/reject |
| System test: TC-S007, TC-S008 written and passed | Done | Content gating; therapist rejection enforcement |

---

### Week 16 — Iteration 6: Mood Tracking and Questionnaires

**Dates:** 19–25 February 2025

| Task | Status | Notes |
|---|---|---|
| Mood entry API (create + history) | Done | POST /mood; GET /mood?days=7 |
| PHQ-9 submission API | Done | POST /questionnaires/phq9; score calculation; crisis threshold |
| GAD-7 submission API | Done | POST /questionnaires/gad7 |
| Flutter: Mood logging screen | Done | Slider + emoji labels + note field |
| Flutter: Mood history chart | Done | fl_chart 7-day and 30-day line charts |
| Flutter: PHQ-9/GAD-7 questionnaire screens | Done | Per-question answer selection; progress bar |
| Crisis notice screen | Done | Triggered when PHQ-9 ≥ 20; helpline number displayed |
| System test: TC-S006 written and passed | Done | PHQ-9 severe threshold triggers crisis notice |

---

### Week 17 — Iteration 6 (continued): Content Hub and Cloudinary

**Dates:** 26 February – 4 March 2025

| Task | Status | Notes |
|---|---|---|
| Cloudinary upload integrated | Done | Images, audio, video upload from Flutter and Node.js |
| Content CRUD API | Done | Full create/read/update/delete for all content types |
| Content hub Flutter screens | Done | Category tabs; article reader; audio player; video player |
| LRU content cache | Done | Previously loaded content available offline |
| Subscription-gated premium content | Done | Premium flag check against user's active subscription |
| System test: TC-S012, TC-S013, TC-S015 written and passed | Done | Subscription gating; audio playback |

---

### Week 18 — Iteration 7: Wellness Games and Achievement System

**Dates:** 5–11 March 2025

| Task | Status | Notes |
|---|---|---|
| Breathing Bubble game | Done | Animated expand/contract; 4-7-8 breathing pattern |
| Wellness Trivia game | Done | Multiple choice; score tracking |
| Affirmation Builder game | Done | Selectable affirmations; personalisation |
| Motivational Story game | Done | Narrative choice mechanics |
| Game session recording API | Done | POST /games/sessions |
| Achievement unlock logic | Done | Event-triggered checks; badge awarded on first occurrence |
| Flutter: Achievement gallery | Done | Profile page with unlocked badges |
| Unit tests: TC-U019, TC-U020 written and passed | Done | Session recording; achievement award |

---

### Week 19 — Iteration 7 (continued): Offline Sync, Push Notifications, Subscriptions

**Dates:** 12–18 March 2025

| Task | Status | Notes |
|---|---|---|
| SQLite offline mood logging | Done | sqflite integration; background sync on connectivity restore |
| Offline-to-online sync job | Done | connectivity_plus listener → flush queue on reconnect |
| FCM push notifications (all event types) | Done | Booking confirmation, session reminder, content approval |
| Subscription creation API | Done | POST /subscriptions; plan tier gating |
| Flutter: Subscription plans screen | Done | Free/Silver/Gold tier display |
| Unit tests: TC-U029, TC-U030 written and passed | Done | Offline sync; cache serving |
| Final Construction phase review | Done | All 7 iterations complete; full feature set delivered |

---

## PHASE 4: TRANSITION (Week 20)

### Week 20 — Testing, UAT, Post-Survey, Final Report

**Dates:** 19 March – 30 April 2025

| Task | Status | Notes |
|---|---|---|
| System test cases TC-S001 to TC-S015 executed | Done | All 15 passed |
| UAT planning and participant recruitment | Done | 5 target users + 2 clients identified and scheduled |
| UAT sessions conducted (5 target users) | Done | TC-UAT001 to TC-UAT013, TC-UAT021 to TC-UAT025 |
| UAT sessions conducted (Ms. Karki — therapist role) | Done | TC-UAT014 to TC-UAT016, TC-UAT020 |
| UAT sessions conducted (Dr. Singh — admin role) | Done | TC-UAT017 to TC-UAT019 |
| Post-survey distributed and collected | Done | 132 responses; 100% positive outcomes |
| User feedback forms collected | Done | All 5 target users + 2 clients |
| Client approval letters obtained | Done | Signed by Ms. Karki and Dr. Singh |
| System screenshots captured | Done | All major screens; see Appendix J.12 |
| Final Gantt chart updated with actual timeline | Done | Deviations noted: WebRTC +1 week; eSewa −1 week |
| FYP report finalised | Done | All 6 chapters + appendices A–N |
| Report submitted | Done | Submitted April 2025 |

---

## CONSTRUCTION ITERATION SUMMARY

| Iteration | Weeks | Primary Deliverable | Status |
|---|---|---|---|
| 1 | 9–10 | Authentication + onboarding | Complete |
| 2 | 10–11 | Database layer + API structure | Complete |
| 3 | 11–12 | Therapist directory + admin verification | Complete |
| 4 | 12–13 | Appointment booking + eSewa payment | Complete |
| 5 | 14–15 | WebRTC consultation + admin dashboard | Complete |
| 6 | 16–17 | Mood tracking + questionnaires + content hub | Complete |
| 7 | 18–19 | Wellness games + achievements + offline + notifications | Complete |
