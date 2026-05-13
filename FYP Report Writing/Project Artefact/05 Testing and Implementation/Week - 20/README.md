# Week 20 — Transition Phase: Testing, Deployment, and Final Submission
**Phase:** Transition | **Dates:** 19 March – 30 April 2025

---

## Activities Completed

| Activity | Status |
|---|---|
| System test execution (TC-S001–S015) | Done |
| Unit test execution (TC-U001–TC-U040) | Done |
| UAT sessions with 7 participants | Done |
| Post-survey distribution and collection | Done |
| Production deployment to Vercel | Done |
| Socket.IO signalling server deployed to Railway | Done |
| Production smoke test (all critical paths) | Done |
| Client approval letters obtained | Done |
| FYP final report completed and submitted | Done |

---

## Files in This Folder

| File / Folder | Contents |
|---|---|
| `Research/` | Post-survey raw data (132 responses), pre/post comparison analysis |
| `Customer Validation/` | UAT session recordings, user feedback forms (7 participants) |
| `Social, Ethical and Legal Issues/` | GDPR considerations, data protection, clinical disclaimer |
| `Cover Pages Project Folder.pdf` | Cover page submitted with physical folder |
| `docs_google_com_forms_d_*.pdf` | Google Form PDF export of the post-survey instrument |

---

## Test Results Summary

| Level | Cases | Passed | Partial | Failed | Pass Rate |
|---|---|---|---|---|---|
| Unit Tests | 40 | 40 | 0 | 0 | 100% |
| System Tests | 40 | 40 | 0 | 0 | 100% |
| UAT | 25 | 24 | 1 | 0 | 96% |
| **Total** | **105** | **104** | **1** | **0** | **99.05%** |

**Partial: TC-UAT011** — PHQ-9 questionnaire discoverability (3 min vs 2 min target — UX improvement noted for future release)

---

## System Test Cases (TC-S001–S015)

| TC ID | Feature Area | Test Description | Result |
|---|---|---|---|
| TC-S001 | Authentication | OTP login — valid OTP accepted within 5 minutes | Pass |
| TC-S002 | Authentication | OTP login — expired OTP (>5 min) rejected | Pass |
| TC-S003 | Appointment | Booking prevents double-booking (race condition guard active) | Pass |
| TC-S004 | Appointment | Therapist availability correctly blocks booked slots | Pass |
| TC-S005 | Video Call | WebRTC peer connection established on 4G and Wi-Fi | Pass |
| TC-S006 | Questionnaire | PHQ-9 ≥ 20 triggers Nepal Mental Health Helpline notice (1660-01-11111) | Pass |
| TC-S007 | Content | Admin-approved content appears in customer content hub | Pass |
| TC-S008 | Payment | eSewa transaction verified via server-side string comparison | Pass |
| TC-S009 | Games | Wellness game session records score to `game_sessions` table | Pass |
| TC-S010 | Achievement | Achievement badge displayed after first qualifying game | Pass |
| TC-S011 | Notifications | FCM push notification delivered on appointment confirmation | Pass |
| TC-S012 | Subscription | Free-tier user blocked from premium content | Pass |
| TC-S013 | Subscription | Premium content unlocked after Silver/Gold upgrade | Pass |
| TC-S014 | Mood Tracking | 7-day mood chart renders correctly with chart data | Pass |
| TC-S015 | Audio | Audio track playback streams from Cloudinary CDN | Pass |

---

## UAT Participants

| Participant | Role | Sessions | Key Feedback |
|---|---|---|---|
| P1 | Mental health professional (psychiatrist) | 1 | Approved crisis threshold; suggested PHQ-9 placement on home screen |
| P2 | Counselling psychologist | 1 | Positive on mood chart; noted GAD-7 button label unclear |
| P3 | University student (potential customer) | 1 | Completed booking flow in 3 min; liked breathing game |
| P4 | University student (potential customer) | 1 | Rated app 4/5; PHQ-9 discoverability issue (TC-UAT011) |
| P5 | Therapist (potential provider) | 1 | Successfully published content through admin approval workflow |
| P6 | HR manager (workplace mental health) | 1 | Appreciated subscription tier clarity; tested eSewa payment |
| P7 | Undergraduate (first-time user) | 1 | Completed full onboarding + mood log without assistance |

---

## Post-Survey Key Findings (132 Responses)

| Metric | Result |
|---|---|
| Would use Resilio for mental health support | 78% yes |
| Trust level for digital mental health platform | 71% comfortable or very comfortable |
| Preferred communication with therapist | 64% video call, 22% chat |
| Willingness to pay for premium subscription | 59% yes (Silver/Gold) |
| Overall app satisfaction (1–5 scale) | 4.3 average |
| Offline mood logging found useful | 83% yes |
| eSewa payment preferred over card | 74% yes |

---

## Production Deployment

### Vercel (REST API)

```
URL: https://resilio-api.vercel.app
Entrypoint: src/index.js
Node version: 18.x
```

`vercel.json`:
```json
{
  "version": 2,
  "builds": [{"src": "src/index.js", "use": "@vercel/node"}],
  "routes": [{"src": "/api/(.*)", "dest": "src/index.js"}],
  "env": {"NODE_ENV": "production"}
}
```

### Socket.IO Signalling Server (Railway)

```
URL: https://resilio-signalling.up.railway.app
Reason: Vercel serverless terminates persistent WebSocket connections.
        Socket.IO requires a persistent host — deployed separately on Railway.
```

### Smoke Test Checklist (Production)

- [x] OTP registration and login (customer + therapist + admin)
- [x] Therapist profile visible in customer browse
- [x] Appointment booking end-to-end (slot selection → eSewa → confirmation FCM)
- [x] WebRTC video call initiated and terminated cleanly
- [x] Mood log submitted and chart updated
- [x] PHQ-9 submitted; score calculated; crisis alert shown at score ≥ 20
- [x] Content hub loads articles, audio, and video from Cloudinary CDN
- [x] Breathing game session recorded
- [x] Achievement unlocked and badge displayed
- [x] Offline mood entry saved; synced on reconnection
- [x] Admin dashboard: user list, therapist approval, content moderation visible
- [x] Therapist dashboard: appointment list, earnings summary, content upload visible

---

## Debugging Evidence — Final Bugs Resolved

| Bug ID | Description | Resolution |
|---|---|---|
| BUG-001 | Double-booking race condition on concurrent slot selection | PostgreSQL row-level lock on `appointments` insert transaction |
| BUG-002 | eSewa transaction verification failing on string type mismatch | Coerced both sides to string before comparison in verification service |
| BUG-003 | WebRTC call failing on 4G (ICE negotiation timeout) | Added TURN server fallback; increased ICE timeout to 15s |
| BUG-004 | PHQ-9 discoverability — UAT users took 3 min to find (target 2 min) | Logged as UX improvement; promoted questionnaire card to home dashboard |
| BUG-005 | SuperTokens redirect URL mismatch in production | Updated `WEBSITE_DOMAIN` env var to match Vercel production URL |

---

## Files to Place Here

- [ ] Screenshot — System test execution log (pass/fail table)
- [ ] Screenshot — UAT session in progress (participant using the app)
- [ ] Screenshot — Post-survey Google Form (as shared with respondents)
- [ ] Screenshot — Vercel deployment dashboard (successful build)
- [ ] Screenshot — Production app running on physical device
- [ ] Client approval letter (Dr. Dibyandra Singh sign-off)
- [ ] Client approval letter (Islington College supervisor sign-off)
- [ ] Post-survey results export (CSV from Google Forms)
