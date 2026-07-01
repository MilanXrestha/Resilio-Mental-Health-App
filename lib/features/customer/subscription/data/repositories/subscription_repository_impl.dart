import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/core/database/database_helper.dart';
import 'package:Resilio/core/di/injection.dart';
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

  SubscriptionRepositoryImpl(this._remoteDataSource, this._networkInfo);

  // Offline cache keys (sqflite `cache` table via DatabaseHelper).
  static const _kSubscription = 'sub_current';
  static const _kTransactions = 'sub_transactions';

  DatabaseHelper get _db => getIt<DatabaseHelper>();

  @override
  Future<Either<Failure, SubscriptionEntity>> getSubscription() async {
    if (await _networkInfo.isConnected) {
      try {
        final subscription = await _remoteDataSource.getSubscription();
        await _cacheSubscription(subscription);
        return Right(subscription);
      } on ServerException catch (e) {
        // Server says no active subscription → drop stale cache so an expired
        // user is never served a cached "active" state.
        await _db.removeFromCache(_kSubscription);
        return Left(ServerFailure(e.message));
      } catch (e) {
        // Network hiccup — fall back to cache if present. isActive is
        // re-evaluated against endDate on read, so an expired plan stays locked.
        final cached = await _readCachedSubscription();
        if (cached != null) return Right(cached);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      final cached = await _readCachedSubscription();
      if (cached != null) return Right(cached);
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
        await _cacheSubscription(subscription);
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
        await _cacheTransactions(transactions);
        return Right(transactions);
      } on ServerException catch (e) {
        final cached = await _readCachedTransactions();
        if (cached != null) return Right(cached);
        return Left(ServerFailure(e.message));
      } catch (e) {
        final cached = await _readCachedTransactions();
        if (cached != null) return Right(cached);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      final cached = await _readCachedTransactions();
      if (cached != null) return Right(cached);
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  // ── Cache helpers ──────────────────────────────────────────────────────────

  Future<void> _cacheSubscription(SubscriptionEntity s) async {
    await _db.saveToCache(
      _kSubscription,
      utf8.encode(jsonEncode(_subToJson(s))),
    );
  }

  Future<SubscriptionEntity?> _readCachedSubscription() async {
    try {
      final bytes = await _db.getFromCache(_kSubscription);
      if (bytes == null) return null;
      return _subFromJson(jsonDecode(utf8.decode(bytes)));
    } catch (_) {
      return null;
    }
  }

  Future<void> _cacheTransactions(List<TransactionEntity> txns) async {
    await _db.saveToCache(
      _kTransactions,
      utf8.encode(jsonEncode(txns.map(_txToJson).toList())),
    );
  }

  Future<List<TransactionEntity>?> _readCachedTransactions() async {
    try {
      final bytes = await _db.getFromCache(_kTransactions);
      if (bytes == null) return null;
      final List<dynamic> data = jsonDecode(utf8.decode(bytes));
      return data.map((e) => _txFromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> _subToJson(SubscriptionEntity s) => {
    'id': s.id,
    'userId': s.userId,
    'planId': s.planId,
    'status': s.status,
    'startDate': s.startDate.toIso8601String(),
    'endDate': s.endDate?.toIso8601String(),
    'paymentMethod': s.paymentMethod,
    'lastTransactionId': s.lastTransactionId,
    'isAutoRenew': s.isAutoRenew,
    'createdAt': s.createdAt.toIso8601String(),
    'updatedAt': s.updatedAt.toIso8601String(),
  };

  SubscriptionEntity _subFromJson(Map<String, dynamic> j) => SubscriptionEntity(
    id: j['id'] ?? '',
    userId: j['userId'] ?? '',
    planId: j['planId'] ?? '',
    status: j['status'] ?? '',
    startDate: DateTime.tryParse(j['startDate'] ?? '') ?? DateTime.now(),
    endDate: j['endDate'] != null ? DateTime.tryParse(j['endDate']) : null,
    paymentMethod: j['paymentMethod'] ?? '',
    lastTransactionId: j['lastTransactionId'] ?? '',
    isAutoRenew: j['isAutoRenew'] ?? false,
    createdAt: DateTime.tryParse(j['createdAt'] ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(j['updatedAt'] ?? '') ?? DateTime.now(),
  );

  Map<String, dynamic> _txToJson(TransactionEntity t) => {
    'id': t.id,
    'userId': t.userId,
    'subscriptionId': t.subscriptionId,
    'paymentProvider': t.paymentProvider,
    'paymentProviderTransactionId': t.paymentProviderTransactionId,
    'amount': t.amount,
    'currency': t.currency,
    'status': t.status,
    'planId': t.planId,
    'createdAt': t.createdAt.toIso8601String(),
  };

  TransactionEntity _txFromJson(Map<String, dynamic> j) => TransactionEntity(
    id: j['id'] ?? '',
    userId: j['userId'] ?? '',
    subscriptionId: j['subscriptionId'] ?? '',
    paymentProvider: j['paymentProvider'] ?? '',
    paymentProviderTransactionId: j['paymentProviderTransactionId'] ?? '',
    amount: (j['amount'] as num?)?.toDouble() ?? 0,
    currency: j['currency'] ?? '',
    status: j['status'] ?? '',
    planId: j['planId'] ?? '',
    createdAt: DateTime.tryParse(j['createdAt'] ?? '') ?? DateTime.now(),
  );
}
