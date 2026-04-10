// This is a generated file - do not edit.
//
// Generated from subscription.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'common.pbjson.dart' as $0;

@$core.Deprecated('Use subscriptionDescriptor instead')
const Subscription$json = {
  '1': 'Subscription',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'plan_id', '3': 3, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'start_date', '3': 5, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 6, '4': 1, '5': 9, '10': 'endDate'},
    {'1': 'payment_method', '3': 7, '4': 1, '5': 9, '10': 'paymentMethod'},
    {
      '1': 'last_transaction_id',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'lastTransactionId'
    },
    {'1': 'is_auto_renew', '3': 9, '4': 1, '5': 8, '10': 'isAutoRenew'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 11, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Subscription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscriptionDescriptor = $convert.base64Decode(
    'CgxTdWJzY3JpcHRpb24SDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZB'
    'IXCgdwbGFuX2lkGAMgASgJUgZwbGFuSWQSFgoGc3RhdHVzGAQgASgJUgZzdGF0dXMSHQoKc3Rh'
    'cnRfZGF0ZRgFIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGAYgASgJUgdlbmREYXRlEiUKDn'
    'BheW1lbnRfbWV0aG9kGAcgASgJUg1wYXltZW50TWV0aG9kEi4KE2xhc3RfdHJhbnNhY3Rpb25f'
    'aWQYCCABKAlSEWxhc3RUcmFuc2FjdGlvbklkEiIKDWlzX2F1dG9fcmVuZXcYCSABKAhSC2lzQX'
    'V0b1JlbmV3Eh0KCmNyZWF0ZWRfYXQYCiABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAsg'
    'ASgJUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use transactionDescriptor instead')
const Transaction$json = {
  '1': 'Transaction',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'subscription_id', '3': 3, '4': 1, '5': 9, '10': 'subscriptionId'},
    {'1': 'payment_provider', '3': 4, '4': 1, '5': 9, '10': 'paymentProvider'},
    {
      '1': 'payment_provider_transaction_id',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'paymentProviderTransactionId'
    },
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'status', '3': 8, '4': 1, '5': 9, '10': 'status'},
    {'1': 'plan_id', '3': 9, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode(
    'CgtUcmFuc2FjdGlvbhIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEi'
    'cKD3N1YnNjcmlwdGlvbl9pZBgDIAEoCVIOc3Vic2NyaXB0aW9uSWQSKQoQcGF5bWVudF9wcm92'
    'aWRlchgEIAEoCVIPcGF5bWVudFByb3ZpZGVyEkUKH3BheW1lbnRfcHJvdmlkZXJfdHJhbnNhY3'
    'Rpb25faWQYBSABKAlSHHBheW1lbnRQcm92aWRlclRyYW5zYWN0aW9uSWQSFgoGYW1vdW50GAYg'
    'ASgBUgZhbW91bnQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5EhYKBnN0YXR1cxgIIAEoCV'
    'IGc3RhdHVzEhcKB3BsYW5faWQYCSABKAlSBnBsYW5JZBIdCgpjcmVhdGVkX2F0GAogASgJUglj'
    'cmVhdGVkQXQ=');

@$core.Deprecated('Use getSubscriptionRequestDescriptor instead')
const GetSubscriptionRequest$json = {
  '1': 'GetSubscriptionRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetSubscriptionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRTdWJzY3JpcHRpb25SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use updateSubscriptionRequestDescriptor instead')
const UpdateSubscriptionRequest$json = {
  '1': 'UpdateSubscriptionRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'plan_id', '3': 2, '4': 1, '5': 9, '10': 'planId'},
    {'1': 'status', '3': 3, '4': 1, '5': 9, '10': 'status'},
    {'1': 'payment_provider', '3': 4, '4': 1, '5': 9, '10': 'paymentProvider'},
    {
      '1': 'payment_provider_transaction_id',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'paymentProviderTransactionId'
    },
    {'1': 'amount', '3': 6, '4': 1, '5': 1, '10': 'amount'},
    {'1': 'currency', '3': 7, '4': 1, '5': 9, '10': 'currency'},
  ],
};

/// Descriptor for `UpdateSubscriptionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSubscriptionRequestDescriptor = $convert.base64Decode(
    'ChlVcGRhdGVTdWJzY3JpcHRpb25SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIXCg'
    'dwbGFuX2lkGAIgASgJUgZwbGFuSWQSFgoGc3RhdHVzGAMgASgJUgZzdGF0dXMSKQoQcGF5bWVu'
    'dF9wcm92aWRlchgEIAEoCVIPcGF5bWVudFByb3ZpZGVyEkUKH3BheW1lbnRfcHJvdmlkZXJfdH'
    'JhbnNhY3Rpb25faWQYBSABKAlSHHBheW1lbnRQcm92aWRlclRyYW5zYWN0aW9uSWQSFgoGYW1v'
    'dW50GAYgASgBUgZhbW91bnQSGgoIY3VycmVuY3kYByABKAlSCGN1cnJlbmN5');

@$core.Deprecated('Use listTransactionsRequestDescriptor instead')
const ListTransactionsRequest$json = {
  '1': 'ListTransactionsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resilio.common.PaginationRequest',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `ListTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransactionsRequestDescriptor = $convert.base64Decode(
    'ChdMaXN0VHJhbnNhY3Rpb25zUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSQQoKcG'
    'FnaW5hdGlvbhgCIAEoCzIhLnJlc2lsaW8uY29tbW9uLlBhZ2luYXRpb25SZXF1ZXN0UgpwYWdp'
    'bmF0aW9u');

@$core.Deprecated('Use listTransactionsResponseDescriptor instead')
const ListTransactionsResponse$json = {
  '1': 'ListTransactionsResponse',
  '2': [
    {
      '1': 'transactions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.subscription.Transaction',
      '10': 'transactions'
    },
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resilio.common.PaginationResponse',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `ListTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransactionsResponseDescriptor = $convert.base64Decode(
    'ChhMaXN0VHJhbnNhY3Rpb25zUmVzcG9uc2USRQoMdHJhbnNhY3Rpb25zGAEgAygLMiEucmVzaW'
    'xpby5zdWJzY3JpcHRpb24uVHJhbnNhY3Rpb25SDHRyYW5zYWN0aW9ucxJCCgpwYWdpbmF0aW9u'
    'GAIgASgLMiIucmVzaWxpby5jb21tb24uUGFnaW5hdGlvblJlc3BvbnNlUgpwYWdpbmF0aW9u');

const $core.Map<$core.String, $core.dynamic> SubscriptionServiceBase$json = {
  '1': 'SubscriptionService',
  '2': [
    {
      '1': 'GetSubscription',
      '2': '.resilio.subscription.GetSubscriptionRequest',
      '3': '.resilio.subscription.Subscription'
    },
    {
      '1': 'UpdateSubscription',
      '2': '.resilio.subscription.UpdateSubscriptionRequest',
      '3': '.resilio.subscription.Subscription'
    },
    {
      '1': 'ListTransactions',
      '2': '.resilio.subscription.ListTransactionsRequest',
      '3': '.resilio.subscription.ListTransactionsResponse'
    },
  ],
};

@$core.Deprecated('Use subscriptionServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    SubscriptionServiceBase$messageJson = {
  '.resilio.subscription.GetSubscriptionRequest': GetSubscriptionRequest$json,
  '.resilio.subscription.Subscription': Subscription$json,
  '.resilio.subscription.UpdateSubscriptionRequest':
      UpdateSubscriptionRequest$json,
  '.resilio.subscription.ListTransactionsRequest': ListTransactionsRequest$json,
  '.resilio.common.PaginationRequest': $0.PaginationRequest$json,
  '.resilio.subscription.ListTransactionsResponse':
      ListTransactionsResponse$json,
  '.resilio.subscription.Transaction': Transaction$json,
  '.resilio.common.PaginationResponse': $0.PaginationResponse$json,
};

/// Descriptor for `SubscriptionService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List subscriptionServiceDescriptor = $convert.base64Decode(
    'ChNTdWJzY3JpcHRpb25TZXJ2aWNlEmMKD0dldFN1YnNjcmlwdGlvbhIsLnJlc2lsaW8uc3Vic2'
    'NyaXB0aW9uLkdldFN1YnNjcmlwdGlvblJlcXVlc3QaIi5yZXNpbGlvLnN1YnNjcmlwdGlvbi5T'
    'dWJzY3JpcHRpb24SaQoSVXBkYXRlU3Vic2NyaXB0aW9uEi8ucmVzaWxpby5zdWJzY3JpcHRpb2'
    '4uVXBkYXRlU3Vic2NyaXB0aW9uUmVxdWVzdBoiLnJlc2lsaW8uc3Vic2NyaXB0aW9uLlN1YnNj'
    'cmlwdGlvbhJxChBMaXN0VHJhbnNhY3Rpb25zEi0ucmVzaWxpby5zdWJzY3JpcHRpb24uTGlzdF'
    'RyYW5zYWN0aW9uc1JlcXVlc3QaLi5yZXNpbGlvLnN1YnNjcmlwdGlvbi5MaXN0VHJhbnNhY3Rp'
    'b25zUmVzcG9uc2U=');
