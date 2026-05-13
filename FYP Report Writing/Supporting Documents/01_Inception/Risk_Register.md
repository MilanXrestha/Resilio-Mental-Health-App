# RISK REGISTER

Identified during the Inception and Elaboration phases. Risks were reassessed at the start of each Construction iteration. Likelihood and Impact scored 1 (Low) to 5 (High).

---

## RISK SCORING KEY

| Score | Likelihood | Impact |
|---|---|---|
| 1 | Very unlikely | Negligible — no effect on delivery |
| 2 | Unlikely | Minor — small rework only |
| 3 | Possible | Moderate — delays one iteration |
| 4 | Likely | Significant — delays multiple iterations |
| 5 | Very likely | Critical — threatens project delivery |

**Risk Priority = Likelihood × Impact**

---

## TECHNICAL RISKS

| ID | Risk | Likelihood | Impact | Priority | Mitigation Strategy | Outcome |
|---|---|---|---|---|---|---|
| R-T01 | WebRTC peer connection fails on mobile networks (NAT traversal) | 4 | 4 | 16 | Prototype in Elaboration; implement STUN first, add TURN fallback if needed | STUN insufficient on some mobile networks — TURN server deployed; resolved in Iteration 5 |
| R-T02 | SuperTokens OTP emails go to spam / not delivered | 3 | 4 | 12 | Test with multiple email providers; configure SPF/DKIM on sending domain | Managed SuperTokens service handled deliverability; no significant issue |
| R-T03 | eSewa SDK version incompatibility with Flutter | 3 | 4 | 12 | Prototype payment flow in Elaboration; pin SDK version in pubspec.yaml | Minor SDK issue resolved; version pinned at tested version |
| R-T04 | Supabase RLS policies too restrictive (blocking legitimate queries) | 3 | 3 | 9 | Test each policy thoroughly in Supabase dashboard before connecting Flutter client | Two policies required adjustment during Iteration 3 |
| R-T05 | Flutter BLoC state management complexity causes UI bugs | 3 | 3 | 9 | Use Cubit for simpler screens; full BLoC only where event complexity justifies it | Managed by using Cubit for most screens; no significant issues |
| R-T06 | Cloudinary upload fails on slow connections | 2 | 3 | 6 | Add retry logic and upload progress indicator | Implemented retry; no user-reported failures |
| R-T07 | Offline-to-online sync creates data conflicts | 3 | 3 | 9 | Timestamp-based conflict resolution; offline entries flagged with `synced_from_offline` | Implemented timestamp strategy; tested with TC-U029 |
| R-T08 | FCM push notifications not delivered on all Android versions | 3 | 2 | 6 | Test on Android 8 through 14; handle notification permission request (Android 13+) | Runtime permission request added for Android 13+ |
| R-T09 | WebRTC audio/video quality poor on 3G | 3 | 3 | 9 | Implement adaptive bitrate; document minimum recommended connection | Adaptive quality implemented; 3G sessions functional but lower quality |
| R-T10 | Code generation (Freezed/json_serializable) causes build failures | 2 | 3 | 6 | Pin build_runner and freezed versions; always run `--delete-conflicting-outputs` | Occasional build conflicts; resolved with flag |

---

## SCHEDULE RISKS

| ID | Risk | Likelihood | Impact | Priority | Mitigation Strategy | Outcome |
|---|---|---|---|---|---|---|
| R-S01 | WebRTC integration takes longer than one iteration | 4 | 3 | 12 | Allocate Iteration 5 to WebRTC; overflow into Transition if needed | Overflowed by approximately one week into Transition; no critical impact |
| R-S02 | Client availability for UAT is limited | 3 | 3 | 9 | Schedule UAT sessions weeks in advance; provide async feedback option | Both clients participated on schedule |
| R-S03 | Pre-survey takes longer to reach 100+ responses than expected | 2 | 3 | 6 | Distribute across multiple channels simultaneously from day one | 166 responses in 2 weeks; no delay |
| R-S04 | Construction iterations run sequentially — any delay compounds | 3 | 4 | 12 | Parallelise admin + therapist dashboard development in Iteration 5 | Parallelisation executed; saved approximately one week |
| R-S05 | Report writing underestimated alongside code development | 3 | 3 | 9 | Allocate dedicated report days each week; write chapters concurrently with development | Managed with weekly writing targets |

---

## DOMAIN / CLINICAL RISKS

| ID | Risk | Likelihood | Impact | Priority | Mitigation Strategy | Outcome |
|---|---|---|---|---|---|---|
| R-D01 | PHQ-9 or GAD-7 scoring implemented incorrectly | 2 | 5 | 10 | Cross-reference Kroenke (2001) and Spitzer (2006) scoring tables; Dr. Singh review | Dr. Singh confirmed correct implementation in UAT |
| R-D02 | Crisis threshold set at wrong PHQ-9 score | 2 | 5 | 10 | Clinically validate threshold with Dr. Singh; use published severe range (≥20) | Confirmed correct at ≥20 |
| R-D03 | Nepal Mental Health Helpline number is incorrect or outdated | 2 | 4 | 8 | Verify 1660-01-11111 number against current government sources | Verified as current |
| R-D04 | Therapist verification process is insufficient — unqualified person passes | 2 | 5 | 10 | Require document uploads; admin manual review required for approval | Admin review workflow implemented |

---

## LEGAL / COMPLIANCE RISKS

| ID | Risk | Likelihood | Impact | Priority | Mitigation Strategy | Outcome |
|---|---|---|---|---|---|---|
| R-L01 | Storing health data outside Nepal violates emerging data residency requirements | 2 | 3 | 6 | Disclose international storage in privacy notice; monitor legislative developments | Disclosed in privacy notice; no current legal prohibition |
| R-L02 | eSewa payment integration violates financial regulations | 1 | 5 | 5 | Use official eSewa SDK; no card data stored in Resilio | Official SDK used throughout |
| R-L03 | SuperTokens session tokens stored insecurely on device | 2 | 4 | 8 | Use SuperTokens recommended secure storage; do not write tokens to plain storage | SuperTokens SDK manages secure storage natively |

---

## RISK REGISTER SUMMARY

| Priority Level | Count | Resolved | Outstanding |
|---|---|---|---|
| Critical (20–25) | 0 | — | — |
| High (12–19) | 5 | 5 | 0 |
| Medium (6–11) | 13 | 13 | 0 |
| Low (1–5) | 3 | 3 | 0 |

All identified risks were resolved or mitigated before final submission. No risks materialised into project-threatening incidents. The highest-impact technical risk (R-T01 — WebRTC NAT traversal) required a TURN server deployment that was not in the original plan but was resolved within the available schedule buffer.
