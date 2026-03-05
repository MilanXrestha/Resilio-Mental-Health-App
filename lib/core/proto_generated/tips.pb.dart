// This is a generated file - do not edit.
//
// Generated from tips.proto.

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

/// Tip entity
class Tip extends $pb.GeneratedMessage {
  factory Tip({
    $core.String? id,
    $core.String? title,
    $core.String? tipText,
    $core.String? author,
    $core.String? authorIconUrl,
    $core.String? categoryId,
    $core.Iterable<$core.String>? preferenceIds,
    $core.String? tipType,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.int? sortOrder,
    $core.String? metadata,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (tipText != null) result.tipText = tipText;
    if (author != null) result.author = author;
    if (authorIconUrl != null) result.authorIconUrl = authorIconUrl;
    if (categoryId != null) result.categoryId = categoryId;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    if (tipType != null) result.tipType = tipType;
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (metadata != null) result.metadata = metadata;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Tip._();

  factory Tip.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Tip.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Tip',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.tips'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'tipText')
    ..aOS(4, _omitFieldNames ? '' : 'author')
    ..aOS(5, _omitFieldNames ? '' : 'authorIconUrl')
    ..aOS(6, _omitFieldNames ? '' : 'categoryId')
    ..pPS(7, _omitFieldNames ? '' : 'preferenceIds')
    ..aOS(8, _omitFieldNames ? '' : 'tipType')
    ..aOB(9, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(10, _omitFieldNames ? '' : 'isPremium')
    ..aI(11, _omitFieldNames ? '' : 'sortOrder')
    ..aOS(12, _omitFieldNames ? '' : 'metadata')
    ..aOS(13, _omitFieldNames ? '' : 'createdAt')
    ..aOS(14, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Tip clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Tip copyWith(void Function(Tip) updates) =>
      super.copyWith((message) => updates(message as Tip)) as Tip;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Tip create() => Tip._();
  @$core.override
  Tip createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Tip getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tip>(create);
  static Tip? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get tipText => $_getSZ(2);
  @$pb.TagNumber(3)
  set tipText($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTipText() => $_has(2);
  @$pb.TagNumber(3)
  void clearTipText() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get author => $_getSZ(3);
  @$pb.TagNumber(4)
  set author($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAuthor() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get authorIconUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set authorIconUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAuthorIconUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearAuthorIconUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get categoryId => $_getSZ(5);
  @$pb.TagNumber(6)
  set categoryId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCategoryId() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategoryId() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get preferenceIds => $_getList(6);

  @$pb.TagNumber(8)
  $core.String get tipType => $_getSZ(7);
  @$pb.TagNumber(8)
  set tipType($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTipType() => $_has(7);
  @$pb.TagNumber(8)
  void clearTipType() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isFeatured => $_getBF(8);
  @$pb.TagNumber(9)
  set isFeatured($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsFeatured() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsFeatured() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isPremium => $_getBF(9);
  @$pb.TagNumber(10)
  set isPremium($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsPremium() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsPremium() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get sortOrder => $_getIZ(10);
  @$pb.TagNumber(11)
  set sortOrder($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSortOrder() => $_has(10);
  @$pb.TagNumber(11)
  void clearSortOrder() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get metadata => $_getSZ(11);
  @$pb.TagNumber(12)
  set metadata($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMetadata() => $_has(11);
  @$pb.TagNumber(12)
  void clearMetadata() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get createdAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set createdAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get updatedAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set updatedAt($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasUpdatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearUpdatedAt() => $_clearField(14);
}

/// Get featured tips request
class GetFeaturedTipsRequest extends $pb.GeneratedMessage {
  factory GetFeaturedTipsRequest({
    $core.int? limit,
    $core.Iterable<$core.String>? preferenceIds,
    $core.String? tipType,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    if (tipType != null) result.tipType = tipType;
    return result;
  }

  GetFeaturedTipsRequest._();

  factory GetFeaturedTipsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFeaturedTipsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeaturedTipsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.tips'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'limit')
    ..pPS(2, _omitFieldNames ? '' : 'preferenceIds')
    ..aOS(3, _omitFieldNames ? '' : 'tipType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedTipsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedTipsRequest copyWith(
          void Function(GetFeaturedTipsRequest) updates) =>
      super.copyWith((message) => updates(message as GetFeaturedTipsRequest))
          as GetFeaturedTipsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeaturedTipsRequest create() => GetFeaturedTipsRequest._();
  @$core.override
  GetFeaturedTipsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFeaturedTipsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeaturedTipsRequest>(create);
  static GetFeaturedTipsRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.String get tipType => $_getSZ(2);
  @$pb.TagNumber(3)
  set tipType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTipType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTipType() => $_clearField(3);
}

/// Get featured tips response
class GetFeaturedTipsResponse extends $pb.GeneratedMessage {
  factory GetFeaturedTipsResponse({
    $core.Iterable<Tip>? tips,
  }) {
    final result = create();
    if (tips != null) result.tips.addAll(tips);
    return result;
  }

  GetFeaturedTipsResponse._();

  factory GetFeaturedTipsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFeaturedTipsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeaturedTipsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.tips'),
      createEmptyInstance: create)
    ..pPM<Tip>(1, _omitFieldNames ? '' : 'tips', subBuilder: Tip.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedTipsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedTipsResponse copyWith(
          void Function(GetFeaturedTipsResponse) updates) =>
      super.copyWith((message) => updates(message as GetFeaturedTipsResponse))
          as GetFeaturedTipsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeaturedTipsResponse create() => GetFeaturedTipsResponse._();
  @$core.override
  GetFeaturedTipsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFeaturedTipsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeaturedTipsResponse>(create);
  static GetFeaturedTipsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Tip> get tips => $_getList(0);
}

/// Get tip by ID request
class GetTipByIdRequest extends $pb.GeneratedMessage {
  factory GetTipByIdRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetTipByIdRequest._();

  factory GetTipByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTipByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTipByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.tips'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTipByIdRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTipByIdRequest copyWith(void Function(GetTipByIdRequest) updates) =>
      super.copyWith((message) => updates(message as GetTipByIdRequest))
          as GetTipByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTipByIdRequest create() => GetTipByIdRequest._();
  @$core.override
  GetTipByIdRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTipByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTipByIdRequest>(create);
  static GetTipByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

/// List tips request
class ListTipsRequest extends $pb.GeneratedMessage {
  factory ListTipsRequest({
    $0.PaginationRequest? pagination,
    $core.String? categoryId,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.String? tipType,
    $core.Iterable<$core.String>? preferenceIds,
    $core.int? sortOrder,
  }) {
    final result = create();
    if (pagination != null) result.pagination = pagination;
    if (categoryId != null) result.categoryId = categoryId;
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (tipType != null) result.tipType = tipType;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    if (sortOrder != null) result.sortOrder = sortOrder;
    return result;
  }

  ListTipsRequest._();

  factory ListTipsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTipsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTipsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.tips'),
      createEmptyInstance: create)
    ..aOM<$0.PaginationRequest>(1, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationRequest.create)
    ..aOS(2, _omitFieldNames ? '' : 'categoryId')
    ..aOB(3, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(4, _omitFieldNames ? '' : 'isPremium')
    ..aOS(5, _omitFieldNames ? '' : 'tipType')
    ..pPS(6, _omitFieldNames ? '' : 'preferenceIds')
    ..aI(7, _omitFieldNames ? '' : 'sortOrder')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTipsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTipsRequest copyWith(void Function(ListTipsRequest) updates) =>
      super.copyWith((message) => updates(message as ListTipsRequest))
          as ListTipsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTipsRequest create() => ListTipsRequest._();
  @$core.override
  ListTipsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListTipsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTipsRequest>(create);
  static ListTipsRequest? _defaultInstance;

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
  $core.String get tipType => $_getSZ(4);
  @$pb.TagNumber(5)
  set tipType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTipType() => $_has(4);
  @$pb.TagNumber(5)
  void clearTipType() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get preferenceIds => $_getList(5);

  @$pb.TagNumber(7)
  $core.int get sortOrder => $_getIZ(6);
  @$pb.TagNumber(7)
  set sortOrder($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSortOrder() => $_has(6);
  @$pb.TagNumber(7)
  void clearSortOrder() => $_clearField(7);
}

/// List tips response
class ListTipsResponse extends $pb.GeneratedMessage {
  factory ListTipsResponse({
    $core.Iterable<Tip>? tips,
    $0.PaginationResponse? pagination,
  }) {
    final result = create();
    if (tips != null) result.tips.addAll(tips);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListTipsResponse._();

  factory ListTipsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTipsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTipsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.tips'),
      createEmptyInstance: create)
    ..pPM<Tip>(1, _omitFieldNames ? '' : 'tips', subBuilder: Tip.create)
    ..aOM<$0.PaginationResponse>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTipsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTipsResponse copyWith(void Function(ListTipsResponse) updates) =>
      super.copyWith((message) => updates(message as ListTipsResponse))
          as ListTipsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTipsResponse create() => ListTipsResponse._();
  @$core.override
  ListTipsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListTipsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTipsResponse>(create);
  static ListTipsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Tip> get tips => $_getList(0);

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

/// Create tip request
class CreateTipRequest extends $pb.GeneratedMessage {
  factory CreateTipRequest({
    $core.String? title,
    $core.String? tipText,
    $core.String? author,
    $core.String? authorIconUrl,
    $core.String? categoryId,
    $core.Iterable<$core.String>? preferenceIds,
    $core.String? tipType,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.int? sortOrder,
    $core.String? metadata,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (tipText != null) result.tipText = tipText;
    if (author != null) result.author = author;
    if (authorIconUrl != null) result.authorIconUrl = authorIconUrl;
    if (categoryId != null) result.categoryId = categoryId;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    if (tipType != null) result.tipType = tipType;
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  CreateTipRequest._();

  factory CreateTipRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTipRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTipRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.tips'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'tipText')
    ..aOS(3, _omitFieldNames ? '' : 'author')
    ..aOS(4, _omitFieldNames ? '' : 'authorIconUrl')
    ..aOS(5, _omitFieldNames ? '' : 'categoryId')
    ..pPS(6, _omitFieldNames ? '' : 'preferenceIds')
    ..aOS(7, _omitFieldNames ? '' : 'tipType')
    ..aOB(8, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(9, _omitFieldNames ? '' : 'isPremium')
    ..aI(10, _omitFieldNames ? '' : 'sortOrder')
    ..aOS(11, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTipRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTipRequest copyWith(void Function(CreateTipRequest) updates) =>
      super.copyWith((message) => updates(message as CreateTipRequest))
          as CreateTipRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTipRequest create() => CreateTipRequest._();
  @$core.override
  CreateTipRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateTipRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTipRequest>(create);
  static CreateTipRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get tipText => $_getSZ(1);
  @$pb.TagNumber(2)
  set tipText($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTipText() => $_has(1);
  @$pb.TagNumber(2)
  void clearTipText() => $_clearField(2);

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
  $core.String get tipType => $_getSZ(6);
  @$pb.TagNumber(7)
  set tipType($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTipType() => $_has(6);
  @$pb.TagNumber(7)
  void clearTipType() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isFeatured => $_getBF(7);
  @$pb.TagNumber(8)
  set isFeatured($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIsFeatured() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsFeatured() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isPremium => $_getBF(8);
  @$pb.TagNumber(9)
  set isPremium($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsPremium() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsPremium() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get sortOrder => $_getIZ(9);
  @$pb.TagNumber(10)
  set sortOrder($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSortOrder() => $_has(9);
  @$pb.TagNumber(10)
  void clearSortOrder() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get metadata => $_getSZ(10);
  @$pb.TagNumber(11)
  set metadata($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMetadata() => $_has(10);
  @$pb.TagNumber(11)
  void clearMetadata() => $_clearField(11);
}

/// Update tip request
class UpdateTipRequest extends $pb.GeneratedMessage {
  factory UpdateTipRequest({
    $core.String? id,
    $core.String? title,
    $core.String? tipText,
    $core.String? author,
    $core.String? authorIconUrl,
    $core.String? categoryId,
    $core.Iterable<$core.String>? preferenceIds,
    $core.String? tipType,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.int? sortOrder,
    $core.String? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (tipText != null) result.tipText = tipText;
    if (author != null) result.author = author;
    if (authorIconUrl != null) result.authorIconUrl = authorIconUrl;
    if (categoryId != null) result.categoryId = categoryId;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    if (tipType != null) result.tipType = tipType;
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  UpdateTipRequest._();

  factory UpdateTipRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTipRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTipRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.tips'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'tipText')
    ..aOS(4, _omitFieldNames ? '' : 'author')
    ..aOS(5, _omitFieldNames ? '' : 'authorIconUrl')
    ..aOS(6, _omitFieldNames ? '' : 'categoryId')
    ..pPS(7, _omitFieldNames ? '' : 'preferenceIds')
    ..aOS(8, _omitFieldNames ? '' : 'tipType')
    ..aOB(9, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(10, _omitFieldNames ? '' : 'isPremium')
    ..aI(11, _omitFieldNames ? '' : 'sortOrder')
    ..aOS(12, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTipRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTipRequest copyWith(void Function(UpdateTipRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateTipRequest))
          as UpdateTipRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTipRequest create() => UpdateTipRequest._();
  @$core.override
  UpdateTipRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateTipRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTipRequest>(create);
  static UpdateTipRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get tipText => $_getSZ(2);
  @$pb.TagNumber(3)
  set tipText($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTipText() => $_has(2);
  @$pb.TagNumber(3)
  void clearTipText() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get author => $_getSZ(3);
  @$pb.TagNumber(4)
  set author($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAuthor() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get authorIconUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set authorIconUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAuthorIconUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearAuthorIconUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get categoryId => $_getSZ(5);
  @$pb.TagNumber(6)
  set categoryId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCategoryId() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategoryId() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get preferenceIds => $_getList(6);

  @$pb.TagNumber(8)
  $core.String get tipType => $_getSZ(7);
  @$pb.TagNumber(8)
  set tipType($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTipType() => $_has(7);
  @$pb.TagNumber(8)
  void clearTipType() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isFeatured => $_getBF(8);
  @$pb.TagNumber(9)
  set isFeatured($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsFeatured() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsFeatured() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isPremium => $_getBF(9);
  @$pb.TagNumber(10)
  set isPremium($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsPremium() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsPremium() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get sortOrder => $_getIZ(10);
  @$pb.TagNumber(11)
  set sortOrder($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSortOrder() => $_has(10);
  @$pb.TagNumber(11)
  void clearSortOrder() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get metadata => $_getSZ(11);
  @$pb.TagNumber(12)
  set metadata($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMetadata() => $_has(11);
  @$pb.TagNumber(12)
  void clearMetadata() => $_clearField(12);
}

/// Delete tip request
class DeleteTipRequest extends $pb.GeneratedMessage {
  factory DeleteTipRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteTipRequest._();

  factory DeleteTipRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteTipRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteTipRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.tips'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteTipRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteTipRequest copyWith(void Function(DeleteTipRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteTipRequest))
          as DeleteTipRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteTipRequest create() => DeleteTipRequest._();
  @$core.override
  DeleteTipRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteTipRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteTipRequest>(create);
  static DeleteTipRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

/// Get tips by type request
class GetTipsByTypeRequest extends $pb.GeneratedMessage {
  factory GetTipsByTypeRequest({
    $core.String? tipType,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (tipType != null) result.tipType = tipType;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetTipsByTypeRequest._();

  factory GetTipsByTypeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTipsByTypeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTipsByTypeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.tips'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tipType')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..aI(3, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTipsByTypeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTipsByTypeRequest copyWith(void Function(GetTipsByTypeRequest) updates) =>
      super.copyWith((message) => updates(message as GetTipsByTypeRequest))
          as GetTipsByTypeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTipsByTypeRequest create() => GetTipsByTypeRequest._();
  @$core.override
  GetTipsByTypeRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTipsByTypeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTipsByTypeRequest>(create);
  static GetTipsByTypeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tipType => $_getSZ(0);
  @$pb.TagNumber(1)
  set tipType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTipType() => $_has(0);
  @$pb.TagNumber(1)
  void clearTipType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

/// Get tips by type response
class GetTipsByTypeResponse extends $pb.GeneratedMessage {
  factory GetTipsByTypeResponse({
    $core.Iterable<Tip>? tips,
    $core.int? totalCount,
  }) {
    final result = create();
    if (tips != null) result.tips.addAll(tips);
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  GetTipsByTypeResponse._();

  factory GetTipsByTypeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTipsByTypeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTipsByTypeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.tips'),
      createEmptyInstance: create)
    ..pPM<Tip>(1, _omitFieldNames ? '' : 'tips', subBuilder: Tip.create)
    ..aI(2, _omitFieldNames ? '' : 'totalCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTipsByTypeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTipsByTypeResponse copyWith(
          void Function(GetTipsByTypeResponse) updates) =>
      super.copyWith((message) => updates(message as GetTipsByTypeResponse))
          as GetTipsByTypeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTipsByTypeResponse create() => GetTipsByTypeResponse._();
  @$core.override
  GetTipsByTypeResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTipsByTypeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTipsByTypeResponse>(create);
  static GetTipsByTypeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Tip> get tips => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => $_clearField(2);
}

/// Tip service definition
class TipServiceApi {
  final $pb.RpcClient _client;

  TipServiceApi(this._client);

  /// Get featured tips
  $async.Future<GetFeaturedTipsResponse> getFeaturedTips(
          $pb.ClientContext? ctx, GetFeaturedTipsRequest request) =>
      _client.invoke<GetFeaturedTipsResponse>(ctx, 'TipService',
          'GetFeaturedTips', request, GetFeaturedTipsResponse());

  /// Get tip by ID
  $async.Future<Tip> getTipById(
          $pb.ClientContext? ctx, GetTipByIdRequest request) =>
      _client.invoke<Tip>(ctx, 'TipService', 'GetTipById', request, Tip());

  /// List tips with filters
  $async.Future<ListTipsResponse> listTips(
          $pb.ClientContext? ctx, ListTipsRequest request) =>
      _client.invoke<ListTipsResponse>(
          ctx, 'TipService', 'ListTips', request, ListTipsResponse());

  /// Get tips by type
  $async.Future<GetTipsByTypeResponse> getTipsByType(
          $pb.ClientContext? ctx, GetTipsByTypeRequest request) =>
      _client.invoke<GetTipsByTypeResponse>(
          ctx, 'TipService', 'GetTipsByType', request, GetTipsByTypeResponse());

  /// Create a new tip (admin only)
  $async.Future<Tip> createTip(
          $pb.ClientContext? ctx, CreateTipRequest request) =>
      _client.invoke<Tip>(ctx, 'TipService', 'CreateTip', request, Tip());

  /// Update tip (admin only)
  $async.Future<Tip> updateTip(
          $pb.ClientContext? ctx, UpdateTipRequest request) =>
      _client.invoke<Tip>(ctx, 'TipService', 'UpdateTip', request, Tip());

  /// Delete tip (admin only)
  $async.Future<$0.Empty> deleteTip(
          $pb.ClientContext? ctx, DeleteTipRequest request) =>
      _client.invoke<$0.Empty>(
          ctx, 'TipService', 'DeleteTip', request, $0.Empty());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
