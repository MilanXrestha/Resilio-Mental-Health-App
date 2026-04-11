import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/therapist_repository.dart';
import 'therapist_state.dart';

@injectable
class TherapistCubit extends Cubit<TherapistState> {
  final TherapistRepository _repository;

  TherapistCubit(this._repository) : super(const TherapistInitial());

  // ── Dashboard ───────────────────────────────────────────────────────────────
  Future<void> loadDashboard() async {
    emit(const TherapistLoading());
    try {
      final data = await _repository.getDashboardStats();
      final chart = (data['sessionChart'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();
      emit(TherapistDashboardLoaded(
        todaySessions: (data['todaySessions'] as num?)?.toInt() ?? 0,
        pendingRequests: (data['pendingRequests'] as num?)?.toInt() ?? 0,
        totalPatients: (data['totalPatients'] as num?)?.toInt() ?? 0,
        weeklyEarnings: (data['weeklyEarnings'] as num?)?.toDouble() ?? 0.0,
        totalEarnings: (data['totalEarnings'] as num?)?.toDouble() ?? 0.0,
        sessionChart: chart,
        nextAppointment: data['nextAppointment'] as Map<String, dynamic>?,
      ));
    } catch (e) {
      emit(TherapistError(e.toString()));
    }
  }

  // ── Appointments ────────────────────────────────────────────────────────────
  Future<void> loadAppointments({String filter = 'all'}) async {
    emit(const TherapistLoading());
    try {
      String? statusParam;
      String? dateParam;

      switch (filter) {
        case 'today':
          dateParam = 'today';
          break;
        case 'upcoming':
          dateParam = 'upcoming';
          break;
        case 'pending':
          statusParam = 'pending';
          break;
        case 'completed':
          statusParam = 'completed';
          break;
        default:
          break;
      }

      final list = await _repository.getAppointments(
        status: statusParam,
        date: dateParam,
      );
      emit(TherapistAppointmentsLoaded(appointments: list, activeFilter: filter));
    } catch (e) {
      emit(TherapistError(e.toString()));
    }
  }

  Future<void> updateAppointmentStatus(String appointmentId, String status, {String currentFilter = 'all'}) async {
    try {
      await _repository.updateAppointmentStatus(appointmentId, status);
      // Reload the list
      await loadAppointments(filter: currentFilter);
    } catch (e) {
      emit(TherapistError(e.toString()));
    }
  }

  // ── Patients ────────────────────────────────────────────────────────────────
  Future<void> loadPatients() async {
    emit(const TherapistLoading());
    try {
      final list = await _repository.getPatients();
      emit(TherapistPatientsLoaded(patients: list, filtered: list));
    } catch (e) {
      emit(TherapistError(e.toString()));
    }
  }

  void filterPatients(String query) {
    final state = this.state;
    if (state is! TherapistPatientsLoaded) return;
    final q = query.toLowerCase().trim();
    final filtered = q.isEmpty
        ? state.patients
        : state.patients
            .where((p) =>
                (p['displayName'] as String? ?? '').toLowerCase().contains(q) ||
                (p['email'] as String? ?? '').toLowerCase().contains(q))
            .toList();
    emit(TherapistPatientsLoaded(patients: state.patients, filtered: filtered, query: query));
  }

  // ── Earnings ────────────────────────────────────────────────────────────────
  Future<void> loadEarnings() async {
    emit(const TherapistLoading());
    try {
      final data = await _repository.getEarnings();
      emit(TherapistEarningsLoaded(
        totalEarnings: (data['totalEarnings'] as num?)?.toDouble() ?? 0.0,
        weekEarnings: (data['weekEarnings'] as num?)?.toDouble() ?? 0.0,
        monthEarnings: (data['monthEarnings'] as num?)?.toDouble() ?? 0.0,
        weeklyChart: (data['weeklyChart'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>(),
        transactions: (data['transactions'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>(),
      ));
    } catch (e) {
      emit(TherapistError(e.toString()));
    }
  }

  // ── Profile ─────────────────────────────────────────────────────────────────
  Future<void> loadProfile() async {
    emit(const TherapistLoading());
    try {
      final profile = await _repository.getPortalProfile();
      emit(TherapistProfileLoaded(profile: profile));
    } catch (e) {
      emit(TherapistError(e.toString()));
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      await _repository.updatePortalProfile(data);
      emit(const TherapistActionSuccess('Profile updated successfully'));
      await loadProfile();
    } catch (e) {
      emit(TherapistError(e.toString()));
    }
  }

  // ── Call Notify ─────────────────────────────────────────────────────────────
  Future<void> notifyCallStart(String appointmentId) async {
    try {
      await _repository.notifyCall(appointmentId);
    } catch (_) {
      // Non-fatal
    }
  }
}
