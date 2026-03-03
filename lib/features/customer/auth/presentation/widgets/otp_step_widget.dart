import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:Resilio/common/widgets/settings_toggle_widget.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/theme/app_text_styles.dart';
import 'package:Resilio/l10n/app_localizations.dart';
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_bloc.dart';
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_state.dart';

import 'otp_input_row.dart';

class OtpStepWidget extends StatelessWidget {
  final String email;
  final List<TextEditingController> otpControllers;
  final List<FocusNode> otpFocusNodes;
  final int otpLength;
  final int resendCountdown;
  final void Function(int index, String value) onOtpChanged;
  final VoidCallback onVerify;
  final VoidCallback onResend;
  final VoidCallback onBack;

  const OtpStepWidget({
    super.key,
    required this.email,
    required this.otpControllers,
    required this.otpFocusNodes,
    required this.otpLength,
    required this.resendCountdown,
    required this.onOtpChanged,
    required this.onVerify,
    required this.onResend,
    required this.onBack,
  });

  String get _otp => otpControllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Settings toggle (language + theme)
          const SettingsToggleWidget(),

          SizedBox(height: 20.h),

          // Logo
          Image.asset(
            'assets/icons/png/wellness_logo.png',
            height: 100.h,
          ),

          SizedBox(height: 10.h),

          // Title
          Text(
            l10n.enterOtpTitle,
            style: AppTextStyles.displayLarge.copyWith(
              color: context.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8.h),

          // Subtitle with email
          _OtpSubtitle(email: email),

          SizedBox(height: 32.h),

          // OTP Input container with better styling
          _OtpInputContainer(
            otpControllers: otpControllers,
            otpFocusNodes: otpFocusNodes,
            otpLength: otpLength,
            onOtpChanged: onOtpChanged,
          ),

          SizedBox(height: 32.h),

          // Verify button
          _VerifyButton(
            otp: _otp,
            otpLength: otpLength,
            onVerify: onVerify,
          ),

          SizedBox(height: 24.h),

          // Resend OTP row
          _ResendOtpRow(
            resendCountdown: resendCountdown,
            onResend: onResend,
          ),

          SizedBox(height: 32.h),

          // Change email link
          _ChangeEmailLink(onTap: onBack),
        ],
      ),
    );
  }
}

class _OtpSubtitle extends StatelessWidget {
  final String email;

  const _OtpSubtitle({required this.email});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          l10n.otpSentTo,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.textSecondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: context.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedMail01,
                color: context.primaryColor,
                size: 16.sp,
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  email,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: context.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OtpInputContainer extends StatelessWidget {
  final List<TextEditingController> otpControllers;
  final List<FocusNode> otpFocusNodes;
  final int otpLength;
  final void Function(int index, String value) onOtpChanged;

  const _OtpInputContainer({
    required this.otpControllers,
    required this.otpFocusNodes,
    required this.otpLength,
    required this.onOtpChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.white.withValues(alpha: 0.03)
            : Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withValues(alpha: 0.08)
              : context.primaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: isDarkMode
            ? []
            : [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // OTP label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedKeyboard,
                color: context.textSecondaryColor,
                size: 16.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                'Enter 6-digit code',
                style: AppTextStyles.bodySmall.copyWith(
                  color: context.textSecondaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // OTP Input boxes
          OtpInputRow(
            otpControllers: otpControllers,
            otpFocusNodes: otpFocusNodes,
            otpLength: otpLength,
            onOtpChanged: onOtpChanged,
          ),
        ],
      ),
    );
  }
}

class _VerifyButton extends StatelessWidget {
  final String otp;
  final int otpLength;
  final VoidCallback onVerify;

  const _VerifyButton({
    required this.otp,
    required this.otpLength,
    required this.onVerify,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final isReady = otp.length == otpLength;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: ElevatedButton(
            onPressed: (isLoading || !isReady) ? null : onVerify,
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primaryColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor:
              context.primaryColor.withValues(alpha: 0.4),
              disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: isReady ? 2 : 0,
              shadowColor: context.primaryColor.withValues(alpha: 0.3),
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
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                  color: Colors.white,
                  size: 22.sp,
                ),
                SizedBox(width: 10.w),
                Text(
                  l10n.verifyOtp,
                  style: AppTextStyles.buttonLarge,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ResendOtpRow extends StatelessWidget {
  final int resendCountdown;
  final VoidCallback onResend;

  const _ResendOtpRow({
    required this.resendCountdown,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final canResend = resendCountdown <= 0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HugeIcon(
            icon: canResend
                ? HugeIcons.strokeRoundedRefresh
                : HugeIcons.strokeRoundedClock01,
            color: canResend
                ? context.primaryColor
                : context.textSecondaryColor,
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            l10n.didNotReceiveOtp,
            style: AppTextStyles.bodySmall.copyWith(
              color: context.textSecondaryColor,
            ),
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: canResend ? onResend : null,
            child: Text(
              canResend
                  ? l10n.resendOtp
                  : '${l10n.resendOtp} (${resendCountdown}s)',
              style: AppTextStyles.bodySmall.copyWith(
                color: canResend
                    ? context.primaryColor
                    : context.textSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChangeEmailLink extends StatelessWidget {
  final VoidCallback onTap;

  const _ChangeEmailLink({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: context.primaryColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedEdit02,
                color: context.primaryColor,
                size: 16.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                l10n.changeEmail,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}