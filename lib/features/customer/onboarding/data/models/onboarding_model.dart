import '../../domain/entities/onboarding_entity.dart';

/// Data model for onboarding page content.
class OnboardingModel {
  final String lottieAsset;
  final String title;
  final String description;

  const OnboardingModel({
    required this.lottieAsset,
    required this.title,
    required this.description,
  });

  OnboardingEntity toEntity() => OnboardingEntity(
        lottieAsset: lottieAsset,
        title: title,
        description: description,
      );
}
