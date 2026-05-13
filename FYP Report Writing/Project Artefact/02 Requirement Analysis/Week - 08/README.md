# Week 8 — WebRTC Prototype, eSewa Prototype, Figma Mockups
**Phase:** Elaboration | **Dates:** 15–21 December 2024

---

## Tasks Completed

| Task | Output |
|---|---|
| WebRTC peer connection prototype | flutter_webrtc + Socket.IO signalling; two-device video call achieved |
| Socket.IO signalling server built | join-room, offer, answer, ice-candidate, leave-room events |
| STUN/TURN discovery | STUN works on WiFi; symmetric NAT on 4G requires TURN (R-T01 flagged) |
| eSewa Flutter SDK prototype | Test environment payment; success/failure/cancel callbacks tested |
| Figma UI mockups completed | All screens for all three user roles |
| Client prototype review — Ms. Sushana Karki | Screen share of Figma; feedback recorded |
| Client prototype review — Dr. Dibyandra Singh | Screen share of Figma + architecture; feedback recorded |

## Files to Place Here

- [ ] WebRTC prototype demo screenshot or screen recording
- [ ] Socket.IO signalling server code snippet
- [ ] eSewa test payment screenshot
- [ ] Figma mockup exports (PNG per screen category)
- [ ] Client prototype review notes

## WebRTC Signalling — Event Flow Implemented

```
Client 1 (Patient)         Socket.IO Server          Client 2 (Therapist)
    │── join-room ─────────────►│◄── join-room ──────────────│
    │◄── user-joined ───────────│─── user-joined ────────────►│
    │── offer (SDP) ───────────►│─── offer ──────────────────►│
    │                           │◄── answer (SDP) ────────────│
    │◄── answer ────────────────│                             │
    │── ice-candidate ─────────►│─── ice-candidate ──────────►│
    │◄── ice-candidate ─────────│◄── ice-candidate ────────────│
    │◄════════ P2P Audio/Video Stream ═══════════════════════►│
```

Full technical spec: `Supporting Documents/12_WebRTC_Signalling_Architecture.md`

## eSewa SDK — Test Payment Result

- Initiated with `EsewaFlutterSdk.initPayment()` using test credentials
- `onPaymentSuccess` callback fired with transaction reference
- Server-side HMAC verification of callback implemented
- Tamper detection (modified amount) tested and rejected

## Client Prototype Feedback Applied

| Feedback Source | Feedback | Action |
|---|---|---|
| Ms. Karki | Add consultation fee to therapist directory card | Done — fee shown on card |
| Ms. Karki | PHQ-9 text feels too clinical | Softer instruction text written |
| Dr. Singh | Patient data panel needed in consultation view | Panel-based consultation UI designed |
| Dr. Singh | Content must be admin-approved before publishing | Admin approval workflow added to design |

## Learning Resources Used This Week

- Fireship — "WebRTC Crash Course" (full YouTube video)
- Hussein Nasser — "How WebRTC Works" (NAT traversal deep dive)
- The Net Ninja — Socket.IO series (rooms, emit/on, disconnection)
- flutter_webrtc GitHub: https://github.com/flutter-webrtc/flutter-webrtc
