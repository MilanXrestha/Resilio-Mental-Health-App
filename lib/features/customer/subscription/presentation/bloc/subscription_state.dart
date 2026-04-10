import 'package:equatable/equatable.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/entities/transaction_entity.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final SubscriptionEntity subscription;
  final List<TransactionEntity> transactions;

  const SubscriptionLoaded({
    required this.subscription,
    this.transactions = const [],
  });

  SubscriptionLoaded copyWith({
    SubscriptionEntity? subscription,
    List<TransactionEntity>? transactions,
  }) {
    return SubscriptionLoaded(
      subscription: subscription ?? this.subscription,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [subscription, transactions];
}

class SubscriptionError extends SubscriptionState {
  final String message;

  const SubscriptionError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Separate state for purchase process UI handling
class SubscriptionPurchaseLoading extends SubscriptionState {}

class SubscriptionPurchaseSuccess extends SubscriptionState {
  final SubscriptionEntity subscription;

  const SubscriptionPurchaseSuccess({required this.subscription});

  @override
  List<Object?> get props => [subscription];
}

class SubscriptionPurchaseFailure extends SubscriptionState {
  final String message;

  const SubscriptionPurchaseFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
