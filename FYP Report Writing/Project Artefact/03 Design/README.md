# PHASE 3: CONSTRUCTION (Iterations 1–4) — DESIGN AND EARLY BUILD
**RUP Phase:** Construction | **Weeks:** 11–14 | **Dates:** January 2025

---

## Phase Objective

Implement the first four development iterations: authentication, database layer, therapist directory + admin verification, and appointment booking with eSewa payment.

---

## Artefacts in This Phase

| Week | Iteration | Features Built |
|---|---|---|
| 11 | Iteration 1 | SuperTokens OTP auth, Google/Facebook Sign-In, role-based routing, user onboarding |
| 12 | Iteration 2 | Database layer live (Supabase), RLS deployed, Node.js API structure, auth middleware |
| 13 | Iteration 3 | Therapist directory + filters, therapist profile, admin verification workflow |
| 14 | Iteration 4 | Appointment booking calendar, eSewa payment integration, payment verification |

---

## Flutter Modules Built This Phase

```
lib/features/customer/
├── auth/          ← OTP flow, Google/Facebook Sign-In, session management
├── onboarding/    ← Preference setup (5-question flow)
├── splash/        ← Splash screen and role-based redirect
├── therapist/     ← Therapist directory and profile view (customer-facing)
├── booking/       ← Appointment slot selection and booking screen
└── appointments/  ← Customer appointment list

lib/features/therapist/
└── profile/       ← Therapist profile creation + submission for verification

lib/features/admin/
└── dashboard/     ← Admin therapist verification queue
```

---

## Backend Routes Built This Phase

```
Backend/src/routes/
├── passwordless-routes.js       ← SuperTokens OTP flow
├── user-routes.js               ← User profile management
├── therapist-routes.js          ← Public therapist directory
├── therapist-portal-routes.js   ← Therapist self-management
├── appointment-routes.js        ← Appointment creation and management
├── payment-routes.js            ← eSewa callback verification
└── admin-routes.js              ← Admin verification actions
```
