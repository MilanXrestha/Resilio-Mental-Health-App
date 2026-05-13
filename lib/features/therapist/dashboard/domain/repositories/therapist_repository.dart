abstract class TherapistRepository {
  Future<Map<String, dynamic>> getDashboardStats();
  Future<List<Map<String, dynamic>>> getAppointments({
    String? status,
    String? date,
  });
  Future<bool> updateAppointmentStatus(String appointmentId, String status);
  Future<List<Map<String, dynamic>>> getPatients();
  Future<Map<String, dynamic>> getEarnings();
  Future<Map<String, dynamic>> getPortalProfile();
  Future<bool> updatePortalProfile(Map<String, dynamic> data);
  Future<bool> changePassword(String currentPassword, String newPassword);
  Future<bool> notifyCall(String appointmentId);

  // Content CRUD
  Future<List<Map<String, dynamic>>> getContent(String type);
  Future<Map<String, dynamic>> createContent(
    String type,
    Map<String, dynamic> data,
  );
  Future<Map<String, dynamic>> updateContent(
    String type,
    String id,
    Map<String, dynamic> data,
  );
  Future<bool> deleteContent(String type, String id);
}
