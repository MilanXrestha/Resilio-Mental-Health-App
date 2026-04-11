import 'package:injectable/injectable.dart';

import '../datasources/remote/appointments_remote_datasource.dart';
import '../../domain/entities/therapist_appointment_entity.dart';
import '../../domain/repositories/appointments_repository.dart';

@LazySingleton(as: AppointmentsRepository)
class AppointmentsRepositoryImpl implements AppointmentsRepository {
  final AppointmentsRemoteDataSource _dataSource;

  AppointmentsRepositoryImpl(this._dataSource);

  @override
  Future<List<TherapistAppointmentEntity>> getAppointments({String? status, String? date}) async {
    try {
      final maps = await _dataSource.getAppointments(status: status, date: date);
      return maps.map(TherapistAppointmentEntity.fromMap).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateStatus(String appointmentId, String status) async {
    try {
      return await _dataSource.updateStatus(appointmentId, status);
    } catch (e) {
      rethrow;
    }
  }
}
