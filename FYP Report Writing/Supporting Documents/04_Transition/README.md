# TRANSITION PHASE — Supporting Documents
**RUP Phase:** Transition | **Week:** 20 | **Dates:** 19 March – 30 April 2025

---

## Phase Objective

Deploy the complete system to production (Vercel + Railway), conduct system testing and user acceptance testing, gather post-survey data, obtain client approval letters, and finalise the FYP report for submission.

---

## Documents in This Folder

| File | Contents | Report Reference |
|---|---|---|
| `Testing_Strategy.md` | Three-level testing approach (unit/system/UAT); test design rationale (equivalence partitioning, BVA); coverage table; UAT protocol; traceability matrix mapping all 24 FRs to test cases; defects log (5 bugs) | Chapter 4; Appendix K |
| `Deployment.md` | Vercel deployment of Node.js/Express backend; actual `vercel.json`; Socket.IO constraint and Railway solution; CORS config; all 14 environment variables; Flutter `ApiEndpoints.dart` pattern; deployment checklist | Chapter 3, Section 3.6 |

---

## Transition Outcomes

| Activity | Result |
|---|---|
| Unit tests (40 cases) | 40/40 passed — 100% |
| System tests (40 cases) | 40/40 passed — 100% |
| UAT (25 cases, 7 participants) | 24 passed, 1 partial — 99.05% overall |
| Post-survey (132 responses) | All 10 outcome metrics positive |
| Vercel production deployment | Live at `https://resilio-api.vercel.app` |
| Socket.IO signalling deployment | Live at `https://resilio-signalling.up.railway.app` |
| Client approval letters | Obtained from Ms. Sushana Karki and Dr. Dibyandra Singh |

---

## Bugs Resolved Before Submission

| Bug ID | Description | Resolution |
|---|---|---|
| BUG-001 | Double-booking race condition on concurrent slot selection | PostgreSQL row-level lock on appointments insert |
| BUG-002 | eSewa verification failing — type mismatch on transaction ID | Coerced both sides to string before comparison |
| BUG-003 | WebRTC ICE failure on 4G networks | Added TURN server fallback; increased ICE timeout to 15s |
| BUG-004 | PHQ-9 discoverability — 3 min vs 2 min target (TC-UAT011 partial) | Promoted questionnaire card to home dashboard |
| BUG-005 | SuperTokens redirect URL mismatch in production | Updated `WEBSITE_DOMAIN` env var to Vercel production URL |

---

## Production Deployment Architecture

```
Flutter App (Android APK)
    ↓ REST calls
Vercel (https://resilio-api.vercel.app)
    Node.js / Express — src/index.js
    ↓
Supabase (PostgreSQL) — managed cloud
    
Flutter App
    ↓ WebSocket
Railway (https://resilio-signalling.up.railway.app)
    Socket.IO signalling server — src/services/webrtc-socket.js
    ↓
WebRTC peer connection (P2P audio/video)
```
