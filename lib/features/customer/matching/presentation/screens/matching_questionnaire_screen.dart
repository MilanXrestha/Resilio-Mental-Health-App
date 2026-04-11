import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';

/// Evidence-based therapist matching questionnaire.
/// Dimensions: mood (PHQ-9), anxiety (GAD-7), sleep, relationships,
/// trauma, coping style, and therapist preferences.
class MatchingQuestionnaireScreen extends StatefulWidget {
  const MatchingQuestionnaireScreen({super.key});

  @override
  State<MatchingQuestionnaireScreen> createState() => _MatchingQuestionnaireScreenState();
}

class _MatchingQuestionnaireScreenState extends State<MatchingQuestionnaireScreen> {
  int _step = 0;
  final Map<int, dynamic> _answers = {};

  static const _questions = [
    _Question(
      key: 'mood',
      title: 'How has your mood been lately?',
      subtitle: 'Over the past 2 weeks',
      icon: Icons.sentiment_satisfied_alt_outlined,
      type: _QType.single,
      options: [
        _Option('Mostly positive — I feel okay', 'positive', 0),
        _Option('Ups and downs, but managing', 'mild', 1),
        _Option('Frequently sad or empty', 'moderate', 2),
        _Option('Persistently low — hard to function', 'severe', 3),
      ],
    ),
    _Question(
      key: 'anxiety',
      title: 'How often do you feel anxious or worried?',
      subtitle: 'Nervousness, panic, or sense of dread',
      icon: Icons.self_improvement_outlined,
      type: _QType.single,
      options: [
        _Option('Rarely or never', 'none', 0),
        _Option('Sometimes, but it passes quickly', 'mild', 1),
        _Option('Often — it affects my day', 'moderate', 2),
        _Option('Almost constantly, hard to control', 'severe', 3),
      ],
    ),
    _Question(
      key: 'sleep',
      title: 'How would you describe your sleep?',
      subtitle: 'Sleep quality has a strong impact on mental health',
      icon: Icons.bedtime_outlined,
      type: _QType.single,
      options: [
        _Option('Generally good', 'good', 0),
        _Option('Occasional trouble sleeping', 'mild', 1),
        _Option('Regularly poor — wake often or can\'t fall asleep', 'moderate', 2),
        _Option('Severely disrupted — exhausted most days', 'severe', 3),
      ],
    ),
    _Question(
      key: 'primary_concern',
      title: 'What is your main reason for seeking therapy?',
      subtitle: 'Select all that apply',
      icon: Icons.favorite_border_rounded,
      type: _QType.multi,
      options: [
        _Option('Depression / low mood', 'Depression', 0),
        _Option('Anxiety / stress', 'Anxiety', 0),
        _Option('Relationship challenges', 'Relationships', 0),
        _Option('Grief or loss', 'Grief', 0),
        _Option('Trauma or PTSD', 'Trauma', 0),
        _Option('Self-esteem or identity', 'Self-esteem', 0),
        _Option('Life transitions', 'Life transitions', 0),
        _Option('Burnout / work stress', 'Burnout', 0),
      ],
    ),
    _Question(
      key: 'trauma_history',
      title: 'Have past difficult experiences affected your wellbeing?',
      subtitle: 'This helps us match trauma-informed therapists if needed',
      icon: Icons.shield_outlined,
      type: _QType.single,
      options: [
        _Option('No — not significantly', 'none', 0),
        _Option('Somewhat — I\'d like support around it', 'mild', 1),
        _Option('Yes — it impacts me regularly', 'moderate', 2),
        _Option('Yes — it\'s a major focus I need help with', 'severe', 3),
      ],
    ),
    _Question(
      key: 'therapeutic_approach',
      title: 'What kind of support feels right for you?',
      subtitle: 'Therapists tailor their style to your preference',
      icon: Icons.psychology_outlined,
      type: _QType.single,
      options: [
        _Option('Practical tools & strategies (CBT-style)', 'CBT', 0),
        _Option('Exploring emotions & past patterns', 'Psychodynamic', 0),
        _Option('Mindfulness & present-moment awareness', 'Mindfulness', 0),
        _Option('I\'m not sure — open to guidance', 'General Counseling', 0),
      ],
    ),
    _Question(
      key: 'therapist_preference',
      title: 'Do you have any therapist preferences?',
      subtitle: 'A comfortable fit improves outcomes',
      icon: Icons.people_outline_rounded,
      type: _QType.single,
      options: [
        _Option('No preference', 'no_preference', 0),
        _Option('Prefer female therapist', 'female', 0),
        _Option('Prefer male therapist', 'male', 0),
        _Option('Prefer therapist with similar cultural background', 'cultural', 0),
      ],
    ),
  ];

  bool get _canProceed {
    final a = _answers[_step];
    if (_questions[_step].type == _QType.multi) {
      return a is List && (a as List).isNotEmpty;
    }
    return a != null;
  }

  void _next() {
    if (_step < _questions.length - 1) {
      setState(() => _step++);
    } else {
      _submit();
    }
  }

  void _submit() {
    // Build query params for weighted matching
    final primaryConcerns = _answers[3];
    final approach = _answers[5]?.toString() ?? '';
    final moodScore = (_questions[0].options.indexWhere((o) => o.value == _answers[0]));
    final anxietyScore = (_questions[1].options.indexWhere((o) => o.value == _answers[1]));
    final traumaLevel = _answers[4]?.toString() ?? 'none';

    // Determine highest-priority specialty from multi-select
    final specialtyList = (primaryConcerns as List<String>?) ?? [];
    final specialty = specialtyList.isNotEmpty ? specialtyList.first : '';

    // Use pushReplacement so the questionnaire is removed from the back stack.
    // Back from the therapist list goes directly to home, not back into the quiz.
    context.pushReplacement('/therapists', extra: {
      'specialty': specialty,
      'specialties': specialtyList,
      'therapeutic_approach': approach,
      'trauma_level': traumaLevel,
      'mood_severity': moodScore,
      'anxiety_severity': anxietyScore,
      'therapist_preference': _answers[6]?.toString() ?? 'no_preference',
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_step];
    final progress = (_step + 1) / _questions.length;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_step > 0) {
                        setState(() => _step--);
                      } else {
                        context.pop();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: context.surfaceColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: context.borderColor),
                      ),
                      child: Icon(Icons.arrow_back_rounded, size: 20.sp, color: context.textPrimaryColor),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Find Your Therapist',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor),
                        ),
                        Text(
                          'Question ${_step + 1} of ${_questions.length}',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Progress bar ─────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: context.borderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(context.primaryColor),
                  minHeight: 6.h,
                ),
              ),
            ),

            SizedBox(height: 28.h),

            // ── Question ─────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: context.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(q.icon, color: context.primaryColor, size: 26.sp),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    q.title,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor, height: 1.3),
                  ),
                  if (q.subtitle.isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    Text(
                      q.subtitle,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textSecondaryColor),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // ── Options ──────────────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                itemCount: q.options.length,
                itemBuilder: (context, i) {
                  final opt = q.options[i];
                  final bool selected;
                  if (q.type == _QType.multi) {
                    final list = (_answers[_step] as List<String>?) ?? [];
                    selected = list.contains(opt.value);
                  } else {
                    selected = _answers[_step] == opt.value;
                  }

                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (q.type == _QType.multi) {
                            final list = List<String>.from((_answers[_step] as List<String>?) ?? []);
                            if (list.contains(opt.value)) {
                              list.remove(opt.value);
                            } else {
                              list.add(opt.value);
                            }
                            _answers[_step] = list;
                          } else {
                            _answers[_step] = opt.value;
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: selected ? context.primaryColor.withOpacity(0.08) : context.surfaceColor,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: selected ? context.primaryColor : context.borderColor,
                            width: selected ? 1.5 : 0.8,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 22.w,
                              height: 22.w,
                              decoration: BoxDecoration(
                                color: selected ? context.primaryColor : Colors.transparent,
                                shape: q.type == _QType.multi ? BoxShape.rectangle : BoxShape.circle,
                                borderRadius: q.type == _QType.multi ? BorderRadius.circular(6.r) : null,
                                border: Border.all(
                                  color: selected ? context.primaryColor : context.textSecondaryColor.withOpacity(0.5),
                                  width: 1.5,
                                ),
                              ),
                              child: selected
                                  ? Icon(Icons.check_rounded, size: 14.sp, color: Colors.white)
                                  : null,
                            ),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Text(
                                opt.label,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
                                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                                  color: selected ? context.textPrimaryColor : context.textSecondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ── CTA ──────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canProceed ? _next : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: context.borderColor,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                    elevation: 0,
                    textStyle: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                  child: Text(_step == _questions.length - 1 ? 'Find My Matches' : 'Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Data models ──────────────────────────────────────────────────────────────

enum _QType { single, multi }

class _Question {
  final String key;
  final String title;
  final String subtitle;
  final IconData icon;
  final _QType type;
  final List<_Option> options;

  const _Question({
    required this.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.type,
    required this.options,
  });
}

class _Option {
  final String label;
  final String value;
  final int severity; // 0-3, used for backend scoring

  const _Option(this.label, this.value, this.severity);
}
