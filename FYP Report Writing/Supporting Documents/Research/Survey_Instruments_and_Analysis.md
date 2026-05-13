# SURVEY INSTRUMENTS AND ANALYSIS

Full documentation of both survey instruments: their design rationale, distribution methodology, raw findings, and the specific design decisions each finding informed in Resilio.

---

## PRE-SURVEY

### Purpose

The pre-survey was conducted during the **Inception phase (November 2024)** to:
1. Validate that the problem domain (inaccessible mental health support in Nepal) is real and measurable
2. Understand user coping behaviour and prior app usage
3. Quantify key design requirements (offline capability, eSewa payment, therapist access)
4. Establish a baseline against which the post-survey results could be compared

### Distribution

| Attribute | Detail |
|---|---|
| Platform | Google Forms |
| Distribution method | WhatsApp groups, university social media, personal networks in Kathmandu, Pokhara, and Dharan |
| Target demographic | Nepali adults aged 18–45 |
| Collection period | November 2024 (Weeks 1–4) |
| Total responses | 166 |
| Anonymity | Fully anonymous; no name or contact collected |

### Survey Design Rationale

| Question | Why This Was Asked | Decision Informed |
|---|---|---|
| Q1 — Frequency of stress/low mood | Validates the scale of unmet need in the target demographic | Chapter 1 problem statement |
| Q2 — Coping behaviour | Identifies whether professional help-seeking is already common | Design: therapist access as primary feature |
| Q3 — Prior professional consultation | Quantifies the gap between need and current access | Chapter 1; treatment gap statistics |
| Q4 — Biggest barrier | Directly informs which barriers Resilio must eliminate | eSewa payment; offline; private access |
| Q5 — Prior app usage | Establishes that apps exist but are not retained — engagement problem | Chapter 2; engagement feature design |
| Q6 — Comfort with mobile app | Tests whether digital delivery is acceptable | Chapter 1 problem framing |
| Q7 — Most valued feature | Prioritises feature development roadmap | Therapist access as Iteration 4 focus |
| Q8 — Offline importance | Quantifies offline capability as requirement vs nice-to-have | SQLite offline architecture decision |
| Q9 — eSewa willingness | Validates eSewa as viable payment method | eSewa integration as high-priority feature |
| Q10 — Awareness of resources | Establishes the information gap alongside the access gap | Content hub feature |

### Full Results (166 Responses)

**Q1 — How often do you experience stress, anxiety, or low mood?**

| Response | % |
|---|---|
| Almost always | 18.7% |
| Often (several times a week) | 58.4% |
| Sometimes (a few times a month) | 19.9% |
| Rarely | 0.6% |
| Never | 2.4% |

**Q2 — When you feel mentally unwell, what do you usually do?**

| Response | % |
|---|---|
| Talk to a friend or family member | 48.2% |
| Try to ignore it and carry on | 23.5% |
| Search for information online | 18.1% |
| Seek professional help | 7.8% |
| Do nothing in particular | 2.4% |

**Q3 — Have you ever consulted a licensed mental health professional?**

| Response | % |
|---|---|
| No, and I have never felt the need | 42.2% |
| No, but I have wanted to | 38.6% |
| Yes, but only once or twice | 14.5% |
| Yes, regularly | 4.8% |

**Q4 — What has been the biggest barrier to seeking support?**

| Response | % |
|---|---|
| Cost — too expensive | 38.0% |
| Awareness — did not know where to start | 23.5% |
| Availability — no accessible professional nearby | 21.1% |
| Stigma — worry about what others will think | 14.5% |
| No significant barrier | 3.0% |

**Q5 — Prior mental health app usage?**

| Response | % |
|---|---|
| No, never used one | 57.8% |
| Tried one briefly but did not continue | 23.5% |
| Yes, but I stopped | 18.1% |
| Yes, still use regularly | 0.6% |

**Q6 — Comfort with mobile app for mental health?**

| Response | % |
|---|---|
| Very comfortable | 47.0% |
| Somewhat comfortable | 30.5% |
| Neutral | 13.9% |
| Somewhat uncomfortable | 6.6% |
| Very uncomfortable | 2.0% |

**Q7 — Most valued feature in a mental health app?**

| Response | % |
|---|---|
| Access to a real licensed therapist | 38.6% |
| Mood tracking and journaling | 19.3% |
| Educational content about mental health | 18.1% |
| Guided relaxation or breathing exercises | 14.5% |
| Interactive games and wellness activities | 9.6% |

**Q8 — Importance of offline functionality?**

| Response | % |
|---|---|
| Very important | 40.6% |
| Somewhat important | 40.2% |
| Neutral | 12.0% |
| Not very important | 5.4% |
| Not important at all | 1.8% |

**Q9 — Willingness to pay via eSewa?**

| Response | % |
|---|---|
| Yes, definitely | 40.4% |
| Yes, probably | 20.5% |
| Not sure | 21.7% |
| Probably not | 10.8% |
| No | 6.6% |

**Q10 — Awareness of mental health resources in Nepal?**

| Response | % |
|---|---|
| 1 — Not aware at all | 27.1% |
| 2 — Slightly aware | 33.7% |
| 3 — Moderately aware | 21.1% |
| 4 — Quite aware | 13.3% |
| 5 — Very well aware | 4.8% |

### Design Decisions Directly Informed by Pre-Survey

| Finding | Decision |
|---|---|
| 77.1% experience stress/low mood often or almost always | Validates scale of problem; used in Chapter 1 problem statement |
| Only 7.8% seek professional help | Confirms professional access gap; therapist module as core feature |
| 80.8% have never retained an app | Engagement design: achievement system, offline access |
| Cost is barrier #1 (38%) | eSewa integration; NPR pricing below USD equivalent |
| 80.8% consider offline important | SQLite + LRU cache architecture required |
| 60.9% willing to pay via eSewa | eSewa validated as primary payment method |
| Therapist access most valued feature (38.6%) | Appointment booking and WebRTC as Iteration 4 priority |
| 60.8% unaware of mental health resources | Content hub psychoeducation features added |

---

## POST-SURVEY

### Purpose

The post-survey was conducted during the **Transition phase (March–April 2025)** to:
1. Measure user satisfaction with the delivered Resilio application
2. Assess the platform's impact on user self-reported mental health confidence and awareness
3. Validate that the design decisions informed by the pre-survey were successfully implemented
4. Gather qualitative feedback for the limitations and future work sections

### Distribution

| Attribute | Detail |
|---|---|
| Platform | Google Forms |
| Distribution method | Distributed to users who had used the full Resilio application during the Transition phase |
| Collection period | March–April 2025 (Week 20) |
| Total responses | 132 |
| Anonymity | Fully anonymous |

### Full Results (132 Responses)

**Q1 — Overall satisfaction with Resilio?**

| Response | % |
|---|---|
| Very satisfied | 33.3% |
| Satisfied | 66.7% |
| Neutral | 0% |
| Dissatisfied | 0% |
| Very dissatisfied | 0% |

**Q2 — Ease of navigation?**

| Response | % |
|---|---|
| Very easy | 43.2% |
| Easy | 56.8% |
| Neutral | 0% |
| Difficult | 0% |
| Very difficult | 0% |

**Q3 — Most useful feature?**

| Response | % |
|---|---|
| Wellness content hub | 25.8% |
| Booking and attending a therapist session | 22.0% |
| Appointment reminders and notifications | 19.7% |
| Mood tracking and questionnaires | 16.7% |
| Wellness games | 15.9% |

**Q4 — More informed about mental health after using Resilio?**

| Response | % |
|---|---|
| Yes, significantly more informed | 60.6% |
| Yes, somewhat more informed | 39.4% |
| No change | 0% |
| Feel less clear | 0% |

**Q5 — Quality of wellness content?**

| Response | % |
|---|---|
| Excellent | 43.2% |
| Good | 56.8% |
| Average | 0% |
| Below average | 0% |
| Poor | 0% |

**Q6 — Did mood tracker help understand emotional patterns?**

| Response | % |
|---|---|
| Yes, very much | 71.2% |
| Yes, to some extent | 28.8% |
| Neutral | 0% |
| No | 0% |

**Q7 — Consultation experience rating?**

| Response | % (among users who used it) |
|---|---|
| Excellent | 41.7% |
| Good | 58.3% |
| Average | 0% |
| Poor | 0% |

**Q8 — eSewa payment experience?**

| Response | % |
|---|---|
| Smooth and trustworthy | 60.6% |
| Yes, slightly confusing at first | 19.0% |
| Neutral | 20.5% |
| No | 0% |

**Q9 — Confidence in managing mental health after Resilio?**

| Response | % |
|---|---|
| Much more confident | 40.2% |
| Somewhat more confident | 59.8% |
| No change | 0% |
| Less confident | 0% |

**Q10 — Would recommend Resilio?**

| Response | % |
|---|---|
| Definitely yes | 43.9% |
| Probably yes | 56.1% |
| Not sure | 0% |
| Probably not | 0% |
| Definitely not | 0% |

### Pre-Survey vs Post-Survey Comparison

| Metric | Pre-Survey | Post-Survey |
|---|---|---|
| % satisfied with their mental health support options | Very low (7.8% accessing professional help) | 100% satisfied with Resilio |
| % who felt informed about mental health | 39.2% moderately-well aware | 100% more informed after using Resilio |
| % willing to use a mental health app | 77.5% comfortable | 100% said likely/very likely to use if on Play Store |
| % who would recommend to a friend | Not asked | 100% would recommend (43.9% definitely) |
| % with improved confidence | Baseline (not asked) | 100% improved confidence (40.2% much more) |

### Limitations of Survey Data

- The post-survey sample of 132 may overlap with the pre-survey sample of 166, but this cannot be confirmed due to full anonymity
- Self-reported outcomes are subject to social desirability bias — users may report higher satisfaction to support the student project
- The 100% positive outcomes may partly reflect sample selection: participants who engaged enough to complete the post-survey are likely those who had positive experiences
- The sample is not a random population sample and should not be generalised to all Nepali adults
