import 'package:Resilio/core/proto_generated/subscription.pb.dart' as pb;
import 'package:Resilio/features/customer/subscription/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.userId,
    required super.subscriptionId,
    required super.paymentProvider,
    required super.paymentProviderTransactionId,
    required super.amount,
    required super.currency,
    required super.status,
    required super.planId,
    required super.createdAt,
  });

  factory TransactionModel.fromProto(pb.Transaction proto) {
    return TransactionModel(
      id: proto.id,
      userId: proto.userId,
      subscriptionId: proto.subscriptionId,
      paymentProvider: proto.paymentProvider,
      paymentProviderTransactionId: proto.paymentProviderTransactionId,
      amount: proto.amount,
      currency: proto.currency,
      status: proto.status,
      planId: proto.planId,
      createdAt: DateTime.tryParse(proto.createdAt) ?? DateTime.now(),
    );
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      subscriptionId: json['subscription_id'] ?? '',
      paymentProvider: json['payment_provider'] ?? '',
      paymentProviderTransactionId: json['payment_provider_transaction_id'] ?? '',
      amount: (json['amount'] is String) 
          ? double.tryParse(json['amount']) ?? 0.0 
          : (json['amount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] ?? '',
      status: json['status'] ?? '',
      planId: json['plan_id'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }
}
