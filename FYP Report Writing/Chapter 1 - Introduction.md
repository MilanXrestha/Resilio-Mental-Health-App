# CHAPTER 1: INTRODUCTION

---

## 1.1 Project Description

### 1.1.1 Overview of Resilio

Resilio is a cross-platform mobile application designed to bridge the gap between mental health need and mental health access in Nepal. The name derives from the Latin *resilire* (to spring back), reflecting its purpose: helping users recover their emotional equilibrium and build psychological resilience. The platform serves three user groups through dedicated interfaces. Customers book appointments with licensed therapists, attend live video or audio consultations, log their mood, complete clinical questionnaires, access a wellness content hub, and engage with interactive wellness games. Therapists manage their patient list, conduct online sessions, publish content, and track earnings. Administrators approve therapist registrations, moderate content, and monitor platform activity.

Payment is handled through eSewa, Nepal's most widely adopted digital wallet, removing the credit card barrier that prevents Nepali users from accessing international platforms. The system is built with Flutter and Dart for the mobile frontend, Node.js and Express for the backend API, PostgreSQL as the primary database, Firebase for notifications, Cloudinary for media, and WebRTC for live consultation sessions.

*[INSERT FIGURE 1.1: Resilio Application Logo and Branding]*

### 1.1.2 Background Context and Importance

Mental health occupies an underserved position in global public health. In high-income countries, roughly half of those with mental conditions receive some treatment; in low and middle-income countries, fewer than one in ten do (Patel et al., 2018). Digital technology has emerged as the most scalable strategy for addressing this gap. Research confirms that video-delivered therapy achieves outcomes comparable to in-person sessions (Backhaus et al., 2012), and that well-designed mobile applications can provide meaningful support in resource-limited environments (Naslund et al., 2017). Resilio was developed specifically for Nepal, where need is documented but the existing landscape of digital tools fails to address it in any comprehensive way. Full statistical detail on Nepal's mental health crisis is provided in Appendix A.

---

## 1.2 Current Scenario

### 1.2.1 Nepal's Mental Health Context

Nepal's challenge is acute. The Nepal Mental Health Survey found that approximately 12.9% of Nepali adults have a diagnosable mental health condition, with an estimated 3.9 million Nepalis living with at least one disorder (Ministry of Health and Population, 2020; Atreya, Upreti and Nepal, 2023). The country has only 144 psychiatrists (0.17 per 100,000 people) against a WHO recommended minimum of 1.0, with the majority based in Kathmandu (World Health Organization, 2021). Suicide rates increased from 19.67 to 23.56 per 100,000 between 2019 and 2023 (Bhandari et al., 2024).

Despite this, Nepal holds one structural advantage: mobile broadband penetration has reached 144.56%, approximately 96% of internet access is via mobile devices, and smartphone penetration is projected to reach 70% by the mid-2020s (DataReportal, 2025). Any platform targeting Nepal must, however, be built for intermittent connectivity: approximately 30% of the population lacks regular internet access, and any application that fails without a constant connection cannot reach the users who need it most.

*[INSERT FIGURE 1.2: Mental Health Workforce per 100,000: International Comparison (WHO, 2021)]*

---

## 1.3 Problem Domain and Project as a Solution

### 1.3.1 Gaps in Existing Systems

The problem is not the absence of mental health applications. More than 10,000 exist globally (Torous et al., 2019). The problem is that virtually none were built for Nepal's users, economy, or infrastructure. Four specific gaps define what the current ecosystem fails to provide:

**Gap 1: No integrated platform.** No existing application combines professional therapist consultation, self-help tools, mood tracking, and culturally relevant content in a single platform for Nepali users.

**Gap 2: No locally payable service.** eSewa and Khalti are not supported by any major international mental health platform, systematically excluding Nepali users regardless of willingness to pay.

**Gap 3: No offline-capable application.** A platform requiring a constant connection is structurally unsuited to reaching users in rural Nepal.

**Gap 4: No culturally adapted content.** Stigma in Nepal is shaped by cultural and spiritual frameworks (Kohrt and Harper, 2008). Effective engagement requires Nepali-language content developed by Nepali professionals.

### 1.3.2 Resilio as a Solution

Resilio addresses each gap directly. It integrates every component of the mental health support journey into one application, where data flows between modules and contributes to a continuous care record. It uses an offline-first SQLite architecture so core features function without connectivity. It processes payments via eSewa at locally calibrated pricing. Its content is produced by Nepali professionals and the interface supports the Nepali language.

---

## 1.4 Aim and Objectives

### 1.4.1 Aim

To design, develop, and deploy Resilio: a cross-platform mobile application providing personalised mental health support, secure access to licensed therapists, and interactive wellness content to underserved users in Nepal.

### 1.4.2 Objectives

1. Develop a Flutter and Dart mobile application with a Node.js backend following Clean Architecture principles.
2. Implement an offline-first data layer using SQLite and LRU caching.
3. Build a mood tracking system informed by ecological momentary assessment principles.
4. Develop a multimedia wellness content hub supporting audio, video, and articles.
5. Create interactive wellness games incorporating breathing exercises, trivia, and role-play scenarios.
6. Implement therapist discovery, questionnaire-based matching, and WebRTC live consultation.
7. Integrate eSewa for subscription and per-session payment processing.
8. Build role-specific dashboards for administrators and therapists.
9. Handle personal health data in accordance with data protection principles including encryption and minimal data collection.

---

## 1.5 Structure of the Report

**Chapter 2** establishes the contextual foundation, profiling end users, reviewing comparable platforms (BetterHelp, Headspace, Wysa), and justifying the design approach through critical comparison.

**Chapter 3** documents the development process from methodology selection through RUP phases, survey results, requirements, system design, and implementation.

**Chapter 4** details testing across unit, system, integration, and user acceptance testing, followed by critical analysis of performance and outcomes.

**Chapter 5** addresses legal, social and ethical considerations, advantages, limitations, and future work.

---

## References

Atreya, A., Upreti, M. and Nepal, S. (2023) 'Barriers to mental health care access in Nepal', *International Journal of Social Psychiatry*, 69(3), pp. 543-547.

Backhaus, A., Agha, Z., Maglione, M.L., Repp, A., Ross, B., Zuest, D., Rice-Thorp, N.M., Lohr, J. and Thorp, S.R. (2012) 'Videoconferencing psychotherapy: A systematic review', *Psychological Services*, 9(2), pp. 111-131.

Bakker, D., Kazantzis, N., Rickwood, D. and Rickard, N. (2016) 'Mental health smartphone apps: Review and evidence-based recommendations for future developments', *JMIR Mental Health*, 3(1), e7.

Bhandari, P., Ale, K., Bhatta, D., Parajuli, P. and Paudel, S. (2024) 'Exploring trends: Five-year analysis of suicide rates in Nepal', *Mental Illness*, 2024, article 5396303.

Chandrashekar, P. (2018) 'Do mental health mobile apps work: Evidence and recommendations for designing high-efficacy mental health mobile apps', *mHealth*, 4, p. 6.

DataReportal (2025) *Digital 2025: Nepal*. Available at: https://datareportal.com/reports/digital-2025-nepal (Accessed: 15 April 2026).

Kohrt, B.A. and Harper, I. (2008) 'Navigating diagnoses: Understanding mind-body relations, mental health, and stigma in Nepal', *Culture, Medicine and Psychiatry*, 32(4), pp. 462-491.

Luitel, N.P., Jordans, M.J.D., Adhikari, R.P., Upadhaya, N., Hanlon, C., Lund, C. and Komproe, I.H. (2015) 'Mental health care in Nepal: Current situation and challenges for development of a district mental health care plan', *Conflict and Health*, 9(1), p. 3.

Ministry of Health and Population, Nepal (2020) *Nepal Mental Health Survey 2020*. Kathmandu: Government of Nepal.

Naslund, J.A., Aschbrenner, K.A., Araya, R., Marsch, L.A., Unutzer, J., Patel, V. and Bartels, S.J. (2017) 'Digital technology for treating and preventing mental disorders in low-income and middle-income countries', *The Lancet Psychiatry*, 4(6), pp. 486-500.

Patel, V., Saxena, S., Lund, C., Thornicroft, G. and others (2018) 'The Lancet Commission on global mental health and sustainable development', *The Lancet*, 392(10157), pp. 1553-1598.

Torous, J., Myrick, K.J., Rauseo-Ricupero, N. and Firth, J. (2019) 'Digital mental health and COVID-19: Using technology today to accelerate the curve on access and quality tomorrow', *JMIR Mental Health*, 7(3), e18848.

World Health Organization (2021) *WHO Special Initiative for Mental Health: Situational Assessment: Nepal*. Geneva: WHO.
