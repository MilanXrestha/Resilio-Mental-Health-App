import 'package:equatable/equatable.dart';

/// Preference Entity
/// Represents a content preference category that users can select
class PreferenceEntity extends Equatable {
  final String id;
  final String preferenceId;
  final String preferenceName;
  final String preferenceDescription;
  final String preferenceIcon;
  final bool isSvg;
  final int sortOrder;
  final bool isActive;

  const PreferenceEntity({
    required this.id,
    required this.preferenceId,
    required this.preferenceName,
    required this.preferenceDescription,
    required this.preferenceIcon,
    this.isSvg = false,
    this.sortOrder = 0,
    this.isActive = true,
  });

  bool get isNetworkIcon => preferenceIcon.startsWith('http');

  @override
  List<Object?> get props => [
        id,
        preferenceId,
        preferenceName,
        preferenceDescription,
        preferenceIcon,
        isSvg,
        sortOrder,
        isActive,
      ];

  PreferenceEntity copyWith({
    String? id,
    String? preferenceId,
    String? preferenceName,
    String? preferenceDescription,
    String? preferenceIcon,
    bool? isSvg,
    int? sortOrder,
    bool? isActive,
  }) {
    return PreferenceEntity(
      id: id ?? this.id,
      preferenceId: preferenceId ?? this.preferenceId,
      preferenceName: preferenceName ?? this.preferenceName,
      preferenceDescription: preferenceDescription ?? this.preferenceDescription,
      preferenceIcon: preferenceIcon ?? this.preferenceIcon,
      isSvg: isSvg ?? this.isSvg,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
    );
  }
}
