# Week 13 — Iteration 3: Therapist Directory and Admin Verification
**Phase:** Construction | **Dates:** 15–21 January 2025

---

## Features Built

| Feature | Layer | Status |
|---|---|---|
| Therapist profile creation API | `therapist-portal-routes.js` | Done |
| Therapist public directory API (with filters) | `therapist-routes.js` | Done |
| Admin verification queue API | `admin-routes.js` | Done |
| Admin reject therapist API | `admin-routes.js` | Done |
| Flutter: Therapist directory screen (filterable cards) | `customer/therapist/` | Done |
| Flutter: Therapist profile page | `customer/therapist/` | Done |
| Flutter: Admin therapist verification screen | `admin/dashboard/` | Done |
| Unverified therapist excluded from public listing | RLS + backend filter | Done |

## Files to Place Here

- [ ] Screenshot — Therapist directory screen with filter applied
- [ ] Screenshot — Therapist profile page
- [ ] Screenshot — Admin verification queue
- [ ] Screenshot — Postman: unverified therapist excluded from GET /therapists
- [ ] Code snippet — is_verified filter in therapist repository

## Key Logic: Unverified Therapist Exclusion

RLS policy on `therapist_profiles`:
```sql
-- Public SELECT: only verified therapists visible
CREATE POLICY "Public can view verified therapists"
ON therapist_profiles FOR SELECT
USING (is_verified = true);

-- Admin can see all (including unverified)
CREATE POLICY "Admin sees all therapists"
ON therapist_profiles FOR SELECT
USING (auth.jwt() ->> 'role' = 'admin');
```

## Test Cases Passed

- TC-U023 — Therapist profile links to user record
- TC-U024 — Unverified therapist excluded from public listing
- TC-U025 — Admin verification sets is_verified to true
- TC-S008 — Admin rejection prevents directory listing

## Debugging Evidence

- [ ] Screenshot of therapist excluded when is_verified = false (Postman)
- [ ] Screenshot of therapist appearing after admin approval
