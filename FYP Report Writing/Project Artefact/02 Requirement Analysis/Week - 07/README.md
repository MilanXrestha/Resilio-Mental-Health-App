# Week 7 — Activity Diagrams, DFDs, Wireframes, SuperTokens Prototype
**Phase:** Elaboration | **Dates:** 8–14 December 2024

---

## Tasks Completed

| Task | Output |
|---|---|
| Activity diagram — Appointment booking and payment | draw.io export |
| Activity diagram — WebRTC video consultation | draw.io export |
| Activity diagram — Therapist content publication | draw.io export |
| Sequence diagram — SuperTokens OTP login | Mermaid code |
| Sequence diagram — Appointment booking | Mermaid code |
| Sequence diagram — WebRTC session | Mermaid code |
| Level 0 DFD (context diagram) | draw.io export |
| Level 1 DFDs — Customer flows | draw.io export |
| Level 1 DFDs — Therapist + Admin flows | draw.io export |
| Wireframes begun in Figma | Onboarding, auth, home, therapist directory screens |
| SuperTokens OTP prototype built | 3-step flow: createCode → consumeCode → /complete |
| Google Sign-In prototype built | ThirdParty provider via SuperTokens |

## Files to Place Here

- [ ] Activity diagrams (×3) — PNG exports
- [ ] Sequence diagrams (×3) — PNG from Mermaid or draw.io
- [ ] DFD Level 0 and Level 1 — PNG exports
- [ ] Wireframe screenshots (Figma export)
- [ ] SuperTokens prototype screenshot / screen recording

## SuperTokens OTP Flow — Implemented This Week

```
Step 1 — POST /auth/signinup/code
  Body: { "email": "user@example.com" }
  Response: { preAuthSessionId, deviceId }

Step 2 — POST /auth/signinup/code/consume
  Body: { preAuthSessionId, deviceId, userInputCode }
  Response: st-access-token in header

Step 3 — POST /auth/passwordless/complete (custom endpoint)
  Header: Authorization: Bearer <token>
  Body: { "email": "user@example.com" }
  Response: { user: { id, email, role }, isNewUser: true }
```

Note: `supertokens_flutter` is overridden to the git master branch in `pubspec.yaml` because the pub.dev version did not support the custom FDI implementation required.

## Learning Resources Used This Week

- Reso Coder — Flutter BLoC tutorial series (architecture setup)
- SuperTokens official docs — Passwordless recipe: https://supertokens.com/docs/passwordless/introduction
- SuperTokens GitHub examples — Node.js backend integration
