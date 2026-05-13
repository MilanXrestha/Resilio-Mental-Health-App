# CONSTRUCTION PHASE — Supporting Documents
**RUP Phase:** Construction | **Weeks:** 11–19 | **Dates:** January – March 2025
**Iterations:** 7 (across 9 weeks)

---

## Phase Objective

Implement all 24 functional requirements iteratively across seven planned development iterations. Each iteration produces tested, integrated software that is demonstrated to stakeholders before the next iteration begins. Deliverables feed Chapter 3 (Development) of the final report.

---

## Documents in This Folder

| File | Contents | Report Reference |
|---|---|---|
| `Technology_Documentation.md` | Every Flutter package, Node.js package, and external service with version, purpose, and official documentation URL | Chapter 3, Section 3.4 |
| `Development_Tools_and_Environment.md` | IDEs (Android Studio, VS Code), Flutter toolchain, Node.js commands, Git strategy, Postman, DBeaver, Figma, draw.io, hardware setup | Chapter 3, Section 3.4 |
| `WebRTC_Signalling_Architecture.md` | Socket.IO event table, step-by-step signalling flow, RTCPeerConnection init code, STUN/TURN configuration, Coturn setup, session room ID design | Chapter 3, Section 3.5.5; Appendix J |
| `Project_Structure_and_Artefacts.md` | Annotated Flutter `lib/` tree, Node.js backend tree, SQL migration sequence, Protobuf definitions, Project Artefact folder map, week-by-week feature delivery table, code-to-report cross-reference | Chapter 3 (all sections) |
| `Learning_Resources.md` | YouTube channels, official documentation, tutorials, and dev.to/Medium articles used to learn every technology in the project | Reference |

---

## Development Iterations

| Iteration | Weeks | Primary Features |
|---|---|---|
| Iter 1 | 11 | SuperTokens OTP + Google/Facebook auth; GoRouter role guards; onboarding |
| Iter 2 | 12 | Supabase schema deployed; RLS policies live; API skeleton; GetIt DI wired |
| Iter 3 | 13 | Therapist directory; therapist profile management; admin verification workflow |
| Iter 4 | 14 | Appointment booking; real-time slot availability; eSewa payment integration |
| Iter 5 | 15 | WebRTC video consultation; Socket.IO signalling server; admin dashboard |
| Iter 6 | 16–17 | Mood tracking; PHQ-9/GAD-7; crisis alert; content hub; Cloudinary; subscription gating |
| Iter 7 | 18–19 | Wellness games (4 types); achievements; favourites; FCM push notifications; SQLite offline sync |

---

## Key Technical Decisions Made

| Decision | Rationale |
|---|---|
| `supertokens_flutter` via git override | pub.dev version didn't support combined OTP + third-party recipe; master branch required |
| `esewa_flutter_sdk` as local path dep | eSewa v2 payment verification API not available on pub.dev version; SDK bundled locally |
| `better_player_plus` over `video_player` | Handles both long-form video and short reels (short flag) in one package |
| `dartz` Either type | Domain layer returns `Either<Failure, T>` — forces callers to handle error states without exceptions |
| Socket.IO on separate host | Vercel serverless terminates persistent connections; Socket.IO requires persistent WebSocket host (Railway) |
| Protocol Buffers for offline | Binary serialisation reduces SQLite row size vs JSON; typed schema prevents corruption on sync |
| GetIt + Injectable | Compile-time DI registration via code generation; no runtime reflection |
