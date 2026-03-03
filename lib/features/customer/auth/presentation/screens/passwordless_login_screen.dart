import 'dart:async';

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

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// A standalone, two-step passwordless login screen (email → OTP).
///
/// Carries its own [BlocProvider<AuthBloc>] so it is fully self-contained and
/// avoids the "Provider<AuthBloc> not found" error that occurs when an
/// AlertDialog opens in a context outside the provider tree.
class PasswordlessLoginScreen extends StatelessWidget {
  const PasswordlessLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: const _PasswordlessLoginView(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _PasswordlessLoginView extends StatefulWidget {
  const _PasswordlessLoginView();

  @override
  State<_PasswordlessLoginView> createState() => _PasswordlessLoginViewState();
}

class _PasswordlessLoginViewState extends State<_PasswordlessLoginView>
    with SingleTickerProviderStateMixin {
  // Step 1 — Email
  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();

  // Step 2 — OTP
  static const int _otpLength = 6;
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes =
      List.generate(6, (_) => FocusNode());

  bool _onOtpStep = false;
  String _sentEmail = '';

  // Resend countdown
  int _resendCountdown = 60;
  Timer? _resendTimer;

  late final AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    for (final c in _otpControllers) { c.dispose(); }
    for (final f in _otpFocusNodes) { f.dispose(); }
    _resendTimer?.cancel();
    _slideController.dispose();
    super.dispose();
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  String get _otp => _otpControllers.map((c) => c.text).join();

  void _startResendTimer() {
    _resendCountdown = 60;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_resendCountdown <= 0) {
        _resendTimer?.cancel();
      } else {
        if (mounted) setState(() => _resendCountdown--);
      }
    });
  }

  void _sendOtp() {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) return;
    _sentEmail = email;
    context.read<AuthBloc>().add(SendOtpRequested(email: email));
  }

  void _submitOtp() {
    if (_otp.length < _otpLength) return;
    context.read<AuthBloc>().add(
          VerifyOtpRequested(
            email: _sentEmail,
            otp: _otp,
            preAuthSessionId:
                (context.read<AuthBloc>().state as OtpSent?)?.sessionData.preAuthSessionId ?? '',
            deviceId:
                (context.read<AuthBloc>().state as OtpSent?)?.sessionData.deviceId ?? '',
          ),
        );
  }

  void _resendOtp() {
    if (_resendCountdown > 0) return;
    for (final c in _otpControllers) { c.clear(); }
    _otpFocusNodes.first.requestFocus();
    context.read<AuthBloc>().add(SendOtpRequested(email: _sentEmail));
    _startResendTimer();
  }

  void _goToOtpStep() {
    setState(() => _onOtpStep = true);
    _startResendTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _otpFocusNodes.first.requestFocus();
    });
  }

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < _otpLength - 1) {
      _otpFocusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
    if (_otp.length == _otpLength) {
      // Give the keyboard a frame to close cleanly, then auto-submit
      Future.delayed(const Duration(milliseconds: 120), _submitOtp);
    }
    setState(() {});
  }

  // ─────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpSent && !_onOtpStep) {
          _goToOtpStep();
        } else if (state is OtpSent && _onOtpStep) {
          // OTP resent
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('New code sent! Check your inbox.'),
              backgroundColor: Colors.green.shade600,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
          );
        } else if (state is AuthAuthenticated) {
          if (state.user.preferencesCompleted) {
            context.goNamed(RouteNames.home);
          } else {
            context.goNamed(RouteNames.preferences);
          }
        } else if (state is AuthError) {
        for (final c in _otpControllers) { c.clear(); }
        if (_onOtpStep) { _otpFocusNodes.first.requestFocus(); }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red.shade600,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.background.dark,
                      const Color(0xFF0A2010),
                    ],
                  )
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFE8F5E9), Color(0xFFF1F8E9)],
                  ),
          ),
          child: SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 380),
              transitionBuilder: (child, animation) {
                final slide = Tween<Offset>(
                  begin: const Offset(0.15, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                    parent: animation, curve: Curves.easeOutCubic));
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(position: slide, child: child),
                );
              },
              child: _onOtpStep
                  ? _OtpStep(
                      key: const ValueKey('otp'),
                      email: _sentEmail,
                      otpControllers: _otpControllers,
                      otpFocusNodes: _otpFocusNodes,
                      onOtpChanged: _onOtpChanged,
                      onVerify: _submitOtp,
                      onResend: _resendOtp,
                      resendCountdown: _resendCountdown,
                      onBack: () {
                        setState(() {
                          _onOtpStep = false;
                          for (final c in _otpControllers) { c.clear(); }
                        });
                        _resendTimer?.cancel();
                      },
                    )
                  : _EmailStep(
                      key: const ValueKey('email'),
                      emailController: _emailController,
                      emailFocus: _emailFocus,
                      onSend: _sendOtp,
                      onBack: () => context.pop(),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Step 1 — Email entry
// ─────────────────────────────────────────────────────────────────────────────

class _EmailStep extends StatelessWidget {
  final TextEditingController emailController;
  final FocusNode emailFocus;
  final VoidCallback onSend;
  final VoidCallback onBack;

  const _EmailStep({
    super.key,
    required this.emailController,
    required this.emailFocus,
    required this.onSend,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Back
          Align(
            alignment: Alignment.centerLeft,
            child: _BackButton(onTap: onBack),
          ),

          SizedBox(height: 40.h),

          // Icon hero
          Center(
            child: Container(
              width: 90.w,
              height: 90.w,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    context.primaryColor.withValues(alpha: 0.25),
                    context.primaryColor.withValues(alpha: 0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.mark_email_unread_outlined,
                size: 44.sp,
                color: context.primaryColor,
              ),
            )
                .animate()
                .scale(duration: 500.ms, curve: Curves.elasticOut)
                .fadeIn(),
          ),

          SizedBox(height: 32.h),

          Text(
            'Sign in with Email',
            style: AppTextStyles.headlineLarge.copyWith(
              color: context.textPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 100.ms, duration: 350.ms),

          SizedBox(height: 10.h),

          Text(
            "We'll send a one-time code to your inbox.\nNo password needed.",
            style: AppTextStyles.bodyMedium.copyWith(
              color: context.textSecondaryColor,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 180.ms, duration: 350.ms),

          SizedBox(height: 48.h),

          // Email card
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : context.primaryColor.withValues(alpha: 0.15),
              ),
              boxShadow: isDark
                  ? []
                  : [
                      BoxShadow(
                        color: context.primaryColor.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      )
                    ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email address',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 10.h),
                TextField(
                  controller: emailController,
                  focusNode: emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => onSend(),
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'you@example.com',
                    hintStyle: AppTextStyles.bodyLarge.copyWith(
                      color: context.textSecondaryColor.withValues(alpha: 0.5),
                    ),
                    prefixIcon: Icon(
                      Icons.alternate_email_rounded,
                      color: context.primaryColor,
                      size: 20.sp,
                    ),
                    filled: true,
                    fillColor: isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : context.primaryColor.withValues(alpha: 0.04),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide(
                        color: context.primaryColor.withValues(alpha: 0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide(
                        color: context.primaryColor,
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 14.h),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 260.ms, duration: 350.ms).slideY(
                begin: 0.15,
                curve: Curves.easeOut,
                duration: 350.ms,
                delay: 260.ms,
              ),

          SizedBox(height: 28.h),

          // Send button
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final isLoading = state is AuthLoading;
              return _GradientButton(
                onTap: isLoading ? null : onSend,
                isLoading: isLoading,
                label: 'Send Code',
                icon: Icons.send_rounded,
              );
            },
          ).animate().fadeIn(delay: 340.ms, duration: 350.ms),

          SizedBox(height: 32.h),

          // Info chip
          Center(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: context.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                    color: context.primaryColor.withValues(alpha: 0.15)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shield_outlined,
                      size: 16.sp, color: context.primaryColor),
                  SizedBox(width: 6.w),
                  Text(
                    'Secured by SuperTokens',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: context.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 420.ms),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Step 2 — OTP entry
// ─────────────────────────────────────────────────────────────────────────────

class _OtpStep extends StatelessWidget {
  final String email;
  final List<TextEditingController> otpControllers;
  final List<FocusNode> otpFocusNodes;
  final void Function(int, String) onOtpChanged;
  final VoidCallback onVerify;
  final VoidCallback onResend;
  final int resendCountdown;
  final VoidCallback onBack;

  const _OtpStep({
    super.key,
    required this.email,
    required this.otpControllers,
    required this.otpFocusNodes,
    required this.onOtpChanged,
    required this.onVerify,
    required this.onResend,
    required this.resendCountdown,
    required this.onBack,
  });

  String get _otp => otpControllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: _BackButton(onTap: onBack),
          ),

          SizedBox(height: 36.h),

          // Animated envelope icon
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 90.w,
                height: 90.w,
                decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                    context.primaryColor.withValues(alpha: 0.2),
                    context.primaryColor.withValues(alpha: 0.03),
                  ]),
                  shape: BoxShape.circle,
                ),
              ),
              Icon(Icons.mark_email_read_outlined,
                  size: 44.sp, color: context.primaryColor),
            ],
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scaleXY(
                  end: 1.06,
                  duration: 1800.ms,
                  curve: Curves.easeInOut)
              .animate()
              .scale(duration: 500.ms, curve: Curves.elasticOut)
              .fadeIn(),

          SizedBox(height: 28.h),

          Text(
            'Check your inbox',
            style: AppTextStyles.headlineLarge.copyWith(
              color: context.textPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 80.ms),

          SizedBox(height: 10.h),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTextStyles.bodyMedium
                  .copyWith(color: context.textSecondaryColor, height: 1.5),
              children: [
                const TextSpan(text: 'We sent a 6-digit code to\n'),
                TextSpan(
                  text: email,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: context.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 160.ms),

          SizedBox(height: 44.h),

          // OTP boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) {
              return _OtpBox(
                controller: otpControllers[index],
                focusNode: otpFocusNodes[index],
                onChanged: (v) => onOtpChanged(index, v),
                onTap: () {
                  otpControllers[index].selection =
                      TextSelection.fromPosition(
                    TextPosition(
                        offset: otpControllers[index].text.length),
                  );
                },
              )
                  .animate(delay: (index * 55).ms)
                  .slideY(begin: 0.4, duration: 380.ms, curve: Curves.easeOut)
                  .fadeIn();
            }),
          ),

          SizedBox(height: 40.h),

          // Verify button
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final isLoading = state is AuthLoading;
              final ready = _otp.length == 6;
              return _GradientButton(
                onTap: (isLoading || !ready) ? null : onVerify,
                isLoading: isLoading,
                label: 'Verify & Sign In',
                icon: Icons.verified_user_rounded,
              );
            },
          ).animate().fadeIn(delay: 400.ms),

          SizedBox(height: 28.h),

          // Resend row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive it? ",
                style: AppTextStyles.bodyMedium
                    .copyWith(color: context.textSecondaryColor),
              ),
              GestureDetector(
                onTap: resendCountdown > 0 ? null : onResend,
                child: Text(
                  resendCountdown > 0
                      ? 'Resend in ${resendCountdown}s'
                      : 'Resend code',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: resendCountdown > 0
                        ? context.textSecondaryColor
                        : context.primaryColor,
                    fontWeight: FontWeight.w700,
                    decoration: resendCountdown > 0
                        ? TextDecoration.none
                        : TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 480.ms),

          SizedBox(height: 16.h),

          // Security note
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.timer_outlined,
                    size: 16.sp, color: Colors.amber.shade700),
                SizedBox(width: 8.w),
                Text(
                  'Code expires in 15 minutes',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.amber.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 550.ms),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared widgets
// ─────────────────────────────────────────────────────────────────────────────

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: context.primaryColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          size: 18.sp,
          color: context.primaryColor,
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isLoading;
  final String label;
  final IconData icon;

  const _GradientButton({
    required this.onTap,
    required this.isLoading,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null && !isLoading;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: enabled
              ? LinearGradient(
                  colors: [
                    context.primaryColor,
                    context.primaryColor.withValues(alpha: 0.75),
                  ],
                )
              : LinearGradient(
                  colors: [
                    context.primaryColor.withValues(alpha: 0.35),
                    context.primaryColor.withValues(alpha: 0.25),
                  ],
                ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: context.primaryColor.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  )
                ]
              : [],
        ),
        child: Center(
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: Colors.white, size: 20.sp),
                    SizedBox(width: 10.w),
                    Text(
                      label,
                      style: AppTextStyles.buttonLarge
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _OtpBox extends StatefulWidget {
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
  State<_OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<_OtpBox> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final focused = widget.focusNode.hasFocus;
    final filled = widget.controller.text.isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 46.w,
      height: 58.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: focused
            ? context.primaryColor.withValues(alpha: 0.08)
            : filled
                ? context.primaryColor.withValues(alpha: 0.05)
                : context.backgroundColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: focused
              ? context.primaryColor
              : filled
                  ? context.primaryColor.withValues(alpha: 0.4)
                  : context.borderColor,
          width: focused ? 2.2 : 1.5,
        ),
        boxShadow: focused
            ? [
                BoxShadow(
                  color: context.primaryColor.withValues(alpha: 0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ]
            : [],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: AppTextStyles.headlineMedium.copyWith(
          color: context.textPrimaryColor,
          fontWeight: FontWeight.w700,
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
