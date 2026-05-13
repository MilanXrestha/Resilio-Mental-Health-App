import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import 'package:Resilio/l10n/app_localizations.dart';

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

  List<_Question> _getQuestions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      _Question(
        key: 'mood',
        title: l10n.qMoodTitle,
        subtitle: l10n.qMoodSubtitle,
        icon: Icons.sentiment_satisfied_alt_outlined,
        type: _QType.single,
        options: [
          _Option(l10n.qMoodOpt1, 'positive', 0),
          _Option(l10n.qMoodOpt2, 'mild', 1),
          _Option(l10n.qMoodOpt3, 'moderate', 2),
          _Option(l10n.qMoodOpt4, 'severe', 3),
        ],
      ),
      _Question(
        key: 'anxiety',
        title: l10n.qAnxietyTitle,
        subtitle: l10n.qAnxietySubtitle,
        icon: Icons.self_improvement_outlined,
        type: _QType.single,
        options: [
          _Option(l10n.qAnxietyOpt1, 'none', 0),
          _Option(l10n.qAnxietyOpt2, 'mild', 1),
          _Option(l10n.qAnxietyOpt3, 'moderate', 2),
          _Option(l10n.qAnxietyOpt4, 'severe', 3),
        ],
      ),
      _Question(
        key: 'sleep',
        title: l10n.qSleepTitle,
        subtitle: l10n.qSleepSubtitle,
        icon: Icons.bedtime_outlined,
        type: _QType.single,
        options: [
          _Option(l10n.qSleepOpt1, 'good', 0),
          _Option(l10n.qSleepOpt2, 'mild', 1),
          _Option(l10n.qSleepOpt3, 'moderate', 2),
          _Option(l10n.qSleepOpt4, 'severe', 3),
        ],
      ),
      _Question(
        key: 'primary_concern',
        title: l10n.qConcernTitle,
        subtitle: l10n.qConcernSubtitle,
        icon: Icons.favorite_border_rounded,
        type: _QType.multi,
        options: [
          _Option(l10n.qConcernOpt1, 'Depression', 0),
          _Option(l10n.qConcernOpt2, 'Anxiety', 0),
          _Option(l10n.qConcernOpt3, 'Relationships', 0),
          _Option(l10n.qConcernOpt4, 'Grief', 0),
          _Option(l10n.qConcernOpt5, 'Trauma', 0),
          _Option(l10n.qConcernOpt6, 'Self-esteem', 0),
          _Option(l10n.qConcernOpt7, 'Life transitions', 0),
          _Option(l10n.qConcernOpt8, 'Burnout', 0),
        ],
      ),
      _Question(
        key: 'trauma_history',
        title: l10n.qTraumaTitle,
        subtitle: l10n.qTraumaSubtitle,
        icon: Icons.shield_outlined,
        type: _QType.single,
        options: [
          _Option(l10n.qTraumaOpt1, 'none', 0),
          _Option(l10n.qTraumaOpt2, 'mild', 1),
          _Option(l10n.qTraumaOpt3, 'moderate', 2),
          _Option(l10n.qTraumaOpt4, 'severe', 3),
        ],
      ),
      _Question(
        key: 'therapeutic_approach',
        title: l10n.qApproachTitle,
        subtitle: l10n.qApproachSubtitle,
        icon: Icons.psychology_outlined,
        type: _QType.single,
        options: [
          _Option(l10n.qApproachOpt1, 'CBT', 0),
          _Option(l10n.qApproachOpt2, 'Psychodynamic', 0),
          _Option(l10n.qApproachOpt3, 'Mindfulness', 0),
          _Option(l10n.qApproachOpt4, 'General Counseling', 0),
        ],
      ),
      _Question(
        key: 'therapist_preference',
        title: l10n.qPrefTitle,
        subtitle: l10n.qPrefSubtitle,
        icon: Icons.people_outline_rounded,
        type: _QType.single,
        options: [
          _Option(l10n.qPrefOpt1, 'no_preference', 0),
          _Option(l10n.qPrefOpt2, 'female', 0),
          _Option(l10n.qPrefOpt3, 'male', 0),
          _Option(l10n.qPrefOpt4, 'cultural', 0),
        ],
      ),
    ];
  }

  bool _canProceed(List<_Question> questions) {
    final a = _answers[_step];
    if (questions[_step].type == _QType.multi) {
      return a is List && (a as List).isNotEmpty;
    }
    return a != null;
  }

  void _next(List<_Question> questions) {
    if (_step < questions.length - 1) {
      setState(() => _step++);
    } else {
      _submit(questions);
    }
  }

  void _submit(List<_Question> questions) {
    // Build query params for weighted matching
    final primaryConcerns = _answers[3];
    final approach = _answers[5]?.toString() ?? '';
    final moodScore = (questions[0].options.indexWhere((o) => o.value == _answers[0]));
    final anxietyScore = (questions[1].options.indexWhere((o) => o.value == _answers[1]));
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
    final questions = _getQuestions(context);
    final q = questions[_step];
    final progress = (_step + 1) / questions.length;

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
                          AppLocalizations.of(context)!.findTherapist,
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor),
                        ),
                        Text(
                          AppLocalizations.of(context)!.questionProgress(_step + 1, questions.length),
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
                  onPressed: _canProceed(questions) ? () => _next(questions) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: context.borderColor,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                    elevation: 0,
                    textStyle: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                  child: Text(_step == questions.length - 1 ? AppLocalizations.of(context)!.findMatches : AppLocalizations.of(context)!.continueText),
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
