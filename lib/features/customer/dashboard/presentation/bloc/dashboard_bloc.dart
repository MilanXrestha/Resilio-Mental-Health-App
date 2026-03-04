import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/auth_token_service.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/usecases/get_dashboard_user_profile_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardUserProfileUseCase _getUserProfileUseCase;
  final AuthTokenService _authTokenService;

  DashboardBloc(
      this._getUserProfileUseCase,
      this._authTokenService,
      ) : super(DashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<RefreshDashboard>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
      LoadDashboard event,
      Emitter<DashboardState> emit,
      ) async {
    emit(DashboardLoading());

    // Check if user is authenticated using AuthTokenService
    if (!_authTokenService.isAuthenticated) {
      emit(const DashboardError('User not authenticated'));
      return;
    }

    final result = await _getUserProfileUseCase();

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
    final currentState = state;
    if (currentState is DashboardLoaded) {
      emit(DashboardLoading());
    }

    // Check if user is authenticated
    if (!_authTokenService.isAuthenticated) {
      emit(const DashboardError('User not authenticated'));
      return;
    }

    final result = await _getUserProfileUseCase();

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