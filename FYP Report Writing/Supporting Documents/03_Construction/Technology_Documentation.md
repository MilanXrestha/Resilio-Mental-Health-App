# TECHNOLOGY DOCUMENTATION REFERENCE

Official documentation links and version information for every technology, package, framework, service, and SDK used in Resilio. Organised by layer (Frontend, Backend, Database, External Services, DevOps/Tools).

---

## FRONTEND — Flutter Mobile Application

### Core Framework

| Technology | Version Used | Official Documentation |
|---|---|---|
| Flutter SDK | 3.x (stable channel) | https://docs.flutter.dev |
| Dart | 3.x | https://dart.dev/guides |
| Material Design 3 | Flutter built-in | https://m3.material.io |

### State Management and Architecture

| Package | Purpose | Documentation |
|---|---|---|
| `flutter_bloc` | BLoC/Cubit state management pattern | https://bloclibrary.dev |
| `equatable` | Value equality for BLoC states/events | https://pub.dev/packages/equatable |
| `get_it` | Service locator for dependency injection | https://pub.dev/packages/get_it |
| `injectable` | Code generation annotations for GetIt | https://pub.dev/packages/injectable |

### Navigation

| Package | Purpose | Documentation |
|---|---|---|
| `go_router` | Declarative routing with route guards | https://pub.dev/packages/go_router |

### Code Generation

| Package | Purpose | Documentation |
|---|---|---|
| `freezed` | Immutable state models, union types, copyWith | https://pub.dev/packages/freezed |
| `freezed_annotation` | Annotations for Freezed | https://pub.dev/packages/freezed_annotation |
| `json_serializable` | JSON serialisation/deserialisation | https://pub.dev/packages/json_serializable |
| `json_annotation` | Annotations for json_serializable | https://pub.dev/packages/json_annotation |
| `build_runner` | Code generation runner | https://pub.dev/packages/build_runner |

### Networking

| Package | Purpose | Documentation |
|---|---|---|
| `dio` | HTTP client with interceptors | https://pub.dev/packages/dio |

### Local Storage / Offline

| Package | Purpose | Documentation |
|---|---|---|
| `sqflite` | SQLite local database | https://pub.dev/packages/sqflite |
| `path_provider` | Device file system paths | https://pub.dev/packages/path_provider |
| `protobuf` | Binary serialisation for offline sync | https://pub.dev/packages/protobuf |

### Authentication

| Package | Version | Purpose | Documentation |
|---|---|---|---|
| `supertokens_flutter` | git master (override) | SuperTokens Flutter SDK — OTP passwordless + Google + Facebook via FDI protocol | https://supertokens.com/docs/flutter/quickstart |
| `google_sign_in` | latest | Google OAuth Sign-In | https://pub.dev/packages/google_sign_in |
| `flutter_facebook_auth` | latest | Facebook OAuth Sign-In | https://pub.dev/packages/flutter_facebook_auth |

> **Note:** `supertokens_flutter` is declared under `dependency_overrides` in `pubspec.yaml` pointing to the GitHub master branch (`git: url: https://github.com/supertokens/supertokens-flutter ref: master`) because the pub.dev version did not support the OTP + third-party combined recipe required by Resilio.

### Firebase (Multiple Services)

| Package | Version | Purpose | Documentation |
|---|---|---|---|
| `firebase_auth` | ^6.1.4 | Firebase Authentication | https://firebase.flutter.dev/docs/auth/overview |
| `cloud_firestore` | ^6.1.2 | Cloud Firestore real-time data synchronisation | https://firebase.flutter.dev/docs/firestore/overview |
| `cloud_functions` | ^6.0.6 | Firebase Cloud Functions invocation | https://firebase.flutter.dev/docs/functions/overview |
| `firebase_messaging` | ^16.1.1 | Firebase Cloud Messaging (FCM) push notifications | https://firebase.flutter.dev/docs/messaging/overview |

### Real-Time Communication

| Package | Purpose | Documentation |
|---|---|---|
| `flutter_webrtc` | WebRTC peer connection management | https://pub.dev/packages/flutter_webrtc |
| `socket_io_client` | Socket.IO client for signalling | https://pub.dev/packages/socket_io_client |

### Notifications

| Package | Purpose | Documentation |
|---|---|---|
| `firebase_messaging` | Firebase Cloud Messaging (FCM) | https://firebase.flutter.dev/docs/messaging/overview |
| `flutter_local_notifications` | Local notification display | https://pub.dev/packages/flutter_local_notifications |

### Media and Content

| Package | Purpose | Documentation |
|---|---|---|
| `better_player_plus` | ^1.0.8 | Enhanced video player (long-form and short reels) | https://pub.dev/packages/better_player_plus |
| `just_audio` | latest | Audio playback for guided audio tracks | https://pub.dev/packages/just_audio |
| `audioplayers` | ^6.6.0 | Secondary audio playback (game sounds, UI feedback) | https://pub.dev/packages/audioplayers |
| `cached_network_image` | latest | LRU image caching from Cloudinary CDN | https://pub.dev/packages/cached_network_image |
| `image_picker` | latest | Profile photo and media selection | https://pub.dev/packages/image_picker |
| `flutter_tts` | ^4.2.5 | Text-to-speech for content narration | https://pub.dev/packages/flutter_tts |

> **Note:** `video_player` and `chewie` were initially considered but replaced by `better_player_plus` which provides both long-form and short-reel (short flag) playback in a single package.

### Payment

| Package | Version | Purpose | Documentation |
|---|---|---|---|
| `esewa_flutter_sdk` | local path | eSewa payment integration | https://developer.esewa.com.np |

> **Note:** `esewa_flutter_sdk` is declared as a **local path dependency** (`path: ./esewa_flutter_sdk`) in `pubspec.yaml`. The SDK is bundled directly in the project directory rather than sourced from pub.dev, as the pub.dev version did not support the eSewa v2 payment verification API required by Resilio.

### Charts and Visualisation

| Package | Version | Purpose | Documentation |
|---|---|---|---|
| `fl_chart` | latest | Mood history line/bar charts | https://pub.dev/packages/fl_chart |
| `table_calendar` | ^3.2.0 | Appointment calendar view | https://pub.dev/packages/table_calendar |

### UI and Animation

| Package | Version | Purpose | Documentation |
|---|---|---|---|
| `lottie` | ^3.3.1 | Lottie animation player (loading, success states) | https://pub.dev/packages/lottie |
| `flip_card` | ^0.7.0 | Card flip animation (Wellness Trivia game) | https://pub.dev/packages/flip_card |
| `animations` | latest | Shared element and page transition animations | https://pub.dev/packages/animations |

### Functional Programming

| Package | Version | Purpose | Documentation |
|---|---|---|---|
| `dartz` | ^0.10.1 | Functional Either type for error handling in domain layer | https://pub.dev/packages/dartz |
| `rxdart` | ^0.28.0 | Reactive extensions — stream composition | https://pub.dev/packages/rxdart |

### Utilities

| Package | Version | Purpose | Documentation |
|---|---|---|---|
| `intl` | latest | Internationalisation, date formatting | https://pub.dev/packages/intl |
| `flutter_localizations` | built-in | l10n support for Nepali translation | Flutter built-in |
| `shared_preferences` | latest | Lightweight key-value local storage | https://pub.dev/packages/shared_preferences |
| `connectivity_plus` | ^6.1.4 | Network connectivity detection (online/offline toggle) | https://pub.dev/packages/connectivity_plus |
| `flutter_cache_manager` | ^3.4.1 | LRU content cache for offline media | https://pub.dev/packages/flutter_cache_manager |
| `permission_handler` | latest | Camera and microphone permission requests | https://pub.dev/packages/permission_handler |
| `url_launcher` | latest | Opening external URLs (Nepal crisis helpline) | https://pub.dev/packages/url_launcher |

---

## BACKEND — Node.js / Express API

### Core

| Technology | Version | Documentation |
|---|---|---|
| Node.js | 20.x LTS | https://nodejs.org/en/docs/ |
| Express.js | 4.x | https://expressjs.com/en/4x/api.html |

### Authentication Middleware

| Package | Purpose | Documentation |
|---|---|---|
| `supertokens-node` | SuperTokens backend SDK; session verification middleware | https://supertokens.com/docs/nodejs/quickstart |

### Database Client

| Package | Purpose | Documentation |
|---|---|---|
| `@supabase/supabase-js` | Supabase JavaScript client for database operations | https://supabase.com/docs/reference/javascript/introduction |

### Notifications

| Package | Purpose | Documentation |
|---|---|---|
| `firebase-admin` | Sending FCM push notifications from backend | https://firebase.google.com/docs/admin/setup |

### Real-Time

| Package | Purpose | Documentation |
|---|---|---|
| `socket.io` | WebRTC signalling server | https://socket.io/docs/v4 |

### Utilities

| Package | Purpose | Documentation |
|---|---|---|
| `dotenv` | Environment variable management | https://www.npmjs.com/package/dotenv |
| `cors` | Cross-Origin Resource Sharing headers | https://www.npmjs.com/package/cors |
| `helmet` | HTTP security headers | https://helmetjs.github.io |
| `express-validator` | Request body validation middleware | https://express-validator.github.io/docs |
| `uuid` | UUID generation for room IDs and records | https://www.npmjs.com/package/uuid |

---

## DATABASE — Supabase (PostgreSQL)

| Technology | Documentation |
|---|---|
| PostgreSQL 15 | https://www.postgresql.org/docs/15/ |
| Supabase Platform | https://supabase.com/docs |
| Row Level Security | https://supabase.com/docs/guides/auth/row-level-security |
| Supabase SQL Editor | https://supabase.com/docs/guides/database/query-files |
| Supabase Migrations | https://supabase.com/docs/reference/cli/supabase-db-diff |

---

## AUTHENTICATION — SuperTokens

| Component | Documentation |
|---|---|
| SuperTokens Overview | https://supertokens.com/docs/community/introduction |
| Passwordless Recipe | https://supertokens.com/docs/passwordless/introduction |
| Node.js Backend SDK | https://supertokens.com/docs/nodejs/quickstart |
| FDI API Reference | https://supertokens.com/docs/contribute/apis/fdi |
| SuperTokens Managed Service | https://supertokens.com/docs/community/supertokens-core/self-hosting/overview |
| Google Provider Setup | https://supertokens.com/docs/thirdparty/common-customizations/sign-in-and-up/provider-config |
| Facebook Provider Setup | https://supertokens.com/docs/thirdparty/common-customizations/sign-in-and-up/provider-config |

---

## PUSH NOTIFICATIONS — Firebase Cloud Messaging

| Component | Documentation |
|---|---|
| Firebase Console | https://console.firebase.google.com |
| Flutter Firebase Setup | https://firebase.flutter.dev/docs/overview |
| Firebase Messaging (Flutter) | https://firebase.flutter.dev/docs/messaging/overview |
| firebase-admin (Node.js) | https://firebase.google.com/docs/admin/setup |
| FCM Message Formats | https://firebase.google.com/docs/cloud-messaging/concept-options |

---

## MEDIA STORAGE — Cloudinary

| Component | Documentation |
|---|---|
| Cloudinary Overview | https://cloudinary.com/documentation |
| Upload API | https://cloudinary.com/documentation/image_upload_api_reference |
| Video Upload | https://cloudinary.com/documentation/video_upload_api_reference |
| Unsigned Upload Presets | https://cloudinary.com/documentation/upload_presets |
| Transformation URL Reference | https://cloudinary.com/documentation/transformation_reference |
| CDN Delivery | https://cloudinary.com/documentation/advanced_url_delivery_options |

---

## REAL-TIME COMMUNICATION — WebRTC + Socket.IO

| Component | Documentation |
|---|---|
| WebRTC Official | https://webrtc.org |
| WebRTC API Reference | https://developer.mozilla.org/en-US/docs/Web/API/WebRTC_API |
| flutter_webrtc | https://github.com/flutter-webrtc/flutter-webrtc |
| Socket.IO Server Docs | https://socket.io/docs/v4/server-api |
| Socket.IO Client Docs | https://socket.io/docs/v4/client-api |
| STUN/TURN (Google free STUN) | stun:stun.l.google.com:19302 |
| Coturn (TURN server) | https://github.com/coturn/coturn |

---

## PAYMENT — eSewa

| Component | Documentation |
|---|---|
| eSewa Developer Portal | https://developer.esewa.com.np |
| eSewa Flutter SDK | https://pub.dev/packages/esewa_flutter_sdk |
| eSewa Test Credentials | Available in developer portal after registration |
| Payment Flow Documentation | https://developer.esewa.com.np/#/epay |

---

## DESIGN TOOLS

| Tool | Purpose | Link |
|---|---|---|
| Figma | High-fidelity UI mockups and prototype | https://figma.com |
| draw.io / diagrams.net | UML, ERD, DFD, system architecture diagrams | https://app.diagrams.net |
| Mermaid Live Editor | Mermaid diagram code preview | https://mermaid.live |
| Lucidchart | Gantt chart, WBS | https://lucidchart.com |
| Canva | Report visual assets | https://canva.com |

---

## DEVELOPMENT TOOLS

| Tool | Purpose | Link |
|---|---|---|
| Android Studio | Primary Flutter IDE | https://developer.android.com/studio |
| VS Code | Secondary editor (backend) | https://code.visualstudio.com |
| Dart DevTools | Flutter widget inspector and performance profiler | https://docs.flutter.dev/tools/devtools |
| Postman | API endpoint testing | https://www.postman.com |
| DBeaver | PostgreSQL GUI for Supabase inspection | https://dbeaver.io |
| Git | Version control | https://git-scm.com |
| GitHub | Remote repository hosting | https://github.com |
| Android Emulator | App testing on virtual Android device | Android Studio built-in |
| Physical Android Device | On-device testing (WebRTC, push notifications) | — |
