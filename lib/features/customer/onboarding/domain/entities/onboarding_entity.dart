import 'package:equatable/equatable.dart';

/// Entity representing a single onboarding page content.
class OnboardingEntity extends Equatable {
  final String lottieAsset;
  final String title;
  final String description;

  const OnboardingEntity({
    required this.lottieAsset,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [lottieAsset, title, description];
}
