class TherapistAppointmentEntity {
  final String id;
  final String patientId;
  final String patientName;
  final String patientEmail;
  final String patientProfilePicUrl;
  final String therapistId;
  final DateTime scheduledTime;
  final String status;
  final String paymentStatus;
  final String? paymentTransactionId;
  final String? meetingRoomId;
  final double price;
  final String notes;
  final DateTime createdAt;

  const TherapistAppointmentEntity({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.patientEmail,
    required this.patientProfilePicUrl,
    required this.therapistId,
    required this.scheduledTime,
    required this.status,
    required this.paymentStatus,
    this.paymentTransactionId,
    this.meetingRoomId,
    required this.price,
    required this.notes,
    required this.createdAt,
  });

  factory TherapistAppointmentEntity.fromMap(Map<String, dynamic> map) {
    return TherapistAppointmentEntity(
      id: map['id'] as String? ?? '',
      patientId: map['patientId'] as String? ?? '',
      patientName: map['patientName'] as String? ?? '',
      patientEmail: map['patientEmail'] as String? ?? '',
      patientProfilePicUrl: map['patientProfilePicUrl'] as String? ?? '',
      therapistId: map['therapistId'] as String? ?? '',
      scheduledTime: DateTime.tryParse(map['scheduledTime'] as String? ?? '') ?? DateTime.now(),
      status: map['status'] as String? ?? 'pending',
      paymentStatus: map['paymentStatus'] as String? ?? '',
      paymentTransactionId: map['paymentTransactionId'] as String?,
      meetingRoomId: map['meetingRoomId'] as String?,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      notes: map['notes'] as String? ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  TherapistAppointmentEntity copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? patientEmail,
    String? patientProfilePicUrl,
    String? therapistId,
    DateTime? scheduledTime,
    String? status,
    String? paymentStatus,
    String? paymentTransactionId,
    String? meetingRoomId,
    double? price,
    String? notes,
    DateTime? createdAt,
  }) {
    return TherapistAppointmentEntity(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      patientEmail: patientEmail ?? this.patientEmail,
      patientProfilePicUrl: patientProfilePicUrl ?? this.patientProfilePicUrl,
      therapistId: therapistId ?? this.therapistId,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentTransactionId: paymentTransactionId ?? this.paymentTransactionId,
      meetingRoomId: meetingRoomId ?? this.meetingRoomId,
      price: price ?? this.price,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
