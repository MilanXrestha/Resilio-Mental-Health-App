import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:Resilio/common/utils/validators.dart';
import 'package:Resilio/common/widgets/app_text_field.dart';
import 'package:Resilio/common/widgets/settings_toggle_widget.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/theme/app_text_styles.dart';
import 'package:Resilio/l10n/app_localizations.dart';
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_bloc.dart';
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_state.dart';

class EmailStepWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final VoidCallback onSendOtp;
  final VoidCallback onBack;

  const EmailStepWidget({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.onSendOtp,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      child: Form(
        key: formKey,
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
              l10n.passwordlessLogin,
              style: AppTextStyles.displayLarge.copyWith(
                color: context.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 8.h),

            // Subtitle
            Text(
              l10n.passwordlessSubtitle,
              style: AppTextStyles.bodyMedium.copyWith(
                color: context.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40.h),

            // Email field
            AppTextField(
              controller: emailController,
              label: l10n.email,
              hint: l10n.emailHint,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              textInputAction: TextInputAction.done,
              validator: Validators.validateEmail,
              onSubmitted: (_) => onSendOtp(),
            ),

            SizedBox(height: 24.h),

            // Send OTP button
            _SendOtpButton(onPressed: onSendOtp),

            SizedBox(height: 24.h),

            // Secured by badge
            const _SecuredByBadge(),

            SizedBox(height: 32.h),

            // Back to login link
            _BackToLoginLink(onTap: onBack),
          ],
        ),
      ),
    );
  }
}

class _SendOtpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SendOtpButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: context.primaryColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
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
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedMailSend01,
                color: Colors.white,
                size: 22.sp,
              ),
              SizedBox(width: 10.w),
              Text(
                l10n.sendOtp,
                style: AppTextStyles.buttonLarge,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SecuredByBadge extends StatelessWidget {
  const _SecuredByBadge();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: context.primaryColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: context.primaryColor.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedCheckList,
              color: context.primaryColor,
              size: 16.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              l10n.securedBy,
              style: AppTextStyles.bodySmall.copyWith(
                color: context.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackToLoginLink extends StatelessWidget {
  final VoidCallback onTap;

  const _BackToLoginLink({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          l10n.alreadyHaveAccount,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.textSecondaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft01,
                color: context.primaryColor,
                size: 18.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                l10n.backToLogin,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}