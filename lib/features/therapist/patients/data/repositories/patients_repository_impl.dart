import 'package:injectable/injectable.dart';

import '../datasources/remote/patients_remote_datasource.dart';
import '../../domain/entities/therapist_patient_entity.dart';
import '../../domain/repositories/patients_repository.dart';

@LazySingleton(as: PatientsRepository)
class PatientsRepositoryImpl implements PatientsRepository {
  final PatientsRemoteDataSource _dataSource;

  PatientsRepositoryImpl(this._dataSource);

  @override
  Future<List<TherapistPatientEntity>> getPatients() async {
    try {
      final maps = await _dataSource.getPatients();
      return maps.map(TherapistPatientEntity.fromMap).toList();
    } catch (e) {
      rethrow;
    }
  }
}
