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

import 'common.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Subscription extends $pb.GeneratedMessage {
  factory Subscription({
    $core.String? id,
    $core.String? userId,
    $core.String? planId,
    $core.String? status,
    $core.String? startDate,
    $core.String? endDate,
    $core.String? paymentMethod,
    $core.String? lastTransactionId,
    $core.bool? isAutoRenew,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (planId != null) result.planId = planId;
    if (status != null) result.status = status;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (lastTransactionId != null) result.lastTransactionId = lastTransactionId;
    if (isAutoRenew != null) result.isAutoRenew = isAutoRenew;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Subscription._();

  factory Subscription.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Subscription.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Subscription',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'resilio.subscription'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'planId')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'startDate')
    ..aOS(6, _omitFieldNames ? '' : 'endDate')
    ..aOS(7, _omitFieldNames ? '' : 'paymentMethod')
    ..aOS(8, _omitFieldNames ? '' : 'lastTransactionId')
    ..aOB(9, _omitFieldNames ? '' : 'isAutoRenew')
    ..aOS(10, _omitFieldNames ? '' : 'createdAt')
    ..aOS(11, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Subscription clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Subscription copyWith(void Function(Subscription) updates) =>
      super.copyWith((message) => updates(message as Subscription))
          as Subscription;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Subscription create() => Subscription._();
  @$core.override
  Subscription createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Subscription getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Subscription>(create);
  static Subscription? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get planId => $_getSZ(2);
  @$pb.TagNumber(3)
  set planId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPlanId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlanId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get startDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set startDate($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStartDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearStartDate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get endDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set endDate($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasEndDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearEndDate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get paymentMethod => $_getSZ(6);
  @$pb.TagNumber(7)
  set paymentMethod($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPaymentMethod() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentMethod() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get lastTransactionId => $_getSZ(7);
  @$pb.TagNumber(8)
  set lastTransactionId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLastTransactionId() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastTransactionId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isAutoRenew => $_getBF(8);
  @$pb.TagNumber(9)
  set isAutoRenew($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsAutoRenew() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsAutoRenew() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get createdAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set createdAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get updatedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set updatedAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => $_clearField(11);
}

class Transaction extends $pb.GeneratedMessage {
  factory Transaction({
    $core.String? id,
    $core.String? userId,
    $core.String? subscriptionId,
    $core.String? paymentProvider,
    $core.String? paymentProviderTransactionId,
    $core.double? amount,
    $core.String? currency,
    $core.String? status,
    $core.String? planId,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (subscriptionId != null) result.subscriptionId = subscriptionId;
    if (paymentProvider != null) result.paymentProvider = paymentProvider;
    if (paymentProviderTransactionId != null)
      result.paymentProviderTransactionId = paymentProviderTransactionId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (planId != null) result.planId = planId;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  Transaction._();

  factory Transaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Transaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Transaction',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'resilio.subscription'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'subscriptionId')
    ..aOS(4, _omitFieldNames ? '' : 'paymentProvider')
    ..aOS(5, _omitFieldNames ? '' : 'paymentProviderTransactionId')
    ..aD(6, _omitFieldNames ? '' : 'amount')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..aOS(9, _omitFieldNames ? '' : 'planId')
    ..aOS(10, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transaction clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transaction copyWith(void Function(Transaction) updates) =>
      super.copyWith((message) => updates(message as Transaction))
          as Transaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transaction create() => Transaction._();
  @$core.override
  Transaction createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Transaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Transaction>(create);
  static Transaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get subscriptionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set subscriptionId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSubscriptionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubscriptionId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get paymentProvider => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentProvider($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPaymentProvider() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentProvider() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get paymentProviderTransactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set paymentProviderTransactionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPaymentProviderTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaymentProviderTransactionId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get planId => $_getSZ(8);
  @$pb.TagNumber(9)
  set planId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPlanId() => $_has(8);
  @$pb.TagNumber(9)
  void clearPlanId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get createdAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set createdAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);
}

class GetSubscriptionRequest extends $pb.GeneratedMessage {
  factory GetSubscriptionRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetSubscriptionRequest._();

  factory GetSubscriptionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSubscriptionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSubscriptionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'resilio.subscription'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionRequest copyWith(
          void Function(GetSubscriptionRequest) updates) =>
      super.copyWith((message) => updates(message as GetSubscriptionRequest))
          as GetSubscriptionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSubscriptionRequest create() => GetSubscriptionRequest._();
  @$core.override
  GetSubscriptionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSubscriptionRequest>(create);
  static GetSubscriptionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class UpdateSubscriptionRequest extends $pb.GeneratedMessage {
  factory UpdateSubscriptionRequest({
    $core.String? userId,
    $core.String? planId,
    $core.String? status,
    $core.String? paymentProvider,
    $core.String? paymentProviderTransactionId,
    $core.double? amount,
    $core.String? currency,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (planId != null) result.planId = planId;
    if (status != null) result.status = status;
    if (paymentProvider != null) result.paymentProvider = paymentProvider;
    if (paymentProviderTransactionId != null)
      result.paymentProviderTransactionId = paymentProviderTransactionId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    return result;
  }

  UpdateSubscriptionRequest._();

  factory UpdateSubscriptionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSubscriptionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSubscriptionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'resilio.subscription'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'planId')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'paymentProvider')
    ..aOS(5, _omitFieldNames ? '' : 'paymentProviderTransactionId')
    ..aD(6, _omitFieldNames ? '' : 'amount')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSubscriptionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSubscriptionRequest copyWith(
          void Function(UpdateSubscriptionRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateSubscriptionRequest))
          as UpdateSubscriptionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSubscriptionRequest create() => UpdateSubscriptionRequest._();
  @$core.override
  UpdateSubscriptionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateSubscriptionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSubscriptionRequest>(create);
  static UpdateSubscriptionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get planId => $_getSZ(1);
  @$pb.TagNumber(2)
  set planId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPlanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlanId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get paymentProvider => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentProvider($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPaymentProvider() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentProvider() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get paymentProviderTransactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set paymentProviderTransactionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPaymentProviderTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaymentProviderTransactionId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);
}

class ListTransactionsRequest extends $pb.GeneratedMessage {
  factory ListTransactionsRequest({
    $core.String? userId,
    $0.PaginationRequest? pagination,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListTransactionsRequest._();

  factory ListTransactionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTransactionsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'resilio.subscription'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOM<$0.PaginationRequest>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationRequest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransactionsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransactionsRequest copyWith(
          void Function(ListTransactionsRequest) updates) =>
      super.copyWith((message) => updates(message as ListTransactionsRequest))
          as ListTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTransactionsRequest create() => ListTransactionsRequest._();
  @$core.override
  ListTransactionsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTransactionsRequest>(create);
  static ListTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.PaginationRequest get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($0.PaginationRequest value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.PaginationRequest ensurePagination() => $_ensure(1);
}

class ListTransactionsResponse extends $pb.GeneratedMessage {
  factory ListTransactionsResponse({
    $core.Iterable<Transaction>? transactions,
    $0.PaginationResponse? pagination,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListTransactionsResponse._();

  factory ListTransactionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTransactionsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'resilio.subscription'),
      createEmptyInstance: create)
    ..pPM<Transaction>(1, _omitFieldNames ? '' : 'transactions',
        subBuilder: Transaction.create)
    ..aOM<$0.PaginationResponse>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransactionsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransactionsResponse copyWith(
          void Function(ListTransactionsResponse) updates) =>
      super.copyWith((message) => updates(message as ListTransactionsResponse))
          as ListTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTransactionsResponse create() => ListTransactionsResponse._();
  @$core.override
  ListTransactionsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTransactionsResponse>(create);
  static ListTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Transaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $0.PaginationResponse get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($0.PaginationResponse value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.PaginationResponse ensurePagination() => $_ensure(1);
}

class SubscriptionServiceApi {
  final $pb.RpcClient _client;

  SubscriptionServiceApi(this._client);

  $async.Future<Subscription> getSubscription(
          $pb.ClientContext? ctx, GetSubscriptionRequest request) =>
      _client.invoke<Subscription>(ctx, 'SubscriptionService',
          'GetSubscription', request, Subscription());
  $async.Future<Subscription> updateSubscription(
          $pb.ClientContext? ctx, UpdateSubscriptionRequest request) =>
      _client.invoke<Subscription>(ctx, 'SubscriptionService',
          'UpdateSubscription', request, Subscription());
  $async.Future<ListTransactionsResponse> listTransactions(
          $pb.ClientContext? ctx, ListTransactionsRequest request) =>
      _client.invoke<ListTransactionsResponse>(ctx, 'SubscriptionService',
          'ListTransactions', request, ListTransactionsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
