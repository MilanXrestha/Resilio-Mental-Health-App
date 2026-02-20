import 'package:equatable/equatable.dart';
import '../../domain/entities/onboarding_entity.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

/// Loading state
class OnboardingLoading extends OnboardingState {
  const OnboardingLoading();
}

/// Loaded state with pages
class OnboardingLoaded extends OnboardingState {
  final List<OnboardingEntity> pages;

  const OnboardingLoaded({required this.pages});

  @override
  List<Object?> get props => [pages];
}

/// Error state
class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Onboarding completed state
class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}
