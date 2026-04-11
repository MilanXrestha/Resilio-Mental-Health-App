import '../entities/therapist_profile_entity.dart';

abstract class TherapistProfileRepository {
  Future<TherapistProfileEntity> getProfile();
  Future<bool> updateProfile(Map<String, dynamic> data);
}
