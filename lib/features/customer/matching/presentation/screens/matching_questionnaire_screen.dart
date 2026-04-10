import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_text_styles.dart';

class MatchingQuestionnaireScreen extends StatefulWidget {
  const MatchingQuestionnaireScreen({super.key});

  @override
  State<MatchingQuestionnaireScreen> createState() => _MatchingQuestionnaireScreenState();
}

class _MatchingQuestionnaireScreenState extends State<MatchingQuestionnaireScreen> {
  int _currentStep = 0;
  
  final List<String> _questions = [
    "What brings you to therapy?",
    "What is your preferred therapist gender?",
    "Are there any specific topics you'd like to focus on?"
  ];

  final List<List<String>> _options = [
    ["Anxiety", "Depression", "Relationships", "Stress", "Other"],
    ["Male", "Female", "Non-binary", "No preference"],
    ["CBT", "Mindfulness", "Trauma-informed", "General Counseling"]
  ];

  final Map<int, String> _answers = {};

  void _nextStep() {
    if (_currentStep < _questions.length - 1) {
      setState(() => _currentStep++);
    } else {
      // Submit and match
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Finding your ideal therapist...')),
      );
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          context.pop(); // Go back or go to matching result
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Therapist'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step ${_currentStep + 1} of ${_questions.length}',
                style: AppTextStyles.labelLarge.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 16.h),
              Text(
                _questions[_currentStep],
                style: AppTextStyles.headlineSmall,
              ),
              SizedBox(height: 32.h),
              Expanded(
                child: ListView.builder(
                  itemCount: _options[_currentStep].length,
                  itemBuilder: (context, index) {
                    final option = _options[_currentStep][index];
                    final isSelected = _answers[_currentStep] == option;
                    
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _answers[_currentStep] = option;
                          });
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected 
                                  ? Theme.of(context).primaryColor 
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                            color: isSelected 
                                ? Theme.of(context).primaryColor.withOpacity(0.1) 
                                : Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                              ),
                              SizedBox(width: 16.w),
                              Text(option, style: AppTextStyles.bodyLarge),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _answers.containsKey(_currentStep) ? _nextStep : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(_currentStep == _questions.length - 1 ? 'Find Matches' : 'Next'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
