# DEVELOPMENT TOOLS AND ENVIRONMENT

All tools, software, services, and environment configurations used during the development of Resilio. Organised by category.

---

## INTEGRATED DEVELOPMENT ENVIRONMENTS (IDEs)

### Android Studio

**Primary IDE for Flutter development.**

| Attribute | Detail |
|---|---|
| Version | Android Studio Hedgehog (2023.1.1) or later |
| Purpose | Flutter/Dart mobile frontend development |
| Key plugins installed | Flutter plugin, Dart plugin, Dart DevTools |
| Download | https://developer.android.com/studio |

**Why Android Studio over VS Code for Flutter:**
Android Studio's Flutter plugin provides a superior widget inspector, built-in Android emulator management, and Gradle build system integration — all essential for Android-first Flutter development.

---

### Visual Studio Code

**Secondary editor for Node.js backend development.**

| Attribute | Detail |
|---|---|
| Version | Latest stable |
| Purpose | Node.js / Express backend, SQL scripts, Markdown |
| Key extensions installed | ESLint, Prettier, REST Client, GitLens, Thunder Client, Markdown Preview Enhanced |
| Download | https://code.visualstudio.com |

---

## FLUTTER / DART TOOLCHAIN

| Tool | Version | Purpose |
|---|---|---|
| Flutter SDK | 3.x (stable) | Cross-platform mobile framework |
| Dart SDK | Bundled with Flutter 3.x | Programming language |
| `flutter pub get` | — | Install Dart/Flutter packages |
| `build_runner` | Latest | Code generation: Freezed, json_serializable, injectable |
| Dart DevTools | Bundled | Widget inspector, performance profiler, memory analysis |
| `flutter analyze` | Bundled | Static analysis and linting |
| `flutter test` | Bundled | Unit and widget test runner |

**Common build commands used during development:**

```bash
# Install all packages
flutter pub get

# Run code generation (Freezed, json_serializable, injectable)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app on connected device/emulator
flutter run

# Run all tests
flutter test

# Build release APK
flutter build apk --release

# Analyse for warnings and errors
flutter analyze
```

---

## NODE.JS BACKEND TOOLCHAIN

| Tool | Version | Purpose |
|---|---|---|
| Node.js | 20.x LTS | JavaScript runtime |
| npm | Bundled with Node.js | Package manager |
| nodemon | Latest | Auto-restart server on file changes during development |
| eslint | Latest | JavaScript linting |
| prettier | Latest | Code formatting |

**Common commands used:**

```bash
# Install dependencies
npm install

# Start development server with auto-restart
npm run dev  # uses nodemon

# Start production server
npm start

# Lint check
npm run lint
```

---

## VERSION CONTROL

### Git + GitHub

| Attribute | Detail |
|---|---|
| Tool | Git 2.x |
| Remote | GitHub (private repository) |
| Branching strategy | Feature branches → `main`; branch per major feature/iteration |
| Commit convention | `feat:`, `fix:`, `enhc:`, `refactor:` prefixes |
| Download | https://git-scm.com |

**Branching structure used:**

```
main                  ← stable, submitted code
├── enhc/customer-enhanced
├── feat/webrtc-video-call
├── feat/esewa-payment
├── feat/mood-tracking
├── feat/admin-dashboard
└── feat/offline-sync
```

---

## API TESTING

### Postman

| Attribute | Detail |
|---|---|
| Version | Latest |
| Purpose | Manual testing of all REST API endpoints during development |
| Collections created | Auth, Appointments, Mood, Questionnaires, Content, Admin, Payment |
| Environment variables | `BASE_URL`, `AUTH_TOKEN`, `TEST_USER_ID`, `TEST_THERAPIST_ID` |
| Download | https://www.postman.com |

**How Postman was used:**
- Testing each endpoint immediately after implementation before writing unit tests
- Simulating eSewa payment callbacks with tampered amounts to verify rejection
- Testing RLS by swapping auth tokens between users
- Documenting request/response formats (see `07_API_Reference.md`)

### Thunder Client (VS Code Extension)

Used as a lightweight in-editor alternative to Postman for quick endpoint checks without switching windows.

---

## DATABASE MANAGEMENT

### Supabase Dashboard

| Attribute | Detail |
|---|---|
| URL | https://supabase.com/dashboard |
| Purpose | Table management, SQL editor, RLS policy editor, query logs |

**Key tasks done in Supabase Dashboard:**
- Creating all 20 database tables with constraints
- Writing and testing RLS policies using the Policy Editor
- Running SQL migration scripts
- Monitoring query performance
- Inspecting foreign key relationships
- Checking real-time subscription events

### DBeaver

| Attribute | Detail |
|---|---|
| Version | Community Edition, latest |
| Purpose | Desktop GUI for PostgreSQL — running complex SQL queries, viewing table relationships visually, data export |
| Download | https://dbeaver.io |

**Why DBeaver alongside Supabase Dashboard:**
The Supabase dashboard SQL editor is useful but limited for complex multi-table queries and schema visualisation. DBeaver provides a full ER diagram view and a more capable SQL editor for development-time database work.

---

## DESIGN TOOLS

### Figma

| Attribute | Detail |
|---|---|
| Purpose | High-fidelity UI mockups, component library, screen flow prototyping |
| Account type | Free tier (sufficient for project scope) |
| Files created | Resilio — Customer Module; Resilio — Therapist Module; Resilio — Admin Module; Design System |
| Link | https://figma.com |

**Key design decisions made in Figma:**
- Established the colour palette: teal-green primary (#2DB5A3), off-white backgrounds, warm accent
- Created reusable component library: buttons, cards, input fields, bottom sheets
- Prototyped the full onboarding flow for client review in Week 7
- Exported all assets (icons, illustrations) as SVG/PNG for Flutter integration

---

### draw.io / diagrams.net

| Attribute | Detail |
|---|---|
| Purpose | All UML diagrams, ERD, DFD, system architecture diagram, WBS |
| Export format | PNG for report insertion; XML source for editability |
| Link | https://app.diagrams.net |

**Diagrams produced:**
- System architecture (Flutter → Node.js → Supabase → External Services)
- Entity-Relationship Diagram (all 20 tables)
- Use case diagrams for Customer, Therapist, Admin
- Activity diagrams (booking flow, WebRTC flow, content publication)
- Level 0 and Level 1 DFDs
- Work Breakdown Structure

---

### Mermaid Live Editor

| Attribute | Detail |
|---|---|
| Purpose | Sequence diagrams embedded in report as Mermaid code |
| Link | https://mermaid.live |

All sequence diagram source code is in `FYP Report Writing/UML Diagrams (Mermaid Code).md`.

---

### Lucidchart

| Attribute | Detail |
|---|---|
| Purpose | Gantt chart (initial and final), project timeline visualisation |
| Link | https://lucidchart.com |

---

## TESTING ENVIRONMENT

### Android Emulator (Android Studio)

| Configuration | Detail |
|---|---|
| Device profile | Pixel 6 (API 34, Android 14) |
| Purpose | Primary development and functional testing |
| Limitation | Cannot fully test push notifications (FCM); WebRTC sometimes behaves differently than real device |

### Physical Android Device

| Device | OS Version | Purpose |
|---|---|---|
| Personal Android phone | Android 13 | Testing push notifications (FCM requires real device), WebRTC video/audio, eSewa payment app integration, offline mode (airplane mode testing) |

**Tests that required a physical device:**
- FCM push notification receipt (TC-U026, TC-S011)
- WebRTC video and audio quality assessment (TC-S004)
- eSewa SDK payment flow (TC-U014, TC-S003)
- Offline mood logging with airplane mode (TC-UAT023)

---

## PROJECT MANAGEMENT

### Notion

| Attribute | Detail |
|---|---|
| Purpose | Project planning, sprint backlog, weekly task tracking |
| Link | https://notion.so |

**What was tracked in Notion:**
- Sprint backlog for each Construction iteration (Iterations 1–7)
- Feature status: To Do → In Progress → Done
- Bug log with priority ratings
- Research notes and source organisation
- Weekly supervisor meeting preparation notes

---

## COMMUNICATION AND COLLABORATION

| Tool | Purpose |
|---|---|
| WhatsApp | Communication with external clients (Ms. Karki, Dr. Singh) |
| Zoom | Video interview with Dr. Dibyandra Singh (Week 2) |
| Google Forms | Pre-survey and post-survey distribution |
| Google Drive | Document sharing with supervisor |
| Email | Formal correspondence; supervisor feedback |

---

## ENVIRONMENT CONFIGURATION

### Flutter Environment

```yaml
# pubspec.yaml (key dependencies)
environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: '>=3.10.0'
```

### Node.js Environment Variables (.env)

```
# Server
PORT=3000
NODE_ENV=development

# Supabase
SUPABASE_URL=https://[project-ref].supabase.co
SUPABASE_SERVICE_KEY=[service-role-key]

# SuperTokens
SUPERTOKENS_CONNECTION_URI=https://[instance].aws.supertokens.io
SUPERTOKENS_API_KEY=[api-key]

# Firebase
FIREBASE_SERVICE_ACCOUNT_PATH=./firebase-service-account.json

# Cloudinary
CLOUDINARY_CLOUD_NAME=[cloud-name]
CLOUDINARY_API_KEY=[key]
CLOUDINARY_API_SECRET=[secret]

# eSewa
ESEWA_SECRET_KEY=[secret]
ESEWA_CLIENT_ID=[client-id]
```

**Security note:** The `.env` file is in `.gitignore` and was never committed to version control. All secrets are stored in environment variables or the deployment platform's secret manager.

---

## HARDWARE USED

| Hardware | Specification | Use |
|---|---|---|
| Development laptop | MacOS 14, Apple M-series chip | Primary development machine |
| Personal Android phone | Android 13 | Physical device testing |
| External display | 27" monitor | Extended workspace for running emulator + IDE simultaneously |
