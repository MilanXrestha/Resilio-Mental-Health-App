import 'package:Resilio/core/proto_generated/subscription.pb.dart' as pb;
import 'package:Resilio/features/customer/subscription/domain/entities/subscription_entity.dart';

class SubscriptionModel extends SubscriptionEntity {
  const SubscriptionModel({
    required super.id,
    required super.userId,
    required super.planId,
    required super.status,
    required super.startDate,
    super.endDate,
    required super.paymentMethod,
    required super.lastTransactionId,
    required super.isAutoRenew,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SubscriptionModel.fromProto(pb.Subscription proto) {
    return SubscriptionModel(
      id: proto.id,
      userId: proto.userId,
      planId: proto.planId,
      status: proto.status,
      startDate: DateTime.tryParse(proto.startDate) ?? DateTime.now(),
      endDate: proto.endDate.isNotEmpty ? DateTime.tryParse(proto.endDate) : null,
      paymentMethod: proto.paymentMethod,
      lastTransactionId: proto.lastTransactionId,
      isAutoRenew: proto.isAutoRenew,
      createdAt: DateTime.tryParse(proto.createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(proto.updatedAt) ?? DateTime.now(),
    );
  }

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      planId: json['plan_id'] ?? '',
      status: json['status'] ?? '',
      startDate: DateTime.tryParse(json['start_date'] ?? '') ?? DateTime.now(),
      endDate: json['end_date'] != null ? DateTime.tryParse(json['end_date']) : null,
      paymentMethod: json['payment_method'] ?? '',
      lastTransactionId: json['last_transaction_id'] ?? '',
      isAutoRenew: json['is_auto_renew'] ?? false,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }
}
