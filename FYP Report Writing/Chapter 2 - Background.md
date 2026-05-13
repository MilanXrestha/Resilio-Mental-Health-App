# CHAPTER 2: BACKGROUND

---

## 2.1 About the End Users

### 2.1.1 Customers

Customers are Nepali adults aged 18 to 45 experiencing stress, anxiety, low mood, or emotional difficulty. They seek accessible and affordable mental health support and include university students facing academic pressure, working adults navigating occupational stress, and individuals in rural areas previously unable to access professional care. Customers have no clinical training and require an interface that is intuitive, private, and non-clinical in tone.

### 2.1.2 Therapists

Therapists are licensed Nepali mental health professionals including psychologists, counsellors, and psychiatrists. They need a professional platform for managing clients, conducting remote sessions, publishing wellness content, and tracking earnings. All therapists on Resilio must submit credentials for administrator verification before their profile becomes publicly visible.

### 2.1.3 System Administrators

Administrators are platform operators with full management access. They approve or reject therapist registrations, moderate content before publication, manage user accounts, and monitor platform analytics. The administrator role requires no technical background; all platform management is handled through the admin dashboard.

### 2.1.4 Client Description

Two external clients inform the project. Ms. Sushana Karki is a licensed counsellor based in Kathmandu who provided requirements and validation from the therapist perspective. Dr. Dibyandra Singh is a clinical psychologist and platform evaluator who assessed the admin workflow and provided feedback through two formal review sessions during the Elaboration phase.

---

## 2.2 Understanding the Solution

### 2.2.1 System Overview

Resilio is a three-tier mobile health platform. The Flutter mobile application communicates with the Node.js and Express REST API. The backend manages business logic and queries the PostgreSQL database via Supabase. External services include SuperTokens for authentication, Firebase for push notifications and real-time data, Cloudinary for media storage and delivery, eSewa for payment processing, and WebRTC with Socket.IO for live consultation sessions. SQLite provides local offline storage on the device.

### 2.2.2 Key Technical Terminologies

**Flutter and Dart:** Flutter is Google's cross-platform UI toolkit. Dart is its compiled programming language. A single Flutter codebase produces native Android and iOS applications, avoiding the overhead of maintaining two separate codebases.

**Clean Architecture:** A software design pattern that separates business logic from UI and data concerns. Resilio's codebase uses a feature-first folder structure with three layers per feature: data, domain, and presentation. The domain layer contains no framework dependencies, making each use case independently testable.

**Flutter BLoC (Business Logic Component):** The state management pattern used in Resilio. BLoC separates UI widgets from business logic by routing all state changes through event and state streams, making the presentation layer declarative and predictable.

**Node.js and Express:** Node.js is a JavaScript runtime that executes server-side code. Express is a lightweight web framework. Together they form the REST API that serves all data to the mobile client.

**PostgreSQL and Supabase:** PostgreSQL is the relational database storing all platform data. Supabase provides a hosted PostgreSQL instance with Row Level Security, allowing fine-grained access control directly at the database level.

**SQLite:** A lightweight embedded database used for offline data persistence on the device. Mood entries, cached content, and user preferences are stored in SQLite and synchronised to PostgreSQL when connectivity is restored.

**SuperTokens:** The open-source authentication framework used for passwordless OTP email login, Google Sign-In, and Facebook Login. SuperTokens manages session tokens, refresh logic, and role assignment without requiring Resilio to store passwords.

**WebRTC (Web Real-Time Communication):** An open standard for real-time peer-to-peer audio and video communication. Resilio uses WebRTC for live consultation sessions between patients and therapists, with Socket.IO on the server providing signalling support for ICE candidate exchange during connection establishment.

**eSewa:** Nepal's most widely adopted digital wallet. eSewa integration allows Nepali users to pay for subscriptions and therapy sessions without requiring an international credit card, removing the primary payment barrier for the target demographic.

**Firebase Cloud Messaging (FCM):** Google's push notification service used to deliver appointment reminders, booking confirmations, and system alerts to users on Android and iOS devices.

**Cloudinary:** A cloud-based media storage and delivery platform. Resilio uses Cloudinary for hosting and streaming audio tracks, educational videos, and therapist profile images, with CDN-backed delivery optimised for mobile.

**Ecological Momentary Assessment (EMA):** A research methodology for capturing psychological states in real time within a person's natural environment. Resilio's mood logging system is informed by EMA principles, prompting users to log their emotional state at intervals rather than retrospectively.

**PHQ-9 and GAD-7:** Clinically validated screening instruments. The Patient Health Questionnaire-9 measures depression severity on a 0-27 scale. The Generalised Anxiety Disorder-7 measures anxiety severity on a 0-21 scale. Both are widely used in primary care and telehealth contexts.

### 2.2.3 Core Features and Functions

| Feature | Description |
|---|---|
| SuperTokens OTP + Social Login | Passwordless authentication via email OTP, Google, or Facebook |
| Preference Onboarding | First-login preference selection to personalise content and therapist recommendations |
| Therapist Directory | Browse, filter, and view verified therapist profiles by specialty, rating, and availability |
| Matching Questionnaire | Questionnaire-driven therapist recommendations |
| Appointment Booking | Real-time calendar-based booking with eSewa payment |
| WebRTC Consultation | Live video and audio session within the application |
| Mood Logging | Daily EMA-based mood log with score, label, and note |
| PHQ-9 / GAD-7 | Clinical questionnaires with historical score tracking |
| Wellness Content Hub | Articles, audio tracks, videos, and shorts delivered via Cloudinary |
| Wellness Games | Breathing exercise, trivia, affirmation builder, role-play scenarios |
| Gamification | Achievement badges and session completion tracking |
| Offline Mode | SQLite persistence and auto-sync for mood logging and cached content |
| FCM Notifications | Appointment reminders, booking confirmations, system alerts |
| Therapist Dashboard | Appointment management, patient records, earnings, content publishing |
| Admin Dashboard | Therapist verification, content moderation, user management, analytics |
| Subscription Management | plan-based access tiers with eSewa payment |

---

## 2.3 Similar Projects

### 2.3.1 BetterHelp

BetterHelp is the world's largest online therapy platform, connecting over 5 million users with licensed therapists through asynchronous messaging and live sessions (BusinessWire, 2025). Its primary strength is the breadth of its therapist network and its evidence base for telehealth outcomes. Its critical limitations in the Nepali context are price (US$60 to US$100 per week), exclusive reliance on credit card payment, English-only interface, and no offline functionality of any kind (BetterHelp, 2024).

### 2.3.2 Headspace

Headspace is a meditation and mindfulness application with over 70 million users globally (Headspace, 2024). It provides guided meditation, sleep content, and breathing exercises. Its strengths are content quality and production value. It is not a therapy platform and provides no professional therapist access, no mood tracking, and no clinical questionnaires. At approximately US$70 per year with credit card payment only, it is effectively inaccessible to most Nepali users.

### 2.3.3 Wysa

Wysa is an AI mental health chatbot with particular adoption in South Asia. It offers CBT-based conversational exercises and claims to detect 82% of users in crisis through conversational analysis (Wysa, 2024). Its advantages over Headspace and BetterHelp include lower cost, South Asian market awareness, and AI-driven risk detection. Its limitations are the absence of licensed therapist access as a core feature, no offline capability, no validated clinical questionnaires, and no Nepali language support.

---

## 2.4 Comparisons and Critical Evaluation

### 2.4.1 Feature Comparison Table

| Feature | BetterHelp | Headspace | Wysa | Resilio |
|---|---|---|---|---|
| Licensed Therapist Access | Yes | No | Paid add-on | Yes |
| Mood Tracking | No | No | Basic | Comprehensive EMA |
| PHQ-9 / GAD-7 Questionnaires | No | No | No | Yes |
| Offline Functionality | None | None | None | Full offline mode |
| Live Video Consultation | Yes | No | No | Yes |
| Gamification and Achievements | No | No | No | Yes |
| Local Payment (eSewa) | No | No | No | Yes |
| Annual Cost (USD) | 3,120 to 5,200 | 70 | Free/add-on | 20 to 30 |
| Nepali Language Support | No | No | No | Yes (in progress) |
| Cultural Adaptation | No | No | Partial | Yes |
| Therapist Views Patient Mood | No | No | No | Yes |
| Offline-First Architecture | No | No | No | Yes |

### 2.4.2 Critical Analysis and Justification

The comparison reveals four structural failures shared across all three existing platforms.

**Fragmentation:** BetterHelp connects therapists but lacks self-help tools. Headspace provides meditation but no professional access. Wysa offers AI support but fragments the therapy connection. Bakker et al. (2016) identified fragmentation as the primary driver of abandonment in digital mental health tools, with 74% of users abandoning applications within two weeks. Resilio is designed as a unified care environment where every module contributes to a continuous record accessible to both user and therapist.

**Economic inaccessibility:** BetterHelp's weekly cost can exceed a Nepali family's monthly income. Every platform reviewed requires an international credit card, excluded from Nepal's predominantly cash and wallet-based economy. eSewa integration is not a convenience feature; it is the mechanism that makes paid digital health services actually accessible.

**Absence of offline capability:** A platform that ceases to function without internet access cannot meaningfully serve users in rural Nepal, where connectivity is unreliable. This is not a minor missing feature; it is a structural mismatch between platform design and user reality.

**Cultural mismatch:** Stigma in Nepal is shaped by deeply embedded spiritual and social frameworks (Kohrt and Harper, 2008). Content developed for English-speaking Western users cannot substitute for Nepali-language content developed by Nepali professionals within this context.

Torous et al. (2019), reviewing over 1,000 mental health applications, found that only 5% offered therapist integration, only 12% had any offline functionality, and only 3% contained evidence-based therapeutic content. Resilio addresses all three gaps simultaneously, which no existing platform in the Nepali market does.

---

## References

Bakker, D., Kazantzis, N., Rickwood, D. and Rickard, N. (2016) 'Mental health smartphone apps: Review and evidence-based recommendations for future developments', *JMIR Mental Health*, 3(1), e7.

BetterHelp (2024) *BetterHelp Platform Quality and Outcomes in 2024*. Available at: https://www.betterhelp.com (Accessed: 15 April 2026).

BusinessWire (2025) *BetterHelp Surpasses 5 Million People Benefiting from Online Therapy Service*. Available at: https://www.businesswire.com (Accessed: 15 April 2026).

Chandrashekar, P. (2018) 'Do mental health mobile apps work', *mHealth*, 4, p. 6.

Headspace (2024) *Headspace: Meditation and Sleep*. Available at: https://www.headspace.com (Accessed: 15 April 2026).

Kohrt, B.A. and Harper, I. (2008) 'Navigating diagnoses: Understanding mind-body relations, mental health, and stigma in Nepal', *Culture, Medicine and Psychiatry*, 32(4), pp. 462-491.

Torous, J., Myrick, K.J., Rauseo-Ricupero, N. and Firth, J. (2019) 'Digital mental health and COVID-19', *JMIR Mental Health*, 7(3), e18848.

Wysa (2024) *Wysa Clinical Evidence and Research*. Available at: https://www.wysa.com (Accessed: 15 April 2026).
