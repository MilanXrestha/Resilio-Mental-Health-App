import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user_profile_entity.dart';
import '../../domain/usecases/get_dashboard_user_profile_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardUserProfileUseCase _getUserProfileUseCase;

  DashboardBloc(this._getUserProfileUseCase) : super(DashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<RefreshDashboard>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    // Get Firebase ID token for authentication
    String idToken = '';
    try {
      idToken = await FirebaseAuth.instance.currentUser?.getIdToken() ?? '';
    } catch (e) {
      emit(DashboardError('Failed to get authentication token'));
      return;
    }

    if (idToken.isEmpty) {
      emit(DashboardError('User not authenticated'));
      return;
    }

    final result = await _getUserProfileUseCase(event.userId, idToken);

    result.fold(
      (failure) => emit(DashboardError(failure.message)),
      (userProfile) {
        final greeting = _getGreeting();
        emit(DashboardLoaded(
          userProfile: userProfile,
          greeting: greeting,
        ));
      },
    );
  }

  Future<void> _onRefreshDashboard(
    RefreshDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    // Emit loading state but keep existing data visible
    final currentState = state;
    if (currentState is DashboardLoaded) {
      emit(DashboardLoading());
    }

    // Get Firebase ID token for authentication
    String idToken = '';
    try {
      idToken = await FirebaseAuth.instance.currentUser?.getIdToken() ?? '';
    } catch (e) {
      emit(DashboardError('Failed to get authentication token'));
      return;
    }

    if (idToken.isEmpty) {
      emit(DashboardError('User not authenticated'));
      return;
    }

    final result = await _getUserProfileUseCase(event.userId, idToken);

    result.fold(
      (failure) => emit(DashboardError(failure.message)),
      (userProfile) {
        final greeting = _getGreeting();
        emit(DashboardLoaded(
          userProfile: userProfile,
          greeting: greeting,
        ));
      },
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}
