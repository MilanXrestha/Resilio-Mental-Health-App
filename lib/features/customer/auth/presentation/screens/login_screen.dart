import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:Resilio/common/utils/validators.dart';
import 'package:Resilio/common/widgets/app_text_field.dart';
import 'package:Resilio/common/widgets/settings_toggle_widget.dart';
import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/core/routing/route_names.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/theme/app_text_styles.dart';
import 'package:Resilio/l10n/app_localizations.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// Login screen with email/password and Google sign-in
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            LoginRequested(
              email: _emailController.text.trim(),
              password: _passwordController.text,
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

  void _onPasswordlessPressed() {
    context.pushNamed(RouteNames.passwordlessLogin);
  }

  void _showPasswordlessDialog() {
    final l10n = AppLocalizations.of(context)!;
    final emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        title: Row(
          children: [
            Icon(
              Icons.lock_open_rounded,
              color: context.primaryColor,
              size: 22.sp,
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                l10n.passwordlessLogin,
                style: AppTextStyles.headlineSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.passwordlessSubtitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: context.textSecondaryColor,
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: l10n.email,
                  hintText: l10n.emailHint,
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            onPressed: () {
              final email = emailController.text.trim();
              if (email.isNotEmpty) {
                Navigator.pop(dialogContext);
                context
                    .read<AuthBloc>()
                    .add(SendOtpRequested(email: email));
              }
            },
            child: Text(l10n.sendOtp),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
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

                      SizedBox(height: 20.h),

                      // Logo
                      Image.asset(
                        'assets/icons/png/wellness_logo.png',
                        height: 100.h,
                      ),

                      SizedBox(height: 10.h),

                      // Welcome text
                      Text(
                        l10n.welcomeBack,
                        style: AppTextStyles.displayLarge.copyWith(
                          color: context.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        l10n.signInToContinue,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: context.textSecondaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 40.h),

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

                      SizedBox(height: 12.h),

                      // Remember me checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                            activeColor: context.primaryColor,
                            side: BorderSide(
                              color: context.textSecondaryColor,
                            ),
                          ),
                          Text(
                            l10n.rememberMe,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      // Login button
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isLoading = state is AuthLoading;
                          return ElevatedButton(
                            onPressed: isLoading ? null : _onLoginPressed,
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
                                    l10n.login,
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

                      SizedBox(height: 12.h),

                      // Passwordless (SuperTokens OTP) button
                      OutlinedButton.icon(
                        onPressed: _onPasswordlessPressed,
                        icon: Icon(
                          Icons.lock_open_rounded,
                          size: 20.sp,
                          color: context.primaryColor,
                        ),
                        label: Text(
                          l10n.passwordlessLogin,
                          style: AppTextStyles.buttonMedium.copyWith(
                            color: context.textPrimaryColor,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          side: BorderSide(color: context.primaryColor.withValues(alpha: 0.5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Sign up link - moved to next line
                      Column(
                        children: [
                          Text(
                            l10n.dontHaveAccount,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: context.textSecondaryColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: () {
                              context.goNamed(RouteNames.register);
                            },
                            child: Text(
                              l10n.signUp,
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