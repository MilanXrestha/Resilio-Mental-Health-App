// This is a generated file - do not edit.
//
// Generated from video.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Video entity representing a video track (short reel or long-form therapy session)
class Video extends $pb.GeneratedMessage {
  factory Video({
    $core.String? id,
    $core.String? title,
    $core.String? description,
    $core.String? artistName,
    $core.String? videoUrl,
    $core.String? thumbnailUrl,
    $core.String? coverImageUrl,
    $core.int? durationSeconds,
    $core.String? categoryId,
    $core.Iterable<$core.String>? moodTags,
    $core.String? videoType,
    $core.double? aspectRatio,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.bool? isActive,
    $core.int? sortOrder,
    $core.int? playCount,
    $core.int? likeCount,
    $core.int? shareCount,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (artistName != null) result.artistName = artistName;
    if (videoUrl != null) result.videoUrl = videoUrl;
    if (thumbnailUrl != null) result.thumbnailUrl = thumbnailUrl;
    if (coverImageUrl != null) result.coverImageUrl = coverImageUrl;
    if (durationSeconds != null) result.durationSeconds = durationSeconds;
    if (categoryId != null) result.categoryId = categoryId;
    if (moodTags != null) result.moodTags.addAll(moodTags);
    if (videoType != null) result.videoType = videoType;
    if (aspectRatio != null) result.aspectRatio = aspectRatio;
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (isActive != null) result.isActive = isActive;
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (playCount != null) result.playCount = playCount;
    if (likeCount != null) result.likeCount = likeCount;
    if (shareCount != null) result.shareCount = shareCount;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Video._();

  factory Video.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Video.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Video',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'video'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'artistName')
    ..aOS(5, _omitFieldNames ? '' : 'videoUrl')
    ..aOS(6, _omitFieldNames ? '' : 'thumbnailUrl')
    ..aOS(7, _omitFieldNames ? '' : 'coverImageUrl')
    ..aI(8, _omitFieldNames ? '' : 'durationSeconds')
    ..aOS(9, _omitFieldNames ? '' : 'categoryId')
    ..pPS(10, _omitFieldNames ? '' : 'moodTags')
    ..aOS(11, _omitFieldNames ? '' : 'videoType')
    ..aD(12, _omitFieldNames ? '' : 'aspectRatio')
    ..aOB(13, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(14, _omitFieldNames ? '' : 'isPremium')
    ..aOB(15, _omitFieldNames ? '' : 'isActive')
    ..aI(16, _omitFieldNames ? '' : 'sortOrder')
    ..aI(17, _omitFieldNames ? '' : 'playCount')
    ..aI(18, _omitFieldNames ? '' : 'likeCount')
    ..aI(19, _omitFieldNames ? '' : 'shareCount')
    ..aOS(20, _omitFieldNames ? '' : 'createdAt')
    ..aOS(21, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Video clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Video copyWith(void Function(Video) updates) =>
      super.copyWith((message) => updates(message as Video)) as Video;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Video create() => Video._();
  @$core.override
  Video createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Video getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Video>(create);
  static Video? _defaultInstance;

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
  $core.String get artistName => $_getSZ(3);
  @$pb.TagNumber(4)
  set artistName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasArtistName() => $_has(3);
  @$pb.TagNumber(4)
  void clearArtistName() => $_clearField(4);

  /// Video URLs
  @$pb.TagNumber(5)
  $core.String get videoUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set videoUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVideoUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearVideoUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get thumbnailUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set thumbnailUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasThumbnailUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearThumbnailUrl() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get coverImageUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set coverImageUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCoverImageUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearCoverImageUrl() => $_clearField(7);

  /// Metadata
  @$pb.TagNumber(8)
  $core.int get durationSeconds => $_getIZ(7);
  @$pb.TagNumber(8)
  set durationSeconds($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDurationSeconds() => $_has(7);
  @$pb.TagNumber(8)
  void clearDurationSeconds() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get categoryId => $_getSZ(8);
  @$pb.TagNumber(9)
  set categoryId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCategoryId() => $_has(8);
  @$pb.TagNumber(9)
  void clearCategoryId() => $_clearField(9);

  @$pb.TagNumber(10)
  $pb.PbList<$core.String> get moodTags => $_getList(9);

  /// Video type: 'short' or 'long'
  @$pb.TagNumber(11)
  $core.String get videoType => $_getSZ(10);
  @$pb.TagNumber(11)
  set videoType($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasVideoType() => $_has(10);
  @$pb.TagNumber(11)
  void clearVideoType() => $_clearField(11);

  /// Aspect ratio (9:16 for shorts, 16:9 for long videos)
  @$pb.TagNumber(12)
  $core.double get aspectRatio => $_getN(11);
  @$pb.TagNumber(12)
  set aspectRatio($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAspectRatio() => $_has(11);
  @$pb.TagNumber(12)
  void clearAspectRatio() => $_clearField(12);

  /// Categorization
  @$pb.TagNumber(13)
  $core.bool get isFeatured => $_getBF(12);
  @$pb.TagNumber(13)
  set isFeatured($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIsFeatured() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsFeatured() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.bool get isPremium => $_getBF(13);
  @$pb.TagNumber(14)
  set isPremium($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasIsPremium() => $_has(13);
  @$pb.TagNumber(14)
  void clearIsPremium() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.bool get isActive => $_getBF(14);
  @$pb.TagNumber(15)
  set isActive($core.bool value) => $_setBool(14, value);
  @$pb.TagNumber(15)
  $core.bool hasIsActive() => $_has(14);
  @$pb.TagNumber(15)
  void clearIsActive() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.int get sortOrder => $_getIZ(15);
  @$pb.TagNumber(16)
  set sortOrder($core.int value) => $_setSignedInt32(15, value);
  @$pb.TagNumber(16)
  $core.bool hasSortOrder() => $_has(15);
  @$pb.TagNumber(16)
  void clearSortOrder() => $_clearField(16);

  /// Stats
  @$pb.TagNumber(17)
  $core.int get playCount => $_getIZ(16);
  @$pb.TagNumber(17)
  set playCount($core.int value) => $_setSignedInt32(16, value);
  @$pb.TagNumber(17)
  $core.bool hasPlayCount() => $_has(16);
  @$pb.TagNumber(17)
  void clearPlayCount() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.int get likeCount => $_getIZ(17);
  @$pb.TagNumber(18)
  set likeCount($core.int value) => $_setSignedInt32(17, value);
  @$pb.TagNumber(18)
  $core.bool hasLikeCount() => $_has(17);
  @$pb.TagNumber(18)
  void clearLikeCount() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.int get shareCount => $_getIZ(18);
  @$pb.TagNumber(19)
  set shareCount($core.int value) => $_setSignedInt32(18, value);
  @$pb.TagNumber(19)
  $core.bool hasShareCount() => $_has(18);
  @$pb.TagNumber(19)
  void clearShareCount() => $_clearField(19);

  /// Timestamps
  @$pb.TagNumber(20)
  $core.String get createdAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set createdAt($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasCreatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearCreatedAt() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get updatedAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set updatedAt($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasUpdatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearUpdatedAt() => $_clearField(21);
}

/// Request/Response messages
class GetVideosRequest extends $pb.GeneratedMessage {
  factory GetVideosRequest({
    $core.String? videoType,
    $core.String? categoryId,
    $core.bool? featuredOnly,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (videoType != null) result.videoType = videoType;
    if (categoryId != null) result.categoryId = categoryId;
    if (featuredOnly != null) result.featuredOnly = featuredOnly;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetVideosRequest._();

  factory GetVideosRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVideosRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVideosRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'video'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'videoType')
    ..aOS(2, _omitFieldNames ? '' : 'categoryId')
    ..aOB(3, _omitFieldNames ? '' : 'featuredOnly')
    ..aI(4, _omitFieldNames ? '' : 'limit')
    ..aI(5, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVideosRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVideosRequest copyWith(void Function(GetVideosRequest) updates) =>
      super.copyWith((message) => updates(message as GetVideosRequest))
          as GetVideosRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVideosRequest create() => GetVideosRequest._();
  @$core.override
  GetVideosRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetVideosRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVideosRequest>(create);
  static GetVideosRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get videoType => $_getSZ(0);
  @$pb.TagNumber(1)
  set videoType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVideoType() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get categoryId => $_getSZ(1);
  @$pb.TagNumber(2)
  set categoryId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategoryId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategoryId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get featuredOnly => $_getBF(2);
  @$pb.TagNumber(3)
  set featuredOnly($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFeaturedOnly() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeaturedOnly() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get offset => $_getIZ(4);
  @$pb.TagNumber(5)
  set offset($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOffset() => $_has(4);
  @$pb.TagNumber(5)
  void clearOffset() => $_clearField(5);
}

class GetVideosResponse extends $pb.GeneratedMessage {
  factory GetVideosResponse({
    $core.Iterable<Video>? videos,
    $core.int? totalCount,
  }) {
    final result = create();
    if (videos != null) result.videos.addAll(videos);
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  GetVideosResponse._();

  factory GetVideosResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVideosResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVideosResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'video'),
      createEmptyInstance: create)
    ..pPM<Video>(1, _omitFieldNames ? '' : 'videos', subBuilder: Video.create)
    ..aI(2, _omitFieldNames ? '' : 'totalCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVideosResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVideosResponse copyWith(void Function(GetVideosResponse) updates) =>
      super.copyWith((message) => updates(message as GetVideosResponse))
          as GetVideosResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVideosResponse create() => GetVideosResponse._();
  @$core.override
  GetVideosResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetVideosResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVideosResponse>(create);
  static GetVideosResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Video> get videos => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => $_clearField(2);
}

class GetVideoByIdRequest extends $pb.GeneratedMessage {
  factory GetVideoByIdRequest({
    $core.String? videoId,
  }) {
    final result = create();
    if (videoId != null) result.videoId = videoId;
    return result;
  }

  GetVideoByIdRequest._();

  factory GetVideoByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVideoByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVideoByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'video'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'videoId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVideoByIdRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVideoByIdRequest copyWith(void Function(GetVideoByIdRequest) updates) =>
      super.copyWith((message) => updates(message as GetVideoByIdRequest))
          as GetVideoByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVideoByIdRequest create() => GetVideoByIdRequest._();
  @$core.override
  GetVideoByIdRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetVideoByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVideoByIdRequest>(create);
  static GetVideoByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get videoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set videoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVideoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoId() => $_clearField(1);
}

class VideoResponse extends $pb.GeneratedMessage {
  factory VideoResponse({
    Video? video,
  }) {
    final result = create();
    if (video != null) result.video = video;
    return result;
  }

  VideoResponse._();

  factory VideoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VideoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'video'),
      createEmptyInstance: create)
    ..aOM<Video>(1, _omitFieldNames ? '' : 'video', subBuilder: Video.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoResponse copyWith(void Function(VideoResponse) updates) =>
      super.copyWith((message) => updates(message as VideoResponse))
          as VideoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoResponse create() => VideoResponse._();
  @$core.override
  VideoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VideoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VideoResponse>(create);
  static VideoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Video get video => $_getN(0);
  @$pb.TagNumber(1)
  set video(Video value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasVideo() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideo() => $_clearField(1);
  @$pb.TagNumber(1)
  Video ensureVideo() => $_ensure(0);
}

class IncrementPlayCountRequest extends $pb.GeneratedMessage {
  factory IncrementPlayCountRequest({
    $core.String? videoId,
  }) {
    final result = create();
    if (videoId != null) result.videoId = videoId;
    return result;
  }

  IncrementPlayCountRequest._();

  factory IncrementPlayCountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IncrementPlayCountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IncrementPlayCountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'video'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'videoId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncrementPlayCountRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncrementPlayCountRequest copyWith(
          void Function(IncrementPlayCountRequest) updates) =>
      super.copyWith((message) => updates(message as IncrementPlayCountRequest))
          as IncrementPlayCountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IncrementPlayCountRequest create() => IncrementPlayCountRequest._();
  @$core.override
  IncrementPlayCountRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IncrementPlayCountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IncrementPlayCountRequest>(create);
  static IncrementPlayCountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get videoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set videoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVideoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoId() => $_clearField(1);
}

class PlayCountResponse extends $pb.GeneratedMessage {
  factory PlayCountResponse({
    $core.int? newCount,
  }) {
    final result = create();
    if (newCount != null) result.newCount = newCount;
    return result;
  }

  PlayCountResponse._();

  factory PlayCountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PlayCountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlayCountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'video'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'newCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayCountResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayCountResponse copyWith(void Function(PlayCountResponse) updates) =>
      super.copyWith((message) => updates(message as PlayCountResponse))
          as PlayCountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayCountResponse create() => PlayCountResponse._();
  @$core.override
  PlayCountResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PlayCountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlayCountResponse>(create);
  static PlayCountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get newCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set newCount($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNewCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewCount() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
