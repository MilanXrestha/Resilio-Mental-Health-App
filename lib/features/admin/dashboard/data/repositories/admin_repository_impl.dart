import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/features/admin/dashboard/domain/repositories/admin_repository.dart';

@LazySingleton(as: AdminRepository)
class AdminRepositoryImpl implements AdminRepository {
  final Dio _dio;
  AdminRepositoryImpl(this._dio);

  // ── Dashboard ─────────────────────────────────────
  @override
  Future<Map<String, dynamic>> getDashboardStats() async {
    final r = await _dio.get('/admin/stats');
    return r.data as Map<String, dynamic>;
  }

  // ── Therapists ─────────────────────────────────────
  @override
  Future<Map<String, dynamic>> getTherapists({String verified = 'all', String search = ''}) async {
    final r = await _dio.get('/admin/therapists', queryParameters: {
      'verified': verified,
      if (search.isNotEmpty) 'search': search,
    });
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<bool> verifyTherapist(String therapistId, {required bool isVerified, String? rejectionReason}) async {
    await _dio.patch('/admin/therapists/$therapistId/verify', data: {
      'isVerified': isVerified,
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
    });
    return true;
  }

  @override
  Future<bool> deleteTherapist(String therapistId) async {
    await _dio.delete('/admin/therapists/$therapistId');
    return true;
  }

  @override
  Future<bool> updateTherapistCommission(String therapistId, double commissionRate) async {
    await _dio.patch('/admin/therapists/$therapistId/commission', data: {'commissionRate': commissionRate});
    return true;
  }

  // ── Users ──────────────────────────────────────────
  @override
  Future<Map<String, dynamic>> getUsers({String role = 'all', String search = '', int limit = 50, int offset = 0}) async {
    final r = await _dio.get('/admin/users', queryParameters: {
      'role': role, 'limit': limit, 'offset': offset,
      if (search.isNotEmpty) 'search': search,
    });
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<bool> updateUserRole(String userId, {required String userRole}) async {
    await _dio.patch('/admin/users/$userId/role', data: {'userRole': userRole});
    return true;
  }

  @override
  Future<bool> updateUserStatus(String userId, {required bool isActive}) async {
    await _dio.patch('/admin/users/$userId/status', data: {'isActive': isActive});
    return true;
  }

  @override
  Future<bool> deleteUser(String userId) async {
    await _dio.delete('/admin/users/$userId');
    return true;
  }

  // ── Appointments ───────────────────────────────────
  @override
  Future<Map<String, dynamic>> getAppointments({String status = 'all', int limit = 50, int offset = 0}) async {
    final r = await _dio.get('/admin/appointments', queryParameters: {'status': status, 'limit': limit, 'offset': offset});
    return r.data as Map<String, dynamic>;
  }

  // ── Generic Content ────────────────────────────────
  @override
  Future<Map<String, dynamic>> getContent({String type = 'all', int limit = 50, int offset = 0}) async {
    final r = await _dio.get('/admin/content', queryParameters: {'type': type, 'limit': limit, 'offset': offset});
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<bool> deleteContent(String type, String contentId) async {
    await _dio.delete('/admin/content/$type/$contentId');
    return true;
  }

  // ── Tips ───────────────────────────────────────────
  @override
  Future<Map<String, dynamic>> getTips({int limit = 50, int offset = 0, String search = ''}) async {
    final r = await _dio.get('/admin/tips', queryParameters: {'limit': limit, 'offset': offset, if (search.isNotEmpty) 'search': search});
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> createTip(Map<String, dynamic> tipData) async {
    final r = await _dio.post('/admin/tips', data: tipData);
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> updateTip(String id, Map<String, dynamic> tipData) async {
    final r = await _dio.put('/admin/tips/$id', data: tipData);
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<bool> deleteTip(String id) async {
    await _dio.delete('/admin/tips/$id');
    return true;
  }

  // ── Quotes ─────────────────────────────────────────
  @override
  Future<Map<String, dynamic>> getQuotes({int limit = 50, int offset = 0, String search = ''}) async {
    final r = await _dio.get('/admin/quotes', queryParameters: {'limit': limit, 'offset': offset, if (search.isNotEmpty) 'search': search});
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> createQuote(Map<String, dynamic> quoteData) async {
    final r = await _dio.post('/admin/quotes', data: quoteData);
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> updateQuote(String id, Map<String, dynamic> quoteData) async {
    final r = await _dio.put('/admin/quotes/$id', data: quoteData);
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<bool> deleteQuote(String id) async {
    await _dio.delete('/admin/quotes/$id');
    return true;
  }

  // ── Audio ──────────────────────────────────────────
  @override
  Future<Map<String, dynamic>> getAudio({int limit = 50, int offset = 0, String search = ''}) async {
    final r = await _dio.get('/admin/audio', queryParameters: {'limit': limit, 'offset': offset, if (search.isNotEmpty) 'search': search});
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> createAudio(Map<String, dynamic> audioData) async {
    final r = await _dio.post('/admin/audio', data: audioData);
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> updateAudio(String id, Map<String, dynamic> audioData) async {
    final r = await _dio.put('/admin/audio/$id', data: audioData);
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<bool> deleteAudio(String id) async {
    await _dio.delete('/admin/audio/$id');
    return true;
  }

  // ── Videos ─────────────────────────────────────────
  @override
  Future<Map<String, dynamic>> getVideos({int limit = 50, int offset = 0, String search = '', String videoType = 'all'}) async {
    final r = await _dio.get('/admin/videos', queryParameters: {'limit': limit, 'offset': offset, 'videoType': videoType, if (search.isNotEmpty) 'search': search});
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> createVideo(Map<String, dynamic> videoData) async {
    final r = await _dio.post('/admin/videos', data: videoData);
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> updateVideo(String id, Map<String, dynamic> videoData) async {
    final r = await _dio.put('/admin/videos/$id', data: videoData);
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<bool> deleteVideo(String id) async {
    await _dio.delete('/admin/videos/$id');
    return true;
  }

  // ── Images ─────────────────────────────────────────
  @override
  Future<Map<String, dynamic>> getImages({int limit = 50, int offset = 0, String search = ''}) async {
    final r = await _dio.get('/admin/images', queryParameters: {'limit': limit, 'offset': offset, if (search.isNotEmpty) 'search': search});
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> createImage(Map<String, dynamic> imageData) async {
    final r = await _dio.post('/admin/images', data: imageData);
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> updateImage(String id, Map<String, dynamic> imageData) async {
    final r = await _dio.put('/admin/images/$id', data: imageData);
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<bool> deleteImage(String id) async {
    await _dio.delete('/admin/images/$id');
    return true;
  }

  // ── Revenue ────────────────────────────────────────
  @override
  Future<Map<String, dynamic>> getRevenueStats() async {
    final r = await _dio.get('/admin/revenue');
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getSubscriptions({String status = 'all', int limit = 50, int offset = 0}) async {
    final r = await _dio.get('/admin/subscriptions', queryParameters: {'status': status, 'limit': limit, 'offset': offset});
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getTherapistPayments({int limit = 50, int offset = 0}) async {
    final r = await _dio.get('/admin/therapist-payments', queryParameters: {'limit': limit, 'offset': offset});
    return r.data as Map<String, dynamic>;
  }

  // ── Notifications Broadcast ────────────────────────
  @override
  Future<Map<String, dynamic>> broadcastNotification({
    required String title,
    required String body,
    String targetRole = 'all',
    String? actionType,
    Map<String, dynamic>? actionPayload,
  }) async {
    final r = await _dio.post('/admin/notifications/broadcast', data: {
      'title': title, 'body': body, 'targetRole': targetRole,
      if (actionType != null) 'actionType': actionType,
      if (actionPayload != null) 'actionPayload': actionPayload,
    });
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<List<dynamic>> getNotificationHistory({int limit = 20, int offset = 0}) async {
    final r = await _dio.get('/admin/notifications/history', queryParameters: {'limit': limit, 'offset': offset});
    return (r.data['history'] as List<dynamic>?) ?? [];
  }

  // ── Preferences ────────────────────────────────────
  @override
  Future<List<dynamic>> getPreferences() async {
    final r = await _dio.get('/admin/preferences');
    return (r.data['categories'] as List<dynamic>?) ?? [];
  }

  @override
  Future<Map<String, dynamic>> createPreference(Map<String, dynamic> preferenceData) async {
    final r = await _dio.post('/admin/preferences', data: preferenceData);
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> updatePreference(String id, Map<String, dynamic> preferenceData) async {
    final r = await _dio.put('/admin/preferences/$id', data: preferenceData);
    return r.data as Map<String, dynamic>;
  }

  @override
  Future<bool> deletePreference(String id) async {
    await _dio.delete('/admin/preferences/$id');
    return true;
  }
}
