# PHASE 2: ELABORATION — REQUIREMENT ANALYSIS AND DESIGN
**RUP Phase:** Elaboration | **Weeks:** 6–10 | **Dates:** December 2024

---

## Phase Objective

Refine requirements through client engagement, produce all system design artefacts, prototype high-risk technical components (SuperTokens, WebRTC, eSewa), and deliver the Interim Report.

---

## Artefacts in This Phase

| Week | Folder | Artefacts |
|---|---|---|
| 6 | `Week - 06/` | SRS, use case diagrams (×3), ERD, system architecture diagram |
| 7 | `Week - 07/` | Activity diagrams, sequence diagrams, DFDs, wireframes, SuperTokens prototype |
| 8 | `Week - 08/` | eSewa prototype, WebRTC prototype, Figma UI mockups (all screens) |
| 9 | `Week - 09/` | Client prototype review notes (Ms. Karki + Dr. Singh), database schema finalised, RLS policies |
| 10 | `Week - 10/` | Interim Report submitted, Elaboration phase review |

---

## Key Outputs

- **SRS** — see Appendix M of FYP report
- **Use Case Diagrams** — see Appendix J.5 and `UML Diagrams (Mermaid Code).md`
- **ERD** — see Appendix J.8 (20 tables)
- **Wireframes** — see Appendix J.10
- **Figma Mockups** — see Appendix J.11
- **Interim Report** — `FYP Report Writing/Interim Report/`

---

## Prototypes Built This Phase

| Prototype | Risk Mitigated | Outcome |
|---|---|---|
| SuperTokens OTP (createCode → consumeCode → complete) | R-T02: OTP deliverability | Successful; managed service handles deliverability |
| Google Sign-In via SuperTokens ThirdParty | — | Successful |
| eSewa Flutter SDK test payment | R-T03: SDK compatibility | Successful; SDK version pinned |
| WebRTC peer connection with Socket.IO signalling | R-T01: NAT traversal | Partial — STUN works on WiFi; TURN needed for 4G |
