# LEARNING RESOURCES

All YouTube channels, video tutorials, online courses, articles, and documentation used during the development of Resilio. Organised by technology/topic. These represent the primary learning materials used to acquire or deepen understanding of each technology used in the project.

---

## FLUTTER AND DART

### YouTube — Primary Channels

| Channel | What Was Learned | Key Videos / Playlists |
|---|---|---|
| **Reso Coder** (resocoder.com / YouTube) | Flutter BLoC pattern, Clean Architecture feature-first structure, Freezed, GetIt/Injectable dependency injection | "Flutter TDD Clean Architecture" course series; "Flutter BLoC Tutorial" series; "Freezed & json_serializable" |
| **Flutter Official Channel** (youtube.com/@flutterdev) | Dart fundamentals, widget lifecycle, Material Design 3, navigation patterns, performance | "Flutter Forward" talks; "Widget of the Week" series; "Flutter at Google I/O" |
| **Robert Brunhage** | Practical Flutter patterns, state management comparison | "Flutter BLoC vs Provider"; real-world project walkthroughs |
| **Johannes Milke** | Widget-specific deep dives, animations | Individual widget tutorials |
| **Vandad Nahavandipoor** | Advanced Dart, collections, async programming | "Flutter Course for Beginners" (full playlist) |
| **The Flutter Way** | Full project builds, UI implementation | Full app builds for layout reference |
| **Code With Andrea** | Flutter architecture, testing patterns | "Flutter & Firebase Masterclass" |

### Key Topics Learned via YouTube

- Flutter BLoC (Business Logic Component) pattern — state management
- Cubit vs BLoC distinction — used Cubit for simpler screens, BLoC for complex flows
- GoRouter navigation with route guards
- Freezed code generation for immutable state models
- GetIt service locator and Injectable annotation processing
- `flutter_webrtc` package setup and peer connection management
- `sqflite` offline SQLite integration
- Dio HTTP client with interceptors for auth token injection
- `json_serializable` and code generation workflow (`flutter pub run build_runner build`)

### Official Flutter Documentation

- Flutter Docs: https://docs.flutter.dev
- Dart Docs: https://dart.dev/guides
- Flutter BLoC Library: https://bloclibrary.dev
- GoRouter: https://pub.dev/packages/go_router
- Freezed: https://pub.dev/packages/freezed
- GetIt: https://pub.dev/packages/get_it
- Injectable: https://pub.dev/packages/injectable
- flutter_webrtc: https://pub.dev/packages/flutter_webrtc
- sqflite: https://pub.dev/packages/sqflite
- Dio: https://pub.dev/packages/dio

---

## SUPABASE (PostgreSQL + RLS)

### YouTube

| Channel | What Was Learned |
|---|---|
| **Supabase Official** (youtube.com/@Supabase) | Row Level Security setup; Supabase client in Dart; database migrations; real-time subscriptions |
| **Fireship** | "Supabase in 100 seconds"; SQL fundamentals refresher |
| **Jon Meyers** | "Build a full-stack app with Supabase and Flutter" |

### Key Topics Learned

- PostgreSQL table creation with foreign keys and constraints
- Row Level Security (RLS): writing policies with `auth.uid()` and role checks
- Supabase JavaScript and Dart clients
- Supabase dashboard for table management and SQL editor
- Real-time listeners for appointment status changes
- Storage buckets (used briefly before switching to Cloudinary)

### Official Documentation

- Supabase Docs: https://supabase.com/docs
- Supabase Row Level Security Guide: https://supabase.com/docs/guides/auth/row-level-security
- Supabase Flutter Client: https://supabase.com/docs/reference/dart/introduction
- PostgreSQL Docs: https://www.postgresql.org/docs/

---

## NODE.JS AND EXPRESS

### YouTube

| Channel | What Was Learned |
|---|---|
| **Traversy Media** | Express.js crash course; REST API with Node.js; middleware patterns |
| **The Net Ninja** | Node.js full course; JWT auth; async/await patterns in Express |
| **Academind** (Maximilian Schwarzmüller) | REST API design; error handling middleware; modular Express architecture |
| **Fireship** | "Node.js in 100 seconds"; "Express.js in 100 seconds" |
| **Hussein Nasser** | Backend fundamentals; database connection pooling; HTTPS setup |

### Key Topics Learned

- Express.js routing and middleware
- Authentication middleware (validating SuperTokens session tokens)
- Repository pattern for data layer separation
- Environment variable management with dotenv
- CORS configuration for mobile clients
- Error handling middleware patterns
- Async/await with try-catch in route handlers

### Official Documentation

- Node.js Docs: https://nodejs.org/en/docs/
- Express.js Docs: https://expressjs.com/en/4x/api.html
- npm: https://docs.npmjs.com/

---

## SUPERTOKENS (Authentication)

### YouTube / Tutorials

| Resource | What Was Learned |
|---|---|
| **SuperTokens Official Blog** (supertokens.com/blog) | Passwordless recipe setup; session management; FDI protocol |
| **SuperTokens GitHub Examples** | Node.js backend init; Flutter frontend integration patterns |
| Searched: "SuperTokens passwordless Flutter" — various dev.to and Medium articles | Three-step OTP flow: createCode → consumeCode → custom /complete endpoint |

### Key Topics Learned

- SuperTokens self-hosted vs managed service (used managed)
- Passwordless recipe: `createCode`, `consumeCode` API calls
- FDI (Frontend Driver Interface) — the protocol the Flutter client uses
- Session token handling: `st-access-token` returned in response headers
- Google Sign-In and Facebook Sign-In provider setup in SuperTokens dashboard
- Custom `/auth/passwordless/complete` backend endpoint to sync user into Supabase after auth

### Official Documentation

- SuperTokens Docs (Passwordless): https://supertokens.com/docs/passwordless/introduction
- SuperTokens Node.js SDK: https://supertokens.com/docs/nodejs/quickstart
- SuperTokens FDI Spec: https://supertokens.com/docs/contribute/apis/fdi

---

## WEBRTC AND SOCKET.IO

### YouTube

| Channel / Video | What Was Learned |
|---|---|
| **Fireship** — "WebRTC in 100 seconds" | WebRTC fundamentals: SDP, ICE candidates, STUN/TURN |
| **Fireship** — "WebRTC Crash Course" (full) | Full peer connection lifecycle; signalling architecture |
| **Hussein Nasser** | "How WebRTC Works" — deep dive into ICE, STUN, TURN; NAT traversal |
| **The Net Ninja** — Socket.IO series | Socket.IO rooms; emit/on patterns; namespace vs room; disconnection handling |
| **WebRTC.org official samples** | flutter_webrtc package integration reference |
| Various Medium/dev.to articles | "Flutter WebRTC video call with Socket.IO signalling" implementation guides |

### Key Topics Learned

- **SDP (Session Description Protocol):** offer/answer exchange between peers
- **ICE (Interactive Connectivity Establishment):** candidate gathering; STUN for public IP discovery
- **TURN server:** relay server when direct peer connection fails; deployed for fallback
- **Socket.IO signalling flow:** join-room → offer → answer → ice-candidate → leave-room
- **flutter_webrtc RTCPeerConnection:** creating offers, setting remote descriptions, adding ICE candidates
- **Media streams:** getUserMedia for camera/microphone access in Flutter
- **Socket.IO rooms:** how both client and therapist join the same meeting room ID

### Official Documentation

- WebRTC Official: https://webrtc.org
- flutter_webrtc GitHub: https://github.com/flutter-webrtc/flutter-webrtc
- Socket.IO Docs v4: https://socket.io/docs/v4
- STUN/TURN: https://webrtc.org/getting-started/turn-server

---

## FIREBASE (FCM Push Notifications)

### YouTube

| Channel | What Was Learned |
|---|---|
| **Firebase Official** (youtube.com/@Firebase) | FCM setup; Flutter Firebase integration; notification payload structure |
| **Reso Coder** — "Flutter Firebase Push Notifications" | flutter_local_notifications integration; foreground/background handling |
| **The Net Ninja** — Firebase series | Firebase project setup; google-services.json configuration |

### Key Topics Learned

- FCM token registration and storage per user in Supabase
- Sending notifications from Node.js backend using firebase-admin SDK
- Handling foreground, background, and terminated app notification states in Flutter
- Notification payload structure: title, body, data fields
- Deep linking from notification to specific screen in app

### Official Documentation

- Firebase Flutter Setup: https://firebase.flutter.dev/docs/overview
- FCM (Flutter): https://firebase.flutter.dev/docs/messaging/overview
- firebase-admin (Node.js): https://firebase.google.com/docs/admin/setup

---

## ESEWA PAYMENT INTEGRATION

### Resources Used

| Resource | What Was Learned |
|---|---|
| **eSewa Developer Portal** | API documentation; test credentials; callback verification |
| **eSewa Flutter SDK GitHub** | SDK initiation; ESewaConfig, ESewaPayment, callback handlers |
| **fonepay.com docs** (eSewa parent) | HMAC signature verification for server-side validation |
| Nepali developer community (GitHub issues, Stack Overflow) | Debugging payment callback URL and SDK version compatibility |

### Key Topics Learned

- eSewa test environment vs production environment setup
- ESewaFlutterSdk.initPayment() parameters: productId, productName, productPrice
- Three callback handlers: onPaymentSuccess, onPaymentFailure, onPaymentCancellation
- Server-side HMAC signature verification to prevent tampered payment callbacks
- Storing transaction reference IDs for audit trail

### Official Documentation

- eSewa Flutter SDK: https://pub.dev/packages/esewa_flutter_sdk
- eSewa Developer Portal: https://developer.esewa.com.np

---

## CLOUDINARY (Media Storage and Delivery)

### Resources Used

| Resource | What Was Learned |
|---|---|
| **Cloudinary Documentation** | Upload API; transformation URLs; unsigned upload presets |
| YouTube: "Cloudinary with Flutter" tutorials | flutter_cloudinary_public package; image and video upload |
| Cloudinary blog | CDN delivery; adaptive bitrate streaming for video |

### Official Documentation

- Cloudinary Docs: https://cloudinary.com/documentation
- Upload API: https://cloudinary.com/documentation/image_upload_api_reference

---

## PROTOCOL BUFFERS (Offline Serialisation)

### Resources Used

| Resource | What Was Learned |
|---|---|
| Protocol Buffers official docs | .proto file syntax; generating Dart code from .proto |
| YouTube: "Protocol Buffers in 100 seconds" (Fireship) | Why protobuf over JSON: binary efficiency |
| protobuf Dart package docs | Encoding/decoding binary messages in Flutter |

### Official Documentation

- Protocol Buffers: https://protobuf.dev
- protobuf Dart: https://pub.dev/packages/protobuf

---

## GENERAL SOFTWARE ENGINEERING

### YouTube

| Channel | What Was Learned |
|---|---|
| **Fireship** | Technology overviews; quick conceptual primers for many tech decisions |
| **Traversy Media** | Full-stack project patterns; REST API fundamentals |
| **Tech With Tim** | Python scripting for data processing (pre-survey analysis) |
| **Academind** | Clean code; modular architecture concepts |

### Books and Written Resources

| Resource | Used For |
|---|---|
| *Clean Architecture* — Robert C. Martin (2017) | Feature-first architecture design; layer separation rationale |
| *The Rational Unified Process* — Philippe Kruchten (2003) | RUP methodology framework; phase definitions |
| *Software Engineering* — Ian Sommerville (2016) | Testing frameworks; non-functional requirements categories |
| *Software Engineering: A Practitioner's Approach* — Roger Pressman (2014) | System testing methodology; test case design |

---

## DESIGN TOOLS

| Tool | Used For | Learning Resource |
|---|---|---|
| **Figma** | UI mockup design; component library | Figma official YouTube; "Figma for Beginners" tutorials |
| **draw.io / diagrams.net** | UML diagrams, ERD, data flow diagrams | Built-in documentation; YouTube tutorials |
| **Mermaid** | Inline markdown UML in report | mermaid.js.org official docs; Live Editor |
| **Lucidchart** | Gantt chart and WBS creation | Lucidchart tutorial videos |

---

## ADDITIONAL REFERENCE ARTICLES (Dev.to / Medium / Stack Overflow)

| Topic | Platform | Description |
|---|---|---|
| Flutter BLoC with Clean Architecture | Medium (Reso Coder) | Detailed walkthrough of feature-first file structure |
| SuperTokens + Flutter integration | dev.to | Community article: integrating the FDI API from Flutter |
| WebRTC with Socket.IO in Flutter | Medium | Step-by-step signalling implementation |
| Supabase RLS policies in Flutter | dev.to | Writing row-level security for multi-role apps |
| eSewa integration Nepal | GitHub Gists / Nepali dev blogs | Community guidance on SDK usage and HMAC verification |
| flutter_webrtc STUN configuration | GitHub Issues | Resolving ICE candidate failures on mobile networks |
| Protobuf with Flutter offline sync | Medium | Binary serialisation for local SQLite queues |
