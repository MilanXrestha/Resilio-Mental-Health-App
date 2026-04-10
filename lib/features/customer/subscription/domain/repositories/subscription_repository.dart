import 'package:dartz/dartz.dart';
import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/features/customer/subscription/domain/entities/subscription_entity.dart';
import 'package:Resilio/features/customer/subscription/domain/entities/transaction_entity.dart';

abstract class SubscriptionRepository {
  Future<Either<Failure, SubscriptionEntity>> getSubscription();
  Future<Either<Failure, SubscriptionEntity>> updateSubscription({
    required String planId,
    required String status,
    required String paymentProvider,
    required String paymentProviderTransactionId,
    required double amount,
    required String currency,
  });
  Future<Either<Failure, List<TransactionEntity>>> getTransactions();
}
