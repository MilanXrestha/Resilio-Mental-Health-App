import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/features/admin/dashboard/domain/repositories/admin_repository.dart';

enum AdminNotifStatus { initial, loading, success, error }

class AdminNotifState {
  final AdminNotifStatus status;
  final List<dynamic> history;
  final String? error;
  final int? lastSentCount;

  const AdminNotifState({
    this.status = AdminNotifStatus.initial,
    this.history = const [],
    this.error,
    this.lastSentCount,
  });

  AdminNotifState copyWith({
    AdminNotifStatus? status,
    List<dynamic>? history,
    String? error,
    int? lastSentCount,
  }) {
    return AdminNotifState(
      status: status ?? this.status,
      history: history ?? this.history,
      error: error ?? this.error,
      lastSentCount: lastSentCount ?? this.lastSentCount,
    );
  }
}

@injectable
class AdminNotificationCubit extends Cubit<AdminNotifState> {
  final AdminRepository _repository;

  AdminNotificationCubit(this._repository) : super(const AdminNotifState());

  Future<void> loadHistory() async {
    emit(state.copyWith(status: AdminNotifStatus.loading));
    try {
      final history = await _repository.getNotificationHistory();
      emit(state.copyWith(status: AdminNotifStatus.initial, history: history));
    } catch (e) {
      emit(state.copyWith(status: AdminNotifStatus.error, error: e.toString()));
    }
  }

  Future<bool> broadcast({
    required String title,
    required String body,
    String targetRole = 'all',
    String? actionType,
  }) async {
    emit(state.copyWith(status: AdminNotifStatus.loading));
    try {
      final result = await _repository.broadcastNotification(
        title: title,
        body: body,
        targetRole: targetRole,
        actionType: actionType,
      );
      final sent = result['sent'] as int? ?? 0;
      emit(state.copyWith(status: AdminNotifStatus.success, lastSentCount: sent));
      await loadHistory();
      return true;
    } catch (e) {
      emit(state.copyWith(status: AdminNotifStatus.error, error: e.toString()));
      return false;
    }
  }

  void reset() => emit(state.copyWith(status: AdminNotifStatus.initial));
}
