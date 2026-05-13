# PHASE 3: CONSTRUCTION (Iterations 5–7) — DEVELOPMENT
**RUP Phase:** Construction | **Weeks:** 15–19 | **Dates:** February–March 2025

---

## Phase Objective

Implement the remaining five development iterations: WebRTC video consultation and admin dashboard, mood tracking and questionnaires and content hub, wellness games and achievements, offline sync and push notifications and subscriptions.

> **Note:** This folder must contain code snippets and debugging evidence per the teacher's requirement. Each week README includes code examples and lists specific debugging screenshots to include.

---

## Artefacts in This Phase

| Week | Iteration | Features Built |
|---|---|---|
| 15 | Iteration 5 | WebRTC video consultation, Socket.IO signalling, TURN deployment, admin dashboard |
| 16 | Iteration 6 | Mood tracking, PHQ-9/GAD-7, crisis protocol, Cloudinary media |
| 17 | Iteration 6 cont. | Content hub (articles, audio, video), subscription gating |
| 18 | Iteration 7 | Wellness games (Breathing, Trivia, Affirmation, Story), achievement system |
| 19 | Iteration 7 cont. | SQLite offline sync, FCM push notifications, subscription tiers |

---

## Flutter Modules Built This Phase

```
lib/features/customer/
├── dashboard/      ← Customer home screen, quick actions, daily quote
├── appointments/   ← Appointment list, video call entry
├── main/           ← WebRTC consultation screen (patient view)
├── games/          ← Breathing bubble, trivia, affirmation, story games
├── audio/          ← Audio content player
├── video/          ← Video content player
├── images/         ← Image content viewer
├── explore/        ← Content hub browsing
├── categories/     ← Content category browsing
├── favorites/      ← Saved content and therapists
├── subscription/   ← Subscription plans and upgrade flow
├── notifications/  ← Push notification handling
├── preferences/    ← User settings
├── profile/        ← User profile management
├── settings/       ← App settings
├── tips/           ← Wellness tips
└── matching/       ← Therapist matching questionnaire

lib/features/therapist/
├── dashboard/      ← Therapist home, appointments, earnings summary
├── appointments/   ← Session management, consultation view with patient data
├── content/        ← Content publishing workflow
├── patients/       ← Patient list and mood/questionnaire data
└── earnings/       ← Earnings dashboard

lib/features/admin/
└── dashboard/      ← Analytics, user management, content moderation
```

---

## Backend Routes Built This Phase

```
Backend/src/routes/
├── webrtc-signal-routes.js          ← Socket.IO signalling (separate server)
├── audio-routes.js                  ← Audio content CRUD
├── video-routes.js                  ← Video content CRUD
├── images-routes.js                 ← Image content CRUD
├── category-routes.js               ← Content categories
├── games-routes.js                  ← Game sessions + achievements
├── subscription-routes.js           ← Subscription management
├── notification-routes.js           ← Notification management + FCM token
├── quote-routes.js                  ← Daily quotes
├── tips-routes.js                   ← Wellness tips
├── favorite-routes.js               ← Favourites management
├── preference-routes.js             ← User preferences
└── appointment-messages-routes.js   ← In-session messaging
```
