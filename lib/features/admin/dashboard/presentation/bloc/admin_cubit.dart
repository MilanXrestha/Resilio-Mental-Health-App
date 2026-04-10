import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/features/admin/dashboard/domain/repositories/admin_repository.dart';
import 'admin_state.dart';

@injectable
class AdminCubit extends Cubit<AdminState> {
  final AdminRepository _repository;

  AdminCubit(this._repository) : super(const AdminState.initial());

  Future<void> loadDashboard() async {
    emit(const AdminState.loading());
    try {
      final stats = await _repository.getDashboardStats();
      final users = await _repository.getUsers();
      final pending = await _repository.getTherapists(verified: false);
      final approved = await _repository.getTherapists(verified: true);
      
      emit(AdminState.loaded(
        stats: stats,
        users: users,
        pendingTherapists: pending,
        approvedTherapists: approved,
      ));
    } catch (e) {
      emit(AdminState.error(e.toString()));
    }
  }

  Future<void> verifyTherapist(String therapistId, {required bool approve}) async {
    if (state.maybeMap(loaded: (_) => false, orElse: () => true)) return;
    
    try {
      await _repository.verifyTherapist(therapistId, approve: approve);
      
      // Reload everything to get the latest DB state
      await loadDashboard(); 
    } catch (e) {
      // Just reload on error too for safety, or report issue
      await loadDashboard(); 
    }
  }
}
