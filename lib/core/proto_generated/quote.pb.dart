// This is a generated file - do not edit.
//
// Generated from quote.proto.

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

/// Quote entity
class Quote extends $pb.GeneratedMessage {
  factory Quote({
    $core.String? id,
    $core.String? quoteText,
    $core.String? author,
    $core.String? authorIconUrl,
    $core.String? categoryId,
    $core.Iterable<$core.String>? preferenceIds,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.String? quoteType,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (quoteText != null) result.quoteText = quoteText;
    if (author != null) result.author = author;
    if (authorIconUrl != null) result.authorIconUrl = authorIconUrl;
    if (categoryId != null) result.categoryId = categoryId;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (quoteType != null) result.quoteType = quoteType;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Quote._();

  factory Quote.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Quote.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Quote',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.quote'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'quoteText')
    ..aOS(3, _omitFieldNames ? '' : 'author')
    ..aOS(4, _omitFieldNames ? '' : 'authorIconUrl')
    ..aOS(5, _omitFieldNames ? '' : 'categoryId')
    ..pPS(6, _omitFieldNames ? '' : 'preferenceIds')
    ..aOB(7, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(8, _omitFieldNames ? '' : 'isPremium')
    ..aOS(9, _omitFieldNames ? '' : 'quoteType')
    ..aOS(10, _omitFieldNames ? '' : 'createdAt')
    ..aOS(11, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Quote clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Quote copyWith(void Function(Quote) updates) =>
      super.copyWith((message) => updates(message as Quote)) as Quote;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Quote create() => Quote._();
  @$core.override
  Quote createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Quote getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Quote>(create);
  static Quote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get quoteText => $_getSZ(1);
  @$pb.TagNumber(2)
  set quoteText($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuoteText() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuoteText() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get author => $_getSZ(2);
  @$pb.TagNumber(3)
  set author($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get authorIconUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set authorIconUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAuthorIconUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthorIconUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get categoryId => $_getSZ(4);
  @$pb.TagNumber(5)
  set categoryId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCategoryId() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategoryId() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get preferenceIds => $_getList(5);

  @$pb.TagNumber(7)
  $core.bool get isFeatured => $_getBF(6);
  @$pb.TagNumber(7)
  set isFeatured($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsFeatured() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsFeatured() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isPremium => $_getBF(7);
  @$pb.TagNumber(8)
  set isPremium($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIsPremium() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsPremium() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get quoteType => $_getSZ(8);
  @$pb.TagNumber(9)
  set quoteType($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasQuoteType() => $_has(8);
  @$pb.TagNumber(9)
  void clearQuoteType() => $_clearField(9);

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

/// Get featured quotes request
class GetFeaturedQuotesRequest extends $pb.GeneratedMessage {
  factory GetFeaturedQuotesRequest({
    $core.int? limit,
    $core.Iterable<$core.String>? preferenceIds,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    return result;
  }

  GetFeaturedQuotesRequest._();

  factory GetFeaturedQuotesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFeaturedQuotesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeaturedQuotesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.quote'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'limit')
    ..pPS(2, _omitFieldNames ? '' : 'preferenceIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedQuotesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedQuotesRequest copyWith(
          void Function(GetFeaturedQuotesRequest) updates) =>
      super.copyWith((message) => updates(message as GetFeaturedQuotesRequest))
          as GetFeaturedQuotesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeaturedQuotesRequest create() => GetFeaturedQuotesRequest._();
  @$core.override
  GetFeaturedQuotesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFeaturedQuotesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeaturedQuotesRequest>(create);
  static GetFeaturedQuotesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get preferenceIds => $_getList(1);
}

/// Get featured quotes response
class GetFeaturedQuotesResponse extends $pb.GeneratedMessage {
  factory GetFeaturedQuotesResponse({
    $core.Iterable<Quote>? quotes,
  }) {
    final result = create();
    if (quotes != null) result.quotes.addAll(quotes);
    return result;
  }

  GetFeaturedQuotesResponse._();

  factory GetFeaturedQuotesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFeaturedQuotesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeaturedQuotesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.quote'),
      createEmptyInstance: create)
    ..pPM<Quote>(1, _omitFieldNames ? '' : 'quotes', subBuilder: Quote.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedQuotesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedQuotesResponse copyWith(
          void Function(GetFeaturedQuotesResponse) updates) =>
      super.copyWith((message) => updates(message as GetFeaturedQuotesResponse))
          as GetFeaturedQuotesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeaturedQuotesResponse create() => GetFeaturedQuotesResponse._();
  @$core.override
  GetFeaturedQuotesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFeaturedQuotesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeaturedQuotesResponse>(create);
  static GetFeaturedQuotesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Quote> get quotes => $_getList(0);
}

/// Get quote by ID request
class GetQuoteByIdRequest extends $pb.GeneratedMessage {
  factory GetQuoteByIdRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetQuoteByIdRequest._();

  factory GetQuoteByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetQuoteByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetQuoteByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.quote'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetQuoteByIdRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetQuoteByIdRequest copyWith(void Function(GetQuoteByIdRequest) updates) =>
      super.copyWith((message) => updates(message as GetQuoteByIdRequest))
          as GetQuoteByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQuoteByIdRequest create() => GetQuoteByIdRequest._();
  @$core.override
  GetQuoteByIdRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetQuoteByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetQuoteByIdRequest>(create);
  static GetQuoteByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

/// List quotes request
class ListQuotesRequest extends $pb.GeneratedMessage {
  factory ListQuotesRequest({
    $0.PaginationRequest? pagination,
    $core.String? categoryId,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.String? quoteType,
    $core.Iterable<$core.String>? preferenceIds,
  }) {
    final result = create();
    if (pagination != null) result.pagination = pagination;
    if (categoryId != null) result.categoryId = categoryId;
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (quoteType != null) result.quoteType = quoteType;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    return result;
  }

  ListQuotesRequest._();

  factory ListQuotesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListQuotesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListQuotesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.quote'),
      createEmptyInstance: create)
    ..aOM<$0.PaginationRequest>(1, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationRequest.create)
    ..aOS(2, _omitFieldNames ? '' : 'categoryId')
    ..aOB(3, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(4, _omitFieldNames ? '' : 'isPremium')
    ..aOS(5, _omitFieldNames ? '' : 'quoteType')
    ..pPS(6, _omitFieldNames ? '' : 'preferenceIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListQuotesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListQuotesRequest copyWith(void Function(ListQuotesRequest) updates) =>
      super.copyWith((message) => updates(message as ListQuotesRequest))
          as ListQuotesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListQuotesRequest create() => ListQuotesRequest._();
  @$core.override
  ListQuotesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListQuotesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListQuotesRequest>(create);
  static ListQuotesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $0.PaginationRequest get pagination => $_getN(0);
  @$pb.TagNumber(1)
  set pagination($0.PaginationRequest value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPagination() => $_has(0);
  @$pb.TagNumber(1)
  void clearPagination() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.PaginationRequest ensurePagination() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get categoryId => $_getSZ(1);
  @$pb.TagNumber(2)
  set categoryId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategoryId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategoryId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isFeatured => $_getBF(2);
  @$pb.TagNumber(3)
  set isFeatured($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsFeatured() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsFeatured() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isPremium => $_getBF(3);
  @$pb.TagNumber(4)
  set isPremium($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsPremium() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsPremium() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get quoteType => $_getSZ(4);
  @$pb.TagNumber(5)
  set quoteType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQuoteType() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuoteType() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get preferenceIds => $_getList(5);
}

/// List quotes response
class ListQuotesResponse extends $pb.GeneratedMessage {
  factory ListQuotesResponse({
    $core.Iterable<Quote>? quotes,
    $0.PaginationResponse? pagination,
  }) {
    final result = create();
    if (quotes != null) result.quotes.addAll(quotes);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListQuotesResponse._();

  factory ListQuotesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListQuotesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListQuotesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.quote'),
      createEmptyInstance: create)
    ..pPM<Quote>(1, _omitFieldNames ? '' : 'quotes', subBuilder: Quote.create)
    ..aOM<$0.PaginationResponse>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListQuotesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListQuotesResponse copyWith(void Function(ListQuotesResponse) updates) =>
      super.copyWith((message) => updates(message as ListQuotesResponse))
          as ListQuotesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListQuotesResponse create() => ListQuotesResponse._();
  @$core.override
  ListQuotesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListQuotesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListQuotesResponse>(create);
  static ListQuotesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Quote> get quotes => $_getList(0);

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

/// Create quote request
class CreateQuoteRequest extends $pb.GeneratedMessage {
  factory CreateQuoteRequest({
    $core.String? quoteText,
    $core.String? author,
    $core.String? authorIconUrl,
    $core.String? categoryId,
    $core.Iterable<$core.String>? preferenceIds,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.String? quoteType,
  }) {
    final result = create();
    if (quoteText != null) result.quoteText = quoteText;
    if (author != null) result.author = author;
    if (authorIconUrl != null) result.authorIconUrl = authorIconUrl;
    if (categoryId != null) result.categoryId = categoryId;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (quoteType != null) result.quoteType = quoteType;
    return result;
  }

  CreateQuoteRequest._();

  factory CreateQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateQuoteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.quote'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'quoteText')
    ..aOS(2, _omitFieldNames ? '' : 'author')
    ..aOS(3, _omitFieldNames ? '' : 'authorIconUrl')
    ..aOS(4, _omitFieldNames ? '' : 'categoryId')
    ..pPS(5, _omitFieldNames ? '' : 'preferenceIds')
    ..aOB(6, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(7, _omitFieldNames ? '' : 'isPremium')
    ..aOS(8, _omitFieldNames ? '' : 'quoteType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateQuoteRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateQuoteRequest copyWith(void Function(CreateQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as CreateQuoteRequest))
          as CreateQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateQuoteRequest create() => CreateQuoteRequest._();
  @$core.override
  CreateQuoteRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateQuoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateQuoteRequest>(create);
  static CreateQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteText => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteText($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuoteText() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteText() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get author => $_getSZ(1);
  @$pb.TagNumber(2)
  set author($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAuthor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get authorIconUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set authorIconUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthorIconUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthorIconUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get categoryId => $_getSZ(3);
  @$pb.TagNumber(4)
  set categoryId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategoryId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategoryId() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get preferenceIds => $_getList(4);

  @$pb.TagNumber(6)
  $core.bool get isFeatured => $_getBF(5);
  @$pb.TagNumber(6)
  set isFeatured($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsFeatured() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsFeatured() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isPremium => $_getBF(6);
  @$pb.TagNumber(7)
  set isPremium($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsPremium() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsPremium() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get quoteType => $_getSZ(7);
  @$pb.TagNumber(8)
  set quoteType($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasQuoteType() => $_has(7);
  @$pb.TagNumber(8)
  void clearQuoteType() => $_clearField(8);
}

/// Update quote request
class UpdateQuoteRequest extends $pb.GeneratedMessage {
  factory UpdateQuoteRequest({
    $core.String? id,
    $core.String? quoteText,
    $core.String? author,
    $core.String? authorIconUrl,
    $core.String? categoryId,
    $core.Iterable<$core.String>? preferenceIds,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.String? quoteType,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (quoteText != null) result.quoteText = quoteText;
    if (author != null) result.author = author;
    if (authorIconUrl != null) result.authorIconUrl = authorIconUrl;
    if (categoryId != null) result.categoryId = categoryId;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (quoteType != null) result.quoteType = quoteType;
    return result;
  }

  UpdateQuoteRequest._();

  factory UpdateQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateQuoteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.quote'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'quoteText')
    ..aOS(3, _omitFieldNames ? '' : 'author')
    ..aOS(4, _omitFieldNames ? '' : 'authorIconUrl')
    ..aOS(5, _omitFieldNames ? '' : 'categoryId')
    ..pPS(6, _omitFieldNames ? '' : 'preferenceIds')
    ..aOB(7, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(8, _omitFieldNames ? '' : 'isPremium')
    ..aOS(9, _omitFieldNames ? '' : 'quoteType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateQuoteRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateQuoteRequest copyWith(void Function(UpdateQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateQuoteRequest))
          as UpdateQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateQuoteRequest create() => UpdateQuoteRequest._();
  @$core.override
  UpdateQuoteRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateQuoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateQuoteRequest>(create);
  static UpdateQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get quoteText => $_getSZ(1);
  @$pb.TagNumber(2)
  set quoteText($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuoteText() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuoteText() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get author => $_getSZ(2);
  @$pb.TagNumber(3)
  set author($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthor() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthor() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get authorIconUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set authorIconUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAuthorIconUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthorIconUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get categoryId => $_getSZ(4);
  @$pb.TagNumber(5)
  set categoryId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCategoryId() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategoryId() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get preferenceIds => $_getList(5);

  @$pb.TagNumber(7)
  $core.bool get isFeatured => $_getBF(6);
  @$pb.TagNumber(7)
  set isFeatured($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsFeatured() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsFeatured() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isPremium => $_getBF(7);
  @$pb.TagNumber(8)
  set isPremium($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIsPremium() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsPremium() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get quoteType => $_getSZ(8);
  @$pb.TagNumber(9)
  set quoteType($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasQuoteType() => $_has(8);
  @$pb.TagNumber(9)
  void clearQuoteType() => $_clearField(9);
}

/// Delete quote request
class DeleteQuoteRequest extends $pb.GeneratedMessage {
  factory DeleteQuoteRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteQuoteRequest._();

  factory DeleteQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteQuoteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.quote'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteQuoteRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteQuoteRequest copyWith(void Function(DeleteQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteQuoteRequest))
          as DeleteQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteQuoteRequest create() => DeleteQuoteRequest._();
  @$core.override
  DeleteQuoteRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteQuoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteQuoteRequest>(create);
  static DeleteQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

/// Quote service definition
class QuoteServiceApi {
  final $pb.RpcClient _client;

  QuoteServiceApi(this._client);

  /// Get featured quotes
  $async.Future<GetFeaturedQuotesResponse> getFeaturedQuotes(
          $pb.ClientContext? ctx, GetFeaturedQuotesRequest request) =>
      _client.invoke<GetFeaturedQuotesResponse>(ctx, 'QuoteService',
          'GetFeaturedQuotes', request, GetFeaturedQuotesResponse());

  /// Get quote by ID
  $async.Future<Quote> getQuoteById(
          $pb.ClientContext? ctx, GetQuoteByIdRequest request) =>
      _client.invoke<Quote>(
          ctx, 'QuoteService', 'GetQuoteById', request, Quote());

  /// List quotes with filters
  $async.Future<ListQuotesResponse> listQuotes(
          $pb.ClientContext? ctx, ListQuotesRequest request) =>
      _client.invoke<ListQuotesResponse>(
          ctx, 'QuoteService', 'ListQuotes', request, ListQuotesResponse());

  /// Create a new quote (admin only)
  $async.Future<Quote> createQuote(
          $pb.ClientContext? ctx, CreateQuoteRequest request) =>
      _client.invoke<Quote>(
          ctx, 'QuoteService', 'CreateQuote', request, Quote());

  /// Update quote (admin only)
  $async.Future<Quote> updateQuote(
          $pb.ClientContext? ctx, UpdateQuoteRequest request) =>
      _client.invoke<Quote>(
          ctx, 'QuoteService', 'UpdateQuote', request, Quote());

  /// Delete quote (admin only)
  $async.Future<$0.Empty> deleteQuote(
          $pb.ClientContext? ctx, DeleteQuoteRequest request) =>
      _client.invoke<$0.Empty>(
          ctx, 'QuoteService', 'DeleteQuote', request, $0.Empty());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
