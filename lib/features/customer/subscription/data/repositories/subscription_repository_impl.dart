import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/core/errors/exceptions.dart';
import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/core/network/network_info.dart';
import 'package:Resilio/features/customer/subscription/data/datasources/subscription_remote_data_source.dart';
import 'package:Resilio/features/customer/subscription/domain/entities/subscription_entity.dart';
import 'package:Resilio/features/customer/subscription/domain/entities/transaction_entity.dart';
import 'package:Resilio/features/customer/subscription/domain/repositories/subscription_repository.dart';

@LazySingleton(as: SubscriptionRepository)
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  SubscriptionRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, SubscriptionEntity>> getSubscription() async {
    if (await _networkInfo.isConnected) {
      try {
        final subscription = await _remoteDataSource.getSubscription();
        return Right(subscription);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, SubscriptionEntity>> updateSubscription({
    required String planId,
    required String status,
    required String paymentProvider,
    required String paymentProviderTransactionId,
    required double amount,
    required String currency,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final subscription = await _remoteDataSource.updateSubscription(
          planId: planId,
          status: status,
          paymentProvider: paymentProvider,
          paymentProviderTransactionId: paymentProviderTransactionId,
          amount: amount,
          currency: currency,
        );
        return Right(subscription);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactions() async {
    if (await _networkInfo.isConnected) {
      try {
        final transactions = await _remoteDataSource.getTransactions();
        return Right(transactions);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
