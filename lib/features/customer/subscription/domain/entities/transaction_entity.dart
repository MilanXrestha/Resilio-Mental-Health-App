import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String userId;
  final String subscriptionId;
  final String paymentProvider;
  final String paymentProviderTransactionId;
  final double amount;
  final String currency;
  final String status;
  final String planId;
  final DateTime createdAt;

  const TransactionEntity({
    required this.id,
    required this.userId,
    required this.subscriptionId,
    required this.paymentProvider,
    required this.paymentProviderTransactionId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.planId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        subscriptionId,
        paymentProvider,
        paymentProviderTransactionId,
        amount,
        currency,
        status,
        planId,
        createdAt,
      ];
}
