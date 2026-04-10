import 'package:equatable/equatable.dart';

class SubscriptionEntity extends Equatable {
  final String id;
  final String userId;
  final String planId; // 'GOLD', 'PLATINUM', 'DIAMOND'
  final String status; // 'active', 'cancelled', 'expired'
  final DateTime startDate;
  final DateTime? endDate;
  final String paymentMethod;
  final String lastTransactionId;
  final bool isAutoRenew;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SubscriptionEntity({
    required this.id,
    required this.userId,
    required this.planId,
    required this.status,
    required this.startDate,
    this.endDate,
    required this.paymentMethod,
    required this.lastTransactionId,
    required this.isAutoRenew,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isActive => status == 'active' && (endDate == null || endDate!.isAfter(DateTime.now()));

  @override
  List<Object?> get props => [
        id,
        userId,
        planId,
        status,
        startDate,
        endDate,
        paymentMethod,
        lastTransactionId,
        isAutoRenew,
        createdAt,
        updatedAt,
      ];
}
