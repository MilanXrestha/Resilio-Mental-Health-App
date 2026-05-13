import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/features/admin/dashboard/domain/repositories/admin_repository.dart';
import 'admin_state.dart';

@injectable
class AdminCubit extends Cubit<AdminState> {
  final AdminRepository _repository;

  AdminCubit(this._repository) : super(const AdminState.initial());

  AdminState _createLoadedState({
    Map<String, dynamic>? stats,
    List<dynamic>? therapists,
    int? totalTherapists,
    String? therapistFilter,
    String? therapistSearch,
    List<dynamic>? users,
    int? totalUsers,
    String? userRoleFilter,
    String? userSearch,
    List<dynamic>? appointments,
    int? totalAppointments,
    String? appointmentFilter,
    List<dynamic>? content,
    int? totalContent,
    String? contentFilter,
    bool? isVerifyingTherapist,
    bool? isDeletingTherapist,
    bool? isUpdatingUser,
    bool? isDeletingContent,
  }) {
    return state.maybeMap(
      loaded: (s) => s.copyWith(
        stats: stats ?? s.stats,
        therapists: therapists ?? s.therapists,
        totalTherapists: totalTherapists ?? s.totalTherapists,
        therapistFilter: therapistFilter ?? s.therapistFilter,
        therapistSearch: therapistSearch ?? s.therapistSearch,
        users: users ?? s.users,
        totalUsers: totalUsers ?? s.totalUsers,
        userRoleFilter: userRoleFilter ?? s.userRoleFilter,
        userSearch: userSearch ?? s.userSearch,
        appointments: appointments ?? s.appointments,
        totalAppointments: totalAppointments ?? s.totalAppointments,
        appointmentFilter: appointmentFilter ?? s.appointmentFilter,
        content: content ?? s.content,
        totalContent: totalContent ?? s.totalContent,
        contentFilter: contentFilter ?? s.contentFilter,
        isVerifyingTherapist: isVerifyingTherapist ?? s.isVerifyingTherapist,
        isDeletingTherapist: isDeletingTherapist ?? s.isDeletingTherapist,
        isUpdatingUser: isUpdatingUser ?? s.isUpdatingUser,
        isDeletingContent: isDeletingContent ?? s.isDeletingContent,
      ),
      orElse: () => AdminState.loaded(
        stats: stats ?? {},
        therapists: therapists ?? [],
        totalTherapists: totalTherapists ?? 0,
        therapistFilter: therapistFilter ?? 'all',
        therapistSearch: therapistSearch ?? '',
        users: users ?? [],
        totalUsers: totalUsers ?? 0,
        userRoleFilter: userRoleFilter ?? 'all',
        userSearch: userSearch ?? '',
        appointments: appointments ?? [],
        totalAppointments: totalAppointments ?? 0,
        appointmentFilter: appointmentFilter ?? 'all',
        content: content ?? [],
        totalContent: totalContent ?? 0,
        contentFilter: contentFilter ?? 'all',
        isVerifyingTherapist: isVerifyingTherapist ?? false,
        isDeletingTherapist: isDeletingTherapist ?? false,
        isUpdatingUser: isUpdatingUser ?? false,
        isDeletingContent: isDeletingContent ?? false,
      ),
    );
  }

  Future<void> loadDashboard() async {
    try {
      final stats = await _repository.getDashboardStats();
      emit(_createLoadedState(stats: stats));
    } catch (e) {
      emit(AdminState.error(e.toString()));
    }
  }

  Future<void> loadTherapists({
    String verified = 'all',
    String search = '',
  }) async {
    try {
      final result = await _repository.getTherapists(
        verified: verified,
        search: search,
      );
      final therapists = result['therapists'] as List<dynamic>? ?? [];
      final total = result['total'] as int? ?? 0;

      emit(
        _createLoadedState(
          therapists: therapists,
          totalTherapists: total,
          therapistFilter: verified,
          therapistSearch: search,
        ),
      );
    } catch (e) {
      emit(AdminState.error(e.toString()));
    }
  }

  Future<void> verifyTherapist(
    String therapistId, {
    required bool isVerified,
    String? rejectionReason,
  }) async {
    emit(_createLoadedState(isVerifyingTherapist: true));
    try {
      await _repository.verifyTherapist(
        therapistId,
        isVerified: isVerified,
        rejectionReason: rejectionReason,
      );
      await loadTherapists();
      await loadDashboard();
    } catch (e) {
      emit(AdminState.error(e.toString()));
    } finally {
      emit(_createLoadedState(isVerifyingTherapist: false));
    }
  }

  Future<void> deleteTherapist(String therapistId) async {
    emit(_createLoadedState(isDeletingTherapist: true));
    try {
      await _repository.deleteTherapist(therapistId);
      await loadTherapists();
      await loadDashboard();
    } catch (e) {
      emit(AdminState.error(e.toString()));
    } finally {
      emit(_createLoadedState(isDeletingTherapist: false));
    }
  }

  Future<void> loadUsers({String role = 'all', String search = ''}) async {
    try {
      final result = await _repository.getUsers(role: role, search: search);
      final users = result['users'] as List<dynamic>? ?? [];
      final total = result['total'] as int? ?? 0;

      emit(
        _createLoadedState(
          users: users,
          totalUsers: total,
          userRoleFilter: role,
          userSearch: search,
        ),
      );
    } catch (e) {
      emit(AdminState.error(e.toString()));
    }
  }

  Future<void> updateUserRole(String userId, {required String userRole}) async {
    emit(_createLoadedState(isUpdatingUser: true));
    try {
      await _repository.updateUserRole(userId, userRole: userRole);
      await loadUsers();
      await loadDashboard();
    } catch (e) {
      emit(AdminState.error(e.toString()));
    } finally {
      emit(_createLoadedState(isUpdatingUser: false));
    }
  }

  Future<void> updateUserStatus(String userId, {required bool isActive}) async {
    emit(_createLoadedState(isUpdatingUser: true));
    try {
      await _repository.updateUserStatus(userId, isActive: isActive);
      await loadUsers();
    } catch (e) {
      emit(AdminState.error(e.toString()));
    } finally {
      emit(_createLoadedState(isUpdatingUser: false));
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _repository.deleteUser(userId);
      await loadUsers();
      await loadDashboard();
    } catch (e) {
      emit(AdminState.error(e.toString()));
    }
  }

  Future<void> loadAppointments({String status = 'all'}) async {
    try {
      final result = await _repository.getAppointments(status: status);
      final appointments = result['appointments'] as List<dynamic>? ?? [];
      final total = result['total'] as int? ?? 0;

      emit(
        _createLoadedState(
          appointments: appointments,
          totalAppointments: total,
          appointmentFilter: status,
        ),
      );
    } catch (e) {
      emit(AdminState.error(e.toString()));
    }
  }

  Future<void> loadContent({String type = 'all'}) async {
    try {
      final result = await _repository.getContent(type: type);
      final content = result['content'] as List<dynamic>? ?? [];
      final total = result['total'] as int? ?? 0;

      emit(
        _createLoadedState(
          content: content,
          totalContent: total,
          contentFilter: type,
        ),
      );
    } catch (e) {
      emit(AdminState.error(e.toString()));
    }
  }

  Future<void> deleteContent(String type, String contentId) async {
    emit(_createLoadedState(isDeletingContent: true));
    try {
      await _repository.deleteContent(type, contentId);
      await loadContent();
    } catch (e) {
      emit(AdminState.error(e.toString()));
    } finally {
      emit(_createLoadedState(isDeletingContent: false));
    }
  }

  void clearTherapistSearch() {
    emit(_createLoadedState(therapistSearch: ''));
    loadTherapists(search: '');
  }

  void clearUserSearch() {
    emit(_createLoadedState(userSearch: ''));
    loadUsers(search: '');
  }
}
