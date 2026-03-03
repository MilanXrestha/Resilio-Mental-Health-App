import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/core/routing/route_names.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/theme/app_text_styles.dart';
import 'package:Resilio/l10n/app_localizations.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../domain/usecases/send_otp_usecase.dart';

/// Screen shown after the user enters their email for passwordless login.
/// Displays 6 OTP input boxes and handles verification via AuthBloc.
class OtpVerificationScreen extends StatelessWidget {
  final String email;
  final OtpSessionData sessionData;

  const OtpVerificationScreen({
    super.key,
    required this.email,
    required this.sessionData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: _OtpVerificationView(email: email, sessionData: sessionData),
    );
  }
}

class _OtpVerificationView extends StatefulWidget {
  final String email;
  final OtpSessionData sessionData;

  const _OtpVerificationView({
    required this.email,
    required this.sessionData,
  });

  @override
  State<_OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<_OtpVerificationView> {
  static const int _otpLength = 6;

  final List<TextEditingController> _controllers =
      List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(_otpLength, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    // Auto-submit when all 6 digits entered
    if (_otp.length == _otpLength) {
      _submitOtp();
    }
    setState(() {});
  }

  void _submitOtp() {
    if (_otp.length < _otpLength) return;
    context.read<AuthBloc>().add(
          VerifyOtpRequested(
            email: widget.email,
            otp: _otp,
            preAuthSessionId: widget.sessionData.preAuthSessionId,
            deviceId: widget.sessionData.deviceId,
          ),
        );
  }

  void _resendOtp() {
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes.first.requestFocus();
    context.read<AuthBloc>().add(SendOtpRequested(email: widget.email));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          if (state.user.preferencesCompleted) {
            context.goNamed(RouteNames.home);
          } else {
            context.goNamed(RouteNames.preferences);
          }
        } else if (state is OtpSent) {
          // OTP resent — show confirmation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.otpResent),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
        } else if (state is AuthError) {
          // Clear OTP boxes on error so user can retry
          for (final c in _controllers) {
            c.clear();
          }
          _focusNodes.first.requestFocus();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.background.dark.withValues(alpha: 0.9),
                      AppColors.background.dark,
                    ],
                  )
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFE8F5E9), Color(0xFFFFFFFF)],
                  ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: context.textPrimaryColor,
                        size: 20.sp,
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Icon
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: context.primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.mark_email_read_outlined,
                      size: 40.sp,
                      color: context.primaryColor,
                    ),
                  )
                      .animate()
                      .scale(duration: 400.ms, curve: Curves.elasticOut),

                  SizedBox(height: 28.h),

                  Text(
                    l10n.enterOtpTitle,
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: context.textPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

                  SizedBox(height: 12.h),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: context.textSecondaryColor,
                      ),
                      children: [
                        TextSpan(text: '${l10n.otpSentTo} '),
                        TextSpan(
                          text: widget.email,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: context.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                  SizedBox(height: 48.h),

                  // OTP boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_otpLength, (index) {
                      return _OtpBox(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        onChanged: (v) => _onOtpChanged(index, v),
                        onTap: () => _controllers[index].selection =
                            TextSelection.fromPosition(
                          TextPosition(
                              offset: _controllers[index].text.length),
                        ),
                      ).animate(delay: (index * 60).ms)
                          .slideY(begin: 0.3, duration: 350.ms, curve: Curves.easeOut)
                          .fadeIn();
                    }),
                  ),

                  SizedBox(height: 40.h),

                  // Verify button
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading || _otp.length < _otpLength
                              ? null
                              : _submitOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.primaryColor,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                                context.primaryColor.withValues(alpha: 0.4),
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? SizedBox(
                                  height: 22.h,
                                  width: 22.h,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  l10n.verifyOtp,
                                  style: AppTextStyles.buttonLarge,
                                ),
                        ),
                      );
                    },
                  ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

                  SizedBox(height: 28.h),

                  // Resend
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.didNotReceiveOtp,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: context.textSecondaryColor,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          GestureDetector(
                            onTap: isLoading ? null : _resendOtp,
                            child: Text(
                              l10n.resendOtp,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isLoading
                                    ? context.textSecondaryColor
                                    : context.primaryColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ).animate().fadeIn(delay: 500.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A single OTP digit input box
class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onTap;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.w,
      height: 56.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: focusNode.hasFocus
              ? context.primaryColor
              : context.borderColor,
          width: focusNode.hasFocus ? 2 : 1.5,
        ),
        boxShadow: focusNode.hasFocus
            ? [
                BoxShadow(
                  color: context.primaryColor.withValues(alpha: 0.18),
                  blurRadius: 8,
                  spreadRadius: 1,
                )
              ]
            : [],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onTap: onTap,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: AppTextStyles.headlineMedium.copyWith(
          color: context.textPrimaryColor,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        cursorColor: context.primaryColor,
      ),
    );
  }
}
