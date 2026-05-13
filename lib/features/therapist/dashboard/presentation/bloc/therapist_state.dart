import 'package:equatable/equatable.dart';

// We use Equatable to help Bloc determine if state changed
class TherapistState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  // Single source of truth for all dashboard features
  final Map<String, dynamic>? dashboardData;
  final List<Map<String, dynamic>>? appointments;
  final String activeAppointmentFilter;
  final List<Map<String, dynamic>>? patients;
  final List<Map<String, dynamic>>? filteredPatients;
  final String patientQuery;
  final Map<String, dynamic>? earningsData;
  final Map<String, dynamic>? profile;

  const TherapistState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.dashboardData,
    this.appointments,
    this.activeAppointmentFilter = 'all',
    this.patients,
    this.filteredPatients,
    this.patientQuery = '',
    this.earningsData,
    this.profile,
  });

  TherapistState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
    Map<String, dynamic>? dashboardData,
    List<Map<String, dynamic>>? appointments,
    String? activeAppointmentFilter,
    List<Map<String, dynamic>>? patients,
    List<Map<String, dynamic>>? filteredPatients,
    String? patientQuery,
    Map<String, dynamic>? earningsData,
    Map<String, dynamic>? profile,
  }) {
    return TherapistState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess ? null : (successMessage ?? this.successMessage),
      dashboardData: dashboardData ?? this.dashboardData,
      appointments: appointments ?? this.appointments,
      activeAppointmentFilter: activeAppointmentFilter ?? this.activeAppointmentFilter,
      patients: patients ?? this.patients,
      filteredPatients: filteredPatients ?? this.filteredPatients,
      patientQuery: patientQuery ?? this.patientQuery,
      earningsData: earningsData ?? this.earningsData,
      profile: profile ?? this.profile,
    );
  }

  // Getters for specific features
  bool get hasDashboard => dashboardData != null;
  bool get hasAppointments => appointments != null;
  bool get hasPatients => patients != null;
  bool get hasEarnings => earningsData != null;
  bool get hasProfile => profile != null;

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        successMessage,
        dashboardData,
        appointments,
        activeAppointmentFilter,
        patients,
        filteredPatients,
        patientQuery,
        earningsData,
        profile,
      ];
}
