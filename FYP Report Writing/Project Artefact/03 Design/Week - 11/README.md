# Week 11 — Iteration 1: Authentication and Onboarding
**Phase:** Construction | **Dates:** 1–7 January 2025

---

## Features Built

| Feature | Module | Status |
|---|---|---|
| SuperTokens OTP 3-step flow | `customer/auth/` | Done |
| Google Sign-In | `customer/auth/` | Done |
| Facebook Sign-In | `customer/auth/` | Done |
| Role-based GoRouter navigation guards | `core/routing/` | Done |
| User onboarding (5-question preference flow) | `customer/onboarding/` | Done |
| GetIt + Injectable DI wiring | `core/di/` | Done |
| Splash screen with role redirect | `customer/splash/` | Done |

## Files to Place Here

- [ ] Screenshot — OTP email entry screen
- [ ] Screenshot — OTP verification screen
- [ ] Screenshot — Google Sign-In flow
- [ ] Screenshot — Onboarding preference screens (×5 questions)
- [ ] Screenshot — Role-based redirect to correct dashboard
- [ ] Code snippet — GoRouter role guard

## Key Code: GoRouter Role Guard

```dart
// core/routing/app_router.dart
redirect: (context, state) {
  final user = context.read<AuthBloc>().state.user;
  if (user == null) return '/login';
  switch (user.role) {
    case 'admin': return '/admin/dashboard';
    case 'therapist': return '/therapist/dashboard';
    default: return '/customer/home';
  }
},
```

## Test Cases Passed

- TC-U001 — Valid OTP registration
- TC-U002 — Duplicate email rejected
- TC-U003 — Google Sign-In new user
- TC-U004 — Role assignment correct

## Learning Resources

- Reso Coder — Flutter BLoC tutorial series (BLoC + Clean Architecture)
- Reso Coder — "Flutter TDD Clean Architecture" (feature-first structure)
- GoRouter docs: https://pub.dev/packages/go_router
- Injectable docs: https://pub.dev/packages/injectable
