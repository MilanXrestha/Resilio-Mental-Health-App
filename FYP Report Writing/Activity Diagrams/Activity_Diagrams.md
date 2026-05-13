# RESILIO — CORE FEATURE ACTIVITY DIAGRAMS (UML 2.x Notation)

## UML ACTIVITY DIAGRAM NOTATION USED

| Symbol | Mermaid Syntax | Meaning |
|--------|----------------|---------|
| ● Filled circle | `S((● ))` | **Initial Node** — start of activity |
| ◎ Circle in circle | `E(((●)))` | **Activity Final Node** — end of activity |
| Rounded rectangle | `A[Action Name]` | **Action / Activity** |
| Diamond | `D{Question?}` | **Decision / Merge Node** |
| Guard on arrow | `--> \|[condition]\|` | **Guard Condition** (square brackets = UML standard) |
| Horizontal bar | Represented with `:::fork` class | **Fork / Join** (parallel) |

> **Draw.io Import:** Extras → Edit Diagram → change dropdown to **Mermaid** → paste → OK

---

## ACTIVITY DIAGRAM 1: USER AUTHENTICATION

```mermaid
flowchart TD
    S(("●")) --> A[Launch Application]
    A --> B[Display Login Screen]
    B --> C{Select Login Method}

    C --> |[OTP Email]| D[Enter Email Address]
    D --> E[Request OTP Code]
    E --> F[Enter 6-Digit OTP]
    F --> G{OTP Valid?}
    G --> |[Invalid]| F
    G --> |[Valid]| H[Create Session Token]

    C --> |[Google OAuth]| I[Redirect to Google Sign-In]
    I --> J[Receive Firebase ID Token]
    J --> H

    C --> |[Facebook OAuth]| K[Redirect to Facebook Sign-In]
    K --> J

    H --> L{User Account Exists?}
    L --> |[No]| M[Create New User Record]
    M --> N[Assign Role = customer]
    N --> O{Preferences Completed?}
    L --> |[Yes]| O

    O --> |[No]| P[Show Onboarding Screen]
    P --> Q[Select Mental Health Goals]
    Q --> R[Save User Preferences]
    R --> S2{Check User Role}
    O --> |[Yes]| S2

    S2 --> |[customer]| T[Navigate to Customer Home]
    S2 --> |[therapist]| U[Navigate to Therapist Dashboard]
    S2 --> |[admin]| V[Navigate to Admin Portal]

    T & U & V --> E2(((●)))
```

---

## ACTIVITY DIAGRAM 2: BOOK APPOINTMENT

```mermaid
flowchart TD
    S(("●")) --> A[Open Therapist Directory]
    A --> B[Browse Therapist List]
    B --> C{Apply Filters?}
    C --> |[Yes]| D[Filter by Specialty / Language / Fee]
    D --> E[View Filtered Results]
    C --> |[No]| E

    E --> F[Select Therapist Profile]
    F --> G{PHQ-9 Completed?}
    G --> |[No]| H[Complete Matching Questionnaire]
    H --> I[Submit PHQ-9 / GAD-7 Answers]
    I --> J[View Available Time Slots]
    G --> |[Yes]| J

    J --> K[Select Date and Time Slot]
    K --> L[Choose Session Type: Video or Audio]
    L --> M[Review Booking Summary]
    M --> N{Confirm Booking?}
    N --> |[Cancel]| B
    N --> |[Confirm]| O[Create Pending Appointment]

    O --> P[Redirect to eSewa Payment]
    P --> Q[Customer Completes Payment]
    Q --> R{Payment Successful?}
    R --> |[Failed]| S2{Retry?}
    S2 --> |[Yes]| P
    S2 --> |[No]| T[Cancel Pending Appointment]
    T --> E2(((●)))

    R --> |[Success]| U[Verify Payment Server-Side]
    U --> V[Update Appointment Status = Confirmed]
    V --> W[Send FCM Notification to Therapist]
    W --> X[Send FCM Confirmation to Customer]
    X --> Y[Display Booking Confirmed Screen]
    Y --> E2(((●)))
```

---

## ACTIVITY DIAGRAM 3: VIDEO CONSULTATION SESSION

```mermaid
flowchart TD
    S(("●")) --> A[Receive Session Reminder Notification]
    A --> B[Tap Join Session]
    B --> C[Verify Session Token with API]
    C --> D{Token Valid?}
    D --> |[Invalid]| E[Redirect to Login]
    E --> B
    D --> |[Valid]| F[Generate WebRTC Room ID]

    F --> G[Customer Joins Room]
    G --> H[Therapist Joins Room]
    H --> I[Therapist Views Patient Mood and PHQ Scores]
    I --> J[Exchange SDP Offer via Signalling Server]
    J --> K[Exchange SDP Answer via Signalling Server]
    K --> L[Exchange ICE Candidates]
    L --> M{Peer Connection Established?}
    M --> |[No]| N[Retry ICE Negotiation]
    N --> L
    M --> |[Yes]| O[Live Audio and Video Session Active]

    O --> P{Session Ends?}
    P --> |[Network Lost]| Q[Attempt Auto-Reconnect]
    Q --> R{Reconnected?}
    R --> |[Yes]| O
    R --> |[No — Timeout]| S2[End Session]
    P --> |[User Ends Session]| S2

    S2 --> T[Update Appointment Status = Completed]
    T --> U[Record Therapist Earnings]
    U --> V[Send Post-Session Notification to Customer]
    V --> E2(((●)))
```

---

## ACTIVITY DIAGRAM 4: MOOD TRACKING AND PHQ-9 ASSESSMENT

```mermaid
flowchart TD
    S(("●")) --> A[Open Mood Tracker Section]
    A --> B{Network Available?}
    B --> |[Online]| C[Fetch Mood History from Supabase]
    B --> |[Offline]| D[Load Mood History from SQLite Cache]
    C --> E[Display 7-Day Mood Chart]
    D --> E

    E --> F{Already Logged Today?}
    F --> |[Yes]| G[Display Today's Entry]
    G --> H{Edit Mood?}
    H --> |[No]| I{PHQ-9 Due?}
    H --> |[Yes]| J[Show Mood Slider 1 to 5]
    F --> |[No]| J

    J --> K[Customer Drags Mood Slider]
    K --> L[Optionally Add Journal Note]
    L --> M{Network Available?}
    M --> |[Online]| N[Save Mood Entry to Supabase]
    M --> |[Offline]| O[Save Entry to SQLite — Pending Sync]
    N --> I
    O --> I

    I --> |[No — Not Due]| P[Show Updated Mood Dashboard]
    I --> |[Yes — Overdue]| Q{Customer Agrees to PHQ-9?}
    Q --> |[No]| P
    Q --> |[Yes]| R[Display PHQ-9 Questions 1 to 9]
    R --> S2[Customer Answers Each Question 0 to 3]
    S2 --> T[Calculate Total PHQ-9 Score]
    T --> U{Score Level?}
    U --> |[Score 0 to 9 — Mild]| V[Show Positive Encouragement]
    U --> |[Score 10 to 19 — Moderate]| W[Suggest Booking a Therapist]
    U --> |[Score 20 and above — Severe]| X[Display Crisis Alert and Helpline Numbers]

    V --> Y[Save Assessment Result to Database]
    W --> Y
    X --> Y
    Y --> P
    P --> E2(((●)))
```

---

## ACTIVITY DIAGRAM 5: BROWSE CONTENT HUB AND PREMIUM GATING

```mermaid
flowchart TD
    S(("●")) --> A[Open Content Hub]
    A --> B[Check Subscription Status]
    B --> C{Active Premium Plan?}
    C --> |[Yes]| D[isPremium = true]
    C --> |[No]| E[isPremium = false]
    D --> F[Load All Content — No Restriction]
    E --> F

    F --> G[Display Category Tabs: Articles, Audio, Video, Quotes]
    G --> H{Search or Filter?}
    H --> |[Yes]| I[Enter Search Term or Select Category]
    I --> J[Fetch Filtered Content Results]
    H --> |[No]| J
    J --> K[Display Content Cards]

    K --> L[Tap on Content Item]
    L --> M{Is Content Premium?}
    M --> |[No — Free]| N[Open Content Viewer]
    M --> |[Yes]| O{isPremium?}
    O --> |[Yes]| N
    O --> |[No]| P[Display Paywall Screen]
    P --> Q{Upgrade to Premium?}
    Q --> |[No]| K
    Q --> |[Yes]| R[Navigate to Subscription Flow]
    R --> E2(((●)))

    N --> S2{Content Type}
    S2 --> |[Article]| T[Show Markdown Reader]
    S2 --> |[Audio]| U[Launch Audio Player]
    S2 --> |[Video]| V[Launch Video Player]
    S2 --> |[Quote / Tip]| W[Show Full-Screen Card]

    T & U & V & W --> X{Save to Favourites?}
    X --> |[Yes]| Y[Save Content to Favourites List]
    X --> |[No]| Z{Continue Browsing?}
    Y --> Z
    Z --> |[Yes]| K
    Z --> |[No]| E2(((●)))
```

---

## ACTIVITY DIAGRAM 6: SUBSCRIPTION PURCHASE

```mermaid
flowchart TD
    S(("●")) --> A[Open Subscription Screen]
    A --> B[Fetch Available Plans from API]
    B --> C[Display Plan Cards: Monthly and Annual]
    C --> D{Select a Plan}
    D --> |[Cancel]| E2a(((●)))
    D --> |[Monthly Plan]| E[Initiate Payment — Monthly]
    D --> |[Annual Plan]| F[Initiate Payment — Annual]

    E --> G[Create Pending Transaction in Database]
    F --> G

    G --> H[Redirect to eSewa Checkout Page]
    H --> I[Customer Enters eSewa Credentials]
    I --> J[Customer Confirms Payment Amount]
    J --> K{eSewa Payment Result}

    K --> |[Failed]| L{Retry?}
    L --> |[Yes]| H
    L --> |[No]| M[Delete Pending Transaction]
    M --> E2b(((●)))

    K --> |[Cancelled]| M

    K --> |[Success]| N[eSewa Sends Callback to Backend]
    N --> O[Backend Verifies Signature with eSewa]
    O --> P{Signature Valid?}
    P --> |[Invalid]| Q[Reject and Log Suspicious Transaction]
    Q --> E2b(((●)))

    P --> |[Valid]| R[Update Transaction Status = Completed]
    R --> S2[Create Active Subscription Record]
    S2 --> T[Send FCM Notification: Premium Activated]
    T --> U[Set isPremium = true in App]
    U --> V[Unlock All Premium Content]
    V --> W[Display Welcome to Premium Screen]
    W --> E2c(((●)))
```
