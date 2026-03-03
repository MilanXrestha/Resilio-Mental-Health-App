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

  // SuperTokens FDI endpoints (passwordless)
  // These are served by supertokens-node middleware at /api/v1/auth/**
  // NOTE: baseUrl already contains /api/v1, so paths here are relative to that.
  static const String stCreateCode  = '/auth/signinup/code';
  static const String stConsumeCode = '/auth/signinup/code/consume';

  // Our custom route: syncs ST user into Supabase after OTP verify
  static const String passwordlessComplete = '/passwordless/complete';
}
