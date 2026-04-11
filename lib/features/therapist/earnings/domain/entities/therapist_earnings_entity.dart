class TherapistEarningsEntity {
  final double totalEarnings;
  final double weekEarnings;
  final double monthEarnings;
  final List<Map<String, dynamic>> weeklyChart;
  final List<Map<String, dynamic>> transactions;

  const TherapistEarningsEntity({
    required this.totalEarnings,
    required this.weekEarnings,
    required this.monthEarnings,
    required this.weeklyChart,
    required this.transactions,
  });

  factory TherapistEarningsEntity.fromMap(Map<String, dynamic> map) {
    return TherapistEarningsEntity(
      totalEarnings: (map['totalEarnings'] as num?)?.toDouble() ?? 0.0,
      weekEarnings: (map['weekEarnings'] as num?)?.toDouble() ?? 0.0,
      monthEarnings: (map['monthEarnings'] as num?)?.toDouble() ?? 0.0,
      weeklyChart: (map['weeklyChart'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>(),
      transactions: (map['transactions'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>(),
    );
  }
}
