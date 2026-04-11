import '../entities/therapist_patient_entity.dart';

abstract class PatientsRepository {
  Future<List<TherapistPatientEntity>> getPatients();
}
