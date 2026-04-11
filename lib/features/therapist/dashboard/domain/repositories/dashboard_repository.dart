import '../entities/dashboard_stats_entity.dart';

abstract class DashboardRepository {
  Future<DashboardStatsEntity> getStats();
  Future<bool> notifyCall(String appointmentId);
}
