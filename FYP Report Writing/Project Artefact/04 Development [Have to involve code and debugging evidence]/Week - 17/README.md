# Week 17 — Iteration 6 (cont.): Content Hub and Subscription Gating
**Phase:** Construction | **Dates:** 19–25 February 2025

---

## Features Built

| Feature | Layer | Status |
|---|---|---|
| Content CRUD API (articles, audio, video, images) | `audio/video/images-routes.js` | Done |
| Content category API | `category-routes.js` | Done |
| Flutter: Content hub home screen (category tabs) | `customer/explore/` | Done |
| Flutter: Article reader | `customer/explore/` | Done |
| Flutter: Audio player (`just_audio`) | `customer/audio/` | Done |
| Flutter: Video player (`better_player_plus`) | `customer/video/` | Done |
| LRU content cache (`flutter_cache_manager`) | `core/` | Done |
| Premium content gating (subscription check) | Backend + Flutter | Done |
| Therapist content publishing screen | `therapist/content/` | Done |
| Admin content moderation queue | `admin/dashboard/` | Done |
| Content approval workflow | `admin-routes.js` | Done |
| Quotes and tips APIs | `quote-routes.js`, `tips-routes.js` | Done |

## Files to Place Here

- [ ] Screenshot — Content hub main screen (category tabs)
- [ ] Screenshot — Article reader
- [ ] Screenshot — Audio player
- [ ] Screenshot — Video player
- [ ] Screenshot — Premium content paywall (free user blocked)
- [ ] Screenshot — Premium content unlocked (after subscription)
- [ ] Screenshot — Therapist content publishing screen
- [ ] Screenshot — Admin content moderation queue

## Content Types Implemented

| Type | Flutter Package | Backend Table |
|---|---|---|
| Long-form video | `better_player_plus` | `video_tracks` |
| Short video / Reels | `better_player_plus` | `video_tracks` (short flag) |
| Audio guided session | `just_audio` | `audio_tracks` |
| Article | Custom rich text renderer | `content` |
| Images / Infographics | `cached_network_image` | `images` |
| Daily quotes | Text widget | `quotes` |
| Wellness tips | Card widget | `tips` |

## Subscription Tiers

| Tier | Access Level |
|---|---|
| Free | Non-premium content only |
| Silver | All content + limited sessions |
| Gold | All content + unlimited sessions |

## Test Cases Passed

- TC-S007 — Content publication through admin approval
- TC-S012 — Free-tier content restriction
- TC-S013 — Premium content unlocked after upgrade
- TC-S015 — Audio track playback
