# Week 15 — Iteration 5: WebRTC Consultation and Admin Dashboard
**Phase:** Construction | **Dates:** 5–11 February 2025

---

## Features Built

| Feature | Layer | Status |
|---|---|---|
| Socket.IO signalling server deployed | Backend (separate host) | Done |
| flutter_webrtc peer connection | `customer/main/` | Done |
| TURN server deployed (Coturn) | Cloud VM | Done — R-T01 resolved |
| Patient consultation screen (video + controls) | `customer/main/` | Done |
| Therapist consultation view (video + patient data panel) | `therapist/appointments/` | Done |
| Patient mood chart in therapist consultation panel | `therapist/appointments/` | Done |
| Admin analytics dashboard | `admin/dashboard/` | Done |
| Admin user management screen | `admin/dashboard/` | Done |

## Files to Place Here

- [ ] Screenshot — WebRTC video call active (both ends)
- [ ] Screenshot — Therapist consultation panel showing patient mood data
- [ ] Screenshot — Admin analytics dashboard
- [ ] Screenshot — TURN server debug log (proving relay worked on 4G)
- [ ] Code snippet — RTCPeerConnection initialisation with STUN + TURN

## Code: RTCPeerConnection with STUN + TURN

```dart
// lib/features/customer/main/.../webrtc_service.dart
final Map<String, dynamic> _iceServers = {
  'iceServers': [
    {'urls': 'stun:stun.l.google.com:19302'},
    {
      'urls': 'turn:[TURN_SERVER_IP]:3478',
      'username': '[TURN_USERNAME]',
      'credential': '[TURN_PASSWORD]',
    },
  ]
};

final RTCPeerConnection peerConnection =
    await createPeerConnection(_iceServers);
```

## BUG-003: WebRTC Failed on 4G

| Attribute | Detail |
|---|---|
| Bug | WebRTC ICE negotiation completes but media stream does not flow on 4G mobile |
| Root cause | Mobile carrier uses symmetric NAT — STUN cannot traverse it |
| Symptoms | `onConnectionState` stayed `'checking'` indefinitely on 4G |
| Fix | Deployed Coturn TURN server; added TURN credentials to ICE server config |
| Test | Ran TC-S004 on 4G after TURN deployment — video call established |

## Files to Place Here (Debugging Evidence)

- [ ] Screenshot of WebRTC `connectionState: 'checking'` (before TURN — showing the bug)
- [ ] Screenshot of WebRTC `connectionState: 'connected'` (after TURN — showing the fix)
- [ ] Screenshot of TURN server access log showing relay used

## Test Cases Passed

- TC-S004 — Live WebRTC video consultation
- TC-S005 — Therapist views patient mood data in consultation
