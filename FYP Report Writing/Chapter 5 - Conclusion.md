# CHAPTER 5: CONCLUSION

---

## 5.1 Legal, Social and Ethical Issues

### 5.1.1 Legal Issues

**Data Protection:** Resilio processes sensitive health data including mood logs, questionnaire scores, and session communications. The platform's data handling is designed to comply with Nepal's Individual Privacy Act 2018 and the Electronic Transactions Act 2063, as well as GDPR standards as an international baseline. Specific measures include TLS encryption for all data in transit, Row Level Security on the PostgreSQL database, a user-facing account deletion mechanism, and a minimal data collection policy.

**Data Residency:** Firebase and Cloudinary store data outside Nepal. Users are informed at registration. This will need to be reviewed if Nepal enacts domestic data localisation legislation as discussed in the draft cybersecurity policy (Ministry of Communication and Information Technology, 2023).

**Professional Liability:** Resilio acts as a marketplace and does not employ therapists or provide clinical advice directly. The administrator verification process ensures only credentialled professionals operate on the platform. Terms of service clearly delineate the platform's liability boundaries.

**Crisis Protocol:** When a user scores 20 or above on the PHQ-9 (severe range), the application directs them to the Nepal Mental Health Helpline (1660-01-11111) and emergency services. This satisfies the minimum duty-of-care obligation for a mental health platform.

### 5.1.2 Social Issues

**Stigma Reduction:** Making it as simple to book a therapy session as to pay a utility bill via eSewa gradually normalises help-seeking behaviour. The privacy of a digital platform removes the social consequences associated with being seen at a psychiatrist's office in communities where stigma remains significant (Kohrt and Harper, 2008).

**Rural Access Equity:** Nepal's mental health infrastructure is concentrated in Kathmandu. Resilio's offline-capable, eSewa-payable, locally priced platform offers professional care access to users in rural areas where no traditional channel exists.

**Therapist Economic Empowerment:** The therapist module enables Nepali professionals to extend their reach beyond their physical location, conduct remote sessions, and publish content, creating additional income streams and making the mental health profession more financially sustainable in Nepal.

### 5.1.3 Ethical Issues

**Data Minimisation:** Only data necessary for each function is collected. Mood logs and questionnaire scores are never used for advertising or third-party profiling. Consent is obtained in plain language at the point of collection.

**Boundaries of Non-Clinical Features:** Wellness games, mood tracking, and the content hub are self-help tools, not clinical interventions. PHQ-9 and GAD-7 result screens include explicit statements that scores are informational and not clinical diagnoses.

**Algorithmic Fairness:** The therapist matching algorithm prioritises specialisation, language preference, and availability. As the platform grows, the matching logic will be reviewed to identify and correct any unintended biases in recommendations.

**User Wellbeing Over Engagement:** Resilio does not use streak mechanics that penalise users for missing days, does not send excessive re-engagement notifications, and does not use dark pattern design techniques. Gamification elements are designed to build healthy habits, not compulsive usage.

---

## 5.2 Advantages

**Integrated Care Environment:** Resilio is the only platform combining therapist access, self-help tools, mood tracking, validated questionnaires, and multimedia content in a single application for Nepali users. This eliminates the fragmentation that Bakker et al. (2016) identified as the primary driver of digital mental health tool abandonment.

**Offline-First Architecture:** Core features continue to function without internet connectivity, addressing the connectivity conditions of approximately 30% of the target population.

**Local Payment and Pricing:** eSewa integration at locally calibrated pricing removes both the credit card barrier and the affordability barrier that make international platforms inaccessible to the target demographic.

**Therapist Visibility into Patient Data:** Mood log data and questionnaire scores flow from patient to therapist within the consultation interface before each session. Ms. Sushana Karki confirmed this as clinically transformative for session preparation. The post-survey recorded a 100% positive rate for the mood tracker helping users understand their emotional patterns.

**Evidence-Based Design:** The mood tracking system follows EMA principles (Shiffman et al., 2008). Questionnaires use the clinically validated PHQ-9 and GAD-7 instruments. Gamification draws on research demonstrating 40-60% engagement improvements in health applications (Fleming et al., 2019).

---

## 5.3 Limitations

**Android-Only Deployment:** An iOS build is technically straightforward with Flutter, but Apple's health app compliance documentation was outside this project's timeline. This is the next required step for a full-market rollout.

**English-Dominant Interface:** Full Nepali localisation is partially implemented using Flutter's `l10n` framework but incomplete. This represents the highest-priority enhancement for the next development cycle.

**Limited Crisis Detection:** Crisis support is limited to PHQ-9 score thresholds. Unlike Wysa's 82% crisis detection rate through conversational AI (Wysa, 2024), Resilio does not monitor real-time signals within mood logs or free-text entries. A future release should incorporate NLP-driven risk detection.

**External Service Dependency:** Core booking, payment, and live session features require live connectivity to Firebase, eSewa, and Cloudinary. A failure in any of these services affects user experience in ways the offline architecture cannot mitigate.

---

## 5.4 Future Work

**Nepali Language Localisation:** Full Nepali translation of all UI strings and therapeutic content is the highest-priority enhancement. The Flutter `l10n` infrastructure is in place.

**AI-Driven Therapist Matching:** Incorporating machine learning to refine matching recommendations over time based on session outcomes and compatibility signals, building on research by Abd-Alrazaq et al. (2020).

**NLP for Mood Insights:** Semantic analysis of mood log text to identify sentiment patterns and risk indicators, enabling proactive between-session monitoring.

**iOS Release:** App Store health compliance documentation to extend platform reach to iPhone users.

**Community Peer Support:** Moderated community discussion spaces with therapist participation, following research by Naslund et al. (2016) on peer support engagement in digital mental health.

**Wearable Integration:** Correlating self-reported mood with physiological data from wearables to improve clinical utility of the monitoring system (Torous et al., 2019).

**Group Therapy Sessions:** Extending the WebRTC infrastructure to multi-party sessions for group therapy delivery.

---

## References

Abd-Alrazaq, A.A., Alajlani, M., Alalwan, A.A., Bewick, B.M., Gardner, P. and Househ, M. (2020) 'An overview of the features of chatbots in mental health: A scoping review', *International Journal of Medical Informatics*, 132, article 103978.

Bakker, D., Kazantzis, N., Rickwood, D. and Rickard, N. (2016) 'Mental health smartphone apps: Review and evidence-based recommendations for future developments', *JMIR Mental Health*, 3(1), e7.

Fleming, T., Bavin, L., Lucassen, M., Stasiak, K., Hopkins, S. and Merry, S. (2019) 'Beyond the trial: Systematic review of real-world uptake and engagement with digital self-help interventions for depression, low mood, or anxiety', *Journal of Medical Internet Research*, 21(6), e12556.

Government of Nepal (2018) *Individual Privacy Act 2018*. Kathmandu: Government of Nepal.

Kohrt, B.A. and Harper, I. (2008) 'Navigating diagnoses: Understanding mind-body relations, mental health, and stigma in Nepal', *Culture, Medicine and Psychiatry*, 32(4), pp. 462-491.

Ministry of Communication and Information Technology, Nepal (2023) *Draft National Cybersecurity Policy*. Kathmandu: Government of Nepal.

Naslund, J.A., Aschbrenner, K.A., Marsch, L.A. and Bartels, S.J. (2016) 'The future of mental health care: Peer-to-peer support and social media', *Epidemiology and Psychiatric Sciences*, 25(2), pp. 113-122.

Shiffman, S., Stone, A.A. and Hufford, M.R. (2008) 'Ecological momentary assessment', *Annual Review of Clinical Psychology*, 4, pp. 1-32.

Torous, J., Myrick, K.J., Rauseo-Ricupero, N. and Firth, J. (2019) 'Digital mental health and COVID-19', *JMIR Mental Health*, 7(3), e18848.

Wysa (2024) *Wysa Clinical Evidence and Research*. Available at: https://www.wysa.com (Accessed: 15 April 2026).
