import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'otp_input_box.dart';

class OtpInputRow extends StatelessWidget {
  final List<TextEditingController> otpControllers;
  final List<FocusNode> otpFocusNodes;
  final int otpLength;
  final void Function(int index, String value) onOtpChanged;
  final bool hasError;

  const OtpInputRow({
    super.key,
    required this.otpControllers,
    required this.otpFocusNodes,
    required this.otpLength,
    required this.onOtpChanged,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive spacing based on available width
        final availableWidth = constraints.maxWidth;
        final boxWidth = 44.w;
        final totalBoxesWidth = boxWidth * otpLength;
        final remainingSpace = availableWidth - totalBoxesWidth;
        final spacing = (remainingSpace / (otpLength + 1)).clamp(4.0, 12.0);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(otpLength, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing / 2),
              child: OtpInputBox(
                controller: otpControllers[index],
                focusNode: otpFocusNodes[index],
                onChanged: (value) => onOtpChanged(index, value),
                isError: hasError,
              ),
            );
          }),
        );
      },
    );
  }
}