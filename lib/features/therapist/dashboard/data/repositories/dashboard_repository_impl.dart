import 'package:injectable/injectable.dart';

import '../datasources/remote/dashboard_remote_datasource.dart';
import '../../domain/entities/dashboard_stats_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';

@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final TherapistDashboardRemoteDataSource _dataSource;

  DashboardRepositoryImpl(this._dataSource);

  @override
  Future<DashboardStatsEntity> getStats() async {
    try {
      final map = await _dataSource.getStats();
      return DashboardStatsEntity.fromMap(map);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> notifyCall(String appointmentId) async {
    try {
      return await _dataSource.notifyCall(appointmentId);
    } catch (e) {
      rethrow;
    }
  }
}
