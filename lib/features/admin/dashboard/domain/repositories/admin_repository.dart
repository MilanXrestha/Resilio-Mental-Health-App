abstract class AdminRepository {
  Future<Map<String, dynamic>> getDashboardStats();
  Future<List<dynamic>> getUsers();
  Future<List<dynamic>> getTherapists({bool verified = true});
  Future<bool> verifyTherapist(String therapistId, {required bool approve});
}
