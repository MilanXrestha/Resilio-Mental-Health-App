# Week 6 — SRS, Use Cases, ERD, System Architecture
**Phase:** Elaboration | **Dates:** 1–7 December 2024

---

## Tasks Completed

| Task | Output |
|---|---|
| Software Requirements Specification (SRS) written | Full SRS — see Appendix M |
| Use case diagram — Customer module | Mermaid source in `UML Diagrams (Mermaid Code).md` |
| Use case diagram — Therapist module | Mermaid source in `UML Diagrams (Mermaid Code).md` |
| Use case diagram — Admin module | Mermaid source in `UML Diagrams (Mermaid Code).md` |
| Entity-Relationship Diagram drafted | 20 tables; all relationships mapped; see Appendix J.8 |
| System architecture diagram created | Three-tier: Flutter → Node.js → Supabase + all external services |

## Files to Place Here

- [ ] SRS document (PDF) — or reference Appendix M
- [ ] Use case diagrams (×3) — PNG exports from draw.io or Mermaid
- [ ] ERD diagram — PNG export
- [ ] System architecture diagram — PNG export

## Functional Requirements Summary (from SRS)

| ID | Requirement | Priority |
|---|---|---|
| FR-C01 | Customer registers via SuperTokens OTP / Google / Facebook | High |
| FR-C05 | Customer books appointment via real-time availability calendar | High |
| FR-C06 | eSewa payment for appointments | High |
| FR-C07 | Live WebRTC video/audio consultation | High |
| FR-C08 | Daily mood logging (score, emoji, note) | High |
| FR-C09 | PHQ-9 and GAD-7 questionnaires | High |
| FR-T04 | Therapist views patient mood + questionnaire data in consultation | High |
| FR-A01 | Admin approves/rejects therapist registrations | High |

Full SRS: Appendix M of FYP report.

## ERD — Table Count

20 tables: users, therapist_profiles, appointments, subscriptions, mood_entries, questionnaire_responses, game_sessions, achievements, achievement_entities, content, categories, favorites, notifications, transactions, preferences, user_preferences, quotes, tips, video_comments, appointment_messages

Full schema: `Supporting Documents/08_Database_Schema.md`
