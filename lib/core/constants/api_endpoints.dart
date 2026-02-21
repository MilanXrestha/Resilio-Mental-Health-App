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
}
