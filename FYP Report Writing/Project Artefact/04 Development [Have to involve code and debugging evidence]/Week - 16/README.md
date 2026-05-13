# Week 16 — Iteration 6: Mood Tracking, Questionnaires, Cloudinary
**Phase:** Construction | **Dates:** 12–18 February 2025

---

## Features Built

| Feature | Layer | Status |
|---|---|---|
| Mood entry API (POST + GET history) | `appointment-routes.js` + mood logic | Done |
| PHQ-9 submission API with score calculation | Backend service | Done |
| GAD-7 submission API with score calculation | Backend service | Done |
| Crisis threshold (PHQ-9 ≥ 20) → helpline notice | Backend + Flutter | Done |
| Flutter: Mood logging screen (slider + emoji + note) | `customer/dashboard/` | Done |
| Flutter: Mood history chart (7-day + 30-day) | `fl_chart` | Done |
| Flutter: PHQ-9 questionnaire screen | `customer/dashboard/` | Done |
| Flutter: GAD-7 questionnaire screen | `customer/dashboard/` | Done |
| Flutter: Crisis notice screen | `customer/dashboard/` | Done |
| Cloudinary integration (image + audio + video upload) | `cloudinary_public` | Done |
| In-session appointment messaging | `appointment-messages-controller.js` | Done |

## Files to Place Here

- [ ] Screenshot — Mood logging screen
- [ ] Screenshot — 7-day mood history chart
- [ ] Screenshot — PHQ-9 questionnaire (mid-completion)
- [ ] Screenshot — PHQ-9 result screen (with severity band)
- [ ] Screenshot — Crisis notice (triggered at score ≥ 20)
- [ ] Screenshot — GAD-7 result screen

## Code: PHQ-9 Score Calculation and Crisis Check

```javascript
// Backend/src/domain/services/ (questionnaire use case)
function calculatePHQ9(answers) {
  if (answers.length !== 9) throw new Error('PHQ-9 requires exactly 9 answers');
  const invalid = answers.some(a => a < 0 || a > 3 || !Number.isInteger(a));
  if (invalid) throw new Error('All answers must be integers 0–3');

  const totalScore = answers.reduce((sum, a) => sum + a, 0);
  let severityBand;
  if (totalScore <= 4) severityBand = 'Minimal';
  else if (totalScore <= 9) severityBand = 'Mild';
  else if (totalScore <= 14) severityBand = 'Moderate';
  else if (totalScore <= 19) severityBand = 'Moderately Severe';
  else severityBand = 'Severe';

  return {
    totalScore,
    severityBand,
    crisisAlert: totalScore >= 20,  // Triggers Nepal Mental Health Helpline notice
  };
}
```

## Evidence: Crisis Protocol

The Nepal Mental Health Helpline number displayed when `crisisAlert: true`:
**1660-01-11111**

Validated by Dr. Dibyandra Singh as clinically correct threshold (PHQ-9 ≥ 20 = severe range).

## Test Cases Passed

- TC-U008 to TC-U010 — Mood score validation
- TC-U011 to TC-U013 — PHQ-9 and GAD-7 calculation
- TC-S006 — Crisis notice at PHQ-9 ≥ 20
- TC-S014 — Mood chart renders correctly
