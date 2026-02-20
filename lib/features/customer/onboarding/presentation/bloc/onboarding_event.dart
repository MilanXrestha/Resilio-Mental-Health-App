import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load onboarding pages
class LoadOnboardingPages extends OnboardingEvent {
  const LoadOnboardingPages();
}

/// Event to complete onboarding
class CompleteOnboarding extends OnboardingEvent {
  const CompleteOnboarding();
}

/// Event to skip onboarding
class SkipOnboarding extends OnboardingEvent {
  const SkipOnboarding();
}
