import 'package:equatable/equatable.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object?> get props => [];
}

class LoadSubscription extends SubscriptionEvent {}

class PurchaseSubscription extends SubscriptionEvent {
  final String planId;
  final String status;
  final String paymentProvider;
  final String paymentProviderTransactionId;
  final double amount;
  final String currency;

  const PurchaseSubscription({
    required this.planId,
    required this.status,
    required this.paymentProvider,
    required this.paymentProviderTransactionId,
    required this.amount,
    required this.currency,
  });

  @override
  List<Object?> get props => [
        planId,
        status,
        paymentProvider,
        paymentProviderTransactionId,
        amount,
        currency,
      ];
}

class LoadTransactions extends SubscriptionEvent {}
