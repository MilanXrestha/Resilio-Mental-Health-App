class ApiEndpoints {
  // Production backend URL
  static const String baseUrl = 'https://resilio-backend.vercel.app/api/v1';
  
  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  
  // Users
  static const String users = '/users';
  static const String syncUser = '/users/sync';
  static const String me = '/users/me';

  // Preferences
  static const String preferences = '/preferences';
  static const String preferencesMe = '/preferences/me';
  static const String preferencesMeCompleted = '/preferences/me/completed';

  // Categories
  static const String categories = '/categories';
  static const String categoryContent = '/categories';

  // Quotes
  static const String quotes = '/quotes';
  static const String quotesFeatured = '/quotes/featured';

  // Tips
  static const String tips = '/tips';
  static const String tipsFeatured = '/tips/featured';
  static const String tipsByType = '/tips/type';

  // Images
  static const String images = '/images';
  static const String imagesFeatured = '/images/featured';
  static const String imagesByType = '/images/type';

  // Audio
  static const String audio = '/audio';
  static const String audioFeatured = '/audio/featured';
  static const String audioCategory = '/audio/category';

  // Video
  static const String video = '/videos';
  static const String videoShorts = '/videos/shorts';
  static const String videoLong = '/videos/long';
  static const String videoFeatured = '/videos/featured';

  // Search
  static const String search = '/search';

  // Favorites
  static const String favorites = '/favorites';
  static const String favoriteStatus = '/favorites/status';
  static const String favoriteUser = '/favorites/user';

  // Mood sharing with therapists
  static const String moodShareCandidates = '/mood/therapists';
  static const String moodShare = '/mood/share';
  static const String moodShares = '/mood/shares';

  // SuperTokens FDI endpoints (passwordless)
  // These are served by supertokens-node middleware at /api/v1/auth/**
  // NOTE: baseUrl already contains /api/v1, so paths here are relative to that.
  static const String stCreateCode  = '/auth/signinup/code';
  static const String stConsumeCode = '/auth/signinup/code/consume';

  // Our custom route: syncs ST user into Supabase after OTP verify
  static const String passwordlessComplete = '/passwordless/complete';
}


