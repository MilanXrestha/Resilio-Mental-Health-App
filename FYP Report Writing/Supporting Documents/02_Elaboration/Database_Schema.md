# DATABASE SCHEMA — RESILIO (PostgreSQL / Supabase)

Full schema for the Resilio PostgreSQL database hosted on Supabase. Includes table descriptions, column definitions, relationships, Row Level Security policies, and indexing notes.

---

## OVERVIEW

| Statistic | Value |
|---|---|
| Database | PostgreSQL 15 via Supabase |
| Total tables | 20 |
| Authentication | SuperTokens (external); user IDs synced into `users` table |
| Access control | Row Level Security (RLS) on all tables |
| Hosting | Supabase managed cloud (data stored outside Nepal — disclosed in privacy notice) |

---

## TABLE: users

Central user table. Every registered user has one record here. Role determines which module they access.

| Column | Type | Constraints | Description |
|---|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() | Primary key |
| email | TEXT | UNIQUE, NOT NULL | User email address |
| user_role | TEXT | NOT NULL, CHECK IN ('user','therapist','admin') | Application role |
| full_name | TEXT | | Display name |
| avatar_url | TEXT | | Cloudinary URL for profile photo |
| fcm_token | TEXT | | Firebase Cloud Messaging device token |
| is_active | BOOLEAN | DEFAULT true | Account active status |
| created_at | TIMESTAMPTZ | DEFAULT now() | Account creation timestamp |
| updated_at | TIMESTAMPTZ | DEFAULT now() | Last profile update |

**RLS Policies:**
- Users can SELECT their own record: `auth.uid() = id`
- Users can UPDATE their own record: `auth.uid() = id`
- Therapists can SELECT customer records for patients with appointments: join-based policy
- Admins have full SELECT and UPDATE access

---

## TABLE: therapist_profiles

Extended profile for users with role = 'therapist'. One-to-one with users.

| Column | Type | Constraints | Description |
|---|---|---|---|
| id | UUID | PK | Primary key |
| user_id | UUID | FK → users.id, UNIQUE | Links to users table |
| bio | TEXT | | Professional biography |
| specialisations | TEXT[] | | Array of specialisation tags |
| languages | TEXT[] | | Languages spoken |
| consultation_fee | NUMERIC(10,2) | NOT NULL | Fee per session in NPR |
| is_verified | BOOLEAN | DEFAULT false | Admin verification status |
| qualification_docs | TEXT[] | | Cloudinary URLs of credential documents |
| years_experience | INTEGER | | Years of professional experience |
| rating | NUMERIC(3,2) | DEFAULT 0 | Average session rating |
| total_sessions | INTEGER | DEFAULT 0 | Total completed sessions |
| created_at | TIMESTAMPTZ | DEFAULT now() | |

**RLS Policies:**
- Any authenticated user can SELECT verified therapist profiles: `is_verified = true`
- Therapist can UPDATE their own profile: `auth.uid() = user_id`
- Admins can SELECT all (including unverified) and UPDATE is_verified

---

## TABLE: appointments

All therapy appointments (pending, confirmed, completed, cancelled).

| Column | Type | Constraints | Description |
|---|---|---|---|
| id | UUID | PK | Primary key |
| patient_id | UUID | FK → users.id | Patient user |
| therapist_id | UUID | FK → therapist_profiles.id | Therapist |
| scheduled_time | TIMESTAMPTZ | NOT NULL | Appointment date and time (UTC) |
| duration_minutes | INTEGER | DEFAULT 50 | Session duration |
| status | TEXT | CHECK IN ('pending','confirmed','completed','cancelled') | Appointment lifecycle status |
| payment_status | TEXT | CHECK IN ('pending','paid','refunded','failed') | Payment status |
| payment_transaction_id | TEXT | | eSewa transaction reference |
| meeting_room_id | TEXT | UNIQUE | WebRTC room identifier |
| notes | TEXT | | Post-session notes (therapist only) |
| created_at | TIMESTAMPTZ | DEFAULT now() | |

**RLS Policies:**
- Patient can SELECT their own appointments: `auth.uid() = patient_id`
- Therapist can SELECT appointments where they are the therapist: `therapist_id IN (SELECT id FROM therapist_profiles WHERE user_id = auth.uid())`
- Only the backend service role can INSERT (via Node.js API)
- Admins have full access

---

## TABLE: subscriptions

Active and historical subscription records per customer.

| Column | Type | Constraints | Description |
|---|---|---|---|
| id | UUID | PK | Primary key |
| user_id | UUID | FK → users.id | Subscriber |
| plan_id | TEXT | NOT NULL | 'FREE', 'SILVER', 'GOLD' |
| status | TEXT | CHECK IN ('active','expired','cancelled') | Subscription status |
| payment_method | TEXT | | 'esewa' |
| started_at | TIMESTAMPTZ | DEFAULT now() | Subscription start |
| expires_at | TIMESTAMPTZ | | Subscription expiry |
| transaction_id | TEXT | | eSewa transaction reference |

**Constraint:** UNIQUE (user_id) WHERE status = 'active' — prevents duplicate active subscriptions.

**RLS Policies:**
- User can SELECT their own subscription
- Only service role can INSERT/UPDATE

---

## TABLE: mood_entries

Daily mood logs submitted by customers.

| Column | Type | Constraints | Description |
|---|---|---|---|
| id | UUID | PK | |
| user_id | UUID | FK → users.id | Owner |
| mood_score | INTEGER | NOT NULL, CHECK (1–5) | Numeric mood rating |
| mood_label | TEXT | | 'Very Sad', 'Sad', 'Neutral', 'Happy', 'Very Happy' |
| note | TEXT | | Free-text journal note (max 500 chars) |
| logged_at | TIMESTAMPTZ | DEFAULT now() | Log timestamp |
| synced_from_offline | BOOLEAN | DEFAULT false | True if entry was created offline and synced |

**RLS Policies:**
- User can SELECT, INSERT, UPDATE their own entries: `auth.uid() = user_id`
- Therapist can SELECT entries for their patients (via appointment relationship)

---

## TABLE: questionnaire_responses

PHQ-9 and GAD-7 submission records.

| Column | Type | Constraints | Description |
|---|---|---|---|
| id | UUID | PK | |
| user_id | UUID | FK → users.id | |
| questionnaire_type | TEXT | CHECK IN ('PHQ9','GAD7') | |
| answers | INTEGER[] | NOT NULL | Array of individual answers |
| total_score | INTEGER | NOT NULL | Sum of answers |
| severity_band | TEXT | | Minimal / Mild / Moderate / Moderately Severe / Severe |
| crisis_alert | BOOLEAN | DEFAULT false | True if PHQ-9 score ≥ 20 |
| completed_at | TIMESTAMPTZ | DEFAULT now() | |

**RLS Policies:**
- User can SELECT and INSERT their own responses
- Therapist can SELECT their patients' responses

---

## TABLE: game_sessions

Records of completed wellness game sessions.

| Column | Type | Constraints | Description |
|---|---|---|---|
| id | UUID | PK | |
| user_id | UUID | FK → users.id | |
| game_type | TEXT | CHECK IN ('breathing','trivia','affirmation','story') | |
| score | INTEGER | DEFAULT 0 | Game score (0 for breathing) |
| duration_seconds | INTEGER | | Session length |
| completed_at | TIMESTAMPTZ | DEFAULT now() | |

**RLS Policies:**
- User can SELECT and INSERT their own sessions

---

## TABLE: achievements

Master list of all available achievement types.

| Column | Type | Description |
|---|---|---|
| id | TEXT | PK — achievement code (e.g. 'FIRST_BREATH') |
| title | TEXT | Display name |
| description | TEXT | Achievement description |
| icon_url | TEXT | Badge icon Cloudinary URL |
| category | TEXT | 'games', 'mood', 'booking', 'questionnaire' |

---

## TABLE: achievement_entities (Junction)

Records which achievements each user has unlocked.

| Column | Type | Description |
|---|---|---|
| id | UUID | PK |
| user_id | UUID | FK → users.id |
| achievement_id | TEXT | FK → achievements.id |
| unlocked_at | TIMESTAMPTZ | |

**Constraint:** UNIQUE (user_id, achievement_id)

---

## TABLE: content (Wellness Content Hub)

All published and pending wellness content items.

| Column | Type | Constraints | Description |
|---|---|---|---|
| id | UUID | PK | |
| author_id | UUID | FK → users.id | Therapist author |
| title | TEXT | NOT NULL | Content title |
| body | TEXT | | Full article text (for articles) |
| content_type | TEXT | CHECK IN ('article','audio','video','short') | |
| media_url | TEXT | | Cloudinary URL for audio/video |
| thumbnail_url | TEXT | | Cloudinary thumbnail |
| category | TEXT | | e.g. 'anxiety', 'depression', 'sleep' |
| is_premium | BOOLEAN | DEFAULT false | Requires active subscription |
| status | TEXT | CHECK IN ('draft','pending_review','published','rejected') | |
| published_at | TIMESTAMPTZ | | Set when admin approves |
| created_at | TIMESTAMPTZ | DEFAULT now() | |

**RLS Policies:**
- Public: SELECT WHERE status = 'published'
- Premium content: SELECT WHERE status = 'published' AND (NOT is_premium OR subscription check)
- Therapist: SELECT/INSERT/UPDATE their own content
- Admin: Full access

---

## TABLE: categories

Tag taxonomy for content classification.

| Column | Type | Description |
|---|---|---|
| id | UUID | PK |
| name | TEXT | Category name (e.g. 'Anxiety', 'Sleep') |
| icon_url | TEXT | Category icon |

---

## TABLE: favorites

User's saved content items and therapist profiles.

| Column | Type | Description |
|---|---|---|
| id | UUID | PK |
| user_id | UUID | FK → users.id |
| item_id | UUID | ID of the favorited item |
| item_type | TEXT | 'content' or 'therapist' |
| saved_at | TIMESTAMPTZ | |

**Constraint:** UNIQUE (user_id, item_id, item_type)

---

## TABLE: notifications

In-app notification records.

| Column | Type | Description |
|---|---|---|
| id | UUID | PK |
| user_id | UUID | FK → users.id |
| title | TEXT | Notification title |
| body | TEXT | Notification body |
| type | TEXT | 'booking_confirmed', 'session_reminder', 'content_approved', etc. |
| is_read | BOOLEAN | DEFAULT false |
| created_at | TIMESTAMPTZ | |

---

## TABLE: transactions

Financial transaction audit log.

| Column | Type | Description |
|---|---|---|
| id | UUID | PK |
| user_id | UUID | Payer |
| appointment_id | UUID | FK → appointments.id (nullable for subscriptions) |
| subscription_id | UUID | FK → subscriptions.id (nullable for appointments) |
| amount | NUMERIC(10,2) | NPR amount |
| payment_method | TEXT | 'esewa' |
| transaction_ref | TEXT | eSewa transaction reference |
| status | TEXT | 'success', 'failed', 'refunded' |
| created_at | TIMESTAMPTZ | |

---

## TABLE: preferences

User's onboarding preference selections.

| Column | Type | Description |
|---|---|---|
| id | UUID | PK |
| user_id | UUID | FK → users.id, UNIQUE |
| goals | TEXT[] | Selected wellness goals |
| concerns | TEXT[] | Areas of concern (anxiety, stress, etc.) |
| preferred_language | TEXT | 'en' or 'ne' |
| notification_enabled | BOOLEAN | |
| updated_at | TIMESTAMPTZ | |

---

## TABLE: quotes

Daily motivational quotes displayed on home screen.

| Column | Type | Description |
|---|---|---|
| id | UUID | PK |
| text | TEXT | Quote body |
| author | TEXT | Quote attribution |
| category | TEXT | Thematic tag |

---

## TABLE: tips

Wellness tip cards displayed in content hub.

| Column | Type | Description |
|---|---|---|
| id | UUID | PK |
| title | TEXT | Tip title |
| body | TEXT | Tip content |
| category | TEXT | |

---

## ROW LEVEL SECURITY — SUMMARY

| Table | Customer | Therapist | Admin | Backend (service role) |
|---|---|---|---|---|
| users | Own record only | Own + patients | All | All |
| therapist_profiles | Verified only | Own profile | All | All |
| appointments | Own appointments | Own patients' | All | All |
| mood_entries | Own entries | Own patients' | None | All |
| questionnaire_responses | Own responses | Own patients' | None | All |
| content | Published only | Own + published | All | All |
| subscriptions | Own | None | All | All |
| notifications | Own | Own | All | All |
| transactions | Own | None | All | All |

---

## KEY INDEXES

| Table | Column | Index Type | Reason |
|---|---|---|---|
| mood_entries | user_id, logged_at | Composite B-tree | Fast 7/30-day range queries |
| appointments | patient_id, scheduled_time | Composite B-tree | Calendar and upcoming session queries |
| appointments | therapist_id, status | Composite B-tree | Therapist appointment list filtering |
| content | status, content_type | Composite B-tree | Published content hub browsing |
| questionnaire_responses | user_id, questionnaire_type | Composite B-tree | History queries |
| therapist_profiles | is_verified | Partial B-tree | Directory listing (only verified) |
