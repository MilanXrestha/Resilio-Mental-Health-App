import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/features/admin/dashboard/domain/repositories/admin_repository.dart';

enum AdminPrefStatus { initial, loading, loaded, error }

class AdminPrefState {
  final AdminPrefStatus status;
  final List<dynamic> categories;
  final bool isCreating;
  final bool isUpdating;
  final bool isDeleting;
  final String? error;

  const AdminPrefState({
    this.status = AdminPrefStatus.initial,
    this.categories = const [],
    this.isCreating = false,
    this.isUpdating = false,
    this.isDeleting = false,
    this.error,
  });

  AdminPrefState copyWith({
    AdminPrefStatus? status,
    List<dynamic>? categories,
    bool? isCreating,
    bool? isUpdating,
    bool? isDeleting,
    String? error,
  }) {
    return AdminPrefState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      isCreating: isCreating ?? this.isCreating,
      isUpdating: isUpdating ?? this.isUpdating,
      isDeleting: isDeleting ?? this.isDeleting,
      error: error ?? this.error,
    );
  }
}

@injectable
class AdminPreferenceCubit extends Cubit<AdminPrefState> {
  final AdminRepository _repository;

  AdminPreferenceCubit(this._repository) : super(const AdminPrefState());

  Future<void> loadPreferences() async {
    emit(state.copyWith(status: AdminPrefStatus.loading));
    try {
      final categories = await _repository.getPreferences();
      emit(state.copyWith(status: AdminPrefStatus.loaded, categories: categories));
    } catch (e) {
      emit(state.copyWith(status: AdminPrefStatus.error, error: e.toString()));
    }
  }

  Future<bool> createPreference(Map<String, dynamic> data) async {
    emit(state.copyWith(isCreating: true));
    try {
      await _repository.createPreference(data);
      await loadPreferences();
      return true;
    } catch (e) {
      emit(state.copyWith(status: AdminPrefStatus.error, error: e.toString()));
      return false;
    } finally {
      emit(state.copyWith(isCreating: false));
    }
  }

  Future<bool> updatePreference(String id, Map<String, dynamic> data) async {
    emit(state.copyWith(isUpdating: true));
    try {
      await _repository.updatePreference(id, data);
      await loadPreferences();
      return true;
    } catch (e) {
      emit(state.copyWith(status: AdminPrefStatus.error, error: e.toString()));
      return false;
    } finally {
      emit(state.copyWith(isUpdating: false));
    }
  }

  Future<bool> deletePreference(String id) async {
    emit(state.copyWith(isDeleting: true));
    try {
      await _repository.deletePreference(id);
      await loadPreferences();
      return true;
    } catch (e) {
      emit(state.copyWith(status: AdminPrefStatus.error, error: e.toString()));
      return false;
    } finally {
      emit(state.copyWith(isDeleting: false));
    }
  }
}
