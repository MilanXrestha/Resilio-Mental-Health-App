import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:Resilio/common/widgets/app_text_field.dart';
import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/core/routing/route_names.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/l10n/app_localizations.dart';
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_bloc.dart';
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_event.dart';
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_state.dart';
import 'package:Resilio/features/customer/auth/presentation/widgets/email_step_widget.dart';
import 'package:Resilio/features/customer/auth/presentation/widgets/otp_step_widget.dart';

/// A standalone, two-step passwordless login screen (email → OTP).
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

class _PasswordlessLoginView extends StatefulWidget {
  const _PasswordlessLoginView();

  @override
  State<_PasswordlessLoginView> createState() => _PasswordlessLoginViewState();
}

class _PasswordlessLoginViewState extends State<_PasswordlessLoginView> {
  // Step 1 — Email
  final _emailController = TextEditingController();
  final _emailFormKey = GlobalKey<FormState>();

  // Step 2 — OTP
  static const int _otpLength = 6;
  final List<TextEditingController> _otpControllers =
  List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes =
  List.generate(_otpLength, (_) => FocusNode());

  bool _onOtpStep = false;
  String _sentEmail = '';

  // Resend countdown
  int _resendCountdown = 60;
  Timer? _resendTimer;

  @override
  void dispose() {
    _emailController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _otpFocusNodes) {
      f.dispose();
    }
    _resendTimer?.cancel();
    super.dispose();
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

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
    if (!(_emailFormKey.currentState?.validate() ?? false)) return;
    final email = _emailController.text.trim();
    _sentEmail = email;
    context.read<AuthBloc>().add(SendOtpRequested(email: email));
  }

  void _submitOtp() {
    if (_otp.length < _otpLength) return;
    final state = context.read<AuthBloc>().state;
    String preAuthSessionId = '';
    String deviceId = '';

    if (state is OtpSent) {
      preAuthSessionId = state.sessionData.preAuthSessionId;
      deviceId = state.sessionData.deviceId;
    }

    context.read<AuthBloc>().add(
      VerifyOtpRequested(
        email: _sentEmail,
        otp: _otp,
        preAuthSessionId: preAuthSessionId,
        deviceId: deviceId,
      ),
    );
  }

  void _resendOtp() {
    if (_resendCountdown > 0) return;
    _clearOtpFields();
    _otpFocusNodes.first.requestFocus();
    context.read<AuthBloc>().add(SendOtpRequested(email: _sentEmail));
    _startResendTimer();
  }

  void _clearOtpFields() {
    for (final c in _otpControllers) {
      c.clear();
    }
  }

  void _goToOtpStep() {
    setState(() => _onOtpStep = true);
    _startResendTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_otpFocusNodes.isNotEmpty) {
        _otpFocusNodes.first.requestFocus();
      }
    });
  }

  void _goBackToEmailStep() {
    setState(() {
      _onOtpStep = false;
      _clearOtpFields();
    });
    _resendTimer?.cancel();
  }

  void _onOtpChanged(int index, String value) {
    // Handle paste - if user pastes full OTP
    if (value.length > 1) {
      _handlePaste(value);
      return;
    }

    if (value.length == 1 && index < _otpLength - 1) {
      _otpFocusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
    if (_otp.length == _otpLength) {
      // Auto-submit after a short delay
      Future.delayed(const Duration(milliseconds: 150), _submitOtp);
    }
    setState(() {});
  }

  void _handlePaste(String pastedText) {
    final digits = pastedText.replaceAll(RegExp(r'[^0-9]'), '');
    for (int i = 0; i < _otpLength && i < digits.length; i++) {
      _otpControllers[i].text = digits[i];
    }
    if (digits.length >= _otpLength) {
      _otpFocusNodes.last.requestFocus();
      Future.delayed(const Duration(milliseconds: 150), _submitOtp);
    } else if (digits.isNotEmpty) {
      _otpFocusNodes[digits.length.clamp(0, _otpLength - 1)].requestFocus();
    }
    setState(() {});
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpSent && !_onOtpStep) {
          _goToOtpStep();
        } else if (state is OtpSent && _onOtpStep) {
          // OTP resent
          _showSnackBar(l10n.newCodeSent);
        } else if (state is AuthAuthenticated) {
          if (state.user.role == 'admin') {
            context.goNamed(RouteNames.adminDashboard);
          } else if (state.user.role == 'therapist') {
            context.goNamed(RouteNames.therapistDashboard);
          } else {
            if (state.user.preferencesCompleted) {
              context.goNamed(RouteNames.home);
            } else {
              context.goNamed(RouteNames.preferences);
            }
          }
        } else if (state is AuthError) {
          _clearOtpFields();
          if (_onOtpStep && _otpFocusNodes.isNotEmpty) {
            _otpFocusNodes.first.requestFocus();
          }
          _showSnackBar(state.message, isError: true);
        }
      },
      child: UnfocusOnTap(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: isDarkMode
                  ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.background.dark.withValues(alpha: 0.8),
                  AppColors.background.dark,
                ],
              )
                  : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFE8F5E9),
                  context.backgroundColor,
                ],
              ),
            ),
            child: SafeArea(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  final slide = Tween<Offset>(
                    begin: const Offset(0.08, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ));
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(position: slide, child: child),
                  );
                },
                child: _onOtpStep
                    ? OtpStepWidget(
                  key: const ValueKey('otp_step'),
                  email: _sentEmail,
                  otpControllers: _otpControllers,
                  otpFocusNodes: _otpFocusNodes,
                  otpLength: _otpLength,
                  resendCountdown: _resendCountdown,
                  onOtpChanged: _onOtpChanged,
                  onVerify: _submitOtp,
                  onResend: _resendOtp,
                  onBack: _goBackToEmailStep,
                )
                    : EmailStepWidget(
                  key: const ValueKey('email_step'),
                  formKey: _emailFormKey,
                  emailController: _emailController,
                  onSendOtp: _sendOtp,
                  onBack: () => context.pop(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}