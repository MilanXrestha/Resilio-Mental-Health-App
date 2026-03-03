// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Resilio';

  @override
  String get appSubtitle => 'Breathe. Move. Thrive.';

  @override
  String get appVersion => 'v1.0.0';

  @override
  String get copyright => 'Copyright © 2026 Resilio App.\nAll rights reserved.';

  @override
  String get login => 'LOGIN';

  @override
  String get adminLogin => 'Admin Login';

  @override
  String get signUp => 'SIGN UP';

  @override
  String get createAccount => 'Create Account';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get startJourney => 'Start your wellness journey with Resilio';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Confirm your password';

  @override
  String get fullName => 'Full Name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get or => 'OR CONTINUE WITH';

  @override
  String get continueWithGoogle => 'Google';

  @override
  String get continueWithFacebook => 'Facebook';

  @override
  String get passwordlessLogin => 'OTP Login';

  @override
  String get passwordlessSubtitle =>
      'We\'ll send a 6-digit code to your email. No password needed.';

  @override
  String get sendOtp => 'Send Code';

  @override
  String get enterOtpTitle => 'Enter Verification Code';

  @override
  String get otpSentTo => 'We sent a 6-digit code to';

  @override
  String get verifyOtp => 'Verify & Sign In';

  @override
  String get didNotReceiveOtp => 'Didn\'t receive the code?';

  @override
  String get resendOtp => 'Resend';

  @override
  String resendOtpIn(Object seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get otpResent => 'A new code has been sent to your email.';

  @override
  String get newCodeSent => 'New code sent! Check your inbox.';

  @override
  String get securedBy => 'Secured by SuperTokens';

  @override
  String get cancel => 'Cancel';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get changeEmail => 'Change Email';

  @override
  String get onboardingTitle1 => 'Welcome to Resilio';

  @override
  String get onboardingDescription1 =>
      'Your journey to mental wellness starts here. Discover mindfulness and peace.';

  @override
  String get onboardingTitle2 => 'Mindful Meditation';

  @override
  String get onboardingDescription2 =>
      'Practice meditation and build habits that support your mental health.';

  @override
  String get onboardingTitle3 => 'Share Your Progress';

  @override
  String get onboardingDescription3 =>
      'Track your journey and share your progress with loved ones.';

  @override
  String get onboardingTitle4 => 'Let\'s Get Started';

  @override
  String get onboardingDescription4 =>
      'You\'re ready to begin. Take the first step towards a calmer mind.';

  @override
  String get nextButton => 'Next';

  @override
  String get skipButton => 'Skip';

  @override
  String get startButton => 'Get Started';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageNepali => 'नेपाली';

  @override
  String get signInToContinue => 'Sign in to continue your wellness journey';
}
