# Week 5 — Technology Selection, Mind Map, Inception Wrap-Up
**Phase:** Inception | **Dates:** Last week of November 2024

---

## Tasks Completed

| Task | Output |
|---|---|
| Technology stack finalised | Full stack documented with version numbers |
| Mind map created | Resilio full scope map (users, features, tech, services) |
| Inception phase artefact review | All 12 planned artefacts verified complete |
| Transition to Elaboration phase | Phase gate passed |

## Files to Place Here

- [ ] Mind map image (Figma or draw.io export)
- [ ] Technology selection rationale document
- [ ] Inception phase review checklist

## Final Technology Stack Selected

### Frontend
| Technology | Version | Purpose |
|---|---|---|
| Flutter | 3.x (SDK ^3.9.2) | Cross-platform mobile framework |
| Dart | 3.x | Programming language |
| flutter_bloc | ^9.1.1 | BLoC/Cubit state management |
| go_router | ^17.1.0 | Declarative routing with role guards |
| get_it + injectable | ^9.2.1 / ^2.7.1 | Dependency injection |
| freezed + json_serializable | ^3.2.5 / ^6.13.0 | Code generation (immutable models) |
| dio | ^5.9.1 | HTTP client with interceptors |
| flutter_webrtc | ^1.4.1 | WebRTC peer connection |
| socket_io_client | ^3.1.4 | Socket.IO WebRTC signalling |
| sqflite | ^2.4.2 | SQLite offline persistence |
| protobuf | ^6.0.0 | Binary serialisation for offline sync |
| firebase_messaging | ^16.1.1 | FCM push notifications |
| cloud_firestore | ^6.1.2 | Real-time data sync |
| firebase_auth | ^6.1.4 | Firebase Authentication |
| google_sign_in | ^7.2.0 | Google OAuth |
| flutter_facebook_auth | ^7.1.1 | Facebook OAuth |
| esewa_flutter_sdk | local path | eSewa payment (local package) |
| supertokens_flutter | git (master) | SuperTokens Flutter SDK (overridden) |
| cloudinary_public | ^0.23.1 | Cloudinary media upload |
| dartz | ^0.10.1 | Functional error handling (Either type) |
| fl_chart | ^1.0.0 | Mood history charts |
| better_player_plus | ^1.0.8 | Video player for content hub |
| just_audio | ^0.10.4 | Audio player for content hub |
| table_calendar | ^3.2.0 | Appointment booking calendar |
| lottie | ^3.3.1 | Animation assets |

### Backend
| Technology | Version | Purpose |
|---|---|---|
| Node.js | 20.x LTS | JavaScript runtime |
| Express | ^4.21.0 | REST API framework |
| @supabase/supabase-js | ^2.47.0 | Database client |
| supertokens-node | ^24.0.1 | Authentication middleware |
| firebase-admin | ^13.0.0 | FCM notification sending |
| socket.io | ^4.8.3 | WebRTC signalling server |
| protobufjs | ^7.4.0 | Protobuf for offline sync |
| joi / zod | — | Request validation |
| winston | ^3.17.0 | Logging |
| helmet + cors | — | Security headers |
| express-rate-limit | ^7.4.0 | Rate limiting |
| nodemailer | ^8.0.1 | Email sending |
| morgan | ^1.10.0 | HTTP request logging |

### External Services
| Service | Purpose |
|---|---|
| Supabase (PostgreSQL) | Primary database + Row Level Security |
| SuperTokens (managed) | OTP passwordless + Google + Facebook auth |
| Firebase (Auth + Firestore + FCM) | Authentication, real-time data, push notifications |
| Cloudinary | Media storage and CDN delivery |
| eSewa | Nepal digital wallet payment |
| WebRTC + STUN/TURN | Real-time video/audio consultation |
| Vercel | Backend API deployment |
