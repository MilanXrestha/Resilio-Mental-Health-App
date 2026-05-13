# CHAPTER 3: DEVELOPMENT

---

## 3.1 Considered Methodologies

Three widely recognised software development lifecycle models were evaluated before selecting a methodology for Resilio.

### 3.1.1 Agile (Scrum)

Agile organises work into short, iterative sprints that deliver working software regularly (Beck et al., 2001). It excels at responding to changing requirements and maintaining close stakeholder contact. However, its light documentation and open-ended nature introduce scope creep risk in a fixed-deadline academic project. Sprint boundaries are also difficult to align with academic submission milestones.

### 3.1.2 Rational Unified Process (RUP)

RUP divides development into four sequential phases: Inception, Elaboration, Construction, and Transition (Kruchten, 2003). It is use-case driven, risk-focused, and heavily documented. Its phase structure maps naturally to academic submission milestones, and its Elaboration phase requires that high-risk architectural components be validated through working prototypes before large-scale construction begins.

### 3.1.3 Prototype Model

The Prototype Model builds a working prototype early for stakeholder feedback before constructing the final system (Pressman, 2014). It surfaces hidden requirements through user interaction but risks producing technically fragile foundations if architectural planning is deferred.

---

## 3.2 Selected Methodology

Rational Unified Process was selected for Resilio based on four factors: the technical complexity of WebRTC, offline synchronisation, and eSewa integration warranted RUP's early risk validation; the four phases mapped directly to academic submission deadlines; the use-case-driven approach suited a three-role system; and both external clients were available for prototype review sessions during Elaboration.

| Criterion | Agile (Scrum) | Prototype Model | RUP |
|---|---|---|---|
| User Involvement | Moderate | High | High at milestones |
| Documentation | Light | Minimal | Comprehensive |
| Flexibility | Very High | High | Moderate |
| Risk Management | Reactive | Moderate | Proactive |
| Deadline Alignment | Difficult | Moderate | Natural |
| Academic Fit | Moderate | Moderate | Excellent |
| Scope Control | Low | Low | High |

---

## 3.3 Phases of RUP Methodology

### 3.3.1 Phase 1: Inception (November 2024)

The Inception phase defined the project scope, validated feasibility, and captured domain requirements through stakeholder interviews and a pre-project survey. Interviews with Ms. Sushana Karki and Dr. Dibyandra Singh confirmed the clinical case for between-session mood tracking visible to therapists, offline content access, and questionnaire-based therapist matching. A pre-project survey of 166 respondents validated the problem domain. Technical feasibility analysis confirmed that WebRTC, eSewa, and SQLite-to-PostgreSQL synchronisation were all viable within the Flutter ecosystem.

### 3.3.2 Phase 2: Elaboration (December 2024)

The Elaboration phase validated the three highest-risk architectural components through working prototypes before construction began. The first prototype confirmed that WebRTC peer connections could be established between two Flutter clients via a Node.js signalling server. The second validated that eSewa sandbox payments could be completed within the Flutter application. The third demonstrated SQLite-to-PostgreSQL synchronisation with timestamp-based conflict resolution. Wireframes and high-fidelity Figma mockups were reviewed with both clients and five potential users, leading to revisions to the therapist discovery interface, mood logging flow, and content hub navigation structure.

*[INSERT FIGURE 3.1: Selected Wireframe Screens]*

*[INSERT FIGURE 3.2: High-Fidelity Figma UI Mockups]*

### 3.3.3 Phase 3: Construction (January to March 2025)

Development proceeded in seven iterations targeting defined feature sets.

| Iteration | Features Delivered |
|---|---|
| 1 | Authentication and onboarding: SuperTokens OTP, Google Sign-In, Facebook Login, preference selection |
| 2 | Therapist module: profile management, availability calendar, patient list, earnings dashboard |
| 3 | Appointment booking and eSewa payment with FCM confirmation notifications |
| 4 | WebRTC video and audio consultation with in-session patient mood data visibility |
| 5 | Wellness content hub: audio, video, images, Cloudinary delivery, favourites |
| 6 | Wellness games, mood tracking, PHQ-9/GAD-7 questionnaires, EMA logging |
| 7 | Admin dashboard, subscriptions, push notifications, offline sync |

*[INSERT FIGURE 3.3: Customer Dashboard Screen]*

*[INSERT FIGURE 3.4: Therapist Dashboard Screen]*

*[INSERT FIGURE 3.5: Admin Dashboard Screen]*

### 3.3.4 Phase 4: Transition (March to April 2025)

The Transition phase covered backend deployment, APK packaging, system testing across all user roles, and user acceptance testing. A post-project survey collected feedback from 132 respondents. Results are summarised in Section 3.4.

---

## 3.4 Survey Results

### 3.4.1 Pre-Survey Results

A pre-project survey of **166 respondents** was conducted during the Inception phase to validate the problem domain and inform requirements. Key findings are summarised below. Full question-by-question response distributions are provided in Appendix G.

| Survey Question | Key Finding |
|---|---|
| Frequency of stress or low mood | 77.1% experience symptoms regularly (often or sometimes) |
| Usual coping behaviour | 48.2% talk to friends or family; only a small minority seek professional help |
| Prior professional consultation | 60.5% never consulted a professional; 39.2% wanted to but did not |
| Biggest barrier to seeking help | Cost (38%), awareness (23.5%), availability (21.1%), stigma (17.5%) |
| Previous app use | 58.4% had never used a mental health app |
| Comfort with digital mental health tools | 77.5% comfortable or very comfortable |
| Most valued feature | Therapist access (38.6%), mood tracking (20.5%), relaxation exercises (similar) |
| Importance of offline functionality | 80.8% consider it very important or somewhat important |
| Willingness to pay via eSewa | 60.9% willing or probably willing |
| Awareness of mental health resources | Over 60% either unaware or only slightly aware |

The survey validated all core design decisions: therapist access as the primary feature, offline-first architecture, eSewa as the payment mechanism, and the educational content hub targeting the resource awareness gap.

### 3.4.2 Post-Survey Results

A post-project survey of **132 respondents** was conducted during the Transition phase with users who had used the full application. Key outcomes are summarised below. Full data is provided in Appendix H.

| Survey Question | Key Outcome |
|---|---|
| Overall satisfaction | 100% positive (66.7% satisfied; 33.3% very satisfied) |
| Navigation ease | 100% positive (56.8% easy; 43.2% very easy) |
| Most useful feature | Content hub (25.8%), therapist booking (22%), notifications (19.7%), mood tracking (16.7%), games (15.9%) |
| Felt more informed about mental health | 100% positive (60.6% significantly; 39.4% somewhat) |
| Wellness content quality | 100% positive (56.8% good; 43.2% excellent) |
| Mood tracker helped understand patterns | 100% positive (71.2% very much; 28.8% somewhat) |
| Consultation experience | 100% positive (41.7% excellent; 58.3% good with minor issues) |
| eSewa payment experience | 60.6% smooth and trustworthy; 20.5% neutral |
| Confidence managing mental health improved | 100% positive (40.2% much more; 59.8% somewhat more) |
| Would recommend Resilio | 100% positive (43.9% definitely; 56.1% probably) |

---

## 3.5 Requirement Analysis

### 3.5.1 Functional Requirements

**Customer Requirements:**

FR-C01: The system shall allow customers to register and log in using SuperTokens passwordless OTP, Google Sign-In, or Facebook Login.

FR-C02: The system shall present a preference selection flow during onboarding to personalise content and therapist recommendations.

FR-C03: The system shall allow customers to browse, filter, and view verified therapist profiles.

FR-C04: The system shall allow customers to complete a matching questionnaire and receive therapist recommendations.

FR-C05: The system shall allow customers to book appointments by selecting available time slots.

FR-C06: The system shall process appointment payments through the eSewa payment gateway.

FR-C07: The system shall allow customers to attend live video and audio consultation sessions within the application.

FR-C08: The system shall allow customers to log daily mood with a score, label, and optional note.

FR-C09: The system shall allow customers to complete PHQ-9 and GAD-7 questionnaires and view historical scores.

FR-C10: The system shall provide a wellness content hub with articles, audio tracks, and educational videos.

FR-C11: The system shall provide interactive wellness games including breathing exercises, trivia, affirmation builder, and role-play scenarios.

FR-C12: The system shall deliver push notifications for appointment reminders, bookings, and updates.

FR-C13: The system shall allow customers to save favourite content items and therapist profiles.

**Therapist Requirements:**

FR-T01: The system shall allow therapists to register and submit professional profiles for verification.

FR-T02: The system shall allow verified therapists to manage their availability calendar.

FR-T03: The system shall allow therapists to view upcoming appointments and patient lists.

FR-T04: The system shall allow therapists to view patient mood logs and questionnaire histories within the consultation interface.

FR-T05: The system shall allow therapists to publish articles, audio, and video to the wellness hub.

FR-T06: The system shall provide therapists with an earnings summary including session history.

**Administrator Requirements:**

FR-A01: The system shall allow administrators to approve or reject therapist registrations.

FR-A02: The system shall allow administrators to manage user accounts, including suspension and removal.

FR-A03: The system shall allow administrators to moderate therapist content before publication.

FR-A04: The system shall provide administrators with platform analytics including active users, subscriptions, and session volume.

### 3.5.2 Non-Functional Requirements

NFR-01 **Performance:** Primary screens shall load within two seconds on 4G. API endpoints shall respond within 500ms under normal load.

NFR-02 **Availability:** Backend API shall target 99.5% uptime. Core features shall remain functional offline.

NFR-03 **Security:** Data in transit shall use TLS 1.2 or higher. Authentication uses SuperTokens session tokens. Role-based access control is enforced on all API endpoints.

NFR-04 **Scalability:** The backend API layer shall support horizontal scaling without changes to the database schema or mobile application.

NFR-05 **Usability:** Core features shall be navigable by a first-time user without instruction. The interface shall target WCAG 2.1 Level AA compliance.

NFR-06 **Data Privacy:** Only minimum necessary data shall be collected. Users may delete their account and all associated data through the application.

---

## 3.6 Design

### 3.6.1 System Architecture

Resilio follows a three-tier client-server architecture. The Flutter mobile client communicates with the Node.js and Express REST API over HTTPS. The backend queries PostgreSQL via Supabase. SuperTokens manages authentication. Firebase Cloud Messaging handles push notification delivery. Cloudinary manages all media assets. WebRTC manages real-time peer-to-peer consultation streams, with Socket.IO on the backend handling WebRTC signalling.

*[INSERT FIGURE 3.6: Full System Architecture Diagram]*

### 3.6.2 Use Case Diagrams

Three use case diagrams were produced, one per user role.

*[INSERT FIGURE 3.7: Customer Use Case Diagram]*

*[INSERT FIGURE 3.8: Therapist Use Case Diagram]*

*[INSERT FIGURE 3.9: Admin Use Case Diagram]*

### 3.6.3 Activity Diagrams

Activity diagrams capture the appointment booking and payment flow and the video consultation session flow, including decision points and exception paths.

*[INSERT FIGURE 3.10: Appointment Booking Activity Diagram]*

*[INSERT FIGURE 3.11: Video Consultation Session Activity Diagram]*

### 3.6.4 Sequence Diagrams

Sequence diagrams capture the interactions between the mobile client, backend API, database, Firebase, and eSewa for the two most complex flows.

*[INSERT FIGURE 3.12: Appointment Booking Sequence Diagram]*

*[INSERT FIGURE 3.13: WebRTC Video Consultation Sequence Diagram]*

### 3.6.5 Entity-Relationship Diagram

The ERD captures all primary entities and their relationships. Core entities include users, therapist_profiles, appointments, subscriptions, transactions, preferences, user_preferences, mood_entries, game_sessions, audio_tracks, video_tracks, categories, favorites, and notifications.

*[INSERT FIGURE 3.14: Entity-Relationship Diagram]*

### 3.6.6 Wireframes and UI Mockups

Wireframes and high-fidelity mockups are included in Appendix J.

---

## 3.7 Implementation

### 3.7.1 Tools and Platforms

| Category | Tool / Platform | Purpose |
|---|---|---|
| Mobile Framework | Flutter 3.x (Dart) | Cross-platform mobile UI |
| State Management | Flutter BLoC | Separation of UI and business logic |
| Backend Runtime | Node.js 20 with Express | REST API server |
| Primary Database | PostgreSQL via Supabase | Relational data storage with RLS |
| Local Storage | SQLite | Offline data persistence |
| Authentication | SuperTokens (OTP + Social) | Session tokens and OTP email flow |
| Push Notifications | Firebase Cloud Messaging | Appointment reminders and alerts |
| Media Storage | Cloudinary | Audio, video, and image delivery |
| Video Calls | WebRTC | Real-time peer-to-peer consultation |
| Payment Gateway | eSewa | Nepali digital wallet payments |
| Version Control | Git and GitHub | Source code management |
| API Testing | Postman | Backend endpoint testing |
| Serialisation | Protocol Buffers | Efficient offline data serialisation |

### 3.7.2 Code Architecture

The Flutter codebase follows Clean Architecture with a feature-first folder structure. Each feature directory contains three layers: data (repository implementations, remote and local data sources, DTOs), domain (entities, repository interfaces, use cases), and presentation (BLoC cubits, state classes, screen widgets). This ensures the UI has no direct dependency on the API or database. All data access flows through domain-layer use cases, making components independently testable. Sample code is provided in Appendix I.

### 3.7.3 Customer Module

The customer module covers the full user journey from onboarding through mood tracking, therapist discovery and booking, live consultation, content consumption, and wellness games. It integrates with every external service: Firebase, eSewa, Cloudinary, WebRTC, and the Node.js backend.

*[INSERT FIGURE 3.15: Customer Onboarding and Preference Selection Screens]*

*[INSERT FIGURE 3.16: Therapist Discovery and Booking Flow Screens]*

*[INSERT FIGURE 3.17: Wellness Content Hub and Games Screens]*

*[INSERT FIGURE 3.18: Mood Tracking and Questionnaire Screens]*

### 3.7.4 Therapist Module

The therapist module provides a professional practice management environment covering appointment management, patient mood history visibility, content publishing, availability scheduling, and live consultation delivery.

*[INSERT FIGURE 3.19: Therapist Dashboard and Appointment Management Screens]*

### 3.7.5 Admin Module

The admin module provides platform-wide management: therapist registration approval, content moderation, user account management, and subscription and analytics dashboards.

*[INSERT FIGURE 3.20: Admin Dashboard and Therapist Verification Screens]*

---

## References

Beck, K., Beedle, M., van Bennekum, A., Cockburn, A., Cunningham, W., Fowler, M. and others (2001) *Manifesto for Agile Software Development*. Available at: https://agilemanifesto.org (Accessed: 15 April 2026).

Kruchten, P. (2003) *The Rational Unified Process: An Introduction*. 3rd edn. Boston: Addison-Wesley.

Martin, R.C. (2017) *Clean Architecture: A Craftsman's Guide to Software Structure and Design*. Upper Saddle River: Prentice Hall.

Pressman, R.S. (2014) *Software Engineering: A Practitioner's Approach*. 8th edn. New York: McGraw-Hill.

Sommerville, I. (2016) *Software Engineering*. 10th edn. Harlow: Pearson Education.
