// This is a generated file - do not edit.
//
// Generated from subscription.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'subscription.pb.dart' as $1;
import 'subscription.pbjson.dart';

export 'subscription.pb.dart';

abstract class SubscriptionServiceBase extends $pb.GeneratedService {
  $async.Future<$1.Subscription> getSubscription(
      $pb.ServerContext ctx, $1.GetSubscriptionRequest request);
  $async.Future<$1.Subscription> updateSubscription(
      $pb.ServerContext ctx, $1.UpdateSubscriptionRequest request);
  $async.Future<$1.ListTransactionsResponse> listTransactions(
      $pb.ServerContext ctx, $1.ListTransactionsRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetSubscription':
        return $1.GetSubscriptionRequest();
      case 'UpdateSubscription':
        return $1.UpdateSubscriptionRequest();
      case 'ListTransactions':
        return $1.ListTransactionsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetSubscription':
        return getSubscription(ctx, request as $1.GetSubscriptionRequest);
      case 'UpdateSubscription':
        return updateSubscription(ctx, request as $1.UpdateSubscriptionRequest);
      case 'ListTransactions':
        return listTransactions(ctx, request as $1.ListTransactionsRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      SubscriptionServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => SubscriptionServiceBase$messageJson;
}
