# Week 4 — Risk Register, WBS, Environment Setup
**Phase:** Inception | **Dates:** 23–30 November 2024

---

## Tasks Completed

| Task | Output |
|---|---|
| Risk register finalised | 21 risks across technical, schedule, domain, legal categories |
| Work Breakdown Structure completed | Five top-level areas; full decomposition |
| Flutter project structure established | Feature-first Clean Architecture; placeholder modules |
| Node.js backend scaffolded | Express app; controllers/services/repositories structure |
| Supabase project provisioned | Database instance; environment variables set |
| SuperTokens managed service configured | Passwordless recipe; Google + Facebook providers enabled |
| GitHub repository structured | Branching strategy defined; .gitignore configured |
| Inception phase review completed | All planned artefacts verified complete |

## Files to Place Here

- [ ] Risk register document (PDF or screenshot)
- [ ] Work Breakdown Structure diagram
- [ ] Flutter project structure screenshot
- [ ] GitHub repository screenshot (initial commit)
- [ ] Supabase project dashboard screenshot

## Risk Register Highlights

| Risk | Priority | Mitigation |
|---|---|---|
| WebRTC NAT traversal fails on mobile | HIGH (16) | STUN first; TURN server as fallback |
| eSewa SDK incompatibility | HIGH (12) | Prototype in Elaboration; pin version |
| PHQ-9 scoring implemented incorrectly | HIGH (10) | Dr. Singh review; cross-reference Kroenke (2001) |
| Construction iterations compound delays | HIGH (12) | Parallelise admin + therapist in Iteration 5 |

Full risk register: `Supporting Documents/10_Risk_Register.md`

## Flutter Project Structure Established

```
lib/
├── core/           ← shared config, DI, routing, theme, network
├── features/
│   ├── customer/   ← all customer-facing modules
│   ├── therapist/  ← all therapist-facing modules
│   ├── admin/      ← admin dashboard module
│   └── shared/     ← shared UI components
└── main.dart
```

## Node.js Backend Structure Established

```
Backend/src/
├── routes/         ← Express route definitions
├── controllers/    ← Request/response handling
├── domain/services/← Business logic (use cases)
├── data/repositories/ ← Supabase database queries
├── middlewares/    ← Auth + proto middleware
└── config/         ← Environment, Supabase client
```
