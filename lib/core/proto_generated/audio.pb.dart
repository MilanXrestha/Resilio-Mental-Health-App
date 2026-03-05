// This is a generated file - do not edit.
//
// Generated from audio.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Audio Track - represents a meditation/calming audio
class AudioTrack extends $pb.GeneratedMessage {
  factory AudioTrack({
    $core.String? id,
    $core.String? title,
    $core.String? description,
    $core.String? artistName,
    $core.String? audioUrl,
    $core.String? coverImageUrl,
    $core.String? thumbnailUrl,
    $core.int? durationSeconds,
    $core.String? categoryId,
    $core.Iterable<$core.String>? moodTags,
    $core.bool? isFeatured,
    $core.bool? isPremium,
    $core.int? sortOrder,
    $core.int? playCount,
    $core.int? likeCount,
    $core.bool? isActive,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (artistName != null) result.artistName = artistName;
    if (audioUrl != null) result.audioUrl = audioUrl;
    if (coverImageUrl != null) result.coverImageUrl = coverImageUrl;
    if (thumbnailUrl != null) result.thumbnailUrl = thumbnailUrl;
    if (durationSeconds != null) result.durationSeconds = durationSeconds;
    if (categoryId != null) result.categoryId = categoryId;
    if (moodTags != null) result.moodTags.addAll(moodTags);
    if (isFeatured != null) result.isFeatured = isFeatured;
    if (isPremium != null) result.isPremium = isPremium;
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (playCount != null) result.playCount = playCount;
    if (likeCount != null) result.likeCount = likeCount;
    if (isActive != null) result.isActive = isActive;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  AudioTrack._();

  factory AudioTrack.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioTrack.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioTrack',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.audio'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'artistName')
    ..aOS(5, _omitFieldNames ? '' : 'audioUrl')
    ..aOS(6, _omitFieldNames ? '' : 'coverImageUrl')
    ..aOS(7, _omitFieldNames ? '' : 'thumbnailUrl')
    ..aI(8, _omitFieldNames ? '' : 'durationSeconds')
    ..aOS(9, _omitFieldNames ? '' : 'categoryId')
    ..pPS(10, _omitFieldNames ? '' : 'moodTags')
    ..aOB(11, _omitFieldNames ? '' : 'isFeatured')
    ..aOB(12, _omitFieldNames ? '' : 'isPremium')
    ..aI(13, _omitFieldNames ? '' : 'sortOrder')
    ..aI(14, _omitFieldNames ? '' : 'playCount')
    ..aI(15, _omitFieldNames ? '' : 'likeCount')
    ..aOB(16, _omitFieldNames ? '' : 'isActive')
    ..aOS(17, _omitFieldNames ? '' : 'createdAt')
    ..aOS(18, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioTrack clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioTrack copyWith(void Function(AudioTrack) updates) =>
      super.copyWith((message) => updates(message as AudioTrack)) as AudioTrack;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioTrack create() => AudioTrack._();
  @$core.override
  AudioTrack createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioTrack getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioTrack>(create);
  static AudioTrack? _defaultInstance;

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

  /// URLs
  @$pb.TagNumber(5)
  $core.String get audioUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set audioUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAudioUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearAudioUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get coverImageUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set coverImageUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCoverImageUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearCoverImageUrl() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get thumbnailUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set thumbnailUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasThumbnailUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearThumbnailUrl() => $_clearField(7);

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

  /// Categorization
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
  $core.int get sortOrder => $_getIZ(12);
  @$pb.TagNumber(13)
  set sortOrder($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasSortOrder() => $_has(12);
  @$pb.TagNumber(13)
  void clearSortOrder() => $_clearField(13);

  /// Stats
  @$pb.TagNumber(14)
  $core.int get playCount => $_getIZ(13);
  @$pb.TagNumber(14)
  set playCount($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasPlayCount() => $_has(13);
  @$pb.TagNumber(14)
  void clearPlayCount() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.int get likeCount => $_getIZ(14);
  @$pb.TagNumber(15)
  set likeCount($core.int value) => $_setSignedInt32(14, value);
  @$pb.TagNumber(15)
  $core.bool hasLikeCount() => $_has(14);
  @$pb.TagNumber(15)
  void clearLikeCount() => $_clearField(15);

  /// Status
  @$pb.TagNumber(16)
  $core.bool get isActive => $_getBF(15);
  @$pb.TagNumber(16)
  set isActive($core.bool value) => $_setBool(15, value);
  @$pb.TagNumber(16)
  $core.bool hasIsActive() => $_has(15);
  @$pb.TagNumber(16)
  void clearIsActive() => $_clearField(16);

  /// Timestamps
  @$pb.TagNumber(17)
  $core.String get createdAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set createdAt($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get updatedAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set updatedAt($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearUpdatedAt() => $_clearField(18);
}

/// Get Featured Audio Tracks Request
class GetFeaturedAudioRequest extends $pb.GeneratedMessage {
  factory GetFeaturedAudioRequest({
    $core.int? limit,
    $core.Iterable<$core.String>? moodFilters,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (moodFilters != null) result.moodFilters.addAll(moodFilters);
    return result;
  }

  GetFeaturedAudioRequest._();

  factory GetFeaturedAudioRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFeaturedAudioRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeaturedAudioRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.audio'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'limit')
    ..pPS(2, _omitFieldNames ? '' : 'moodFilters')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedAudioRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedAudioRequest copyWith(
          void Function(GetFeaturedAudioRequest) updates) =>
      super.copyWith((message) => updates(message as GetFeaturedAudioRequest))
          as GetFeaturedAudioRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeaturedAudioRequest create() => GetFeaturedAudioRequest._();
  @$core.override
  GetFeaturedAudioRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFeaturedAudioRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeaturedAudioRequest>(create);
  static GetFeaturedAudioRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get moodFilters => $_getList(1);
}

/// Get Featured Audio Tracks Response
class GetFeaturedAudioResponse extends $pb.GeneratedMessage {
  factory GetFeaturedAudioResponse({
    $core.Iterable<AudioTrack>? tracks,
  }) {
    final result = create();
    if (tracks != null) result.tracks.addAll(tracks);
    return result;
  }

  GetFeaturedAudioResponse._();

  factory GetFeaturedAudioResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFeaturedAudioResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeaturedAudioResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.audio'),
      createEmptyInstance: create)
    ..pPM<AudioTrack>(1, _omitFieldNames ? '' : 'tracks',
        subBuilder: AudioTrack.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedAudioResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedAudioResponse copyWith(
          void Function(GetFeaturedAudioResponse) updates) =>
      super.copyWith((message) => updates(message as GetFeaturedAudioResponse))
          as GetFeaturedAudioResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeaturedAudioResponse create() => GetFeaturedAudioResponse._();
  @$core.override
  GetFeaturedAudioResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFeaturedAudioResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeaturedAudioResponse>(create);
  static GetFeaturedAudioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AudioTrack> get tracks => $_getList(0);
}

/// Get Audio by Category Request
class GetAudioByCategoryRequest extends $pb.GeneratedMessage {
  factory GetAudioByCategoryRequest({
    $core.String? categoryId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (categoryId != null) result.categoryId = categoryId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetAudioByCategoryRequest._();

  factory GetAudioByCategoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAudioByCategoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAudioByCategoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.audio'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'categoryId')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..aI(3, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudioByCategoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudioByCategoryRequest copyWith(
          void Function(GetAudioByCategoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetAudioByCategoryRequest))
          as GetAudioByCategoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAudioByCategoryRequest create() => GetAudioByCategoryRequest._();
  @$core.override
  GetAudioByCategoryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetAudioByCategoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAudioByCategoryRequest>(create);
  static GetAudioByCategoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get categoryId => $_getSZ(0);
  @$pb.TagNumber(1)
  set categoryId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategoryId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategoryId() => $_clearField(1);

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

/// Get Audio Tracks Response (paginated)
class GetAudioTracksResponse extends $pb.GeneratedMessage {
  factory GetAudioTracksResponse({
    $core.Iterable<AudioTrack>? tracks,
    $core.int? total,
  }) {
    final result = create();
    if (tracks != null) result.tracks.addAll(tracks);
    if (total != null) result.total = total;
    return result;
  }

  GetAudioTracksResponse._();

  factory GetAudioTracksResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAudioTracksResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAudioTracksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.audio'),
      createEmptyInstance: create)
    ..pPM<AudioTrack>(1, _omitFieldNames ? '' : 'tracks',
        subBuilder: AudioTrack.create)
    ..aI(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudioTracksResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudioTracksResponse copyWith(
          void Function(GetAudioTracksResponse) updates) =>
      super.copyWith((message) => updates(message as GetAudioTracksResponse))
          as GetAudioTracksResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAudioTracksResponse create() => GetAudioTracksResponse._();
  @$core.override
  GetAudioTracksResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetAudioTracksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAudioTracksResponse>(create);
  static GetAudioTracksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AudioTrack> get tracks => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// Get Single Audio Track Request
class GetAudioTrackRequest extends $pb.GeneratedMessage {
  factory GetAudioTrackRequest({
    $core.String? audioId,
  }) {
    final result = create();
    if (audioId != null) result.audioId = audioId;
    return result;
  }

  GetAudioTrackRequest._();

  factory GetAudioTrackRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAudioTrackRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAudioTrackRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.audio'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audioId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudioTrackRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudioTrackRequest copyWith(void Function(GetAudioTrackRequest) updates) =>
      super.copyWith((message) => updates(message as GetAudioTrackRequest))
          as GetAudioTrackRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAudioTrackRequest create() => GetAudioTrackRequest._();
  @$core.override
  GetAudioTrackRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetAudioTrackRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAudioTrackRequest>(create);
  static GetAudioTrackRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get audioId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audioId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudioId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudioId() => $_clearField(1);
}

/// Get Single Audio Track Response
class GetAudioTrackResponse extends $pb.GeneratedMessage {
  factory GetAudioTrackResponse({
    AudioTrack? track,
  }) {
    final result = create();
    if (track != null) result.track = track;
    return result;
  }

  GetAudioTrackResponse._();

  factory GetAudioTrackResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAudioTrackResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAudioTrackResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.audio'),
      createEmptyInstance: create)
    ..aOM<AudioTrack>(1, _omitFieldNames ? '' : 'track',
        subBuilder: AudioTrack.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudioTrackResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAudioTrackResponse copyWith(
          void Function(GetAudioTrackResponse) updates) =>
      super.copyWith((message) => updates(message as GetAudioTrackResponse))
          as GetAudioTrackResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAudioTrackResponse create() => GetAudioTrackResponse._();
  @$core.override
  GetAudioTrackResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetAudioTrackResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAudioTrackResponse>(create);
  static GetAudioTrackResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AudioTrack get track => $_getN(0);
  @$pb.TagNumber(1)
  set track(AudioTrack value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTrack() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrack() => $_clearField(1);
  @$pb.TagNumber(1)
  AudioTrack ensureTrack() => $_ensure(0);
}

/// Increment Play Count Request
class IncrementPlayCountRequest extends $pb.GeneratedMessage {
  factory IncrementPlayCountRequest({
    $core.String? audioId,
  }) {
    final result = create();
    if (audioId != null) result.audioId = audioId;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.audio'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'audioId')
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
  $core.String get audioId => $_getSZ(0);
  @$pb.TagNumber(1)
  set audioId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAudioId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAudioId() => $_clearField(1);
}

/// Increment Play Count Response
class IncrementPlayCountResponse extends $pb.GeneratedMessage {
  factory IncrementPlayCountResponse({
    $core.bool? success,
    $core.int? newCount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (newCount != null) result.newCount = newCount;
    return result;
  }

  IncrementPlayCountResponse._();

  factory IncrementPlayCountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IncrementPlayCountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IncrementPlayCountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.audio'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aI(2, _omitFieldNames ? '' : 'newCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncrementPlayCountResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncrementPlayCountResponse copyWith(
          void Function(IncrementPlayCountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as IncrementPlayCountResponse))
          as IncrementPlayCountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IncrementPlayCountResponse create() => IncrementPlayCountResponse._();
  @$core.override
  IncrementPlayCountResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IncrementPlayCountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IncrementPlayCountResponse>(create);
  static IncrementPlayCountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get newCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set newCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewCount() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
