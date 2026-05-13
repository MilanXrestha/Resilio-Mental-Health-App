# API REFERENCE — RESILIO BACKEND

Node.js / Express REST API. All endpoints require HTTPS. Authentication is via SuperTokens session token in the `Authorization: Bearer <token>` header unless otherwise noted.

**Base URL (Development):** `http://localhost:3000`
**Base URL (Production):** `https://resilio-api.vercel.app`

---

## AUTHENTICATION ENDPOINTS

These endpoints implement the SuperTokens passwordless OTP and social login flows. The `/auth/*` routes are handled by the SuperTokens middleware; the `/auth/custom/*` routes are custom Resilio endpoints that sync authenticated users into Supabase.

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/auth/signinup/code` | None | Step 1 — Request OTP email (SuperTokens createCode) |
| POST | `/auth/signinup/code/consume` | None | Step 2 — Verify OTP and obtain access token (SuperTokens consumeCode) |
| POST | `/auth/passwordless/complete` | Bearer token | Step 3 — Sync authenticated user into Supabase; returns user profile and role |
| POST | `/auth/signinup` | None | Google/Facebook Sign-In — SuperTokens thirdparty flow |
| POST | `/auth/signout` | Bearer token | Invalidate SuperTokens session |

### Request/Response: POST /auth/passwordless/complete

**Request:**
```json
{
  "email": "user@example.com"
}
```

**Response (200):**
```json
{
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "role": "user",
    "createdAt": "2025-01-15T10:00:00Z"
  },
  "isNewUser": true
}
```

---

## USER ENDPOINTS

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/users/me` | Bearer | Get current authenticated user's profile |
| PUT | `/users/me` | Bearer | Update current user's profile (name, avatar, bio) |
| DELETE | `/users/me` | Bearer | Delete account and all associated data (GDPR/privacy compliance) |
| GET | `/users/me/preferences` | Bearer | Get user's app preferences |
| PUT | `/users/me/preferences` | Bearer | Update preferences (language, notification settings) |

---

## THERAPIST ENDPOINTS

### Public (Customer-facing)

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/therapists` | Bearer | List all verified therapists; supports query params: `?specialisation=&language=&maxFee=` |
| GET | `/therapists/:id` | Bearer | Get single therapist profile |
| GET | `/therapists/:id/availability` | Bearer | Get available slots for a therapist; `?date=YYYY-MM-DD` |
| GET | `/therapists/recommended` | Bearer | Get therapist recommendations based on user's matching questionnaire |

### Therapist Self-Management

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/therapists/profile` | Bearer (therapist) | Create therapist profile and submit for verification |
| PUT | `/therapists/profile` | Bearer (therapist) | Update therapist profile details |
| GET | `/therapists/me/appointments` | Bearer (therapist) | List all appointments for the authenticated therapist |
| GET | `/therapists/me/patients` | Bearer (therapist) | List all patients who have had sessions with this therapist |
| GET | `/therapists/me/earnings` | Bearer (therapist) | Get earnings summary (total, per-session breakdown) |
| POST | `/therapists/availability` | Bearer (therapist) | Set available time slots |
| DELETE | `/therapists/availability/:slotId` | Bearer (therapist) | Remove an availability slot |

---

## APPOINTMENT ENDPOINTS

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/appointments` | Bearer (customer) | Create a pending appointment record before payment |
| GET | `/appointments` | Bearer | List appointments for the current user (filtered by role) |
| GET | `/appointments/:id` | Bearer | Get single appointment details |
| PUT | `/appointments/:id/cancel` | Bearer | Cancel appointment (customer or therapist) |

### Request/Response: POST /appointments

**Request:**
```json
{
  "therapistId": "uuid",
  "scheduledTime": "2025-03-15T10:00:00Z",
  "meetingRoomId": "room_therapistId_timestamp"
}
```

**Response (201):**
```json
{
  "id": "uuid",
  "patientId": "uuid",
  "therapistId": "uuid",
  "scheduledTime": "2025-03-15T10:00:00Z",
  "status": "pending",
  "paymentStatus": "pending",
  "meetingRoomId": "room_therapistId_timestamp"
}
```

---

## PAYMENT ENDPOINTS

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/payment/verify` | Bearer | Verify eSewa payment callback; confirm appointment on success |

### Request/Response: POST /payment/verify

**Request:**
```json
{
  "appointmentId": "uuid",
  "transactionId": "esewa-txn-ref",
  "totalAmount": "500"
}
```

**Response (200):**
```json
{
  "success": true,
  "appointment": {
    "id": "uuid",
    "status": "confirmed",
    "paymentStatus": "paid",
    "paymentTransactionId": "esewa-txn-ref"
  }
}
```

---

## MOOD ENTRIES ENDPOINTS

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/mood` | Bearer (customer) | Create a new mood log entry |
| GET | `/mood` | Bearer (customer) | Get current user's mood history; `?days=7` or `?days=30` |
| GET | `/mood/:patientId` | Bearer (therapist) | Get a patient's mood history (within therapist-patient relationship) |

### Request/Response: POST /mood

**Request:**
```json
{
  "moodScore": 4,
  "moodLabel": "Happy",
  "note": "Had a productive day at work"
}
```

**Response (201):**
```json
{
  "id": "uuid",
  "userId": "uuid",
  "moodScore": 4,
  "moodLabel": "Happy",
  "note": "Had a productive day at work",
  "loggedAt": "2025-03-15T18:00:00Z"
}
```

---

## QUESTIONNAIRE ENDPOINTS

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/questionnaires/phq9` | Bearer (customer) | Submit PHQ-9 responses; returns total score and severity band |
| POST | `/questionnaires/gad7` | Bearer (customer) | Submit GAD-7 responses; returns total score and severity band |
| GET | `/questionnaires/history` | Bearer (customer) | Get current user's questionnaire history |
| GET | `/questionnaires/:patientId/history` | Bearer (therapist) | Get a patient's questionnaire history (within relationship) |

### Request/Response: POST /questionnaires/phq9

**Request:**
```json
{
  "answers": [0, 1, 2, 1, 0, 3, 2, 1, 1]
}
```

**Response (201):**
```json
{
  "id": "uuid",
  "type": "PHQ9",
  "totalScore": 11,
  "severityBand": "Moderate",
  "crisisAlert": false,
  "completedAt": "2025-03-15T19:00:00Z"
}
```

*Note: If totalScore ≥ 20, `crisisAlert: true` is returned and the Flutter client displays the Nepal Mental Health Helpline notice.*

---

## CONTENT ENDPOINTS

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/content` | Bearer | List all published content; supports `?type=article&category=anxiety` |
| GET | `/content/:id` | Bearer | Get single content item (full article body, audio/video URL) |
| POST | `/content` | Bearer (therapist) | Submit new content for admin review |
| PUT | `/content/:id` | Bearer (therapist, own content) | Edit own unpublished content |
| DELETE | `/content/:id` | Bearer (therapist, own content) | Delete own content |
| PUT | `/content/:id/approve` | Bearer (admin) | Approve content for publication |
| PUT | `/content/:id/reject` | Bearer (admin) | Reject content with reason |

---

## SUBSCRIPTION ENDPOINTS

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/subscriptions/plans` | None | List available subscription tiers (Free, Silver, Gold) |
| GET | `/subscriptions/me` | Bearer | Get current user's active subscription |
| POST | `/subscriptions` | Bearer (customer) | Create subscription after successful eSewa payment |
| DELETE | `/subscriptions/me` | Bearer | Cancel subscription |

---

## GAME SESSIONS ENDPOINTS

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/games/sessions` | Bearer (customer) | Record a completed game session |
| GET | `/games/sessions` | Bearer (customer) | Get current user's game session history |
| GET | `/games/achievements` | Bearer (customer) | Get current user's unlocked achievements |

---

## FAVOURITES ENDPOINTS

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/favourites` | Bearer (customer) | Add content or therapist to favourites |
| DELETE | `/favourites/:id` | Bearer (customer) | Remove from favourites |
| GET | `/favourites` | Bearer (customer) | List all favourites |

---

## NOTIFICATION ENDPOINTS

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/notifications` | Bearer | List notifications for current user |
| PUT | `/notifications/:id/read` | Bearer | Mark notification as read |
| POST | `/notifications/register-token` | Bearer | Register FCM device token for push notifications |

---

## ADMIN ENDPOINTS

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/admin/therapists/pending` | Bearer (admin) | List therapist profiles awaiting verification |
| PUT | `/admin/therapists/:id/verify` | Bearer (admin) | Approve therapist registration |
| PUT | `/admin/therapists/:id/reject` | Bearer (admin) | Reject therapist registration |
| GET | `/admin/users` | Bearer (admin) | List all users with filters |
| DELETE | `/admin/users/:id` | Bearer (admin) | Deactivate user account |
| GET | `/admin/content/pending` | Bearer (admin) | List content items awaiting moderation |
| GET | `/admin/analytics` | Bearer (admin) | Get platform statistics (user counts, session counts, revenue) |

---

## APPOINTMENT MESSAGES ENDPOINTS

In-session messaging attached to a specific appointment (used during therapy sessions alongside the video call).

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/appointments/:id/messages` | Bearer | Get all messages for a specific appointment |
| POST | `/appointments/:id/messages` | Bearer | Send a message within an active appointment session |

### Request/Response: POST /appointments/:id/messages

**Request:**
```json
{
  "content": "I have been feeling anxious since last week.",
  "senderType": "user"
}
```

**Response (201):**
```json
{
  "id": "uuid",
  "appointmentId": "uuid",
  "senderId": "uuid",
  "senderType": "user",
  "content": "I have been feeling anxious since last week.",
  "createdAt": "2025-03-10T14:32:00Z"
}
```

---

## QUOTES ENDPOINTS

Daily inspirational quotes served on the customer home dashboard.

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/quotes/daily` | Bearer | Get today's daily quote |
| GET | `/quotes` | Bearer | List all quotes (paginated) |
| POST | `/quotes` | Bearer (admin) | Create a new quote |
| DELETE | `/quotes/:id` | Bearer (admin) | Delete a quote |

---

## TIPS ENDPOINTS

Wellness tips served in the content hub.

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/tips` | Bearer | List all wellness tips |
| GET | `/tips/:id` | Bearer | Get a specific tip |
| POST | `/tips` | Bearer (admin/therapist) | Create a new tip |
| DELETE | `/tips/:id` | Bearer (admin) | Delete a tip |

---

## PREFERENCES ENDPOINTS

User notification and app behaviour preferences.

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/preferences` | Bearer | Get current user's preferences |
| PUT | `/preferences` | Bearer | Update user preferences |

### Request/Response: PUT /preferences

**Request:**
```json
{
  "notificationsEnabled": true,
  "appointmentReminders": true,
  "moodReminders": true,
  "newsletterOptIn": false,
  "language": "en"
}
```

**Response (200):**
```json
{
  "userId": "uuid",
  "notificationsEnabled": true,
  "appointmentReminders": true,
  "moodReminders": true,
  "newsletterOptIn": false,
  "language": "en",
  "updatedAt": "2025-03-15T09:00:00Z"
}
```

---

## VIDEO COMMENTS ENDPOINTS

Comment threads on video content items.

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| GET | `/videos/:id/comments` | Bearer | List comments for a video |
| POST | `/videos/:id/comments` | Bearer | Post a comment on a video |
| DELETE | `/videos/:id/comments/:commentId` | Bearer | Delete own comment (or admin) |

---

## ERROR RESPONSE FORMAT

All errors return the following structure:

```json
{
  "error": "Human-readable error message",
  "code": "ERROR_CODE"
}
```

| HTTP Status | Meaning |
|---|---|
| 400 | Bad Request — validation error in request body |
| 401 | Unauthorised — missing or invalid SuperTokens session token |
| 403 | Forbidden — authenticated but insufficient role permissions |
| 404 | Not Found — resource does not exist |
| 409 | Conflict — duplicate resource (e.g. double-booking, duplicate subscription) |
| 500 | Internal Server Error — unexpected backend error |

---

## AUTHENTICATION MIDDLEWARE

Every protected endpoint runs through two middleware layers:

```javascript
// 1. SuperTokens session verification
router.use(verifySession());

// 2. Role-based access control
router.use(requireRole(['admin'])); // or 'therapist', 'user'
```

`requireRole` checks the `user_role` column in Supabase and returns 403 if the user's role is not in the allowed list.
