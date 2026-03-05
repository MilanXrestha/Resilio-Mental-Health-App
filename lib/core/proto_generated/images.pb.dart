// This is a generated file - do not edit.
//
// Generated from images.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Image entity
class Image extends $pb.GeneratedMessage {
  factory Image({
    $core.String? id,
    $core.String? title,
    $core.String? description,
    $core.String? imageUrl,
    $core.String? thumbnailUrl,
    $core.String? author,
    $core.String? authorIconUrl,
    $core.String? categoryId,
    $core.Iterable<$core.String>? preferenceIds,
    $core.String? imageType,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.int? resolutionWidth,
    $core.int? resolutionHeight,
    $fixnum.Int64? fileSizeBytes,
    $core.int? downloadCount,
    $core.int? sortOrder,
    $core.String? metadata,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (thumbnailUrl != null) result.thumbnailUrl = thumbnailUrl;
    if (author != null) result.author = author;
    if (authorIconUrl != null) result.authorIconUrl = authorIconUrl;
    if (categoryId != null) result.categoryId = categoryId;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    if (imageType != null) result.imageType = imageType;
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (resolutionWidth != null) result.resolutionWidth = resolutionWidth;
    if (resolutionHeight != null) result.resolutionHeight = resolutionHeight;
    if (fileSizeBytes != null) result.fileSizeBytes = fileSizeBytes;
    if (downloadCount != null) result.downloadCount = downloadCount;
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (metadata != null) result.metadata = metadata;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Image._();

  factory Image.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Image.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Image',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.images'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(5, _omitFieldNames ? '' : 'thumbnailUrl')
    ..aOS(6, _omitFieldNames ? '' : 'author')
    ..aOS(7, _omitFieldNames ? '' : 'authorIconUrl')
    ..aOS(8, _omitFieldNames ? '' : 'categoryId')
    ..pPS(9, _omitFieldNames ? '' : 'preferenceIds')
    ..aOS(10, _omitFieldNames ? '' : 'imageType')
    ..aOB(11, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(12, _omitFieldNames ? '' : 'isPremium')
    ..aI(13, _omitFieldNames ? '' : 'resolutionWidth')
    ..aI(14, _omitFieldNames ? '' : 'resolutionHeight')
    ..aInt64(15, _omitFieldNames ? '' : 'fileSizeBytes')
    ..aI(16, _omitFieldNames ? '' : 'downloadCount')
    ..aI(17, _omitFieldNames ? '' : 'sortOrder')
    ..aOS(18, _omitFieldNames ? '' : 'metadata')
    ..aOS(19, _omitFieldNames ? '' : 'createdAt')
    ..aOS(20, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Image clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Image copyWith(void Function(Image) updates) =>
      super.copyWith((message) => updates(message as Image)) as Image;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Image create() => Image._();
  @$core.override
  Image createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Image getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Image>(create);
  static Image? _defaultInstance;

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
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get imageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get thumbnailUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set thumbnailUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasThumbnailUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearThumbnailUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get author => $_getSZ(5);
  @$pb.TagNumber(6)
  set author($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAuthor() => $_has(5);
  @$pb.TagNumber(6)
  void clearAuthor() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get authorIconUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set authorIconUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAuthorIconUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearAuthorIconUrl() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get categoryId => $_getSZ(7);
  @$pb.TagNumber(8)
  set categoryId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCategoryId() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategoryId() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get preferenceIds => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get imageType => $_getSZ(9);
  @$pb.TagNumber(10)
  set imageType($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasImageType() => $_has(9);
  @$pb.TagNumber(10)
  void clearImageType() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get isFeatured => $_getBF(10);
  @$pb.TagNumber(11)
  set isFeatured($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsFeatured() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsFeatured() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isPremium => $_getBF(11);
  @$pb.TagNumber(12)
  set isPremium($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsPremium() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsPremium() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get resolutionWidth => $_getIZ(12);
  @$pb.TagNumber(13)
  set resolutionWidth($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasResolutionWidth() => $_has(12);
  @$pb.TagNumber(13)
  void clearResolutionWidth() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get resolutionHeight => $_getIZ(13);
  @$pb.TagNumber(14)
  set resolutionHeight($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasResolutionHeight() => $_has(13);
  @$pb.TagNumber(14)
  void clearResolutionHeight() => $_clearField(14);

  @$pb.TagNumber(15)
  $fixnum.Int64 get fileSizeBytes => $_getI64(14);
  @$pb.TagNumber(15)
  set fileSizeBytes($fixnum.Int64 value) => $_setInt64(14, value);
  @$pb.TagNumber(15)
  $core.bool hasFileSizeBytes() => $_has(14);
  @$pb.TagNumber(15)
  void clearFileSizeBytes() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get downloadCount => $_getIZ(15);
  @$pb.TagNumber(16)
  set downloadCount($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(16)
  $core.bool hasDownloadCount() => $_has(15);
  @$pb.TagNumber(16)
  void clearDownloadCount() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.int get sortOrder => $_getIZ(16);
  @$pb.TagNumber(17)
  set sortOrder($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasSortOrder() => $_has(16);
  @$pb.TagNumber(17)
  void clearSortOrder() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get metadata => $_getSZ(17);
  @$pb.TagNumber(18)
  set metadata($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasMetadata() => $_has(17);
  @$pb.TagNumber(18)
  void clearMetadata() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get createdAt => $_getSZ(18);
  @$pb.TagNumber(19)
  set createdAt($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCreatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreatedAt() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get updatedAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set updatedAt($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasUpdatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearUpdatedAt() => $_clearField(20);
}

/// Get featured images request
class GetFeaturedImagesRequest extends $pb.GeneratedMessage {
  factory GetFeaturedImagesRequest({
    $core.int? limit,
    $core.Iterable<$core.String>? preferenceIds,
    $core.String? imageType,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    if (imageType != null) result.imageType = imageType;
    return result;
  }

  GetFeaturedImagesRequest._();

  factory GetFeaturedImagesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFeaturedImagesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeaturedImagesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.images'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'limit')
    ..pPS(2, _omitFieldNames ? '' : 'preferenceIds')
    ..aOS(3, _omitFieldNames ? '' : 'imageType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedImagesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedImagesRequest copyWith(
          void Function(GetFeaturedImagesRequest) updates) =>
      super.copyWith((message) => updates(message as GetFeaturedImagesRequest))
          as GetFeaturedImagesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeaturedImagesRequest create() => GetFeaturedImagesRequest._();
  @$core.override
  GetFeaturedImagesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFeaturedImagesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeaturedImagesRequest>(create);
  static GetFeaturedImagesRequest? _defaultInstance;

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
  $core.String get imageType => $_getSZ(2);
  @$pb.TagNumber(3)
  set imageType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasImageType() => $_has(2);
  @$pb.TagNumber(3)
  void clearImageType() => $_clearField(3);
}

/// Get featured images response
class GetFeaturedImagesResponse extends $pb.GeneratedMessage {
  factory GetFeaturedImagesResponse({
    $core.Iterable<Image>? images,
  }) {
    final result = create();
    if (images != null) result.images.addAll(images);
    return result;
  }

  GetFeaturedImagesResponse._();

  factory GetFeaturedImagesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFeaturedImagesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeaturedImagesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.images'),
      createEmptyInstance: create)
    ..pPM<Image>(1, _omitFieldNames ? '' : 'images', subBuilder: Image.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedImagesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedImagesResponse copyWith(
          void Function(GetFeaturedImagesResponse) updates) =>
      super.copyWith((message) => updates(message as GetFeaturedImagesResponse))
          as GetFeaturedImagesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeaturedImagesResponse create() => GetFeaturedImagesResponse._();
  @$core.override
  GetFeaturedImagesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFeaturedImagesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeaturedImagesResponse>(create);
  static GetFeaturedImagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Image> get images => $_getList(0);
}

/// Get image by ID request
class GetImageByIdRequest extends $pb.GeneratedMessage {
  factory GetImageByIdRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetImageByIdRequest._();

  factory GetImageByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetImageByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetImageByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.images'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageByIdRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImageByIdRequest copyWith(void Function(GetImageByIdRequest) updates) =>
      super.copyWith((message) => updates(message as GetImageByIdRequest))
          as GetImageByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetImageByIdRequest create() => GetImageByIdRequest._();
  @$core.override
  GetImageByIdRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetImageByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetImageByIdRequest>(create);
  static GetImageByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

/// List images request
class ListImagesRequest extends $pb.GeneratedMessage {
  factory ListImagesRequest({
    $0.PaginationRequest? pagination,
    $core.String? categoryId,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.String? imageType,
    $core.Iterable<$core.String>? preferenceIds,
  }) {
    final result = create();
    if (pagination != null) result.pagination = pagination;
    if (categoryId != null) result.categoryId = categoryId;
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (imageType != null) result.imageType = imageType;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    return result;
  }

  ListImagesRequest._();

  factory ListImagesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListImagesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListImagesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.images'),
      createEmptyInstance: create)
    ..aOM<$0.PaginationRequest>(1, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationRequest.create)
    ..aOS(2, _omitFieldNames ? '' : 'categoryId')
    ..aOB(3, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(4, _omitFieldNames ? '' : 'isPremium')
    ..aOS(5, _omitFieldNames ? '' : 'imageType')
    ..pPS(6, _omitFieldNames ? '' : 'preferenceIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListImagesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListImagesRequest copyWith(void Function(ListImagesRequest) updates) =>
      super.copyWith((message) => updates(message as ListImagesRequest))
          as ListImagesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListImagesRequest create() => ListImagesRequest._();
  @$core.override
  ListImagesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListImagesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListImagesRequest>(create);
  static ListImagesRequest? _defaultInstance;

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
  $core.String get imageType => $_getSZ(4);
  @$pb.TagNumber(5)
  set imageType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasImageType() => $_has(4);
  @$pb.TagNumber(5)
  void clearImageType() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get preferenceIds => $_getList(5);
}

/// List images response
class ListImagesResponse extends $pb.GeneratedMessage {
  factory ListImagesResponse({
    $core.Iterable<Image>? images,
    $0.PaginationResponse? pagination,
  }) {
    final result = create();
    if (images != null) result.images.addAll(images);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListImagesResponse._();

  factory ListImagesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListImagesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListImagesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.images'),
      createEmptyInstance: create)
    ..pPM<Image>(1, _omitFieldNames ? '' : 'images', subBuilder: Image.create)
    ..aOM<$0.PaginationResponse>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListImagesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListImagesResponse copyWith(void Function(ListImagesResponse) updates) =>
      super.copyWith((message) => updates(message as ListImagesResponse))
          as ListImagesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListImagesResponse create() => ListImagesResponse._();
  @$core.override
  ListImagesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListImagesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListImagesResponse>(create);
  static ListImagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Image> get images => $_getList(0);

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

/// Get images by type request
class GetImagesByTypeRequest extends $pb.GeneratedMessage {
  factory GetImagesByTypeRequest({
    $core.String? imageType,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (imageType != null) result.imageType = imageType;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetImagesByTypeRequest._();

  factory GetImagesByTypeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetImagesByTypeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetImagesByTypeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.images'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'imageType')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..aI(3, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImagesByTypeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImagesByTypeRequest copyWith(
          void Function(GetImagesByTypeRequest) updates) =>
      super.copyWith((message) => updates(message as GetImagesByTypeRequest))
          as GetImagesByTypeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetImagesByTypeRequest create() => GetImagesByTypeRequest._();
  @$core.override
  GetImagesByTypeRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetImagesByTypeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetImagesByTypeRequest>(create);
  static GetImagesByTypeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get imageType => $_getSZ(0);
  @$pb.TagNumber(1)
  set imageType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasImageType() => $_has(0);
  @$pb.TagNumber(1)
  void clearImageType() => $_clearField(1);

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

/// Get images by type response
class GetImagesByTypeResponse extends $pb.GeneratedMessage {
  factory GetImagesByTypeResponse({
    $core.Iterable<Image>? images,
    $core.int? totalCount,
  }) {
    final result = create();
    if (images != null) result.images.addAll(images);
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  GetImagesByTypeResponse._();

  factory GetImagesByTypeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetImagesByTypeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetImagesByTypeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.images'),
      createEmptyInstance: create)
    ..pPM<Image>(1, _omitFieldNames ? '' : 'images', subBuilder: Image.create)
    ..aI(2, _omitFieldNames ? '' : 'totalCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImagesByTypeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetImagesByTypeResponse copyWith(
          void Function(GetImagesByTypeResponse) updates) =>
      super.copyWith((message) => updates(message as GetImagesByTypeResponse))
          as GetImagesByTypeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetImagesByTypeResponse create() => GetImagesByTypeResponse._();
  @$core.override
  GetImagesByTypeResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetImagesByTypeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetImagesByTypeResponse>(create);
  static GetImagesByTypeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Image> get images => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => $_clearField(2);
}

/// Create image request
class CreateImageRequest extends $pb.GeneratedMessage {
  factory CreateImageRequest({
    $core.String? title,
    $core.String? description,
    $core.String? imageUrl,
    $core.String? thumbnailUrl,
    $core.String? author,
    $core.String? authorIconUrl,
    $core.String? categoryId,
    $core.Iterable<$core.String>? preferenceIds,
    $core.String? imageType,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.int? resolutionWidth,
    $core.int? resolutionHeight,
    $fixnum.Int64? fileSizeBytes,
    $core.int? sortOrder,
    $core.String? metadata,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (thumbnailUrl != null) result.thumbnailUrl = thumbnailUrl;
    if (author != null) result.author = author;
    if (authorIconUrl != null) result.authorIconUrl = authorIconUrl;
    if (categoryId != null) result.categoryId = categoryId;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    if (imageType != null) result.imageType = imageType;
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (resolutionWidth != null) result.resolutionWidth = resolutionWidth;
    if (resolutionHeight != null) result.resolutionHeight = resolutionHeight;
    if (fileSizeBytes != null) result.fileSizeBytes = fileSizeBytes;
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  CreateImageRequest._();

  factory CreateImageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateImageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateImageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.images'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(4, _omitFieldNames ? '' : 'thumbnailUrl')
    ..aOS(5, _omitFieldNames ? '' : 'author')
    ..aOS(6, _omitFieldNames ? '' : 'authorIconUrl')
    ..aOS(7, _omitFieldNames ? '' : 'categoryId')
    ..pPS(8, _omitFieldNames ? '' : 'preferenceIds')
    ..aOS(9, _omitFieldNames ? '' : 'imageType')
    ..aOB(10, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(11, _omitFieldNames ? '' : 'isPremium')
    ..aI(12, _omitFieldNames ? '' : 'resolutionWidth')
    ..aI(13, _omitFieldNames ? '' : 'resolutionHeight')
    ..aInt64(14, _omitFieldNames ? '' : 'fileSizeBytes')
    ..aI(15, _omitFieldNames ? '' : 'sortOrder')
    ..aOS(16, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateImageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateImageRequest copyWith(void Function(CreateImageRequest) updates) =>
      super.copyWith((message) => updates(message as CreateImageRequest))
          as CreateImageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateImageRequest create() => CreateImageRequest._();
  @$core.override
  CreateImageRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateImageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateImageRequest>(create);
  static CreateImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get imageUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set imageUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasImageUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearImageUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get thumbnailUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set thumbnailUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasThumbnailUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearThumbnailUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get author => $_getSZ(4);
  @$pb.TagNumber(5)
  set author($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAuthor() => $_has(4);
  @$pb.TagNumber(5)
  void clearAuthor() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get authorIconUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set authorIconUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAuthorIconUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearAuthorIconUrl() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get categoryId => $_getSZ(6);
  @$pb.TagNumber(7)
  set categoryId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCategoryId() => $_has(6);
  @$pb.TagNumber(7)
  void clearCategoryId() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get preferenceIds => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get imageType => $_getSZ(8);
  @$pb.TagNumber(9)
  set imageType($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasImageType() => $_has(8);
  @$pb.TagNumber(9)
  void clearImageType() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isFeatured => $_getBF(9);
  @$pb.TagNumber(10)
  set isFeatured($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsFeatured() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsFeatured() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get isPremium => $_getBF(10);
  @$pb.TagNumber(11)
  set isPremium($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsPremium() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsPremium() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get resolutionWidth => $_getIZ(11);
  @$pb.TagNumber(12)
  set resolutionWidth($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasResolutionWidth() => $_has(11);
  @$pb.TagNumber(12)
  void clearResolutionWidth() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get resolutionHeight => $_getIZ(12);
  @$pb.TagNumber(13)
  set resolutionHeight($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasResolutionHeight() => $_has(12);
  @$pb.TagNumber(13)
  void clearResolutionHeight() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get fileSizeBytes => $_getI64(13);
  @$pb.TagNumber(14)
  set fileSizeBytes($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasFileSizeBytes() => $_has(13);
  @$pb.TagNumber(14)
  void clearFileSizeBytes() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get sortOrder => $_getIZ(14);
  @$pb.TagNumber(15)
  set sortOrder($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasSortOrder() => $_has(14);
  @$pb.TagNumber(15)
  void clearSortOrder() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get metadata => $_getSZ(15);
  @$pb.TagNumber(16)
  set metadata($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasMetadata() => $_has(15);
  @$pb.TagNumber(16)
  void clearMetadata() => $_clearField(16);
}

/// Update image request
class UpdateImageRequest extends $pb.GeneratedMessage {
  factory UpdateImageRequest({
    $core.String? id,
    $core.String? title,
    $core.String? description,
    $core.String? imageUrl,
    $core.String? thumbnailUrl,
    $core.String? author,
    $core.String? authorIconUrl,
    $core.String? categoryId,
    $core.Iterable<$core.String>? preferenceIds,
    $core.String? imageType,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.int? resolutionWidth,
    $core.int? resolutionHeight,
    $fixnum.Int64? fileSizeBytes,
    $core.int? sortOrder,
    $core.String? metadata,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (thumbnailUrl != null) result.thumbnailUrl = thumbnailUrl;
    if (author != null) result.author = author;
    if (authorIconUrl != null) result.authorIconUrl = authorIconUrl;
    if (categoryId != null) result.categoryId = categoryId;
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    if (imageType != null) result.imageType = imageType;
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (resolutionWidth != null) result.resolutionWidth = resolutionWidth;
    if (resolutionHeight != null) result.resolutionHeight = resolutionHeight;
    if (fileSizeBytes != null) result.fileSizeBytes = fileSizeBytes;
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  UpdateImageRequest._();

  factory UpdateImageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateImageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateImageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.images'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(5, _omitFieldNames ? '' : 'thumbnailUrl')
    ..aOS(6, _omitFieldNames ? '' : 'author')
    ..aOS(7, _omitFieldNames ? '' : 'authorIconUrl')
    ..aOS(8, _omitFieldNames ? '' : 'categoryId')
    ..pPS(9, _omitFieldNames ? '' : 'preferenceIds')
    ..aOS(10, _omitFieldNames ? '' : 'imageType')
    ..aOB(11, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(12, _omitFieldNames ? '' : 'isPremium')
    ..aI(13, _omitFieldNames ? '' : 'resolutionWidth')
    ..aI(14, _omitFieldNames ? '' : 'resolutionHeight')
    ..aInt64(15, _omitFieldNames ? '' : 'fileSizeBytes')
    ..aI(16, _omitFieldNames ? '' : 'sortOrder')
    ..aOS(17, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateImageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateImageRequest copyWith(void Function(UpdateImageRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateImageRequest))
          as UpdateImageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateImageRequest create() => UpdateImageRequest._();
  @$core.override
  UpdateImageRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateImageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateImageRequest>(create);
  static UpdateImageRequest? _defaultInstance;

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
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get imageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get thumbnailUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set thumbnailUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasThumbnailUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearThumbnailUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get author => $_getSZ(5);
  @$pb.TagNumber(6)
  set author($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAuthor() => $_has(5);
  @$pb.TagNumber(6)
  void clearAuthor() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get authorIconUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set authorIconUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAuthorIconUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearAuthorIconUrl() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get categoryId => $_getSZ(7);
  @$pb.TagNumber(8)
  set categoryId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCategoryId() => $_has(7);
  @$pb.TagNumber(8)
  void clearCategoryId() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get preferenceIds => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get imageType => $_getSZ(9);
  @$pb.TagNumber(10)
  set imageType($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasImageType() => $_has(9);
  @$pb.TagNumber(10)
  void clearImageType() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get isFeatured => $_getBF(10);
  @$pb.TagNumber(11)
  set isFeatured($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsFeatured() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsFeatured() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isPremium => $_getBF(11);
  @$pb.TagNumber(12)
  set isPremium($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsPremium() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsPremium() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get resolutionWidth => $_getIZ(12);
  @$pb.TagNumber(13)
  set resolutionWidth($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasResolutionWidth() => $_has(12);
  @$pb.TagNumber(13)
  void clearResolutionWidth() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get resolutionHeight => $_getIZ(13);
  @$pb.TagNumber(14)
  set resolutionHeight($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasResolutionHeight() => $_has(13);
  @$pb.TagNumber(14)
  void clearResolutionHeight() => $_clearField(14);

  @$pb.TagNumber(15)
  $fixnum.Int64 get fileSizeBytes => $_getI64(14);
  @$pb.TagNumber(15)
  set fileSizeBytes($fixnum.Int64 value) => $_setInt64(14, value);
  @$pb.TagNumber(15)
  $core.bool hasFileSizeBytes() => $_has(14);
  @$pb.TagNumber(15)
  void clearFileSizeBytes() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get sortOrder => $_getIZ(15);
  @$pb.TagNumber(16)
  set sortOrder($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(16)
  $core.bool hasSortOrder() => $_has(15);
  @$pb.TagNumber(16)
  void clearSortOrder() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get metadata => $_getSZ(16);
  @$pb.TagNumber(17)
  set metadata($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasMetadata() => $_has(16);
  @$pb.TagNumber(17)
  void clearMetadata() => $_clearField(17);
}

/// Delete image request
class DeleteImageRequest extends $pb.GeneratedMessage {
  factory DeleteImageRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteImageRequest._();

  factory DeleteImageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteImageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteImageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.images'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteImageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteImageRequest copyWith(void Function(DeleteImageRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteImageRequest))
          as DeleteImageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteImageRequest create() => DeleteImageRequest._();
  @$core.override
  DeleteImageRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteImageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteImageRequest>(create);
  static DeleteImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

/// Increment download count request
class IncrementDownloadCountRequest extends $pb.GeneratedMessage {
  factory IncrementDownloadCountRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  IncrementDownloadCountRequest._();

  factory IncrementDownloadCountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IncrementDownloadCountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IncrementDownloadCountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.images'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncrementDownloadCountRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncrementDownloadCountRequest copyWith(
          void Function(IncrementDownloadCountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as IncrementDownloadCountRequest))
          as IncrementDownloadCountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IncrementDownloadCountRequest create() =>
      IncrementDownloadCountRequest._();
  @$core.override
  IncrementDownloadCountRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IncrementDownloadCountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IncrementDownloadCountRequest>(create);
  static IncrementDownloadCountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

/// Images Service - CRUD operations for managing images
class ImagesServiceApi {
  final $pb.RpcClient _client;

  ImagesServiceApi(this._client);

  /// Get featured images (for dashboard/homepage)
  $async.Future<GetFeaturedImagesResponse> getFeaturedImages(
          $pb.ClientContext? ctx, GetFeaturedImagesRequest request) =>
      _client.invoke<GetFeaturedImagesResponse>(ctx, 'ImagesService',
          'GetFeaturedImages', request, GetFeaturedImagesResponse());

  /// Get a single image by ID
  $async.Future<Image> getImageById(
          $pb.ClientContext? ctx, GetImageByIdRequest request) =>
      _client.invoke<Image>(
          ctx, 'ImagesService', 'GetImageById', request, Image());

  /// List all images with pagination and filters
  $async.Future<ListImagesResponse> listImages(
          $pb.ClientContext? ctx, ListImagesRequest request) =>
      _client.invoke<ListImagesResponse>(
          ctx, 'ImagesService', 'ListImages', request, ListImagesResponse());

  /// Get images by type (motivation, nature, etc.)
  $async.Future<GetImagesByTypeResponse> getImagesByType(
          $pb.ClientContext? ctx, GetImagesByTypeRequest request) =>
      _client.invoke<GetImagesByTypeResponse>(ctx, 'ImagesService',
          'GetImagesByType', request, GetImagesByTypeResponse());

  /// Admin operations
  $async.Future<Image> createImage(
          $pb.ClientContext? ctx, CreateImageRequest request) =>
      _client.invoke<Image>(
          ctx, 'ImagesService', 'CreateImage', request, Image());
  $async.Future<Image> updateImage(
          $pb.ClientContext? ctx, UpdateImageRequest request) =>
      _client.invoke<Image>(
          ctx, 'ImagesService', 'UpdateImage', request, Image());
  $async.Future<$0.Empty> deleteImage(
          $pb.ClientContext? ctx, DeleteImageRequest request) =>
      _client.invoke<$0.Empty>(
          ctx, 'ImagesService', 'DeleteImage', request, $0.Empty());

  /// Track downloads
  $async.Future<Image> incrementDownloadCount(
          $pb.ClientContext? ctx, IncrementDownloadCountRequest request) =>
      _client.invoke<Image>(
          ctx, 'ImagesService', 'IncrementDownloadCount', request, Image());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
