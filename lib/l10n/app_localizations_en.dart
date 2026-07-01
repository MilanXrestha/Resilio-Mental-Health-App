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
  String get enter6DigitCode => 'Enter 6-digit code';

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

  @override
  String get alertDialogTitle => 'Confirm';

  @override
  String get confirm => 'Confirm';

  @override
  String get exitAppTitle => 'Exit App';

  @override
  String get exitAppMessage => 'Do you really want to exit the app?';

  @override
  String get exitButton => 'Exit';

  @override
  String hello(String name) {
    return 'Hello, $name';
  }

  @override
  String get timeToUnwind => 'Time to unwind';

  @override
  String get setReminder => 'Set Reminder';

  @override
  String get neverMissQuotes => 'Never miss your favorite quotes';

  @override
  String get dailyInspiration => 'Daily Inspiration';

  @override
  String get swipeFeaturedQuotes => 'Swipe through today\'s featured quotes';

  @override
  String get calmingAudio => 'Calming Audio';

  @override
  String get meditationSessions => 'Meditation & wellness sessions';

  @override
  String get shortVideos => 'Short Videos';

  @override
  String get quickMindfulness => 'Quick mindfulness moments';

  @override
  String get featuredVideos => 'Featured Videos';

  @override
  String get inDepthContent => 'In-depth wellness content';

  @override
  String get wellnessTips => 'Wellness Tips';

  @override
  String get quickAdvice => 'Quick advice for daily wellness';

  @override
  String get moreQuotes => 'More Quotes';

  @override
  String get discoverWords => 'Discover words to lift your spirit';

  @override
  String get exploreCategories => 'Explore Categories';

  @override
  String get findQuotes => 'Find quotes that resonate with you';

  @override
  String get seeAll => 'See All';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get wellnessExpert => 'Wellness Expert';

  @override
  String get yourTherapySessions => 'Your Therapy Sessions';

  @override
  String get talkToProfessional => 'Talk to a Professional';

  @override
  String get viewUpcomingSessions =>
      'View your upcoming and past sessions with your therapist.';

  @override
  String get findRightTherapist =>
      'Find the right therapist for your mental wellness journey.';

  @override
  String get mySessions => 'My Sessions';

  @override
  String get getMatched => 'Get Matched';

  @override
  String get findNew => 'Find New';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get changeNameEmailPhoto => 'Change your name, email, and photo';

  @override
  String get subscription => 'Subscription';

  @override
  String get managePremiumPlan => 'Manage your premium plan';

  @override
  String get transactions => 'Transactions';

  @override
  String get viewBillingHistory => 'View your billing history';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirm => 'Are you sure you want to logout?';

  @override
  String get signOutAccount => 'Sign out of your account';

  @override
  String get free => 'Free';

  @override
  String get profileSection => 'Profile';

  @override
  String get yourProfile => 'Your Profile';

  @override
  String get manageAccountPrefs =>
      'Manage account, subscription, and preferences';

  @override
  String get appearanceSection => 'Appearance';

  @override
  String get generalSection => 'General';

  @override
  String get resetToDefaults => 'Reset to Defaults';

  @override
  String get restoreThemeLanguage => 'Restore theme and language to defaults';

  @override
  String get settingsReset => 'Settings reset to defaults';

  @override
  String get appSettings => 'App Settings';

  @override
  String get errorLoadingSettings => 'Error loading settings';

  @override
  String get cacheCleared => 'Cache cleared successfully';

  @override
  String get clearCacheConfirm => 'Are you sure you want to clear cache?';

  @override
  String currentCacheSize(String size) {
    return 'Current cache size: $size';
  }

  @override
  String get clear => 'Clear';

  @override
  String get clearCache => 'Clear Cache';

  @override
  String get freeUpSpace => 'Free up space';

  @override
  String freeUpSpaceSize(String size) {
    return 'Free up space · $size';
  }

  @override
  String get aboutResilio => 'About Resilio';

  @override
  String get aboutResilioDesc =>
      'Your mental wellness companion for a healthier, more balanced life. Resilio brings you guided meditations, expert tips, breathing exercises, and personalised wellness journeys — all in one place.';

  @override
  String get madeWithLove => '© 2026 Resilio Team · Made with ❤️ in Nepal';

  @override
  String versionLearnMore(String version) {
    return 'Version $version · Learn more';
  }

  @override
  String get myAppointments => 'My Appointments';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get past => 'Past';

  @override
  String get dateNotSet => 'Date not set';

  @override
  String get tapToMessage => 'Tap to message your therapist';

  @override
  String get joinSession => 'Join Session';

  @override
  String get sessionIn15Min => 'Session in 15 minutes';

  @override
  String sessionStartingSoon(String name) {
    return 'Your session with $name starts soon.';
  }

  @override
  String get noUpcomingAppointments => 'No upcoming appointments';

  @override
  String get noPastAppointments => 'No past appointments';

  @override
  String get myTherapy => 'My Therapy';

  @override
  String get errorLoadingAppointments => 'Could not load appointments';

  @override
  String get noUpcomingSessions => 'No upcoming sessions';

  @override
  String get noUpcomingSessionsDesc =>
      'Book a session with a therapist to get started.';

  @override
  String get noPastSessions => 'No past sessions';

  @override
  String get noPastSessionsDesc => 'Your completed sessions will appear here.';

  @override
  String get findTherapist => 'Find a Therapist';

  @override
  String get statusConfirmed => 'Confirmed';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusRejected => 'Rejected';

  @override
  String get statusScheduled => 'Scheduled';

  @override
  String get statusAccepted => 'Accepted';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get bookSession => 'Book Session';

  @override
  String get selectDate => 'Select Date';

  @override
  String get selectTime => 'Select Time';

  @override
  String get allTimesLocal => 'All times are in your local timezone';

  @override
  String get statusBooked => 'Booked';

  @override
  String get sessionBooked => 'Session Booked!';

  @override
  String get sessionBookedDesc =>
      'You\'ll get a notification when it\'s time for your session.';

  @override
  String get selectTimeSlot => 'Select a time slot';

  @override
  String payWithEsewa(String amount) {
    return 'Pay with eSewa';
  }

  @override
  String get sessionDuration => '50 min';

  @override
  String get videoCall => 'Video call';

  @override
  String get paymentFailed =>
      'Payment failed. No charge was made. Please try again.';

  @override
  String paymentSuccessBookingFailed(String ref) {
    return 'Payment went through (ref: $ref) but booking failed. Please contact support.';
  }

  @override
  String get done => 'Done';

  @override
  String get confirmBooking => 'Confirm Booking';

  @override
  String sessionFee(String fee) {
    return 'NPR $fee';
  }

  @override
  String get bookingSuccess => 'Session booked successfully!';

  @override
  String get bookingFailed => 'Booking failed. Please try again.';

  @override
  String get slotAlreadyBooked => 'This slot is already booked.';

  @override
  String get noSlotsAvailable => 'No slots available';

  @override
  String get explore => 'Explore';

  @override
  String get searchHint => 'Search for content…';

  @override
  String get all => 'All';

  @override
  String get contentType => 'Content Type';

  @override
  String get showOnly => 'Show Only';

  @override
  String get featuredContent => 'Featured Content';

  @override
  String get premiumContent => 'Premium Content';

  @override
  String get sortBy => 'Sort By';

  @override
  String get filters => 'Filters';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get gamesHub => 'Games & Wellness';

  @override
  String get dailyQuest => 'DAILY QUEST';

  @override
  String get bonusXp => '+50 bonus XP';

  @override
  String get go => 'Go';

  @override
  String get levelNewcomer => 'Newcomer';

  @override
  String get levelExplorer => 'Explorer';

  @override
  String get levelPractitioner => 'Practitioner';

  @override
  String get levelAchiever => 'Achiever';

  @override
  String get levelMaster => 'Master';

  @override
  String xpToNextRank(Object xp) {
    return '$xp XP to next rank';
  }

  @override
  String get maxRankAchieved => 'Maximum rank achieved 🎉';

  @override
  String get achievements => 'Achievements';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get breathingGame => 'Breathing';

  @override
  String get storyGame => 'Story';

  @override
  String get triviaGame => 'Trivia';

  @override
  String get affirmationGame => 'Affirmation';

  @override
  String get moodTracker => 'Mood';

  @override
  String get goPremium => 'Go Premium';

  @override
  String get transactionHistory => 'Transaction History';

  @override
  String get choosePlan => 'Choose Your Plan';

  @override
  String get yourSubscription => 'Your Subscription';

  @override
  String get currentPlan => 'Current Plan';

  @override
  String get cancelSubscription => 'Cancel Subscription';

  @override
  String get cancelSubscriptionConfirm =>
      'Are you sure you want to cancel your subscription?';

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get subscriptionSuccess => 'Subscription successful!';

  @override
  String endsOn(String date) {
    return 'Ends on $date';
  }

  @override
  String savingsUpgrade(Object percent) {
    return 'Save $percent% by upgrading!';
  }

  @override
  String get subscribe => 'Subscribe';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get currentPlanLabel => 'Current Plan';

  @override
  String get noTransactions => 'No transactions yet';

  @override
  String get retry => 'Retry';

  @override
  String get notifications => 'Notifications';

  @override
  String get noNotifications => 'No notifications yet';

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(Object min) {
    return '${min}m ago';
  }

  @override
  String hoursAgo(Object hr) {
    return '${hr}h ago';
  }

  @override
  String get yesterday => 'Yesterday';

  @override
  String daysAgo(Object d) {
    return '${d}d ago';
  }

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get favoriteAudio => 'Audio';

  @override
  String get favoriteVideos => 'Videos';

  @override
  String get favoriteQuotes => 'Quotes';

  @override
  String get favoriteTips => 'Tips';

  @override
  String get favoriteImages => 'Images';

  @override
  String get signInToSaveFavorites => 'Sign in to save favorites';

  @override
  String get noFavorites => 'No favorites yet';

  @override
  String get addFavorites => 'Tap the heart icon to save content here';

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get moreAboutYou => 'More About You';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get username => 'Username';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get gender => 'Gender';

  @override
  String get save => 'Save Changes';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderOther => 'Other';

  @override
  String get genderPreferNotToSay => 'Prefer not to say';

  @override
  String get selectDateOfBirth => 'Select Date of Birth';

  @override
  String get tapToSet => 'Tap to set';

  @override
  String get profileUpdated => 'Profile updated successfully!';

  @override
  String get inspirationalImages => 'Inspirational Images';

  @override
  String get beautifulWallpapers => 'Beautiful wallpapers to inspire you';

  @override
  String get share => 'Share';

  @override
  String get saveImage => 'Save';

  @override
  String get fullscreen => 'Fullscreen';

  @override
  String get setAsWallpaper => 'Set as Wallpaper';

  @override
  String get wallpaperComingSoon => 'Wallpaper feature coming soon!';

  @override
  String premiumRequired(String action) {
    return 'Premium subscription required to $action this content.';
  }

  @override
  String get failedToSaveImage => 'Failed to save image';

  @override
  String get allImages => 'All inspirational images';

  @override
  String get therapistList => 'Find a Therapist';

  @override
  String get therapistDetail => 'Therapist Profile';

  @override
  String get bookNow => 'Book Now';

  @override
  String get experience => 'Experience';

  @override
  String get specialties => 'Specialties';

  @override
  String get about => 'About';

  @override
  String get reviews => 'Reviews';

  @override
  String reviewsCount(int count) {
    return '($count reviews)';
  }

  @override
  String get perSession => 'Per Session';

  @override
  String get qualifications => 'Qualifications';

  @override
  String get sessionInfo => 'Session Info';

  @override
  String get sessionType => 'Session Type';

  @override
  String get videoCallWebRTC => 'Video Call (WebRTC)';

  @override
  String get duration => 'Duration';

  @override
  String get fee => 'Fee';

  @override
  String feeViaEsewa(String fee) {
    return 'NPR $fee via eSewa';
  }

  @override
  String get noTherapistsFound => 'No therapists found';

  @override
  String get categoriesTitle => 'Categories';

  @override
  String get allCategories => 'All Categories';

  @override
  String get tipsTitle => 'Wellness Tips';

  @override
  String get allTips => 'All wellness tips';

  @override
  String get audioTitle => 'Calming Audio';

  @override
  String get allAudio => 'All audio content';

  @override
  String get allVideos => 'All video content';

  @override
  String get matchingTitle => 'Find Your Match';

  @override
  String get matchingSubtitle =>
      'Answer a few questions to find the right therapist';

  @override
  String get next => 'Next';

  @override
  String get submit => 'Find My Therapist';

  @override
  String questionOf(Object current, Object total) {
    return 'Question $current of $total';
  }

  @override
  String questionProgress(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get appointmentChatTitle => 'Chat';

  @override
  String get sendMessage => 'Send a message…';

  @override
  String get send => 'Send';

  @override
  String get premiumSubscriptionRequired => 'Premium Subscription Required';

  @override
  String get unlockPremium => 'Upgrade to unlock this content';

  @override
  String get loading => 'Loading…';

  @override
  String get error => 'Error';

  @override
  String get close => 'Close';

  @override
  String get back => 'Back';

  @override
  String get continueText => 'Continue';

  @override
  String get findMatches => 'Find My Matches';

  @override
  String get qMoodTitle => 'How has your mood been lately?';

  @override
  String get qMoodSubtitle => 'Over the past 2 weeks';

  @override
  String get qMoodOpt1 => 'Mostly positive — I feel okay';

  @override
  String get qMoodOpt2 => 'Ups and downs, but managing';

  @override
  String get qMoodOpt3 => 'Frequently sad or empty';

  @override
  String get qMoodOpt4 => 'Persistently low — hard to function';

  @override
  String get qAnxietyTitle => 'How often do you feel anxious or worried?';

  @override
  String get qAnxietySubtitle => 'Nervousness, panic, or sense of dread';

  @override
  String get qAnxietyOpt1 => 'Rarely or never';

  @override
  String get qAnxietyOpt2 => 'Sometimes, but it passes quickly';

  @override
  String get qAnxietyOpt3 => 'Often — it affects my day';

  @override
  String get qAnxietyOpt4 => 'Almost constantly, hard to control';

  @override
  String get qSleepTitle => 'How would you describe your sleep?';

  @override
  String get qSleepSubtitle =>
      'Sleep quality has a strong impact on mental health';

  @override
  String get qSleepOpt1 => 'Generally good';

  @override
  String get qSleepOpt2 => 'Occasional trouble sleeping';

  @override
  String get qSleepOpt3 => 'Regularly poor — wake often or can\'t fall asleep';

  @override
  String get qSleepOpt4 => 'Severely disrupted — exhausted most days';

  @override
  String get qConcernTitle => 'What is your main reason for seeking therapy?';

  @override
  String get qConcernSubtitle => 'Select all that apply';

  @override
  String get qConcernOpt1 => 'Depression / low mood';

  @override
  String get qConcernOpt2 => 'Anxiety / stress';

  @override
  String get qConcernOpt3 => 'Relationship challenges';

  @override
  String get qConcernOpt4 => 'Grief or loss';

  @override
  String get qConcernOpt5 => 'Trauma or PTSD';

  @override
  String get qConcernOpt6 => 'Self-esteem or identity';

  @override
  String get qConcernOpt7 => 'Life transitions';

  @override
  String get qConcernOpt8 => 'Burnout / work stress';

  @override
  String get qTraumaTitle =>
      'Have past difficult experiences affected your wellbeing?';

  @override
  String get qTraumaSubtitle =>
      'This helps us match trauma-informed therapists if needed';

  @override
  String get qTraumaOpt1 => 'No — not significantly';

  @override
  String get qTraumaOpt2 => 'Somewhat — I\'d like support around it';

  @override
  String get qTraumaOpt3 => 'Yes — it impacts me regularly';

  @override
  String get qTraumaOpt4 => 'Yes — it\'s a major focus I need help with';

  @override
  String get qApproachTitle => 'What kind of support feels right for you?';

  @override
  String get qApproachSubtitle =>
      'Therapists tailor their style to your preference';

  @override
  String get qApproachOpt1 => 'Practical tools & strategies (CBT-style)';

  @override
  String get qApproachOpt2 => 'Exploring emotions & past patterns';

  @override
  String get qApproachOpt3 => 'Mindfulness & present-moment awareness';

  @override
  String get qApproachOpt4 => 'I\'m not sure — open to guidance';

  @override
  String get qPrefTitle => 'Do you have any therapist preferences?';

  @override
  String get qPrefSubtitle => 'A comfortable fit improves outcomes';

  @override
  String get qPrefOpt1 => 'No preference';

  @override
  String get qPrefOpt2 => 'Prefer female therapist';

  @override
  String get qPrefOpt3 => 'Prefer male therapist';

  @override
  String get qPrefOpt4 => 'Prefer therapist with similar cultural background';

  @override
  String get admContentManagement => 'Content Management';

  @override
  String get admSearchTips => 'Search tips...';

  @override
  String get admNoTipsYet => 'No tips yet';

  @override
  String get admSearchQuotes => 'Search quotes...';

  @override
  String get admNoQuotesYet => 'No quotes yet';

  @override
  String get admSearchAudio => 'Search audio...';

  @override
  String get admNoAudioYet => 'No audio tracks yet';

  @override
  String get admSearchVideos => 'Search videos...';

  @override
  String get admAll => 'All';

  @override
  String get admShorts => '⚡ Shorts';

  @override
  String get admLong => '🎬 Long';

  @override
  String get admNoVideosYet => 'No videos yet';

  @override
  String get admSearchImages => 'Search images...';

  @override
  String get admNoImagesYet => 'No images yet';

  @override
  String get admDeleteContent => 'Delete Content';

  @override
  String get admDeleteItemConfirm =>
      'Are you sure you want to delete this item?';

  @override
  String get admCancel => 'Cancel';

  @override
  String get admDelete => 'Delete';

  @override
  String get admOverview => 'Overview';

  @override
  String get admContent => 'Content';

  @override
  String get admTherapists => 'Therapists';

  @override
  String get admUsers => 'Users';

  @override
  String get admMore => 'More';

  @override
  String get admPushNotifications => 'Push Notifications';

  @override
  String get admPushNotificationsSubtitle =>
      'Broadcast messages to users and therapists';

  @override
  String get admPreferencesConfig => 'Preferences Config';

  @override
  String get admPreferencesConfigSubtitle => 'Manage user onboarding options';

  @override
  String get admRevenueAnalytics => 'Revenue Analytics';

  @override
  String get admRevenueAnalyticsSubtitle => 'View detailed charts and payouts';

  @override
  String get admSettings => 'Settings';

  @override
  String get admSettingsSubtitle => 'Theme, Access, and Logs';

  @override
  String get homePremiumRequired =>
      'Premium subscription required to play this content.';

  @override
  String get gmGames => 'Games';

  @override
  String get gmTodaysMood => 'Today\'s Mood';

  @override
  String get gmWellnessHub => 'Wellness Hub';

  @override
  String get gmLevelProgress => 'Level Progress';

  @override
  String get gmToggleSoundEffects => 'Toggle Sound Effects';

  @override
  String get gmToggleBackgroundMusic => 'Toggle Background Music';

  @override
  String get gmExitQuizTitle => 'Exit Quiz?';

  @override
  String get gmExitProgressLost =>
      'Your progress will be lost. Are you sure you want to exit?';

  @override
  String get gmCancel => 'Cancel';

  @override
  String get gmExit => 'Exit';

  @override
  String get gmLoadingQuestions => 'Loading Questions...';

  @override
  String get gmWellnessTrivia => 'Wellness Trivia';

  @override
  String get gmTestWellnessKnowledge => 'Test your wellness knowledge';

  @override
  String get gmTimeLimit => 'Time Limit';

  @override
  String get gmScoring => 'Scoring';

  @override
  String get gmScoringDesc =>
      'Answer faster for more points. Build streaks for bonuses!';

  @override
  String get gmLearn => 'Learn';

  @override
  String get gmLearnDesc => 'Explanations will help you understand each answer';

  @override
  String get gmNoQuestionsAvailable =>
      'No questions available. Please try again later.';

  @override
  String get gmStartQuiz => 'Start Quiz';

  @override
  String get gmExplanation => 'Explanation';

  @override
  String get gmYourFinalScore => 'Your final score';

  @override
  String get gmQuestions => 'Questions';

  @override
  String get gmCorrect => 'Correct';

  @override
  String get gmAccuracy => 'Accuracy';

  @override
  String get gmBestStreak => 'Best Streak';

  @override
  String get gmPlayAgain => 'Play Again';

  @override
  String get medShare => 'Share';

  @override
  String get medSave => 'Save';

  @override
  String get medFullscreen => 'Fullscreen';

  @override
  String get medInspirationalImages => 'Inspirational Images';

  @override
  String get medLoadingImages => 'Loading images...';

  @override
  String get medErrorLoadingImages => 'Error loading images';

  @override
  String get medRetry => 'Retry';

  @override
  String get medNoImagesAvailable => 'No images available';

  @override
  String get medCheckBackLaterInspirational =>
      'Check back later for new inspirational content';

  @override
  String get medSetWallpaper => 'Set Wallpaper';

  @override
  String get medInfo => 'Info';

  @override
  String get medCreator => 'Creator';

  @override
  String get medWallpaperDownloadComingSoon =>
      'Wallpaper download feature coming soon!';

  @override
  String get medFailedToSaveImage => 'Failed to save image';

  @override
  String get medNoInspirationalImagesAvailable =>
      '⚠️ No inspirational images available';

  @override
  String get medBeautifulWallpapersInspire =>
      'Beautiful wallpapers to inspire you';

  @override
  String get medSeeAll => 'See All';

  @override
  String get medWallpaperComingSoon => 'Wallpaper feature coming soon!';

  @override
  String get medSetAsWallpaper => 'Set as Wallpaper';

  @override
  String get homeReels => 'Reels';

  @override
  String get homeLoadingReels => 'Loading Reels...';

  @override
  String get homeCouldNotLoadReels => 'Could not load reels';

  @override
  String get homeRetry => 'Retry';

  @override
  String get homeNoReelsYet => 'No Reels Yet';

  @override
  String get homeCheckBackSoon => 'Check back soon for new content';

  @override
  String get accEmailCannotBeChanged => 'Email cannot be changed';

  @override
  String get accCardHolder => 'CARD HOLDER';

  @override
  String get accValidThru => 'VALID THRU';

  @override
  String get accResilioPremium => 'RESILIO PREMIUM';

  @override
  String get bizPaymentFailed => 'Payment failed';

  @override
  String get bizPaymentCancelled => 'Payment cancelled';

  @override
  String get bizCancelSubscription => 'Cancel Subscription';

  @override
  String get bizCancelSubscriptionConfirm =>
      'Are you sure you want to cancel your subscription?';

  @override
  String get bizNo => 'No';

  @override
  String get bizYes => 'Yes';

  @override
  String get bizPremiumMembership => 'PREMIUM MEMBERSHIP';

  @override
  String get bizElevateWellnessJourney => 'Elevate Your\\nWellness Journey';

  @override
  String get bizUnlockPremiumContent =>
      'Unlock premium content, guided sessions,\\nand exclusive wellness tools.';

  @override
  String get bizUnlimitedContent => 'Unlimited Content';

  @override
  String get bizExpertTips => 'Expert Tips';

  @override
  String get bizAdFree => 'Ad-Free';

  @override
  String get accConnecting => 'Connecting…';

  @override
  String get accVoiceCall => 'Voice Call';

  @override
  String get accCalling => 'Calling…';

  @override
  String get accUnmute => 'Unmute';

  @override
  String get accCamera => 'Camera';

  @override
  String get accEnd => 'End';

  @override
  String get accFlip => 'Flip';

  @override
  String get accSpeaker => 'Speaker';

  @override
  String get thrSessions => 'Sessions';

  @override
  String get thrCouldNotLoadSessions => 'Could not load sessions';

  @override
  String get thrRetry => 'Retry';

  @override
  String get thrNoSessionsFound => 'No sessions found';

  @override
  String get thrDecline => 'Decline';

  @override
  String get thrAccept => 'Accept';

  @override
  String get thrMessagePatient => 'Message Patient';

  @override
  String get thrJoinSession => 'Join Session';

  @override
  String get thrJoinButtonActivatesHint =>
      'Join button activates 15 min before session';

  @override
  String get thrDeleteContentTitle => 'Delete Content?';

  @override
  String get thrActionCannotBeUndone => 'This action cannot be undone.';

  @override
  String get thrCancel => 'Cancel';

  @override
  String get thrDelete => 'Delete';

  @override
  String get thrEarnings => 'Earnings';

  @override
  String get thrThisWeek => 'This Week';

  @override
  String get thrThisMonth => 'This Month';

  @override
  String get thrTotalEarnings => 'Total Earnings';

  @override
  String get thrAllTimeRevenue => 'All time revenue';

  @override
  String get thrWeeklyRevenue => 'Weekly Revenue';

  @override
  String get thrRecentTransactions => 'Recent Transactions';

  @override
  String get thrMyPatients => 'My Patients';

  @override
  String get thrSearchPatients => 'Search patients…';

  @override
  String get thrNoPatientsYet => 'No patients yet';

  @override
  String get thrNoSessions => 'No sessions';

  @override
  String get accEar => 'Ear';

  @override
  String get accMute => 'Mute';

  @override
  String get accNoVideo => 'No Video';

  @override
  String get admAddFirstTip => 'Add your first tip with the + button';

  @override
  String get thrNotSessionTime => 'Not Session Time';

  @override
  String get accCustomizeAppInterface => 'Customize your app interface';

  @override
  String get accEnglish => 'English';

  @override
  String get accLanguage => 'Language';

  @override
  String get accNepali => 'Nepali';

  @override
  String get accRegisterAsLabel => 'I want to register as a';

  @override
  String get accRoleCustomer => 'customer';

  @override
  String get accRoleTherapist => 'therapist';

  @override
  String get accSelectPreferredLanguage => 'Select your preferred language';

  @override
  String get accTheme => 'Theme';

  @override
  String get accThemeDark => 'Dark';

  @override
  String get accThemeLight => 'Light';

  @override
  String get accThemeSystem => 'System';

  @override
  String get accWellness => 'Wellness';

  @override
  String get bizCurrentPlan => 'Current Plan';

  @override
  String get bizSubscribeNow => 'Subscribe Now';

  @override
  String get bizUpgradeNow => 'Upgrade Now';

  @override
  String gmTimeLimitDesc(Object seconds) {
    return 'You have $seconds seconds for each question';
  }

  @override
  String gmSecondsCount(Object seconds) {
    return '$seconds seconds';
  }

  @override
  String accErrorWithMessage(Object message) {
    return 'Error: $message';
  }

  @override
  String accCameraUnavailable(Object error) {
    return 'Camera unavailable: $error';
  }

  @override
  String thrSessionsForFilterAppearHere(Object filter) {
    return 'Sessions for \"$filter\" will appear here';
  }

  @override
  String thrNoResultsFor(Object query) {
    return 'No results for \"$query\"';
  }

  @override
  String thrSessionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessions',
      one: '1 session',
    );
    return '$_temp0';
  }

  @override
  String thrLastSession(Object date) {
    return 'Last: $date';
  }

  @override
  String get exploreSearchContent => 'Search content...';

  @override
  String get exploreTryAgain => 'Try Again';

  @override
  String get catSearchCategories => 'Search categories...';

  @override
  String get favSignInToSave => 'Sign in to save favorites';

  @override
  String get gmFailedLoadMoods => 'Failed to load mood entries';

  @override
  String get gmJournalUpdated => 'Journal updated';

  @override
  String get gmEnterThoughts => 'Enter your thoughts...';

  @override
  String get gmStay => 'Stay';

  @override
  String get gmLeave => 'Leave';

  @override
  String get gmExitGame => 'Exit Game?';

  @override
  String get gmMindfulBreathing => 'Mindful Breathing';

  @override
  String get gmChoosePatternBegin => 'Choose Pattern & Begin';

  @override
  String get gmChooseYourPattern => 'Choose Your Pattern';

  @override
  String get gmDifferentPatterns => 'Different patterns for different needs';

  @override
  String get gmHowManyRounds => 'How many rounds?';

  @override
  String get gmGetReady => 'Get Ready';

  @override
  String get gmSessionComplete => 'Session Complete!';

  @override
  String get gmExcellentWork => 'Excellent mindfulness work today.';

  @override
  String get gmDone => 'Done';

  @override
  String catSearchIn(Object name) {
    return 'Search $name...';
  }

  @override
  String gmStartRounds(Object count) {
    return 'Start $count Rounds  →';
  }

  @override
  String gmRoundProgress(Object current, Object total) {
    return 'Round $current / $total';
  }
}
