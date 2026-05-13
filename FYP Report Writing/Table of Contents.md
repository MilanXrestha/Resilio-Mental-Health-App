# Resilio — Wellness & Mental Health App
## Final Year Project Report
### CS6P05NI | AY 2025–2026
**Student:** Milan Shrestha | **ID:** 23057135
**Internal Supervisor:** Mr. Aadesh Tandukar
**External Supervisor:** Ms. Oshriya Manandhar

---

# TABLE OF CONTENTS

---

Cover Page

Abstract

Table of Contents

Table of Figures

Table of Tables

Table of Abbreviations

---

## CHAPTER 1: INTRODUCTION

1.1 Project Description
- 1.1.1 Overview of Resilio
- 1.1.2 Background Context
- 1.1.3 Importance of the Project Domain

1.2 Current Scenario
- 1.2.1 Global Mental Health Landscape
- 1.2.2 Mental Health in Nepal — National Context
- 1.2.3 Relevant Statistics and Research

1.3 Problem Domain and Project as a Solution
- 1.3.1 Problem Domain — Challenges in Accessing Mental Health Support
- 1.3.2 Gaps in Existing Systems
- 1.3.3 Resilio as a Solution
- 1.3.4 Key Benefits and Target Users

1.4 Aim and Objectives
- 1.4.1 Aim
- 1.4.2 Objectives

1.5 Structure of the Report
- 1.5.1 Background
- 1.5.2 Development
- 1.5.3 Testing and Analysis
- 1.5.4 Conclusion

---

## CHAPTER 2: BACKGROUND

2.1 About the End Users
- 2.1.1 Customers (Patients / General Users)
- 2.1.2 Therapists
- 2.1.3 System Administrators
- 2.1.4 Client Description (Ms. Sushana Karki & Dr. Dibyandra Singh)

2.2 Understanding the Solution
- 2.2.1 System Overview
- 2.2.2 Key Technical Terminologies and Definitions
- 2.2.3 Core Features and Functions
  - 2.2.3.1 Therapist Discovery and Matching
  - 2.2.3.2 Appointment Booking and Management
  - 2.2.3.3 Live Video / Audio Consultations (WebRTC)
  - 2.2.3.4 Wellness Content Hub (Articles, Audio, Video)
  - 2.2.3.5 Mental Wellness Games and Gamification
  - 2.2.3.6 Mood Tracking and Questionnaires
  - 2.2.3.7 Subscription and eSewa Payment Integration
  - 2.2.3.8 Admin and Therapist Dashboards

2.3 Similar Projects
- 2.3.1 BetterHelp — Online Therapy Platform
- 2.3.2 Headspace — Meditation and Mindfulness App
- 2.3.3 Wysa — AI Mental Health Support App

2.4 Comparisons and Critical Evaluation
- 2.4.1 Feature Comparison Table
- 2.4.2 Critical Analysis of Existing Solutions
- 2.4.3 Justification for the Resilio Approach

---

## CHAPTER 3: DEVELOPMENT

3.1 Considered Methodologies
- 3.1.1 Agile (Scrum)
- 3.1.2 Rational Unified Process (RUP)
- 3.1.3 Prototype Model

3.2 Selected Methodology — RUP
- 3.2.1 Justification for Choosing RUP
- 3.2.2 Methodology Comparison Table

3.3 Phases of RUP Methodology
- 3.3.1 Phase 1: Inception
- 3.3.2 Phase 2: Elaboration
- 3.3.3 Phase 3: Construction
- 3.3.4 Phase 4: Transition

3.4 Survey Results
- 3.4.1 Pre-Survey Results
- 3.4.2 Post-Survey Results

3.5 Requirement Analysis
- 3.5.1 Overall Requirements
- 3.5.2 Functional Requirements
- 3.5.3 Non-Functional Requirements

3.6 Design
- 3.6.1 System Architecture Diagram
- 3.6.2 Use Case Diagrams
  - 3.6.2.1 Customer Use Case Diagram
  - 3.6.2.2 Therapist Use Case Diagram
  - 3.6.2.3 Admin Use Case Diagram
- 3.6.3 Activity Diagrams
- 3.6.4 Sequence Diagrams
- 3.6.5 Entity-Relationship (ER) Diagram
- 3.6.6 Data Flow Diagrams
- 3.6.7 Wireframes and UI Mockups

3.7 Implementation
- 3.7.1 Tools and Platforms Used
  - 3.7.1.1 Flutter & Dart (Mobile Frontend)
  - 3.7.1.2 Node.js / Express (Backend)
  - 3.7.1.3 Firebase (Authentication & Push Notifications)
  - 3.7.1.4 PostgreSQL (Primary Database)
  - 3.7.1.5 Cloudinary (Media Storage)
  - 3.7.1.6 WebRTC / Agora (Video & Audio Calls)
  - 3.7.1.7 eSewa (Payment Gateway)
  - 3.7.1.8 Figma (UI/UX Design)
- 3.7.2 Code Architecture (Clean Architecture / Feature-First)
- 3.7.3 Customer Module — Key Features and Screenshots
- 3.7.4 Therapist Module — Key Features and Screenshots
- 3.7.5 Admin Module — Key Features and Screenshots

---

## CHAPTER 4: TESTING AND ANALYSIS

4.1 Test Plan
- 4.1.1 Unit Testing — Test Plan
- 4.1.2 System Testing — Test Plan

4.2 Unit Testing

4.3 System Testing
- 4.3.1 Black Box Testing
- 4.3.2 Integration Testing
- 4.3.3 User Acceptance Testing

4.4 Critical Analysis
- 4.4.1 System Performance
- 4.4.2 Issues Faced and Resolutions
- 4.4.3 Comparison with Objectives
- 4.4.4 Lessons Learned

---

## CHAPTER 5: CONCLUSION

5.1 Legal, Social and Ethical Issues
- 5.1.1 Legal Issues
- 5.1.2 Social Issues
- 5.1.3 Ethical Issues

5.2 Advantages

5.3 Limitations

5.4 Future Work

---

## CHAPTER 6: REFERENCES

---

## CHAPTER 7: BIBLIOGRAPHY

---

## CHAPTER 8: APPENDIX

8.1 Appendix A: Pre-Survey
- 8.1.1 Pre-Survey Form
- 8.1.2 Sample of Filled Pre-Survey Forms
- 8.1.3 Pre-Survey Results

8.2 Appendix B: Post-Survey
- 8.2.1 Post-Survey Form
- 8.2.2 Sample of Filled Post-Survey Forms
- 8.2.3 Post-Survey Results

8.3 Appendix C: Sample Codes
- 8.3.1 Sample Code — Flutter UI (Customer Booking Flow)
- 8.3.2 Sample Code — Backend API (Authentication / Appointments)

8.4 Appendix D: Designs
- 8.4.1 Gantt Chart
- 8.4.2 Work Breakdown Structure (WBS)
- 8.4.3 Algorithms and Flowcharts
- 8.4.4 Data Flow Diagrams
- 8.4.5 Use Case Diagrams
- 8.4.6 Wireframes

8.5 Appendix E: Screenshots of the System
- 8.5.1 Customer App Screens
- 8.5.2 Therapist App Screens
- 8.5.3 Admin Dashboard Screens

8.6 Appendix F: User Feedback
- 8.6.1 User Feedback Form
- 8.6.2 Sample of Filled User Feedback Forms

8.7 Appendix G: Future Work
- 8.7.1 Readings and References for Future Work

---
*Word limit: 8,000 words (main report) | Overflow material placed in Appendix*
