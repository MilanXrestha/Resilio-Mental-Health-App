abstract class AdminRepository {
  // ── Dashboard ─────────────────────────────────────
  Future<Map<String, dynamic>> getDashboardStats();

  // ── Therapist Management ───────────────────────────
  Future<Map<String, dynamic>> getTherapists({String verified = 'all', String search = ''});
  Future<bool> verifyTherapist(String therapistId, {required bool isVerified, String? rejectionReason});
  Future<bool> deleteTherapist(String therapistId);
  Future<bool> updateTherapistCommission(String therapistId, double commissionRate);

  // ── User Management ────────────────────────────────
  Future<Map<String, dynamic>> getUsers({String role = 'all', String search = '', int limit = 50, int offset = 0});
  Future<bool> updateUserRole(String userId, {required String userRole});
  Future<bool> updateUserStatus(String userId, {required bool isActive});
  Future<bool> deleteUser(String userId);

  // ── Appointment Management ─────────────────────────
  Future<Map<String, dynamic>> getAppointments({String status = 'all', int limit = 50, int offset = 0});

  // ── Generic Content ────────────────────────────────
  Future<Map<String, dynamic>> getContent({String type = 'all', int limit = 50, int offset = 0});
  Future<bool> deleteContent(String type, String contentId);

  // ── Tips CRUD ──────────────────────────────────────
  Future<Map<String, dynamic>> getTips({int limit = 50, int offset = 0, String search = ''});
  Future<Map<String, dynamic>> createTip(Map<String, dynamic> tipData);
  Future<Map<String, dynamic>> updateTip(String id, Map<String, dynamic> tipData);
  Future<bool> deleteTip(String id);

  // ── Quotes CRUD ────────────────────────────────────
  Future<Map<String, dynamic>> getQuotes({int limit = 50, int offset = 0, String search = ''});
  Future<Map<String, dynamic>> createQuote(Map<String, dynamic> quoteData);
  Future<Map<String, dynamic>> updateQuote(String id, Map<String, dynamic> quoteData);
  Future<bool> deleteQuote(String id);

  // ── Audio CRUD ─────────────────────────────────────
  Future<Map<String, dynamic>> getAudio({int limit = 50, int offset = 0, String search = ''});
  Future<Map<String, dynamic>> createAudio(Map<String, dynamic> audioData);
  Future<Map<String, dynamic>> updateAudio(String id, Map<String, dynamic> audioData);
  Future<bool> deleteAudio(String id);

  // ── Video CRUD ─────────────────────────────────────
  Future<Map<String, dynamic>> getVideos({int limit = 50, int offset = 0, String search = '', String videoType = 'all'});
  Future<Map<String, dynamic>> createVideo(Map<String, dynamic> videoData);
  Future<Map<String, dynamic>> updateVideo(String id, Map<String, dynamic> videoData);
  Future<bool> deleteVideo(String id);

  // ── Images CRUD ────────────────────────────────────
  Future<Map<String, dynamic>> getImages({int limit = 50, int offset = 0, String search = ''});
  Future<Map<String, dynamic>> createImage(Map<String, dynamic> imageData);
  Future<Map<String, dynamic>> updateImage(String id, Map<String, dynamic> imageData);
  Future<bool> deleteImage(String id);

  // ── Revenue & Subscriptions ────────────────────────
  Future<Map<String, dynamic>> getRevenueStats();
  Future<Map<String, dynamic>> getSubscriptions({String status = 'all', int limit = 50, int offset = 0});
  Future<Map<String, dynamic>> getTherapistPayments({int limit = 50, int offset = 0});

  // ── Notifications Broadcast ────────────────────────
  Future<Map<String, dynamic>> broadcastNotification({
    required String title,
    required String body,
    String targetRole = 'all',
    String? actionType,
    Map<String, dynamic>? actionPayload,
  });
  Future<List<dynamic>> getNotificationHistory({int limit = 20, int offset = 0});

  // ── Preference Management ──────────────────────────
  Future<List<dynamic>> getPreferences();
  Future<Map<String, dynamic>> createPreference(Map<String, dynamic> preferenceData);
  Future<Map<String, dynamic>> updatePreference(String id, Map<String, dynamic> preferenceData);
  Future<bool> deletePreference(String id);
}
