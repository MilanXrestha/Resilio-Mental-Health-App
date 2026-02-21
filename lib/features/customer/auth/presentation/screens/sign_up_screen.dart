import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/utils/validators.dart';
import '../../../../../common/widgets/app_text_field.dart';
import '../../../../../common/widgets/settings_toggle_widget.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../l10n/app_localizations.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// Sign up screen with email/password and Google sign-in
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: const _SignUpView(),
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView();

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUpPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            SignUpRequested(
              email: _emailController.text.trim(),
              password: _passwordController.text,
              name: _nameController.text.trim(),
            ),
          );
    }
  }

  void _onGoogleSignInPressed() {
    context.read<AuthBloc>().add(GoogleSignInRequested());
  }

  void _onFacebookSignInPressed() {
    context.read<AuthBloc>().add(FacebookSignInRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.goNamed(RouteNames.home);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
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
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Settings toggle (language + theme)
                      const SettingsToggleWidget(),

                      SizedBox(height: 40.h),

                      // Logo
                      Image.asset(
                        'assets/icons/png/wellness_logo.png',
                        height: 80.h,
                      ),

                      SizedBox(height: 32.h),

                      // Welcome text
                      Text(
                        l10n.createAccount,
                        style: AppTextStyles.displayLarge.copyWith(
                          color: context.textPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        l10n.startJourney,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: context.textSecondaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 32.h),

                      // Name field
                      AppTextField(
                        controller: _nameController,
                        label: l10n.fullName,
                        hint: l10n.fullNameHint,
                        prefixIcon: Icons.person_outline,
                        validator: Validators.validateFullName,
                      ),

                      SizedBox(height: 16.h),

                      // Email field
                      AppTextField(
                        controller: _emailController,
                        label: l10n.email,
                        hint: l10n.emailHint,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        validator: Validators.validateEmail,
                      ),

                      SizedBox(height: 16.h),

                      // Password field
                      AppTextField(
                        controller: _passwordController,
                        label: l10n.password,
                        hint: l10n.passwordHint,
                        obscureText: !_isPasswordVisible,
                        prefixIcon: Icons.lock_outlined,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: context.textSecondaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        validator: (value) => Validators.validateSimplePassword(value, minLength: 6),
                      ),

                      SizedBox(height: 16.h),

                      // Confirm Password field
                      AppTextField(
                        controller: _confirmPasswordController,
                        label: l10n.confirmPassword,
                        hint: l10n.confirmPasswordHint,
                        obscureText: !_isConfirmPasswordVisible,
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: context.textSecondaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        validator: (value) => Validators.validateConfirmPassword(value, _passwordController.text),
                      ),

                      SizedBox(height: 24.h),

                      // Sign up button
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isLoading = state is AuthLoading;
                          return ElevatedButton(
                            onPressed: isLoading ? null : _onSignUpPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.primaryColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    l10n.signUp,
                                    style: AppTextStyles.buttonLarge,
                                  ),
                          );
                        },
                      ),

                      SizedBox(height: 16.h),

                      // Or divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: context.borderColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              l10n.or,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: context.textSecondaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: context.borderColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      // Google sign in button
                      OutlinedButton.icon(
                        onPressed: _onGoogleSignInPressed,
                        icon: SvgPicture.asset(
                          'assets/icons/svg/ic_google.svg',
                          width: 20.sp,
                          height: 20.sp,
                        ),
                        label: Text(
                          l10n.continueWithGoogle,
                          style: AppTextStyles.buttonMedium.copyWith(
                            color: context.textPrimaryColor,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          side: BorderSide(color: context.borderColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Facebook sign in button
                      OutlinedButton.icon(
                        onPressed: _onFacebookSignInPressed,
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          size: 20.sp,
                          color: const Color(0xFF1877F2),
                        ),
                        label: Text(
                          l10n.continueWithFacebook,
                          style: AppTextStyles.buttonMedium.copyWith(
                            color: context.textPrimaryColor,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          side: BorderSide(color: context.borderColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Login link - moved to next line
                      Column(
                        children: [
                          Text(
                            l10n.alreadyHaveAccount,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: context.textSecondaryColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: () {
                              context.goNamed(RouteNames.login);
                            },
                            child: Text(
                              l10n.login,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: context.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}