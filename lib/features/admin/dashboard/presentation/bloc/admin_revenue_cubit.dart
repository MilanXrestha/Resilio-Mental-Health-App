import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/features/admin/dashboard/domain/repositories/admin_repository.dart';

// ─── State ───────────────────────────────────────────
enum AdminRevenueStatus { initial, loading, loaded, error }

class AdminRevenueState {
  final AdminRevenueStatus status;
  final Map<String, dynamic> revenueStats;
  final List<dynamic> subscriptions;
  final int totalSubscriptions;
  final List<dynamic> therapistPayments;
  final int totalPayments;
  final String subscriptionFilter;
  final String? error;

  const AdminRevenueState({
    this.status = AdminRevenueStatus.initial,
    this.revenueStats = const {},
    this.subscriptions = const [],
    this.totalSubscriptions = 0,
    this.therapistPayments = const [],
    this.totalPayments = 0,
    this.subscriptionFilter = 'all',
    this.error,
  });

  AdminRevenueState copyWith({
    AdminRevenueStatus? status,
    Map<String, dynamic>? revenueStats,
    List<dynamic>? subscriptions,
    int? totalSubscriptions,
    List<dynamic>? therapistPayments,
    int? totalPayments,
    String? subscriptionFilter,
    String? error,
  }) {
    return AdminRevenueState(
      status: status ?? this.status,
      revenueStats: revenueStats ?? this.revenueStats,
      subscriptions: subscriptions ?? this.subscriptions,
      totalSubscriptions: totalSubscriptions ?? this.totalSubscriptions,
      therapistPayments: therapistPayments ?? this.therapistPayments,
      totalPayments: totalPayments ?? this.totalPayments,
      subscriptionFilter: subscriptionFilter ?? this.subscriptionFilter,
      error: error ?? this.error,
    );
  }
}

// ─── Cubit ───────────────────────────────────────────
@injectable
class AdminRevenueCubit extends Cubit<AdminRevenueState> {
  final AdminRepository _repository;

  AdminRevenueCubit(this._repository) : super(const AdminRevenueState());

  Future<void> loadAll() async {
    emit(state.copyWith(status: AdminRevenueStatus.loading));
    try {
      final stats = await _repository.getRevenueStats();
      emit(state.copyWith(status: AdminRevenueStatus.loaded, revenueStats: stats));
    } catch (e) {
      emit(state.copyWith(status: AdminRevenueStatus.error, error: e.toString()));
    }
  }

  Future<void> loadSubscriptions({String status = 'all'}) async {
    try {
      final result = await _repository.getSubscriptions(status: status);
      emit(state.copyWith(
        subscriptions: result['subscriptions'] as List<dynamic>? ?? [],
        totalSubscriptions: result['total'] as int? ?? 0,
        subscriptionFilter: status,
      ));
    } catch (e) {
      emit(state.copyWith(status: AdminRevenueStatus.error, error: e.toString()));
    }
  }

  Future<void> loadTherapistPayments() async {
    try {
      final result = await _repository.getTherapistPayments();
      emit(state.copyWith(
        therapistPayments: result['payments'] as List<dynamic>? ?? [],
        totalPayments: result['total'] as int? ?? 0,
      ));
    } catch (e) {
      emit(state.copyWith(status: AdminRevenueStatus.error, error: e.toString()));
    }
  }
}
