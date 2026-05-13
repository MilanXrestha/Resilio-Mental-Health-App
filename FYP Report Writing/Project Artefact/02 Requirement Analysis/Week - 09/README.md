# Week 9 — Database Schema, RLS Policies, Interim Report Writing
**Phase:** Elaboration | **Dates:** 22–28 December 2024

---

## Tasks Completed

| Task | Output |
|---|---|
| PostgreSQL database schema finalised | 19 SQL migration files written (see `Backend/sql/`) |
| Row Level Security policies written | All 20 tables; user/therapist/admin/service-role policies tested |
| Database schema documentation | Full schema spec in `Supporting Documents/08_Database_Schema.md` |
| Interim report Chapter 1 written | Introduction, problem domain, Nepal context |
| Interim report Chapter 2 written | Background, literature review, competitor analysis |
| Interim report Chapter 3 written | Development methodology, requirements, design |

## Files to Place Here

- [ ] SQL migration files reference (or link to `Backend/sql/`)
- [ ] Supabase RLS policy screenshots
- [ ] Interim report draft (in progress)

## SQL Migration Files (Backend/sql/)

| File | Contents |
|---|---|
| `01_users_table.sql` | Core users table with role column |
| `02_preferences_tables.sql` | User preferences and onboarding preferences |
| `03_categories_table.sql` | Content category taxonomy |
| `04_audio_tracks_table.sql` | Audio content records |
| `04_quotes_table.sql` | Daily motivational quotes |
| `05_tips_table.sql` | Wellness tips |
| `05_video_tracks_table.sql` | Video content records |
| `06_images_table.sql` | Image content records |
| `07_favorites_table.sql` | User favourites (content + therapist) |
| `08_games_tables.sql` | Game sessions and achievements |
| `09_subscriptions_table.sql` | Subscription records and plan tiers |
| `10_appointments_table.sql` | Appointment lifecycle management |
| `11_therapist_profiles_table.sql` | Extended therapist profile |
| `12_supertokens_migration.sql` | SuperTokens user sync migration |
| `13_notifications_table.sql` | In-app notification records |
| `14_appointments_price_and_fixes.sql` | Appointment fee column additions |
| `15_appointment_messages_table.sql` | In-session messaging between patient and therapist |
| `16_users_profile_fields.sql` | Additional user profile columns |
| `17_video_comments_table.sql` | Comments on video content |
| `18_games_achievements_seed.sql` | Achievement master data seed |
| `19_quiz_affirmation_tables.sql` | Trivia quiz and affirmation game tables |

## RLS Policy Approach

Each table has four policy tiers:
1. **Customer** — can only access their own data (`auth.uid() = user_id`)
2. **Therapist** — can access their own data + data for their patients (via appointment join)
3. **Admin** — full platform access
4. **Service role** (Node.js backend) — bypasses RLS for trusted server operations
