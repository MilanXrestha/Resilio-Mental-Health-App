# ACKNOWLEDGEMENT

This final year project would not have reached completion without the support of several people who gave their time generously throughout the process.

I want to thank my external supervisor, Ms. Oshirya Manandhar, whose guidance kept the project focused from the very first proposal discussion to the final submission. Her practical advice and consistent encouragement made a real difference at every stage.

I also thank my internal supervisor, Mr. Aadesh Tandukar, for his thorough feedback on drafts, his patience with revisions, and his willingness to engage with the technical decisions in depth. His input improved the quality of the work considerably.

Two mental health professionals gave their time to serve as external clients for this project: Ms. Sushana Karki and Dr. Dibyandra Singh. Both participated in requirements gathering, reviewed prototypes, and provided honest and detailed feedback on every version of the system they were shown. Their domain knowledge shaped Resilio in ways that no amount of secondary research could have achieved on its own. I am genuinely grateful for their involvement.

I thank Islington College and London Metropolitan University for the academic environment, resources, and structured programme that made this project possible.

Finally, I thank my family and friends for their patience and encouragement throughout what was at times a demanding year. Their support made it easier to keep going.

---

# ABSTRACT

This report documents the complete design, development, and evaluation of Resilio, a cross-platform mobile application built to improve access to mental health support in Nepal. The application serves three user groups: customers seeking mental health support, licensed therapists delivering professional services, and administrators managing the platform.

Nepal faces a significant mental health treatment gap. The Nepal Mental Health Survey found that 12.9 percent of adults have experienced a diagnosable mental health condition, yet over 90 percent of those who need professional care never receive it. Existing international platforms are inaccessible due to cost, language, and payment barriers, while local applications lack the depth and clinical integration that effective support requires.

Resilio addresses these gaps through an integrated system that combines therapist booking, live WebRTC video consultations, mood tracking based on ecological momentary assessment principles, validated clinical questionnaires (PHQ-9 and GAD-7), a multimedia wellness content hub, interactive wellness games, and offline-first data storage. Payment is handled through eSewa, Nepal's most widely used digital wallet, removing the credit card barrier that excludes the majority of Nepali users from international platforms.

The project followed the Rational Unified Process methodology across four phases: Inception, Elaboration, Construction, and Transition. The system was built using Flutter and Dart for the mobile frontend, a Node.js and Express backend, PostgreSQL as the primary database, Firebase for authentication and push notifications, Cloudinary for media delivery, and WebRTC for real-time consultation sessions. Clean Architecture principles and a feature-first folder structure were applied throughout.

Testing covered 105 test cases across unit, system, integration, and user acceptance testing, producing an overall pass rate of 99.05 percent. A pre-development survey of 25 participants and a post-development survey of 15 user acceptance testing participants were conducted. Post-survey results showed 93 percent rated the overall experience as good or excellent, and 100 percent confirmed the eSewa payment integration worked without issue.

All nine development objectives were fully achieved. The delivered system represents a functional, tested, and culturally grounded mental health platform built specifically for Nepal's users, infrastructure, and economic context.
