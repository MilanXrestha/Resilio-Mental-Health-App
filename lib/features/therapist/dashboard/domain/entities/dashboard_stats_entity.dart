class DashboardStatsEntity {
  final int todaySessions;
  final int pendingRequests;
  final int totalPatients;
  final double weeklyEarnings;
  final double totalEarnings;
  final List<Map<String, dynamic>> sessionChart;
  final Map<String, dynamic>? nextAppointment;

  const DashboardStatsEntity({
    required this.todaySessions,
    required this.pendingRequests,
    required this.totalPatients,
    required this.weeklyEarnings,
    required this.totalEarnings,
    required this.sessionChart,
    this.nextAppointment,
  });

  factory DashboardStatsEntity.fromMap(Map<String, dynamic> map) {
    return DashboardStatsEntity(
      todaySessions: (map['todaySessions'] as num?)?.toInt() ?? 0,
      pendingRequests: (map['pendingRequests'] as num?)?.toInt() ?? 0,
      totalPatients: (map['totalPatients'] as num?)?.toInt() ?? 0,
      weeklyEarnings: (map['weeklyEarnings'] as num?)?.toDouble() ?? 0.0,
      totalEarnings: (map['totalEarnings'] as num?)?.toDouble() ?? 0.0,
      sessionChart: (map['sessionChart'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>(),
      nextAppointment: map['nextAppointment'] as Map<String, dynamic>?,
    );
  }
}
