# Week 12 — Iteration 2: Database Layer and API Structure
**Phase:** Construction | **Dates:** 8–14 January 2025

---

## Features Built

| Feature | Layer | Status |
|---|---|---|
| All 19 SQL migration files run on Supabase | Database | Done |
| RLS policies deployed on all tables | Database | Done |
| Node.js API folder structure (routes/controllers/services/repositories) | Backend | Done |
| SuperTokens `verifySession()` middleware | Backend middleware | Done |
| `requireRole()` RBAC middleware | Backend middleware | Done |
| Base Supabase repository classes | `Backend/src/data/repositories/` | Done |
| User repository and use cases | `user-repository.js`, `user-usecases.js` | Done |

## Files to Place Here

- [ ] Supabase dashboard screenshot (tables list)
- [ ] RLS policy screenshot (example from users or appointments table)
- [ ] Postman screenshot — auth middleware rejecting unauthenticated request
- [ ] Postman screenshot — RBAC middleware rejecting wrong role

## Backend Architecture Pattern

```
Request
  → Route (routes/*.js)
  → Middleware (verifySession → requireRole)
  → Controller (controllers/*.js)
  → Use Case (domain/services/*.js)
  → Repository (data/repositories/*.js)
  → Supabase (PostgreSQL)
```

## RLS Cross-User Test

**Test:** User A queries mood entries with User B's user_id
**Expected:** Empty result (RLS blocks access)
**Result:** Empty result ✓ (TC-U027 passed)

## Test Cases Passed

- TC-U027 — RLS prevents cross-user mood access
- TC-U028 — Therapist cannot access other therapist's patients

## Debugging Evidence (document here)

- [ ] Screenshot of Postman 403 response when wrong role used
- [ ] Screenshot of Supabase query returning empty set when RLS active
