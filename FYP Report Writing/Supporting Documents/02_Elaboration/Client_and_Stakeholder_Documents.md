# CLIENT AND STAKEHOLDER DOCUMENTS

All client details, stakeholder interview summaries, requirements gathered from clients, and feedback received throughout the project lifecycle. Organised chronologically by RUP phase.

---

## CLIENT PROFILES

### Client 1 — Ms. Sushana Karki (Patient/User Perspective)

| Field | Detail |
|---|---|
| Full Name | Ms. Sushana Karki |
| Role | Bachelor's degree student in Psychology, Thames College, Kathmandu |
| Perspective | End-user (patient/student); personal experience with depression |
| Contact Established | Week 2 (Inception phase, November 2024) |
| Involvement Phases | Inception (interview), Elaboration (prototype review), Transition (UAT, approval letter) |
| Key Contribution | Validated user-side requirements; confirmed pain points around cost, stigma, and fragmentation |
| Approval Letter | Appendix F.1 |

### Client 2 — Dr. Dibyandra Singh (Therapist/Clinical Perspective)

| Field | Detail |
|---|---|
| Full Name | Dr. Dibyandra Singh |
| Role | Practising psychiatrist, Sunshine City Medical Center, Melbourne, Australia (clinical training in Nepal) |
| Perspective | Mental health professional (therapist); domain expert |
| Contact Established | Week 2 (Inception phase, November 2024) |
| Involvement Phases | Inception (interview), Elaboration (requirements review), Transition (UAT as admin/therapist, approval letter) |
| Key Contribution | Defined therapist workflow requirements; specified clinical instrument requirements (PHQ-9/GAD-7); articulated the value of therapist access to patient mood data |
| Approval Letter | Appendix F.2 |

---

## PHASE 1: INCEPTION — Stakeholder Interviews

### Interview 1 — Ms. Sushana Karki (Week 2, November 2024)

**Format:** Semi-structured interview, approximately 45 minutes

**Interview Guide Questions:**

1. Can you describe your personal experience seeking mental health support in Nepal?
2. What were the main barriers you encountered?
3. What tools or apps have you tried? What worked and what did not?
4. What would a genuinely useful digital mental health platform look like to you?
5. How important is privacy in your decision to seek mental health support?
6. What would make you trust a mental health app enough to use it regularly?
7. How do you currently pay for services? Would eSewa be acceptable for therapy payments?

**Key Requirements Extracted:**

| Requirement | Category | Priority |
|---|---|---|
| Access to real licensed therapists, not AI bots | Functional | High |
| Private, anonymous entry — no social login required | Non-functional (Privacy) | High |
| Affordable pricing calibrated to Nepali income levels | Non-functional | High |
| eSewa payment (has no credit card) | Functional | High |
| Ability to log how I feel without it being too clinical | Functional | Medium |
| Content that feels relevant to Nepali life — not just Western wellness | Content | Medium |
| Works even with bad internet (university WiFi is unreliable) | Non-functional (Offline) | High |
| No shame in using it — it should look like a wellness app, not a psychiatric tool | UX/Design | High |

**Notable Quote:**
> "I have wanted to see a therapist for two years but I have never gone. The cost is too high, and if my family found out I was going to a psychiatrist they would think something was very wrong with me. An app where I can book a session privately and pay with eSewa would completely remove both of those barriers."

---

### Interview 2 — Dr. Dibyandra Singh (Week 2, November 2024)

**Format:** Video call interview (Zoom), approximately 60 minutes

**Interview Guide Questions:**

1. What does your typical patient consultation workflow look like?
2. What information would be most valuable to have before a session begins?
3. What clinical measurement tools do you currently use with patients?
4. How do you currently track patient progress between sessions?
5. What would a digital platform need to offer for you to recommend it to patients?
6. What concerns would you have about therapists operating on a digital marketplace?
7. What content would you want to publish if you had a platform to reach Nepali patients remotely?

**Key Requirements Extracted:**

| Requirement | Category | Priority |
|---|---|---|
| Access to patient mood logs before and during session | Functional | High |
| PHQ-9 and GAD-7 results visible in consultation view | Functional | High |
| Professional credential verification before public visibility | Functional | High |
| Ability to publish written articles and audio sessions | Functional | Medium |
| Earnings visibility per session | Functional | Medium |
| Clear separation between my patients and other therapists' patients | Non-functional (Security) | High |
| Crisis protocol: high PHQ-9 scores should trigger helpline referral | Functional (Safety) | High |
| Video quality acceptable for therapeutic conversation — not just basic call | Non-functional | High |

**Notable Quote:**
> "If I can see a patient's PHQ-9 score and their mood log for the past two weeks before a session, I can spend the first ten minutes of the session doing actual therapy instead of asking 'so how have you been feeling this week?' That is genuinely transformative for the quality of care I can provide."

---

## PHASE 2: ELABORATION — Client Prototype Reviews

### Prototype Review — Ms. Sushana Karki (Week 7, December 2024)

**Format:** Screen share walkthrough of Figma mockups, ~30 minutes

**Feedback Received:**

| Screen / Feature | Feedback | Action Taken |
|---|---|---|
| Onboarding flow | "Five questions is manageable — do not make it longer" | Kept at 5 questions |
| Therapist directory | "I want to see the price before clicking the profile" | Added fee to directory card |
| Mood logging UI | "The emoji faces are good — more friendly than a number scale alone" | Retained emoji + slider |
| Booking calendar | "The slot picker is clear" | No change needed |
| PHQ-9 screen | "This looks quite clinical — can the text be softer?" | Adjusted instruction text |
| Overall design | "The colours feel calm and trustworthy — the green-teal palette works well" | Palette retained |

---

### Prototype Review — Dr. Dibyandra Singh (Week 7, December 2024)

**Format:** Screen share walkthrough of Figma mockups and architecture diagram, ~45 minutes

**Feedback Received:**

| Screen / Feature | Feedback | Action Taken |
|---|---|---|
| Consultation view | "I need to see the mood chart and questionnaire score on the same screen as the video" | Panel-based consultation UI designed |
| PHQ-9 severity labels | "The severity band descriptions must be clinically accurate — check the Kroenke (2001) scoring" | Verified against published PHQ-9 scoring guidelines |
| Therapist verification | "What stops someone pretending to be a therapist?" | Admin document upload + manual review added |
| Content moderation | "All therapist content should be reviewed before publishing — there must be no unmoderated clinical advice" | Admin approval workflow added |
| Crisis threshold | "PHQ-9 score of 20+ is the severe range — that is the right threshold for a helpline referral" | Crisis notice at ≥20 confirmed |

---

## PHASE 4: TRANSITION — UAT Participation and Final Feedback

### UAT Session — Ms. Sushana Karki (Week 20)

**Role during UAT:** Therapist-role tester + external client reviewer
**Duration:** ~90 minutes

**Post-UAT Feedback Summary:**

| Aspect | Rating | Comment |
|---|---|---|
| Overall platform quality | 5/5 | "This is exactly what Nepal needs" |
| Therapist workflow | 5/5 | "The session preparation data view is something I have wanted for years" |
| Content publishing | 4/5 | "Add a notification when content has been in review for more than 48 hours" |
| Earnings dashboard | 5/5 | "Clear and accurate" |
| Would recommend to colleagues | Yes | "I will actively encourage registration when it launches" |

---

### UAT Session — Dr. Dibyandra Singh (Week 20)

**Role during UAT:** Admin-role tester + clinical domain reviewer
**Duration:** ~60 minutes

**Post-UAT Feedback Summary:**

| Aspect | Rating | Comment |
|---|---|---|
| Admin dashboard clarity | 5/5 | "The verification queue is well organised" |
| Therapist verification process | 5/5 | "Document review workflow is appropriate" |
| Content moderation | 5/5 | "Approval workflow prevents unmoderated advice from reaching patients" |
| Patient data visibility in consultation | 5/5 | "Exactly as specified in the requirements — this is the key clinical differentiator" |
| Crisis protocol | 5/5 | "PHQ-9 ≥ 20 threshold is correct; helpline number is accurate" |
| Clinical accuracy of instruments | 5/5 | "PHQ-9 and GAD-7 scoring bands match published clinical guidance" |

---

## REQUIREMENTS TRACEABILITY

This table maps each client-specified requirement to the feature that implements it.

| Client | Requirement | Implementation | Test Case |
|---|---|---|---|
| Karki | Real licensed therapists only | Admin verification before public listing | TC-U024, TC-U025 |
| Karki | Private/anonymous entry | OTP login (no social account required) | TC-U001 |
| Karki | eSewa payment | eSewa Flutter SDK integration | TC-U014–U016, TC-S003 |
| Karki | Offline mood logging | SQLite + sync architecture | TC-U029, TC-UAT023 |
| Karki | Non-clinical UX | Emoji mood scale; friendly tone | TC-UAT005 |
| Singh | Patient mood data in consultation | Mood chart + PHQ-9/GAD-7 in session view | TC-S005 |
| Singh | PHQ-9 and GAD-7 instruments | Clinical questionnaire module | TC-U011–U013 |
| Singh | Crisis protocol at PHQ-9 ≥ 20 | Threshold-triggered helpline notice | TC-S006 |
| Singh | Credential verification | Admin document review workflow | TC-U024, TC-U025 |
| Singh | Content moderation | Admin approval before publication | TC-S007 |
| Singh | Therapist earnings visibility | Earnings dashboard | TC-UAT015 |
