import '../entities/therapist_appointment_entity.dart';

abstract class AppointmentsRepository {
  Future<List<TherapistAppointmentEntity>> getAppointments({String? status, String? date});
  Future<bool> updateStatus(String appointmentId, String status);
}
