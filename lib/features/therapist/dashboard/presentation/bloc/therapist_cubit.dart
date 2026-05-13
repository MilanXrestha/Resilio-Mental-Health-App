import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/therapist_repository.dart';
import 'therapist_state.dart';

@injectable
class TherapistCubit extends Cubit<TherapistState> {
  final TherapistRepository _repository;

  TherapistCubit(this._repository) : super(const TherapistState());

  // ── Dashboard ───────────────────────────────────────────────────────────────
  Future<void> loadDashboard() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final data = await _repository.getDashboardStats();
      emit(state.copyWith(isLoading: false, dashboardData: data));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // ── Appointments ────────────────────────────────────────────────────────────
  Future<void> loadAppointments({String filter = 'all'}) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
        activeAppointmentFilter: filter,
      ),
    );
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
      emit(state.copyWith(isLoading: false, appointments: list));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> updateAppointmentStatus(
    String appointmentId,
    String status, {
    String currentFilter = 'all',
  }) async {
    try {
      await _repository.updateAppointmentStatus(appointmentId, status);
      // Reload the list
      await loadAppointments(filter: currentFilter);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  // ── Patients ────────────────────────────────────────────────────────────────
  Future<void> loadPatients() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final list = await _repository.getPatients();
      emit(
        state.copyWith(
          isLoading: false,
          patients: list,
          filteredPatients: list,
          patientQuery: '',
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void filterPatients(String query) {
    if (!state.hasPatients) return;
    final q = query.toLowerCase().trim();
    final filtered = q.isEmpty
        ? state.patients!
        : state.patients!
              .where(
                (p) =>
                    (p['displayName'] as String? ?? '').toLowerCase().contains(
                      q,
                    ) ||
                    (p['email'] as String? ?? '').toLowerCase().contains(q),
              )
              .toList();
    emit(state.copyWith(filteredPatients: filtered, patientQuery: query));
  }

  // ── Earnings ────────────────────────────────────────────────────────────────
  Future<void> loadEarnings() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final data = await _repository.getEarnings();
      emit(state.copyWith(isLoading: false, earningsData: data));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // ── Profile ─────────────────────────────────────────────────────────────────
  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final profile = await _repository.getPortalProfile();
      emit(state.copyWith(isLoading: false, profile: profile));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      await _repository.updatePortalProfile(data);
      emit(state.copyWith(successMessage: 'Profile updated successfully'));
      await loadProfile();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      await _repository.changePassword(currentPassword, newPassword);
      emit(state.copyWith(successMessage: 'Password changed successfully'));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
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
