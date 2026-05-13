# Week 18 — Iteration 7: Wellness Games and Achievement System
**Phase:** Construction | **Dates:** 5–11 March 2025

---

## Features Built

| Feature | Layer | Status |
|---|---|---|
| Breathing Bubble game | `customer/games/` | Done |
| Wellness Trivia game | `customer/games/` | Done |
| Affirmation Builder game | `customer/games/` | Done |
| Motivational Story game | `customer/games/` | Done |
| Game session recording API | `games-routes.js` | Done |
| Achievement unlock logic | Backend service | Done |
| Achievement gallery in customer profile | `customer/profile/` | Done |
| Favourites (content + therapist) | `customer/favorites/` + `favorite-routes.js` | Done |
| Text-to-speech for content | `flutter_tts` | Done |

## Files to Place Here

- [ ] Screenshot — Breathing Bubble game (mid-session)
- [ ] Screenshot — Wellness Trivia question card
- [ ] Screenshot — Affirmation Builder screen
- [ ] Screenshot — Achievement gallery (badges displayed)
- [ ] Screenshot — Achievement unlock toast/notification
- [ ] Code snippet — Achievement unlock trigger logic

## Wellness Games — Technical Implementation

### Breathing Bubble Game

```dart
// Animated bubble that expands on inhale, contracts on exhale
// 4-7-8 breathing pattern: inhale 4s, hold 7s, exhale 8s
AnimatedContainer(
  duration: Duration(seconds: _currentPhaseDuration),
  width: _isExpanding ? 250.0 : 120.0,
  height: _isExpanding ? 250.0 : 120.0,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: AppTheme.primaryColor.withOpacity(0.6),
  ),
  child: Center(child: Text(_phaseLabel)),
)
```

### Achievement Seed Data (from `18_games_achievements_seed.sql`)

| Achievement Code | Trigger |
|---|---|
| FIRST_LOG | First mood entry logged |
| FIRST_BREATH | First breathing game completed |
| FIRST_BOOKING | First appointment booked |
| WEEK_STREAK | 7 consecutive days of mood logging |
| FIRST_PHQ | First PHQ-9 completed |
| FIRST_SESSION | First therapy session attended |

## Test Cases Passed

- TC-U019 — Game session recording
- TC-U020 — Achievement unlock (FIRST_BREATH)
- TC-U021 — Favourite content saved
- TC-U022 — Duplicate favourite prevented
- TC-S009 — Wellness game session records score
- TC-S010 — Achievement badge displayed after unlock
