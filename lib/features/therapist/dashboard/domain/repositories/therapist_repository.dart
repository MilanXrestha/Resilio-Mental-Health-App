abstract class TherapistRepository {
  Future<Map<String, dynamic>> getMyProfile();
  Future<List<dynamic>> getMyAppointments();
  Future<bool> updateAvailability(Map<String, dynamic> availabilityData);
}
