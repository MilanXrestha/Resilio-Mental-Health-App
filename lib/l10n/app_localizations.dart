import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ne.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ne'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Resilio'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Breathe. Move. Thrive.'**
  String get appSubtitle;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'v1.0.0'**
  String get appVersion;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright © 2026 Resilio App.\nAll rights reserved.'**
  String get copyright;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get login;

  /// No description provided for @adminLogin.
  ///
  /// In en, this message translates to:
  /// **'Admin Login'**
  String get adminLogin;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'SIGN UP'**
  String get signUp;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @startJourney.
  ///
  /// In en, this message translates to:
  /// **'Start your wellness journey with Resilio'**
  String get startJourney;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmPasswordHint;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR CONTINUE WITH'**
  String get or;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get continueWithFacebook;

  /// No description provided for @passwordlessLogin.
  ///
  /// In en, this message translates to:
  /// **'OTP Login'**
  String get passwordlessLogin;

  /// No description provided for @passwordlessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send a 6-digit code to your email. No password needed.'**
  String get passwordlessSubtitle;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendOtp;

  /// No description provided for @enterOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterOtpTitle;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to'**
  String get otpSentTo;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify & Sign In'**
  String get verifyOtp;

  /// No description provided for @enter6DigitCode.
  ///
  /// In en, this message translates to:
  /// **'Enter 6-digit code'**
  String get enter6DigitCode;

  /// No description provided for @didNotReceiveOtp.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didNotReceiveOtp;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resendOtp;

  /// No description provided for @resendOtpIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String resendOtpIn(Object seconds);

  /// No description provided for @otpResent.
  ///
  /// In en, this message translates to:
  /// **'A new code has been sent to your email.'**
  String get otpResent;

  /// No description provided for @newCodeSent.
  ///
  /// In en, this message translates to:
  /// **'New code sent! Check your inbox.'**
  String get newCodeSent;

  /// No description provided for @securedBy.
  ///
  /// In en, this message translates to:
  /// **'Secured by SuperTokens'**
  String get securedBy;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change Email'**
  String get changeEmail;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Resilio'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDescription1.
  ///
  /// In en, this message translates to:
  /// **'Your journey to mental wellness starts here. Discover mindfulness and peace.'**
  String get onboardingDescription1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Mindful Meditation'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDescription2.
  ///
  /// In en, this message translates to:
  /// **'Practice meditation and build habits that support your mental health.'**
  String get onboardingDescription2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Share Your Progress'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDescription3.
  ///
  /// In en, this message translates to:
  /// **'Track your journey and share your progress with loved ones.'**
  String get onboardingDescription3;

  /// No description provided for @onboardingTitle4.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Get Started'**
  String get onboardingTitle4;

  /// No description provided for @onboardingDescription4.
  ///
  /// In en, this message translates to:
  /// **'You\'re ready to begin. Take the first step towards a calmer mind.'**
  String get onboardingDescription4;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @skipButton.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipButton;

  /// No description provided for @startButton.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get startButton;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageNepali.
  ///
  /// In en, this message translates to:
  /// **'नेपाली'**
  String get languageNepali;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your wellness journey'**
  String get signInToContinue;

  /// No description provided for @alertDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get alertDialogTitle;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @exitAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exitAppTitle;

  /// No description provided for @exitAppMessage.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to exit the app?'**
  String get exitAppMessage;

  /// No description provided for @exitButton.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exitButton;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String hello(String name);

  /// No description provided for @timeToUnwind.
  ///
  /// In en, this message translates to:
  /// **'Time to unwind'**
  String get timeToUnwind;

  /// No description provided for @setReminder.
  ///
  /// In en, this message translates to:
  /// **'Set Reminder'**
  String get setReminder;

  /// No description provided for @neverMissQuotes.
  ///
  /// In en, this message translates to:
  /// **'Never miss your favorite quotes'**
  String get neverMissQuotes;

  /// No description provided for @dailyInspiration.
  ///
  /// In en, this message translates to:
  /// **'Daily Inspiration'**
  String get dailyInspiration;

  /// No description provided for @swipeFeaturedQuotes.
  ///
  /// In en, this message translates to:
  /// **'Swipe through today\'s featured quotes'**
  String get swipeFeaturedQuotes;

  /// No description provided for @calmingAudio.
  ///
  /// In en, this message translates to:
  /// **'Calming Audio'**
  String get calmingAudio;

  /// No description provided for @meditationSessions.
  ///
  /// In en, this message translates to:
  /// **'Meditation & wellness sessions'**
  String get meditationSessions;

  /// No description provided for @shortVideos.
  ///
  /// In en, this message translates to:
  /// **'Short Videos'**
  String get shortVideos;

  /// No description provided for @quickMindfulness.
  ///
  /// In en, this message translates to:
  /// **'Quick mindfulness moments'**
  String get quickMindfulness;

  /// No description provided for @featuredVideos.
  ///
  /// In en, this message translates to:
  /// **'Featured Videos'**
  String get featuredVideos;

  /// No description provided for @inDepthContent.
  ///
  /// In en, this message translates to:
  /// **'In-depth wellness content'**
  String get inDepthContent;

  /// No description provided for @wellnessTips.
  ///
  /// In en, this message translates to:
  /// **'Wellness Tips'**
  String get wellnessTips;

  /// No description provided for @quickAdvice.
  ///
  /// In en, this message translates to:
  /// **'Quick advice for daily wellness'**
  String get quickAdvice;

  /// No description provided for @moreQuotes.
  ///
  /// In en, this message translates to:
  /// **'More Quotes'**
  String get moreQuotes;

  /// No description provided for @discoverWords.
  ///
  /// In en, this message translates to:
  /// **'Discover words to lift your spirit'**
  String get discoverWords;

  /// No description provided for @exploreCategories.
  ///
  /// In en, this message translates to:
  /// **'Explore Categories'**
  String get exploreCategories;

  /// No description provided for @findQuotes.
  ///
  /// In en, this message translates to:
  /// **'Find quotes that resonate with you'**
  String get findQuotes;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @wellnessExpert.
  ///
  /// In en, this message translates to:
  /// **'Wellness Expert'**
  String get wellnessExpert;

  /// No description provided for @yourTherapySessions.
  ///
  /// In en, this message translates to:
  /// **'Your Therapy Sessions'**
  String get yourTherapySessions;

  /// No description provided for @talkToProfessional.
  ///
  /// In en, this message translates to:
  /// **'Talk to a Professional'**
  String get talkToProfessional;

  /// No description provided for @viewUpcomingSessions.
  ///
  /// In en, this message translates to:
  /// **'View your upcoming and past sessions with your therapist.'**
  String get viewUpcomingSessions;

  /// No description provided for @findRightTherapist.
  ///
  /// In en, this message translates to:
  /// **'Find the right therapist for your mental wellness journey.'**
  String get findRightTherapist;

  /// No description provided for @mySessions.
  ///
  /// In en, this message translates to:
  /// **'My Sessions'**
  String get mySessions;

  /// No description provided for @getMatched.
  ///
  /// In en, this message translates to:
  /// **'Get Matched'**
  String get getMatched;

  /// No description provided for @findNew.
  ///
  /// In en, this message translates to:
  /// **'Find New'**
  String get findNew;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changeNameEmailPhoto.
  ///
  /// In en, this message translates to:
  /// **'Change your name, email, and photo'**
  String get changeNameEmailPhoto;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @managePremiumPlan.
  ///
  /// In en, this message translates to:
  /// **'Manage your premium plan'**
  String get managePremiumPlan;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @viewBillingHistory.
  ///
  /// In en, this message translates to:
  /// **'View your billing history'**
  String get viewBillingHistory;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirm;

  /// No description provided for @signOutAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get signOutAccount;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @profileSection.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileSection;

  /// No description provided for @yourProfile.
  ///
  /// In en, this message translates to:
  /// **'Your Profile'**
  String get yourProfile;

  /// No description provided for @manageAccountPrefs.
  ///
  /// In en, this message translates to:
  /// **'Manage account, subscription, and preferences'**
  String get manageAccountPrefs;

  /// No description provided for @appearanceSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceSection;

  /// No description provided for @generalSection.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get generalSection;

  /// No description provided for @resetToDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset to Defaults'**
  String get resetToDefaults;

  /// No description provided for @restoreThemeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Restore theme and language to defaults'**
  String get restoreThemeLanguage;

  /// No description provided for @settingsReset.
  ///
  /// In en, this message translates to:
  /// **'Settings reset to defaults'**
  String get settingsReset;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @errorLoadingSettings.
  ///
  /// In en, this message translates to:
  /// **'Error loading settings'**
  String get errorLoadingSettings;

  /// No description provided for @cacheCleared.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared successfully'**
  String get cacheCleared;

  /// No description provided for @clearCacheConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear cache?'**
  String get clearCacheConfirm;

  /// No description provided for @currentCacheSize.
  ///
  /// In en, this message translates to:
  /// **'Current cache size: {size}'**
  String currentCacheSize(String size);

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @clearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get clearCache;

  /// No description provided for @freeUpSpace.
  ///
  /// In en, this message translates to:
  /// **'Free up space'**
  String get freeUpSpace;

  /// No description provided for @freeUpSpaceSize.
  ///
  /// In en, this message translates to:
  /// **'Free up space · {size}'**
  String freeUpSpaceSize(String size);

  /// No description provided for @aboutResilio.
  ///
  /// In en, this message translates to:
  /// **'About Resilio'**
  String get aboutResilio;

  /// No description provided for @aboutResilioDesc.
  ///
  /// In en, this message translates to:
  /// **'Your mental wellness companion for a healthier, more balanced life. Resilio brings you guided meditations, expert tips, breathing exercises, and personalised wellness journeys — all in one place.'**
  String get aboutResilioDesc;

  /// No description provided for @madeWithLove.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Resilio Team · Made with ❤️ in Nepal'**
  String get madeWithLove;

  /// No description provided for @versionLearnMore.
  ///
  /// In en, this message translates to:
  /// **'Version {version} · Learn more'**
  String versionLearnMore(String version);

  /// No description provided for @myAppointments.
  ///
  /// In en, this message translates to:
  /// **'My Appointments'**
  String get myAppointments;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @dateNotSet.
  ///
  /// In en, this message translates to:
  /// **'Date not set'**
  String get dateNotSet;

  /// No description provided for @tapToMessage.
  ///
  /// In en, this message translates to:
  /// **'Tap to message your therapist'**
  String get tapToMessage;

  /// No description provided for @joinSession.
  ///
  /// In en, this message translates to:
  /// **'Join Session'**
  String get joinSession;

  /// No description provided for @sessionIn15Min.
  ///
  /// In en, this message translates to:
  /// **'Session in 15 minutes'**
  String get sessionIn15Min;

  /// No description provided for @sessionStartingSoon.
  ///
  /// In en, this message translates to:
  /// **'Your session with {name} starts soon.'**
  String sessionStartingSoon(String name);

  /// No description provided for @noUpcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'No upcoming appointments'**
  String get noUpcomingAppointments;

  /// No description provided for @noPastAppointments.
  ///
  /// In en, this message translates to:
  /// **'No past appointments'**
  String get noPastAppointments;

  /// No description provided for @myTherapy.
  ///
  /// In en, this message translates to:
  /// **'My Therapy'**
  String get myTherapy;

  /// No description provided for @errorLoadingAppointments.
  ///
  /// In en, this message translates to:
  /// **'Could not load appointments'**
  String get errorLoadingAppointments;

  /// No description provided for @noUpcomingSessions.
  ///
  /// In en, this message translates to:
  /// **'No upcoming sessions'**
  String get noUpcomingSessions;

  /// No description provided for @noUpcomingSessionsDesc.
  ///
  /// In en, this message translates to:
  /// **'Book a session with a therapist to get started.'**
  String get noUpcomingSessionsDesc;

  /// No description provided for @noPastSessions.
  ///
  /// In en, this message translates to:
  /// **'No past sessions'**
  String get noPastSessions;

  /// No description provided for @noPastSessionsDesc.
  ///
  /// In en, this message translates to:
  /// **'Your completed sessions will appear here.'**
  String get noPastSessionsDesc;

  /// No description provided for @findTherapist.
  ///
  /// In en, this message translates to:
  /// **'Find a Therapist'**
  String get findTherapist;

  /// No description provided for @statusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get statusConfirmed;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get statusRejected;

  /// No description provided for @statusScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get statusScheduled;

  /// No description provided for @statusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get statusAccepted;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get statusUnknown;

  /// No description provided for @bookSession.
  ///
  /// In en, this message translates to:
  /// **'Book Session'**
  String get bookSession;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @allTimesLocal.
  ///
  /// In en, this message translates to:
  /// **'All times are in your local timezone'**
  String get allTimesLocal;

  /// No description provided for @statusBooked.
  ///
  /// In en, this message translates to:
  /// **'Booked'**
  String get statusBooked;

  /// No description provided for @sessionBooked.
  ///
  /// In en, this message translates to:
  /// **'Session Booked!'**
  String get sessionBooked;

  /// No description provided for @sessionBookedDesc.
  ///
  /// In en, this message translates to:
  /// **'You\'ll get a notification when it\'s time for your session.'**
  String get sessionBookedDesc;

  /// No description provided for @selectTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Select a time slot'**
  String get selectTimeSlot;

  /// No description provided for @payWithEsewa.
  ///
  /// In en, this message translates to:
  /// **'Pay with eSewa'**
  String payWithEsewa(String amount);

  /// No description provided for @sessionDuration.
  ///
  /// In en, this message translates to:
  /// **'50 min'**
  String get sessionDuration;

  /// No description provided for @videoCall.
  ///
  /// In en, this message translates to:
  /// **'Video call'**
  String get videoCall;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed. No charge was made. Please try again.'**
  String get paymentFailed;

  /// No description provided for @paymentSuccessBookingFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment went through (ref: {ref}) but booking failed. Please contact support.'**
  String paymentSuccessBookingFailed(String ref);

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @sessionFee.
  ///
  /// In en, this message translates to:
  /// **'NPR {fee}'**
  String sessionFee(String fee);

  /// No description provided for @bookingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Session booked successfully!'**
  String get bookingSuccess;

  /// No description provided for @bookingFailed.
  ///
  /// In en, this message translates to:
  /// **'Booking failed. Please try again.'**
  String get bookingFailed;

  /// No description provided for @slotAlreadyBooked.
  ///
  /// In en, this message translates to:
  /// **'This slot is already booked.'**
  String get slotAlreadyBooked;

  /// No description provided for @noSlotsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No slots available'**
  String get noSlotsAvailable;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for content…'**
  String get searchHint;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @contentType.
  ///
  /// In en, this message translates to:
  /// **'Content Type'**
  String get contentType;

  /// No description provided for @showOnly.
  ///
  /// In en, this message translates to:
  /// **'Show Only'**
  String get showOnly;

  /// No description provided for @featuredContent.
  ///
  /// In en, this message translates to:
  /// **'Featured Content'**
  String get featuredContent;

  /// No description provided for @premiumContent.
  ///
  /// In en, this message translates to:
  /// **'Premium Content'**
  String get premiumContent;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clearFilters;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @gamesHub.
  ///
  /// In en, this message translates to:
  /// **'Games & Wellness'**
  String get gamesHub;

  /// No description provided for @dailyQuest.
  ///
  /// In en, this message translates to:
  /// **'DAILY QUEST'**
  String get dailyQuest;

  /// No description provided for @bonusXp.
  ///
  /// In en, this message translates to:
  /// **'+50 bonus XP'**
  String get bonusXp;

  /// No description provided for @go.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get go;

  /// No description provided for @levelNewcomer.
  ///
  /// In en, this message translates to:
  /// **'Newcomer'**
  String get levelNewcomer;

  /// No description provided for @levelExplorer.
  ///
  /// In en, this message translates to:
  /// **'Explorer'**
  String get levelExplorer;

  /// No description provided for @levelPractitioner.
  ///
  /// In en, this message translates to:
  /// **'Practitioner'**
  String get levelPractitioner;

  /// No description provided for @levelAchiever.
  ///
  /// In en, this message translates to:
  /// **'Achiever'**
  String get levelAchiever;

  /// No description provided for @levelMaster.
  ///
  /// In en, this message translates to:
  /// **'Master'**
  String get levelMaster;

  /// No description provided for @xpToNextRank.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP to next rank'**
  String xpToNextRank(Object xp);

  /// No description provided for @maxRankAchieved.
  ///
  /// In en, this message translates to:
  /// **'Maximum rank achieved 🎉'**
  String get maxRankAchieved;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard;

  /// No description provided for @breathingGame.
  ///
  /// In en, this message translates to:
  /// **'Breathing'**
  String get breathingGame;

  /// No description provided for @storyGame.
  ///
  /// In en, this message translates to:
  /// **'Story'**
  String get storyGame;

  /// No description provided for @triviaGame.
  ///
  /// In en, this message translates to:
  /// **'Trivia'**
  String get triviaGame;

  /// No description provided for @affirmationGame.
  ///
  /// In en, this message translates to:
  /// **'Affirmation'**
  String get affirmationGame;

  /// No description provided for @moodTracker.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get moodTracker;

  /// No description provided for @goPremium.
  ///
  /// In en, this message translates to:
  /// **'Go Premium'**
  String get goPremium;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// No description provided for @choosePlan.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Plan'**
  String get choosePlan;

  /// No description provided for @yourSubscription.
  ///
  /// In en, this message translates to:
  /// **'Your Subscription'**
  String get yourSubscription;

  /// No description provided for @currentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// No description provided for @cancelSubscription.
  ///
  /// In en, this message translates to:
  /// **'Cancel Subscription'**
  String get cancelSubscription;

  /// No description provided for @cancelSubscriptionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel your subscription?'**
  String get cancelSubscriptionConfirm;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @subscriptionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Subscription successful!'**
  String get subscriptionSuccess;

  /// No description provided for @endsOn.
  ///
  /// In en, this message translates to:
  /// **'Ends on {date}'**
  String endsOn(String date);

  /// No description provided for @savingsUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Save {percent}% by upgrading!'**
  String savingsUpgrade(Object percent);

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// No description provided for @currentPlanLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlanLabel;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactions;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotifications;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{min}m ago'**
  String minutesAgo(Object min);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hr}h ago'**
  String hoursAgo(Object hr);

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{d}d ago'**
  String daysAgo(Object d);

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @favoriteAudio.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get favoriteAudio;

  /// No description provided for @favoriteVideos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get favoriteVideos;

  /// No description provided for @favoriteQuotes.
  ///
  /// In en, this message translates to:
  /// **'Quotes'**
  String get favoriteQuotes;

  /// No description provided for @favoriteTips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get favoriteTips;

  /// No description provided for @favoriteImages.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get favoriteImages;

  /// No description provided for @signInToSaveFavorites.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save favorites'**
  String get signInToSaveFavorites;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get noFavorites;

  /// No description provided for @addFavorites.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart icon to save content here'**
  String get addFavorites;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @moreAboutYou.
  ///
  /// In en, this message translates to:
  /// **'More About You'**
  String get moreAboutYou;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @genderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get genderOther;

  /// No description provided for @genderPreferNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get genderPreferNotToSay;

  /// No description provided for @selectDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Select Date of Birth'**
  String get selectDateOfBirth;

  /// No description provided for @tapToSet.
  ///
  /// In en, this message translates to:
  /// **'Tap to set'**
  String get tapToSet;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdated;

  /// No description provided for @inspirationalImages.
  ///
  /// In en, this message translates to:
  /// **'Inspirational Images'**
  String get inspirationalImages;

  /// No description provided for @beautifulWallpapers.
  ///
  /// In en, this message translates to:
  /// **'Beautiful wallpapers to inspire you'**
  String get beautifulWallpapers;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @saveImage.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveImage;

  /// No description provided for @fullscreen.
  ///
  /// In en, this message translates to:
  /// **'Fullscreen'**
  String get fullscreen;

  /// No description provided for @setAsWallpaper.
  ///
  /// In en, this message translates to:
  /// **'Set as Wallpaper'**
  String get setAsWallpaper;

  /// No description provided for @wallpaperComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Wallpaper feature coming soon!'**
  String get wallpaperComingSoon;

  /// No description provided for @premiumRequired.
  ///
  /// In en, this message translates to:
  /// **'Premium subscription required to {action} this content.'**
  String premiumRequired(String action);

  /// No description provided for @failedToSaveImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to save image'**
  String get failedToSaveImage;

  /// No description provided for @allImages.
  ///
  /// In en, this message translates to:
  /// **'All inspirational images'**
  String get allImages;

  /// No description provided for @therapistList.
  ///
  /// In en, this message translates to:
  /// **'Find a Therapist'**
  String get therapistList;

  /// No description provided for @therapistDetail.
  ///
  /// In en, this message translates to:
  /// **'Therapist Profile'**
  String get therapistDetail;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @specialties.
  ///
  /// In en, this message translates to:
  /// **'Specialties'**
  String get specialties;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @reviewsCount.
  ///
  /// In en, this message translates to:
  /// **'({count} reviews)'**
  String reviewsCount(int count);

  /// No description provided for @perSession.
  ///
  /// In en, this message translates to:
  /// **'Per Session'**
  String get perSession;

  /// No description provided for @qualifications.
  ///
  /// In en, this message translates to:
  /// **'Qualifications'**
  String get qualifications;

  /// No description provided for @sessionInfo.
  ///
  /// In en, this message translates to:
  /// **'Session Info'**
  String get sessionInfo;

  /// No description provided for @sessionType.
  ///
  /// In en, this message translates to:
  /// **'Session Type'**
  String get sessionType;

  /// No description provided for @videoCallWebRTC.
  ///
  /// In en, this message translates to:
  /// **'Video Call (WebRTC)'**
  String get videoCallWebRTC;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @fee.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get fee;

  /// No description provided for @feeViaEsewa.
  ///
  /// In en, this message translates to:
  /// **'NPR {fee} via eSewa'**
  String feeViaEsewa(String fee);

  /// No description provided for @noTherapistsFound.
  ///
  /// In en, this message translates to:
  /// **'No therapists found'**
  String get noTherapistsFound;

  /// No description provided for @categoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesTitle;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get allCategories;

  /// No description provided for @tipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Wellness Tips'**
  String get tipsTitle;

  /// No description provided for @allTips.
  ///
  /// In en, this message translates to:
  /// **'All wellness tips'**
  String get allTips;

  /// No description provided for @audioTitle.
  ///
  /// In en, this message translates to:
  /// **'Calming Audio'**
  String get audioTitle;

  /// No description provided for @allAudio.
  ///
  /// In en, this message translates to:
  /// **'All audio content'**
  String get allAudio;

  /// No description provided for @allVideos.
  ///
  /// In en, this message translates to:
  /// **'All video content'**
  String get allVideos;

  /// No description provided for @matchingTitle.
  ///
  /// In en, this message translates to:
  /// **'Find Your Match'**
  String get matchingTitle;

  /// No description provided for @matchingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Answer a few questions to find the right therapist'**
  String get matchingSubtitle;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Find My Therapist'**
  String get submit;

  /// No description provided for @questionOf.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String questionOf(Object current, Object total);

  /// No description provided for @questionProgress.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String questionProgress(int current, int total);

  /// No description provided for @appointmentChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get appointmentChatTitle;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send a message…'**
  String get sendMessage;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @premiumSubscriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Premium Subscription Required'**
  String get premiumSubscriptionRequired;

  /// No description provided for @unlockPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to unlock this content'**
  String get unlockPremium;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @findMatches.
  ///
  /// In en, this message translates to:
  /// **'Find My Matches'**
  String get findMatches;

  /// No description provided for @qMoodTitle.
  ///
  /// In en, this message translates to:
  /// **'How has your mood been lately?'**
  String get qMoodTitle;

  /// No description provided for @qMoodSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Over the past 2 weeks'**
  String get qMoodSubtitle;

  /// No description provided for @qMoodOpt1.
  ///
  /// In en, this message translates to:
  /// **'Mostly positive — I feel okay'**
  String get qMoodOpt1;

  /// No description provided for @qMoodOpt2.
  ///
  /// In en, this message translates to:
  /// **'Ups and downs, but managing'**
  String get qMoodOpt2;

  /// No description provided for @qMoodOpt3.
  ///
  /// In en, this message translates to:
  /// **'Frequently sad or empty'**
  String get qMoodOpt3;

  /// No description provided for @qMoodOpt4.
  ///
  /// In en, this message translates to:
  /// **'Persistently low — hard to function'**
  String get qMoodOpt4;

  /// No description provided for @qAnxietyTitle.
  ///
  /// In en, this message translates to:
  /// **'How often do you feel anxious or worried?'**
  String get qAnxietyTitle;

  /// No description provided for @qAnxietySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nervousness, panic, or sense of dread'**
  String get qAnxietySubtitle;

  /// No description provided for @qAnxietyOpt1.
  ///
  /// In en, this message translates to:
  /// **'Rarely or never'**
  String get qAnxietyOpt1;

  /// No description provided for @qAnxietyOpt2.
  ///
  /// In en, this message translates to:
  /// **'Sometimes, but it passes quickly'**
  String get qAnxietyOpt2;

  /// No description provided for @qAnxietyOpt3.
  ///
  /// In en, this message translates to:
  /// **'Often — it affects my day'**
  String get qAnxietyOpt3;

  /// No description provided for @qAnxietyOpt4.
  ///
  /// In en, this message translates to:
  /// **'Almost constantly, hard to control'**
  String get qAnxietyOpt4;

  /// No description provided for @qSleepTitle.
  ///
  /// In en, this message translates to:
  /// **'How would you describe your sleep?'**
  String get qSleepTitle;

  /// No description provided for @qSleepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sleep quality has a strong impact on mental health'**
  String get qSleepSubtitle;

  /// No description provided for @qSleepOpt1.
  ///
  /// In en, this message translates to:
  /// **'Generally good'**
  String get qSleepOpt1;

  /// No description provided for @qSleepOpt2.
  ///
  /// In en, this message translates to:
  /// **'Occasional trouble sleeping'**
  String get qSleepOpt2;

  /// No description provided for @qSleepOpt3.
  ///
  /// In en, this message translates to:
  /// **'Regularly poor — wake often or can\'t fall asleep'**
  String get qSleepOpt3;

  /// No description provided for @qSleepOpt4.
  ///
  /// In en, this message translates to:
  /// **'Severely disrupted — exhausted most days'**
  String get qSleepOpt4;

  /// No description provided for @qConcernTitle.
  ///
  /// In en, this message translates to:
  /// **'What is your main reason for seeking therapy?'**
  String get qConcernTitle;

  /// No description provided for @qConcernSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select all that apply'**
  String get qConcernSubtitle;

  /// No description provided for @qConcernOpt1.
  ///
  /// In en, this message translates to:
  /// **'Depression / low mood'**
  String get qConcernOpt1;

  /// No description provided for @qConcernOpt2.
  ///
  /// In en, this message translates to:
  /// **'Anxiety / stress'**
  String get qConcernOpt2;

  /// No description provided for @qConcernOpt3.
  ///
  /// In en, this message translates to:
  /// **'Relationship challenges'**
  String get qConcernOpt3;

  /// No description provided for @qConcernOpt4.
  ///
  /// In en, this message translates to:
  /// **'Grief or loss'**
  String get qConcernOpt4;

  /// No description provided for @qConcernOpt5.
  ///
  /// In en, this message translates to:
  /// **'Trauma or PTSD'**
  String get qConcernOpt5;

  /// No description provided for @qConcernOpt6.
  ///
  /// In en, this message translates to:
  /// **'Self-esteem or identity'**
  String get qConcernOpt6;

  /// No description provided for @qConcernOpt7.
  ///
  /// In en, this message translates to:
  /// **'Life transitions'**
  String get qConcernOpt7;

  /// No description provided for @qConcernOpt8.
  ///
  /// In en, this message translates to:
  /// **'Burnout / work stress'**
  String get qConcernOpt8;

  /// No description provided for @qTraumaTitle.
  ///
  /// In en, this message translates to:
  /// **'Have past difficult experiences affected your wellbeing?'**
  String get qTraumaTitle;

  /// No description provided for @qTraumaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This helps us match trauma-informed therapists if needed'**
  String get qTraumaSubtitle;

  /// No description provided for @qTraumaOpt1.
  ///
  /// In en, this message translates to:
  /// **'No — not significantly'**
  String get qTraumaOpt1;

  /// No description provided for @qTraumaOpt2.
  ///
  /// In en, this message translates to:
  /// **'Somewhat — I\'d like support around it'**
  String get qTraumaOpt2;

  /// No description provided for @qTraumaOpt3.
  ///
  /// In en, this message translates to:
  /// **'Yes — it impacts me regularly'**
  String get qTraumaOpt3;

  /// No description provided for @qTraumaOpt4.
  ///
  /// In en, this message translates to:
  /// **'Yes — it\'s a major focus I need help with'**
  String get qTraumaOpt4;

  /// No description provided for @qApproachTitle.
  ///
  /// In en, this message translates to:
  /// **'What kind of support feels right for you?'**
  String get qApproachTitle;

  /// No description provided for @qApproachSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Therapists tailor their style to your preference'**
  String get qApproachSubtitle;

  /// No description provided for @qApproachOpt1.
  ///
  /// In en, this message translates to:
  /// **'Practical tools & strategies (CBT-style)'**
  String get qApproachOpt1;

  /// No description provided for @qApproachOpt2.
  ///
  /// In en, this message translates to:
  /// **'Exploring emotions & past patterns'**
  String get qApproachOpt2;

  /// No description provided for @qApproachOpt3.
  ///
  /// In en, this message translates to:
  /// **'Mindfulness & present-moment awareness'**
  String get qApproachOpt3;

  /// No description provided for @qApproachOpt4.
  ///
  /// In en, this message translates to:
  /// **'I\'m not sure — open to guidance'**
  String get qApproachOpt4;

  /// No description provided for @qPrefTitle.
  ///
  /// In en, this message translates to:
  /// **'Do you have any therapist preferences?'**
  String get qPrefTitle;

  /// No description provided for @qPrefSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A comfortable fit improves outcomes'**
  String get qPrefSubtitle;

  /// No description provided for @qPrefOpt1.
  ///
  /// In en, this message translates to:
  /// **'No preference'**
  String get qPrefOpt1;

  /// No description provided for @qPrefOpt2.
  ///
  /// In en, this message translates to:
  /// **'Prefer female therapist'**
  String get qPrefOpt2;

  /// No description provided for @qPrefOpt3.
  ///
  /// In en, this message translates to:
  /// **'Prefer male therapist'**
  String get qPrefOpt3;

  /// No description provided for @qPrefOpt4.
  ///
  /// In en, this message translates to:
  /// **'Prefer therapist with similar cultural background'**
  String get qPrefOpt4;

  /// No description provided for @admContentManagement.
  ///
  /// In en, this message translates to:
  /// **'Content Management'**
  String get admContentManagement;

  /// No description provided for @admSearchTips.
  ///
  /// In en, this message translates to:
  /// **'Search tips...'**
  String get admSearchTips;

  /// No description provided for @admNoTipsYet.
  ///
  /// In en, this message translates to:
  /// **'No tips yet'**
  String get admNoTipsYet;

  /// No description provided for @admSearchQuotes.
  ///
  /// In en, this message translates to:
  /// **'Search quotes...'**
  String get admSearchQuotes;

  /// No description provided for @admNoQuotesYet.
  ///
  /// In en, this message translates to:
  /// **'No quotes yet'**
  String get admNoQuotesYet;

  /// No description provided for @admSearchAudio.
  ///
  /// In en, this message translates to:
  /// **'Search audio...'**
  String get admSearchAudio;

  /// No description provided for @admNoAudioYet.
  ///
  /// In en, this message translates to:
  /// **'No audio tracks yet'**
  String get admNoAudioYet;

  /// No description provided for @admSearchVideos.
  ///
  /// In en, this message translates to:
  /// **'Search videos...'**
  String get admSearchVideos;

  /// No description provided for @admAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get admAll;

  /// No description provided for @admShorts.
  ///
  /// In en, this message translates to:
  /// **'⚡ Shorts'**
  String get admShorts;

  /// No description provided for @admLong.
  ///
  /// In en, this message translates to:
  /// **'🎬 Long'**
  String get admLong;

  /// No description provided for @admNoVideosYet.
  ///
  /// In en, this message translates to:
  /// **'No videos yet'**
  String get admNoVideosYet;

  /// No description provided for @admSearchImages.
  ///
  /// In en, this message translates to:
  /// **'Search images...'**
  String get admSearchImages;

  /// No description provided for @admNoImagesYet.
  ///
  /// In en, this message translates to:
  /// **'No images yet'**
  String get admNoImagesYet;

  /// No description provided for @admDeleteContent.
  ///
  /// In en, this message translates to:
  /// **'Delete Content'**
  String get admDeleteContent;

  /// No description provided for @admDeleteItemConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get admDeleteItemConfirm;

  /// No description provided for @admCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get admCancel;

  /// No description provided for @admDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get admDelete;

  /// No description provided for @admOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get admOverview;

  /// No description provided for @admContent.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get admContent;

  /// No description provided for @admTherapists.
  ///
  /// In en, this message translates to:
  /// **'Therapists'**
  String get admTherapists;

  /// No description provided for @admUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get admUsers;

  /// No description provided for @admMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get admMore;

  /// No description provided for @admPushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get admPushNotifications;

  /// No description provided for @admPushNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Broadcast messages to users and therapists'**
  String get admPushNotificationsSubtitle;

  /// No description provided for @admPreferencesConfig.
  ///
  /// In en, this message translates to:
  /// **'Preferences Config'**
  String get admPreferencesConfig;

  /// No description provided for @admPreferencesConfigSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage user onboarding options'**
  String get admPreferencesConfigSubtitle;

  /// No description provided for @admRevenueAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Revenue Analytics'**
  String get admRevenueAnalytics;

  /// No description provided for @admRevenueAnalyticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View detailed charts and payouts'**
  String get admRevenueAnalyticsSubtitle;

  /// No description provided for @admSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get admSettings;

  /// No description provided for @admSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Theme, Access, and Logs'**
  String get admSettingsSubtitle;

  /// No description provided for @homePremiumRequired.
  ///
  /// In en, this message translates to:
  /// **'Premium subscription required to play this content.'**
  String get homePremiumRequired;

  /// No description provided for @gmGames.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get gmGames;

  /// No description provided for @gmTodaysMood.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Mood'**
  String get gmTodaysMood;

  /// No description provided for @gmWellnessHub.
  ///
  /// In en, this message translates to:
  /// **'Wellness Hub'**
  String get gmWellnessHub;

  /// No description provided for @gmLevelProgress.
  ///
  /// In en, this message translates to:
  /// **'Level Progress'**
  String get gmLevelProgress;

  /// No description provided for @gmToggleSoundEffects.
  ///
  /// In en, this message translates to:
  /// **'Toggle Sound Effects'**
  String get gmToggleSoundEffects;

  /// No description provided for @gmToggleBackgroundMusic.
  ///
  /// In en, this message translates to:
  /// **'Toggle Background Music'**
  String get gmToggleBackgroundMusic;

  /// No description provided for @gmExitQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit Quiz?'**
  String get gmExitQuizTitle;

  /// No description provided for @gmExitProgressLost.
  ///
  /// In en, this message translates to:
  /// **'Your progress will be lost. Are you sure you want to exit?'**
  String get gmExitProgressLost;

  /// No description provided for @gmCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get gmCancel;

  /// No description provided for @gmExit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get gmExit;

  /// No description provided for @gmLoadingQuestions.
  ///
  /// In en, this message translates to:
  /// **'Loading Questions...'**
  String get gmLoadingQuestions;

  /// No description provided for @gmWellnessTrivia.
  ///
  /// In en, this message translates to:
  /// **'Wellness Trivia'**
  String get gmWellnessTrivia;

  /// No description provided for @gmTestWellnessKnowledge.
  ///
  /// In en, this message translates to:
  /// **'Test your wellness knowledge'**
  String get gmTestWellnessKnowledge;

  /// No description provided for @gmTimeLimit.
  ///
  /// In en, this message translates to:
  /// **'Time Limit'**
  String get gmTimeLimit;

  /// No description provided for @gmScoring.
  ///
  /// In en, this message translates to:
  /// **'Scoring'**
  String get gmScoring;

  /// No description provided for @gmScoringDesc.
  ///
  /// In en, this message translates to:
  /// **'Answer faster for more points. Build streaks for bonuses!'**
  String get gmScoringDesc;

  /// No description provided for @gmLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get gmLearn;

  /// No description provided for @gmLearnDesc.
  ///
  /// In en, this message translates to:
  /// **'Explanations will help you understand each answer'**
  String get gmLearnDesc;

  /// No description provided for @gmNoQuestionsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No questions available. Please try again later.'**
  String get gmNoQuestionsAvailable;

  /// No description provided for @gmStartQuiz.
  ///
  /// In en, this message translates to:
  /// **'Start Quiz'**
  String get gmStartQuiz;

  /// No description provided for @gmExplanation.
  ///
  /// In en, this message translates to:
  /// **'Explanation'**
  String get gmExplanation;

  /// No description provided for @gmYourFinalScore.
  ///
  /// In en, this message translates to:
  /// **'Your final score'**
  String get gmYourFinalScore;

  /// No description provided for @gmQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get gmQuestions;

  /// No description provided for @gmCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get gmCorrect;

  /// No description provided for @gmAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get gmAccuracy;

  /// No description provided for @gmBestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best Streak'**
  String get gmBestStreak;

  /// No description provided for @gmPlayAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get gmPlayAgain;

  /// No description provided for @medShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get medShare;

  /// No description provided for @medSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get medSave;

  /// No description provided for @medFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Fullscreen'**
  String get medFullscreen;

  /// No description provided for @medInspirationalImages.
  ///
  /// In en, this message translates to:
  /// **'Inspirational Images'**
  String get medInspirationalImages;

  /// No description provided for @medLoadingImages.
  ///
  /// In en, this message translates to:
  /// **'Loading images...'**
  String get medLoadingImages;

  /// No description provided for @medErrorLoadingImages.
  ///
  /// In en, this message translates to:
  /// **'Error loading images'**
  String get medErrorLoadingImages;

  /// No description provided for @medRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get medRetry;

  /// No description provided for @medNoImagesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No images available'**
  String get medNoImagesAvailable;

  /// No description provided for @medCheckBackLaterInspirational.
  ///
  /// In en, this message translates to:
  /// **'Check back later for new inspirational content'**
  String get medCheckBackLaterInspirational;

  /// No description provided for @medSetWallpaper.
  ///
  /// In en, this message translates to:
  /// **'Set Wallpaper'**
  String get medSetWallpaper;

  /// No description provided for @medInfo.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get medInfo;

  /// No description provided for @medCreator.
  ///
  /// In en, this message translates to:
  /// **'Creator'**
  String get medCreator;

  /// No description provided for @medWallpaperDownloadComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Wallpaper download feature coming soon!'**
  String get medWallpaperDownloadComingSoon;

  /// No description provided for @medFailedToSaveImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to save image'**
  String get medFailedToSaveImage;

  /// No description provided for @medNoInspirationalImagesAvailable.
  ///
  /// In en, this message translates to:
  /// **'⚠️ No inspirational images available'**
  String get medNoInspirationalImagesAvailable;

  /// No description provided for @medBeautifulWallpapersInspire.
  ///
  /// In en, this message translates to:
  /// **'Beautiful wallpapers to inspire you'**
  String get medBeautifulWallpapersInspire;

  /// No description provided for @medSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get medSeeAll;

  /// No description provided for @medWallpaperComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Wallpaper feature coming soon!'**
  String get medWallpaperComingSoon;

  /// No description provided for @medSetAsWallpaper.
  ///
  /// In en, this message translates to:
  /// **'Set as Wallpaper'**
  String get medSetAsWallpaper;

  /// No description provided for @homeReels.
  ///
  /// In en, this message translates to:
  /// **'Reels'**
  String get homeReels;

  /// No description provided for @homeLoadingReels.
  ///
  /// In en, this message translates to:
  /// **'Loading Reels...'**
  String get homeLoadingReels;

  /// No description provided for @homeCouldNotLoadReels.
  ///
  /// In en, this message translates to:
  /// **'Could not load reels'**
  String get homeCouldNotLoadReels;

  /// No description provided for @homeRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get homeRetry;

  /// No description provided for @homeNoReelsYet.
  ///
  /// In en, this message translates to:
  /// **'No Reels Yet'**
  String get homeNoReelsYet;

  /// No description provided for @homeCheckBackSoon.
  ///
  /// In en, this message translates to:
  /// **'Check back soon for new content'**
  String get homeCheckBackSoon;

  /// No description provided for @accEmailCannotBeChanged.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be changed'**
  String get accEmailCannotBeChanged;

  /// No description provided for @accCardHolder.
  ///
  /// In en, this message translates to:
  /// **'CARD HOLDER'**
  String get accCardHolder;

  /// No description provided for @accValidThru.
  ///
  /// In en, this message translates to:
  /// **'VALID THRU'**
  String get accValidThru;

  /// No description provided for @accResilioPremium.
  ///
  /// In en, this message translates to:
  /// **'RESILIO PREMIUM'**
  String get accResilioPremium;

  /// No description provided for @bizPaymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed'**
  String get bizPaymentFailed;

  /// No description provided for @bizPaymentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Payment cancelled'**
  String get bizPaymentCancelled;

  /// No description provided for @bizCancelSubscription.
  ///
  /// In en, this message translates to:
  /// **'Cancel Subscription'**
  String get bizCancelSubscription;

  /// No description provided for @bizCancelSubscriptionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel your subscription?'**
  String get bizCancelSubscriptionConfirm;

  /// No description provided for @bizNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get bizNo;

  /// No description provided for @bizYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get bizYes;

  /// No description provided for @bizPremiumMembership.
  ///
  /// In en, this message translates to:
  /// **'PREMIUM MEMBERSHIP'**
  String get bizPremiumMembership;

  /// No description provided for @bizElevateWellnessJourney.
  ///
  /// In en, this message translates to:
  /// **'Elevate Your\\nWellness Journey'**
  String get bizElevateWellnessJourney;

  /// No description provided for @bizUnlockPremiumContent.
  ///
  /// In en, this message translates to:
  /// **'Unlock premium content, guided sessions,\\nand exclusive wellness tools.'**
  String get bizUnlockPremiumContent;

  /// No description provided for @bizUnlimitedContent.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Content'**
  String get bizUnlimitedContent;

  /// No description provided for @bizExpertTips.
  ///
  /// In en, this message translates to:
  /// **'Expert Tips'**
  String get bizExpertTips;

  /// No description provided for @bizAdFree.
  ///
  /// In en, this message translates to:
  /// **'Ad-Free'**
  String get bizAdFree;

  /// No description provided for @accConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting…'**
  String get accConnecting;

  /// No description provided for @accVoiceCall.
  ///
  /// In en, this message translates to:
  /// **'Voice Call'**
  String get accVoiceCall;

  /// No description provided for @accCalling.
  ///
  /// In en, this message translates to:
  /// **'Calling…'**
  String get accCalling;

  /// No description provided for @accUnmute.
  ///
  /// In en, this message translates to:
  /// **'Unmute'**
  String get accUnmute;

  /// No description provided for @accCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get accCamera;

  /// No description provided for @accEnd.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get accEnd;

  /// No description provided for @accFlip.
  ///
  /// In en, this message translates to:
  /// **'Flip'**
  String get accFlip;

  /// No description provided for @accSpeaker.
  ///
  /// In en, this message translates to:
  /// **'Speaker'**
  String get accSpeaker;

  /// No description provided for @thrSessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get thrSessions;

  /// No description provided for @thrCouldNotLoadSessions.
  ///
  /// In en, this message translates to:
  /// **'Could not load sessions'**
  String get thrCouldNotLoadSessions;

  /// No description provided for @thrRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get thrRetry;

  /// No description provided for @thrNoSessionsFound.
  ///
  /// In en, this message translates to:
  /// **'No sessions found'**
  String get thrNoSessionsFound;

  /// No description provided for @thrDecline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get thrDecline;

  /// No description provided for @thrAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get thrAccept;

  /// No description provided for @thrMessagePatient.
  ///
  /// In en, this message translates to:
  /// **'Message Patient'**
  String get thrMessagePatient;

  /// No description provided for @thrJoinSession.
  ///
  /// In en, this message translates to:
  /// **'Join Session'**
  String get thrJoinSession;

  /// No description provided for @thrJoinButtonActivatesHint.
  ///
  /// In en, this message translates to:
  /// **'Join button activates 15 min before session'**
  String get thrJoinButtonActivatesHint;

  /// No description provided for @thrDeleteContentTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Content?'**
  String get thrDeleteContentTitle;

  /// No description provided for @thrActionCannotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get thrActionCannotBeUndone;

  /// No description provided for @thrCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get thrCancel;

  /// No description provided for @thrDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get thrDelete;

  /// No description provided for @thrEarnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get thrEarnings;

  /// No description provided for @thrThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thrThisWeek;

  /// No description provided for @thrThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thrThisMonth;

  /// No description provided for @thrTotalEarnings.
  ///
  /// In en, this message translates to:
  /// **'Total Earnings'**
  String get thrTotalEarnings;

  /// No description provided for @thrAllTimeRevenue.
  ///
  /// In en, this message translates to:
  /// **'All time revenue'**
  String get thrAllTimeRevenue;

  /// No description provided for @thrWeeklyRevenue.
  ///
  /// In en, this message translates to:
  /// **'Weekly Revenue'**
  String get thrWeeklyRevenue;

  /// No description provided for @thrRecentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get thrRecentTransactions;

  /// No description provided for @thrMyPatients.
  ///
  /// In en, this message translates to:
  /// **'My Patients'**
  String get thrMyPatients;

  /// No description provided for @thrSearchPatients.
  ///
  /// In en, this message translates to:
  /// **'Search patients…'**
  String get thrSearchPatients;

  /// No description provided for @thrNoPatientsYet.
  ///
  /// In en, this message translates to:
  /// **'No patients yet'**
  String get thrNoPatientsYet;

  /// No description provided for @thrNoSessions.
  ///
  /// In en, this message translates to:
  /// **'No sessions'**
  String get thrNoSessions;

  /// No description provided for @accEar.
  ///
  /// In en, this message translates to:
  /// **'Ear'**
  String get accEar;

  /// No description provided for @accMute.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get accMute;

  /// No description provided for @accNoVideo.
  ///
  /// In en, this message translates to:
  /// **'No Video'**
  String get accNoVideo;

  /// No description provided for @admAddFirstTip.
  ///
  /// In en, this message translates to:
  /// **'Add your first tip with the + button'**
  String get admAddFirstTip;

  /// No description provided for @thrNotSessionTime.
  ///
  /// In en, this message translates to:
  /// **'Not Session Time'**
  String get thrNotSessionTime;

  /// No description provided for @accCustomizeAppInterface.
  ///
  /// In en, this message translates to:
  /// **'Customize your app interface'**
  String get accCustomizeAppInterface;

  /// No description provided for @accEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get accEnglish;

  /// No description provided for @accLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get accLanguage;

  /// No description provided for @accNepali.
  ///
  /// In en, this message translates to:
  /// **'Nepali'**
  String get accNepali;

  /// No description provided for @accRegisterAsLabel.
  ///
  /// In en, this message translates to:
  /// **'I want to register as a'**
  String get accRegisterAsLabel;

  /// No description provided for @accRoleCustomer.
  ///
  /// In en, this message translates to:
  /// **'customer'**
  String get accRoleCustomer;

  /// No description provided for @accRoleTherapist.
  ///
  /// In en, this message translates to:
  /// **'therapist'**
  String get accRoleTherapist;

  /// No description provided for @accSelectPreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get accSelectPreferredLanguage;

  /// No description provided for @accTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get accTheme;

  /// No description provided for @accThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get accThemeDark;

  /// No description provided for @accThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get accThemeLight;

  /// No description provided for @accThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get accThemeSystem;

  /// No description provided for @accWellness.
  ///
  /// In en, this message translates to:
  /// **'Wellness'**
  String get accWellness;

  /// No description provided for @bizCurrentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get bizCurrentPlan;

  /// No description provided for @bizSubscribeNow.
  ///
  /// In en, this message translates to:
  /// **'Subscribe Now'**
  String get bizSubscribeNow;

  /// No description provided for @bizUpgradeNow.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now'**
  String get bizUpgradeNow;

  /// No description provided for @gmTimeLimitDesc.
  ///
  /// In en, this message translates to:
  /// **'You have {seconds} seconds for each question'**
  String gmTimeLimitDesc(Object seconds);

  /// No description provided for @gmSecondsCount.
  ///
  /// In en, this message translates to:
  /// **'{seconds} seconds'**
  String gmSecondsCount(Object seconds);

  /// No description provided for @accErrorWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String accErrorWithMessage(Object message);

  /// No description provided for @accCameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Camera unavailable: {error}'**
  String accCameraUnavailable(Object error);

  /// No description provided for @thrSessionsForFilterAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Sessions for \"{filter}\" will appear here'**
  String thrSessionsForFilterAppearHere(Object filter);

  /// No description provided for @thrNoResultsFor.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String thrNoResultsFor(Object query);

  /// No description provided for @thrSessionCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 session} other{{count} sessions}}'**
  String thrSessionCount(int count);

  /// No description provided for @thrLastSession.
  ///
  /// In en, this message translates to:
  /// **'Last: {date}'**
  String thrLastSession(Object date);

  /// No description provided for @exploreSearchContent.
  ///
  /// In en, this message translates to:
  /// **'Search content...'**
  String get exploreSearchContent;

  /// No description provided for @exploreTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get exploreTryAgain;

  /// No description provided for @catSearchCategories.
  ///
  /// In en, this message translates to:
  /// **'Search categories...'**
  String get catSearchCategories;

  /// No description provided for @favSignInToSave.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save favorites'**
  String get favSignInToSave;

  /// No description provided for @gmFailedLoadMoods.
  ///
  /// In en, this message translates to:
  /// **'Failed to load mood entries'**
  String get gmFailedLoadMoods;

  /// No description provided for @gmJournalUpdated.
  ///
  /// In en, this message translates to:
  /// **'Journal updated'**
  String get gmJournalUpdated;

  /// No description provided for @gmEnterThoughts.
  ///
  /// In en, this message translates to:
  /// **'Enter your thoughts...'**
  String get gmEnterThoughts;

  /// No description provided for @gmStay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get gmStay;

  /// No description provided for @gmLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get gmLeave;

  /// No description provided for @gmExitGame.
  ///
  /// In en, this message translates to:
  /// **'Exit Game?'**
  String get gmExitGame;

  /// No description provided for @gmMindfulBreathing.
  ///
  /// In en, this message translates to:
  /// **'Mindful Breathing'**
  String get gmMindfulBreathing;

  /// No description provided for @gmChoosePatternBegin.
  ///
  /// In en, this message translates to:
  /// **'Choose Pattern & Begin'**
  String get gmChoosePatternBegin;

  /// No description provided for @gmChooseYourPattern.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Pattern'**
  String get gmChooseYourPattern;

  /// No description provided for @gmDifferentPatterns.
  ///
  /// In en, this message translates to:
  /// **'Different patterns for different needs'**
  String get gmDifferentPatterns;

  /// No description provided for @gmHowManyRounds.
  ///
  /// In en, this message translates to:
  /// **'How many rounds?'**
  String get gmHowManyRounds;

  /// No description provided for @gmGetReady.
  ///
  /// In en, this message translates to:
  /// **'Get Ready'**
  String get gmGetReady;

  /// No description provided for @gmSessionComplete.
  ///
  /// In en, this message translates to:
  /// **'Session Complete!'**
  String get gmSessionComplete;

  /// No description provided for @gmExcellentWork.
  ///
  /// In en, this message translates to:
  /// **'Excellent mindfulness work today.'**
  String get gmExcellentWork;

  /// No description provided for @gmDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get gmDone;

  /// No description provided for @catSearchIn.
  ///
  /// In en, this message translates to:
  /// **'Search {name}...'**
  String catSearchIn(Object name);

  /// No description provided for @gmStartRounds.
  ///
  /// In en, this message translates to:
  /// **'Start {count} Rounds  →'**
  String gmStartRounds(Object count);

  /// No description provided for @gmRoundProgress.
  ///
  /// In en, this message translates to:
  /// **'Round {current} / {total}'**
  String gmRoundProgress(Object current, Object total);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ne'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ne':
      return AppLocalizationsNe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
