# Week 14 — Iteration 4: Appointment Booking and eSewa Payment
**Phase:** Construction | **Dates:** 22–28 January 2025

---

## Features Built

| Feature | Layer | Status |
|---|---|---|
| Availability slot management API | `therapist-portal-routes.js` | Done |
| Appointment creation API | `appointment-routes.js` | Done |
| Double-booking prevention | DB constraint + backend check | Done |
| eSewa payment initiation | `esewa_flutter_sdk` (local path) | Done |
| Payment verification endpoint | `payment-routes.js` | Done |
| HMAC tamper detection | `payment-controller.js` | Done |
| Transaction recording | `transactions` table | Done |
| FCM notification on booking confirmation | `firebase-admin` | Done |
| Flutter: Appointment booking calendar | `customer/booking/` (`table_calendar`) | Done |
| Flutter: Slot picker and confirm screen | `customer/booking/` | Done |

## Files to Place Here

- [ ] Screenshot — Appointment booking calendar
- [ ] Screenshot — Available slot selection
- [ ] Screenshot — eSewa payment screen (test environment)
- [ ] Screenshot — Booking confirmation screen
- [ ] Screenshot — Push notification received (both patient and therapist)
- [ ] Postman screenshot — tampered amount callback rejected (403)

## eSewa Payment Flow

```
1. Patient selects slot → POST /appointments → pending appointment created
2. Flutter: EsewaFlutterSdk.initPayment() launched
3. eSewa app opens → patient completes payment
4. onPaymentSuccess callback fires with { transactionId, totalAmount }
5. Flutter: POST /payment/verify { appointmentId, transactionId, totalAmount }
6. Backend: HMAC verification of signature
7. If valid → appointment status = 'confirmed'; payment_status = 'paid'
8. FCM notification sent to both patient and therapist
```

## Note on eSewa SDK

The `esewa_flutter_sdk` is a **local path dependency** in `pubspec.yaml`:
```yaml
esewa_flutter_sdk:
  path: ./esewa_flutter_sdk
```
This is because the pub.dev version was outdated. The local copy is the working version integrated directly into the project.

## Bugs Fixed This Week

| Bug | Description | Fix |
|---|---|---|
| BUG-001 | Double-booking race condition — not atomic | Added DB-level unique constraint |
| BUG-002 | Tampered eSewa callback accepted (string comparison) | Changed to parseFloat with numeric comparison |

## Test Cases Passed

- TC-U005 — Appointment created with valid data
- TC-U006 — Appointment blocked for unverified therapist
- TC-U007 — Double-booking prevented
- TC-U014 — eSewa success callback confirms appointment
- TC-U015 — Failed callback leaves appointment pending
- TC-U016 — Tampered callback rejected
- TC-S003 — End-to-end booking with eSewa payment
