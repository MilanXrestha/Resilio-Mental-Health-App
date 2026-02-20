import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../domain/usecases/complete_onboarding_usecase.dart';
import '../../domain/usecases/get_onboarding_pages_usecase.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetOnboardingPagesUseCase _getOnboardingPagesUseCase;
  final CompleteOnboardingUseCase _completeOnboardingUseCase;

  OnboardingBloc(
    this._getOnboardingPagesUseCase,
    this._completeOnboardingUseCase,
  ) : super(const OnboardingInitial()) {
    on<LoadOnboardingPages>(_onLoadOnboardingPages);
    on<CompleteOnboarding>(_onCompleteOnboarding);
    on<SkipOnboarding>(_onSkipOnboarding);
  }

  Future<void> _onLoadOnboardingPages(
    LoadOnboardingPages event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const OnboardingLoading());
    final result = await _getOnboardingPagesUseCase(NoParams());
    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (pages) => emit(OnboardingLoaded(pages: pages)),
    );
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    final result = await _completeOnboardingUseCase(NoParams());
    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (_) => emit(const OnboardingCompleted()),
    );
  }

  Future<void> _onSkipOnboarding(
    SkipOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    final result = await _completeOnboardingUseCase(NoParams());
    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (_) => emit(const OnboardingCompleted()),
    );
  }
}
