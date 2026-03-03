import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/theme/app_text_styles.dart';

class OtpInputBox extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final bool isError;

  const OtpInputBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.isError = false,
  });

  @override
  State<OtpInputBox> createState() => _OtpInputBoxState();
}

class _OtpInputBoxState extends State<OtpInputBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChange);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    widget.controller.removeListener(_onTextChange);
    _animationController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (mounted) {
      if (widget.focusNode.hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
      setState(() {});
    }
  }

  void _onTextChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = widget.focusNode.hasFocus;
    final isFilled = widget.controller.text.isNotEmpty;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 44.w,
        height: 52.h,
        decoration: BoxDecoration(
          color: _getBackgroundColor(context, isFocused, isFilled, isDarkMode),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: widget.isError
                ? Colors.red
                : _getBorderColor(context, isFocused, isFilled),
            width: isFocused ? 2 : 1.5,
          ),
          boxShadow: isFocused
              ? [
            BoxShadow(
              color: widget.isError
                  ? Colors.red.withValues(alpha: 0.2)
                  : context.primaryColor.withValues(alpha: 0.2),
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            )
          ]
              : isFilled
              ? [
            BoxShadow(
              color: context.primaryColor.withValues(alpha: 0.1),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            )
          ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            onChanged: widget.onChanged,
            onTap: () {
              widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller.text.length),
              );
            },
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: AppTextStyles.headlineMedium.copyWith(
              color: isFilled
                  ? context.primaryColor
                  : context.textPrimaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 22.sp,
            ),
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            cursorColor: context.primaryColor,
            cursorWidth: 2,
            cursorRadius: Radius.circular(2.r),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(
      BuildContext context,
      bool isFocused,
      bool isFilled,
      bool isDarkMode,
      ) {
    if (widget.isError) {
      return Colors.red.withValues(alpha: 0.05);
    }
    if (isFocused) {
      return context.primaryColor.withValues(alpha: 0.08);
    }
    if (isFilled) {
      return context.primaryColor.withValues(alpha: 0.06);
    }
    return isDarkMode
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.grey.withValues(alpha: 0.08);
  }

  Color _getBorderColor(
      BuildContext context,
      bool isFocused,
      bool isFilled,
      ) {
    if (isFocused) {
      return context.primaryColor;
    }
    if (isFilled) {
      return context.primaryColor.withValues(alpha: 0.5);
    }
    return context.borderColor.withValues(alpha: 0.5);
  }
}