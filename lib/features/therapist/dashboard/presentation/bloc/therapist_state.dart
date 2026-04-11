/// Plain Dart state classes — no Freezed needed.
abstract class TherapistState {
  const TherapistState();
}

class TherapistInitial extends TherapistState {
  const TherapistInitial();
}

class TherapistLoading extends TherapistState {
  const TherapistLoading();
}

class TherapistError extends TherapistState {
  final String message;
  const TherapistError(this.message);
}

class TherapistDashboardLoaded extends TherapistState {
  final int todaySessions;
  final int pendingRequests;
  final int totalPatients;
  final double weeklyEarnings;
  final double totalEarnings;
  final List<Map<String, dynamic>> sessionChart;
  final Map<String, dynamic>? nextAppointment;

  const TherapistDashboardLoaded({
    required this.todaySessions,
    required this.pendingRequests,
    required this.totalPatients,
    required this.weeklyEarnings,
    required this.totalEarnings,
    required this.sessionChart,
    this.nextAppointment,
  });
}

class TherapistAppointmentsLoaded extends TherapistState {
  final List<Map<String, dynamic>> appointments;
  final String activeFilter;

  const TherapistAppointmentsLoaded({
    required this.appointments,
    this.activeFilter = 'all',
  });
}

class TherapistPatientsLoaded extends TherapistState {
  final List<Map<String, dynamic>> patients;
  final List<Map<String, dynamic>> filtered;
  final String query;

  const TherapistPatientsLoaded({
    required this.patients,
    required this.filtered,
    this.query = '',
  });
}

class TherapistEarningsLoaded extends TherapistState {
  final double totalEarnings;
  final double weekEarnings;
  final double monthEarnings;
  final List<Map<String, dynamic>> weeklyChart;
  final List<Map<String, dynamic>> transactions;

  const TherapistEarningsLoaded({
    required this.totalEarnings,
    required this.weekEarnings,
    required this.monthEarnings,
    required this.weeklyChart,
    required this.transactions,
  });
}

class TherapistProfileLoaded extends TherapistState {
  final Map<String, dynamic> profile;

  const TherapistProfileLoaded({required this.profile});
}

class TherapistActionSuccess extends TherapistState {
  final String message;
  const TherapistActionSuccess(this.message);
}
