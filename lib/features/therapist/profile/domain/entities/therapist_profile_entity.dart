class TherapistProfileEntity {
  final String id;
  final String displayName;
  final String email;
  final String? profilePictureUrl;
  final String bio;
  final String specialty;
  final List<String> qualifications;
  final bool isVerified;
  final double hourlyRate;
  final int yearsExperience;
  final double rating;
  final int reviewCount;
  final Map<String, dynamic> availabilityJson;

  const TherapistProfileEntity({
    required this.id,
    required this.displayName,
    required this.email,
    this.profilePictureUrl,
    required this.bio,
    required this.specialty,
    required this.qualifications,
    required this.isVerified,
    required this.hourlyRate,
    required this.yearsExperience,
    required this.rating,
    required this.reviewCount,
    required this.availabilityJson,
  });

  factory TherapistProfileEntity.fromMap(Map<String, dynamic> map) {
    return TherapistProfileEntity(
      id: map['id'] as String? ?? '',
      displayName: map['displayName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      profilePictureUrl: map['profilePictureUrl'] as String?,
      bio: map['bio'] as String? ?? '',
      specialty: map['specialty'] as String? ?? '',
      qualifications: (map['qualifications'] as List<dynamic>? ?? []).cast<String>(),
      isVerified: map['isVerified'] as bool? ?? false,
      hourlyRate: (map['hourlyRate'] as num?)?.toDouble() ?? 0.0,
      yearsExperience: (map['yearsExperience'] as num?)?.toInt() ?? 0,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (map['reviewCount'] as num?)?.toInt() ?? 0,
      availabilityJson: map['availabilityJson'] as Map<String, dynamic>? ?? {},
    );
  }
}
