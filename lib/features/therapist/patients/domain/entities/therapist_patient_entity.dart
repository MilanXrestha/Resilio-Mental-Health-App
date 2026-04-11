class TherapistPatientEntity {
  final String id;
  final String displayName;
  final String email;
  final String? profilePictureUrl;
  final int sessionCount;
  final DateTime? lastSessionDate;

  const TherapistPatientEntity({
    required this.id,
    required this.displayName,
    required this.email,
    this.profilePictureUrl,
    required this.sessionCount,
    this.lastSessionDate,
  });

  factory TherapistPatientEntity.fromMap(Map<String, dynamic> map) {
    return TherapistPatientEntity(
      id: map['id'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      profilePictureUrl: map['profilePictureUrl'] as String?,
      sessionCount: (map['sessionCount'] as num?)?.toInt() ?? 0,
      lastSessionDate: map['lastSessionDate'] != null
          ? DateTime.tryParse(map['lastSessionDate'] as String)
          : null,
    );
  }
}
