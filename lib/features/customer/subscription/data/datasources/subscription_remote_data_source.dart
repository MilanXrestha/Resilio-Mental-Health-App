import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/errors/exceptions.dart';
import 'package:Resilio/core/proto_generated/subscription.pb.dart' as pb;
import 'package:Resilio/core/services/auth_token_service.dart';
import 'package:Resilio/features/customer/subscription/data/models/subscription_model.dart';
import 'package:Resilio/features/customer/subscription/data/models/transaction_model.dart';

abstract class SubscriptionRemoteDataSource {
  Future<SubscriptionModel> getSubscription();
  Future<SubscriptionModel> updateSubscription({
    required String planId,
    required String status,
    required String paymentProvider,
    required String paymentProviderTransactionId,
    required double amount,
    required String currency,
  });
  Future<List<TransactionModel>> getTransactions();
}

@LazySingleton(as: SubscriptionRemoteDataSource)
class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final Dio _dio;
  final AuthTokenService _authTokenService;

  SubscriptionRemoteDataSourceImpl(this._dio, this._authTokenService);

  @override
  Future<SubscriptionModel> getSubscription() async {
    try {
      final request = pb.GetSubscriptionRequest(userId: _authTokenService.userId);
      final response = await _dio.get(
        '/subscriptions/me',
        data: request,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/x-protobuf'},
        ),
      );

      final pbResponse = pb.Subscription.fromBuffer(response.data);
      if (pbResponse.id.isEmpty) {
        throw const ServerException('No subscription active');
      }
      return SubscriptionModel.fromProto(pbResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
         throw const ServerException('No subscription active');
      }
      throw ServerException(e.message ?? 'Failed to get subscription');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<SubscriptionModel> updateSubscription({
    required String planId,
    required String status,
    required String paymentProvider,
    required String paymentProviderTransactionId,
    required double amount,
    required String currency,
  }) async {
    try {
      final request = pb.UpdateSubscriptionRequest(
        userId: _authTokenService.userId,
        planId: planId,
        status: status,
        paymentProvider: paymentProvider,
        paymentProviderTransactionId: paymentProviderTransactionId,
        amount: amount,
        currency: currency,
      );

      final response = await _dio.post(
        '/subscriptions',
        data: request,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/x-protobuf'},
        ),
      );

      final pbResponse = pb.Subscription.fromBuffer(response.data);
      return SubscriptionModel.fromProto(pbResponse);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to update subscription');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final request = pb.ListTransactionsRequest(userId: _authTokenService.userId);
      final response = await _dio.get(
        '/subscriptions/transactions',
        data: request,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/x-protobuf'},
        ),
      );

      final pbResponse = pb.ListTransactionsResponse.fromBuffer(response.data);
      return pbResponse.transactions
          .map((tx) => TransactionModel.fromProto(tx))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load transactions');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
