// This is a generated file - do not edit.
//
// Generated from games.proto.

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

class GameSession extends $pb.GeneratedMessage {
  factory GameSession({
    $core.String? id,
    $core.String? userId,
    $core.String? gameType,
    $core.String? startTime,
    $core.String? endTime,
    $core.int? durationSeconds,
    $core.int? score,
    $core.String? metadata,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (gameType != null) result.gameType = gameType;
    if (startTime != null) result.startTime = startTime;
    if (endTime != null) result.endTime = endTime;
    if (durationSeconds != null) result.durationSeconds = durationSeconds;
    if (score != null) result.score = score;
    if (metadata != null) result.metadata = metadata;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  GameSession._();

  factory GameSession.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GameSession.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GameSession',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'gameType')
    ..aOS(4, _omitFieldNames ? '' : 'startTime')
    ..aOS(5, _omitFieldNames ? '' : 'endTime')
    ..aI(6, _omitFieldNames ? '' : 'durationSeconds')
    ..aI(7, _omitFieldNames ? '' : 'score')
    ..aOS(8, _omitFieldNames ? '' : 'metadata')
    ..aOS(9, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GameSession clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GameSession copyWith(void Function(GameSession) updates) =>
      super.copyWith((message) => updates(message as GameSession))
          as GameSession;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GameSession create() => GameSession._();
  @$core.override
  GameSession createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GameSession getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GameSession>(create);
  static GameSession? _defaultInstance;

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
  $core.String get gameType => $_getSZ(2);
  @$pb.TagNumber(3)
  set gameType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGameType() => $_has(2);
  @$pb.TagNumber(3)
  void clearGameType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get startTime => $_getSZ(3);
  @$pb.TagNumber(4)
  set startTime($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStartTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartTime() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get endTime => $_getSZ(4);
  @$pb.TagNumber(5)
  set endTime($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEndTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearEndTime() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get durationSeconds => $_getIZ(5);
  @$pb.TagNumber(6)
  set durationSeconds($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDurationSeconds() => $_has(5);
  @$pb.TagNumber(6)
  void clearDurationSeconds() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get score => $_getIZ(6);
  @$pb.TagNumber(7)
  set score($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasScore() => $_has(6);
  @$pb.TagNumber(7)
  void clearScore() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get metadata => $_getSZ(7);
  @$pb.TagNumber(8)
  set metadata($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMetadata() => $_has(7);
  @$pb.TagNumber(8)
  void clearMetadata() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);
}

class MoodEntry extends $pb.GeneratedMessage {
  factory MoodEntry({
    $core.String? id,
    $core.String? userId,
    $core.int? moodScore,
    $core.String? moodLabel,
    $core.String? note,
    $core.String? entryDate,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (moodScore != null) result.moodScore = moodScore;
    if (moodLabel != null) result.moodLabel = moodLabel;
    if (note != null) result.note = note;
    if (entryDate != null) result.entryDate = entryDate;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  MoodEntry._();

  factory MoodEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MoodEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoodEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aI(3, _omitFieldNames ? '' : 'moodScore')
    ..aOS(4, _omitFieldNames ? '' : 'moodLabel')
    ..aOS(5, _omitFieldNames ? '' : 'note')
    ..aOS(6, _omitFieldNames ? '' : 'entryDate')
    ..aOS(7, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoodEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoodEntry copyWith(void Function(MoodEntry) updates) =>
      super.copyWith((message) => updates(message as MoodEntry)) as MoodEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoodEntry create() => MoodEntry._();
  @$core.override
  MoodEntry createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MoodEntry getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoodEntry>(create);
  static MoodEntry? _defaultInstance;

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
  $core.int get moodScore => $_getIZ(2);
  @$pb.TagNumber(3)
  set moodScore($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMoodScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearMoodScore() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get moodLabel => $_getSZ(3);
  @$pb.TagNumber(4)
  set moodLabel($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMoodLabel() => $_has(3);
  @$pb.TagNumber(4)
  void clearMoodLabel() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get note => $_getSZ(4);
  @$pb.TagNumber(5)
  set note($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNote() => $_has(4);
  @$pb.TagNumber(5)
  void clearNote() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get entryDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set entryDate($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasEntryDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearEntryDate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get createdAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set createdAt($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => $_clearField(7);
}

class Achievement extends $pb.GeneratedMessage {
  factory Achievement({
    $core.String? id,
    $core.String? code,
    $core.String? name,
    $core.String? description,
    $core.String? iconUrl,
    $core.String? requirementType,
    $core.int? requirementValue,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (iconUrl != null) result.iconUrl = iconUrl;
    if (requirementType != null) result.requirementType = requirementType;
    if (requirementValue != null) result.requirementValue = requirementValue;
    return result;
  }

  Achievement._();

  factory Achievement.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Achievement.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Achievement',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'iconUrl')
    ..aOS(6, _omitFieldNames ? '' : 'requirementType')
    ..aI(7, _omitFieldNames ? '' : 'requirementValue')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Achievement clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Achievement copyWith(void Function(Achievement) updates) =>
      super.copyWith((message) => updates(message as Achievement))
          as Achievement;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Achievement create() => Achievement._();
  @$core.override
  Achievement createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Achievement getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Achievement>(create);
  static Achievement? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get iconUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set iconUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIconUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearIconUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get requirementType => $_getSZ(5);
  @$pb.TagNumber(6)
  set requirementType($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRequirementType() => $_has(5);
  @$pb.TagNumber(6)
  void clearRequirementType() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get requirementValue => $_getIZ(6);
  @$pb.TagNumber(7)
  set requirementValue($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRequirementValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearRequirementValue() => $_clearField(7);
}

class UserAchievement extends $pb.GeneratedMessage {
  factory UserAchievement({
    $core.String? id,
    $core.String? userId,
    $core.String? achievementId,
    $core.String? unlockedAt,
    Achievement? achievement,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (achievementId != null) result.achievementId = achievementId;
    if (unlockedAt != null) result.unlockedAt = unlockedAt;
    if (achievement != null) result.achievement = achievement;
    return result;
  }

  UserAchievement._();

  factory UserAchievement.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserAchievement.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserAchievement',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'achievementId')
    ..aOS(4, _omitFieldNames ? '' : 'unlockedAt')
    ..aOM<Achievement>(5, _omitFieldNames ? '' : 'achievement',
        subBuilder: Achievement.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserAchievement clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserAchievement copyWith(void Function(UserAchievement) updates) =>
      super.copyWith((message) => updates(message as UserAchievement))
          as UserAchievement;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserAchievement create() => UserAchievement._();
  @$core.override
  UserAchievement createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserAchievement getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserAchievement>(create);
  static UserAchievement? _defaultInstance;

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
  $core.String get achievementId => $_getSZ(2);
  @$pb.TagNumber(3)
  set achievementId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAchievementId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAchievementId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get unlockedAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set unlockedAt($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUnlockedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnlockedAt() => $_clearField(4);

  @$pb.TagNumber(5)
  Achievement get achievement => $_getN(4);
  @$pb.TagNumber(5)
  set achievement(Achievement value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasAchievement() => $_has(4);
  @$pb.TagNumber(5)
  void clearAchievement() => $_clearField(5);
  @$pb.TagNumber(5)
  Achievement ensureAchievement() => $_ensure(4);
}

class Affirmation extends $pb.GeneratedMessage {
  factory Affirmation({
    $core.String? id,
    $core.String? userId,
    $core.String? text,
    $core.String? backgroundColor,
    $core.String? iconName,
    $core.String? createdAt,
    $core.Iterable<$core.String>? words,
    $core.int? difficulty,
    $core.String? category,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (text != null) result.text = text;
    if (backgroundColor != null) result.backgroundColor = backgroundColor;
    if (iconName != null) result.iconName = iconName;
    if (createdAt != null) result.createdAt = createdAt;
    if (words != null) result.words.addAll(words);
    if (difficulty != null) result.difficulty = difficulty;
    if (category != null) result.category = category;
    return result;
  }

  Affirmation._();

  factory Affirmation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Affirmation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Affirmation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'text')
    ..aOS(4, _omitFieldNames ? '' : 'backgroundColor')
    ..aOS(5, _omitFieldNames ? '' : 'iconName')
    ..aOS(6, _omitFieldNames ? '' : 'createdAt')
    ..pPS(7, _omitFieldNames ? '' : 'words')
    ..aI(8, _omitFieldNames ? '' : 'difficulty')
    ..aOS(9, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Affirmation clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Affirmation copyWith(void Function(Affirmation) updates) =>
      super.copyWith((message) => updates(message as Affirmation))
          as Affirmation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Affirmation create() => Affirmation._();
  @$core.override
  Affirmation createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Affirmation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Affirmation>(create);
  static Affirmation? _defaultInstance;

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
  $core.String get text => $_getSZ(2);
  @$pb.TagNumber(3)
  set text($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasText() => $_has(2);
  @$pb.TagNumber(3)
  void clearText() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get backgroundColor => $_getSZ(3);
  @$pb.TagNumber(4)
  set backgroundColor($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBackgroundColor() => $_has(3);
  @$pb.TagNumber(4)
  void clearBackgroundColor() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get iconName => $_getSZ(4);
  @$pb.TagNumber(5)
  set iconName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIconName() => $_has(4);
  @$pb.TagNumber(5)
  void clearIconName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get createdAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set createdAt($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get words => $_getList(6);

  @$pb.TagNumber(8)
  $core.int get difficulty => $_getIZ(7);
  @$pb.TagNumber(8)
  set difficulty($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDifficulty() => $_has(7);
  @$pb.TagNumber(8)
  void clearDifficulty() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get category => $_getSZ(8);
  @$pb.TagNumber(9)
  set category($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCategory() => $_has(8);
  @$pb.TagNumber(9)
  void clearCategory() => $_clearField(9);
}

class SaveGameSessionRequest extends $pb.GeneratedMessage {
  factory SaveGameSessionRequest({
    $core.String? gameType,
    $core.int? durationSeconds,
    $core.int? score,
    $core.String? metadata,
  }) {
    final result = create();
    if (gameType != null) result.gameType = gameType;
    if (durationSeconds != null) result.durationSeconds = durationSeconds;
    if (score != null) result.score = score;
    if (metadata != null) result.metadata = metadata;
    return result;
  }

  SaveGameSessionRequest._();

  factory SaveGameSessionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SaveGameSessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SaveGameSessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'gameType')
    ..aI(2, _omitFieldNames ? '' : 'durationSeconds')
    ..aI(3, _omitFieldNames ? '' : 'score')
    ..aOS(4, _omitFieldNames ? '' : 'metadata')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveGameSessionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveGameSessionRequest copyWith(
          void Function(SaveGameSessionRequest) updates) =>
      super.copyWith((message) => updates(message as SaveGameSessionRequest))
          as SaveGameSessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SaveGameSessionRequest create() => SaveGameSessionRequest._();
  @$core.override
  SaveGameSessionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SaveGameSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SaveGameSessionRequest>(create);
  static SaveGameSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get gameType => $_getSZ(0);
  @$pb.TagNumber(1)
  set gameType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGameType() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get durationSeconds => $_getIZ(1);
  @$pb.TagNumber(2)
  set durationSeconds($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDurationSeconds() => $_has(1);
  @$pb.TagNumber(2)
  void clearDurationSeconds() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get score => $_getIZ(2);
  @$pb.TagNumber(3)
  set score($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasScore() => $_has(2);
  @$pb.TagNumber(3)
  void clearScore() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get metadata => $_getSZ(3);
  @$pb.TagNumber(4)
  set metadata($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMetadata() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetadata() => $_clearField(4);
}

class SaveMoodEntryRequest extends $pb.GeneratedMessage {
  factory SaveMoodEntryRequest({
    $core.int? moodScore,
    $core.String? moodLabel,
    $core.String? note,
    $core.String? entryDate,
  }) {
    final result = create();
    if (moodScore != null) result.moodScore = moodScore;
    if (moodLabel != null) result.moodLabel = moodLabel;
    if (note != null) result.note = note;
    if (entryDate != null) result.entryDate = entryDate;
    return result;
  }

  SaveMoodEntryRequest._();

  factory SaveMoodEntryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SaveMoodEntryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SaveMoodEntryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'moodScore')
    ..aOS(2, _omitFieldNames ? '' : 'moodLabel')
    ..aOS(3, _omitFieldNames ? '' : 'note')
    ..aOS(4, _omitFieldNames ? '' : 'entryDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveMoodEntryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveMoodEntryRequest copyWith(void Function(SaveMoodEntryRequest) updates) =>
      super.copyWith((message) => updates(message as SaveMoodEntryRequest))
          as SaveMoodEntryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SaveMoodEntryRequest create() => SaveMoodEntryRequest._();
  @$core.override
  SaveMoodEntryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SaveMoodEntryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SaveMoodEntryRequest>(create);
  static SaveMoodEntryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get moodScore => $_getIZ(0);
  @$pb.TagNumber(1)
  set moodScore($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMoodScore() => $_has(0);
  @$pb.TagNumber(1)
  void clearMoodScore() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get moodLabel => $_getSZ(1);
  @$pb.TagNumber(2)
  set moodLabel($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMoodLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearMoodLabel() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get note => $_getSZ(2);
  @$pb.TagNumber(3)
  set note($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearNote() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get entryDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set entryDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEntryDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEntryDate() => $_clearField(4);
}

class SaveAffirmationRequest extends $pb.GeneratedMessage {
  factory SaveAffirmationRequest({
    $core.String? text,
    $core.String? backgroundColor,
    $core.String? iconName,
    $core.Iterable<$core.String>? words,
    $core.int? difficulty,
    $core.String? category,
  }) {
    final result = create();
    if (text != null) result.text = text;
    if (backgroundColor != null) result.backgroundColor = backgroundColor;
    if (iconName != null) result.iconName = iconName;
    if (words != null) result.words.addAll(words);
    if (difficulty != null) result.difficulty = difficulty;
    if (category != null) result.category = category;
    return result;
  }

  SaveAffirmationRequest._();

  factory SaveAffirmationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SaveAffirmationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SaveAffirmationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..aOS(2, _omitFieldNames ? '' : 'backgroundColor')
    ..aOS(3, _omitFieldNames ? '' : 'iconName')
    ..pPS(4, _omitFieldNames ? '' : 'words')
    ..aI(5, _omitFieldNames ? '' : 'difficulty')
    ..aOS(6, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveAffirmationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveAffirmationRequest copyWith(
          void Function(SaveAffirmationRequest) updates) =>
      super.copyWith((message) => updates(message as SaveAffirmationRequest))
          as SaveAffirmationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SaveAffirmationRequest create() => SaveAffirmationRequest._();
  @$core.override
  SaveAffirmationRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SaveAffirmationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SaveAffirmationRequest>(create);
  static SaveAffirmationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get backgroundColor => $_getSZ(1);
  @$pb.TagNumber(2)
  set backgroundColor($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBackgroundColor() => $_has(1);
  @$pb.TagNumber(2)
  void clearBackgroundColor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get iconName => $_getSZ(2);
  @$pb.TagNumber(3)
  set iconName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIconName() => $_has(2);
  @$pb.TagNumber(3)
  void clearIconName() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get words => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get difficulty => $_getIZ(4);
  @$pb.TagNumber(5)
  set difficulty($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDifficulty() => $_has(4);
  @$pb.TagNumber(5)
  void clearDifficulty() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => $_clearField(6);
}

class GetUserGamesProgressRequest extends $pb.GeneratedMessage {
  factory GetUserGamesProgressRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetUserGamesProgressRequest._();

  factory GetUserGamesProgressRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserGamesProgressRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserGamesProgressRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserGamesProgressRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserGamesProgressRequest copyWith(
          void Function(GetUserGamesProgressRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserGamesProgressRequest))
          as GetUserGamesProgressRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserGamesProgressRequest create() =>
      GetUserGamesProgressRequest._();
  @$core.override
  GetUserGamesProgressRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetUserGamesProgressRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserGamesProgressRequest>(create);
  static GetUserGamesProgressRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class ListMoodEntriesRequest extends $pb.GeneratedMessage {
  factory ListMoodEntriesRequest({
    $core.String? userId,
    $core.String? fromDate,
    $core.String? toDate,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (fromDate != null) result.fromDate = fromDate;
    if (toDate != null) result.toDate = toDate;
    return result;
  }

  ListMoodEntriesRequest._();

  factory ListMoodEntriesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMoodEntriesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMoodEntriesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'fromDate')
    ..aOS(3, _omitFieldNames ? '' : 'toDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMoodEntriesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMoodEntriesRequest copyWith(
          void Function(ListMoodEntriesRequest) updates) =>
      super.copyWith((message) => updates(message as ListMoodEntriesRequest))
          as ListMoodEntriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMoodEntriesRequest create() => ListMoodEntriesRequest._();
  @$core.override
  ListMoodEntriesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListMoodEntriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMoodEntriesRequest>(create);
  static ListMoodEntriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromDate($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFromDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromDate() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get toDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set toDate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearToDate() => $_clearField(3);
}

class ListMoodEntriesResponse extends $pb.GeneratedMessage {
  factory ListMoodEntriesResponse({
    $core.Iterable<MoodEntry>? entries,
  }) {
    final result = create();
    if (entries != null) result.entries.addAll(entries);
    return result;
  }

  ListMoodEntriesResponse._();

  factory ListMoodEntriesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListMoodEntriesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMoodEntriesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..pPM<MoodEntry>(1, _omitFieldNames ? '' : 'entries',
        subBuilder: MoodEntry.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMoodEntriesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMoodEntriesResponse copyWith(
          void Function(ListMoodEntriesResponse) updates) =>
      super.copyWith((message) => updates(message as ListMoodEntriesResponse))
          as ListMoodEntriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMoodEntriesResponse create() => ListMoodEntriesResponse._();
  @$core.override
  ListMoodEntriesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListMoodEntriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMoodEntriesResponse>(create);
  static ListMoodEntriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MoodEntry> get entries => $_getList(0);
}

class ListUserAchievementsRequest extends $pb.GeneratedMessage {
  factory ListUserAchievementsRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  ListUserAchievementsRequest._();

  factory ListUserAchievementsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUserAchievementsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUserAchievementsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserAchievementsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserAchievementsRequest copyWith(
          void Function(ListUserAchievementsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListUserAchievementsRequest))
          as ListUserAchievementsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUserAchievementsRequest create() =>
      ListUserAchievementsRequest._();
  @$core.override
  ListUserAchievementsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListUserAchievementsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUserAchievementsRequest>(create);
  static ListUserAchievementsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class ListUserAchievementsResponse extends $pb.GeneratedMessage {
  factory ListUserAchievementsResponse({
    $core.Iterable<UserAchievement>? achievements,
  }) {
    final result = create();
    if (achievements != null) result.achievements.addAll(achievements);
    return result;
  }

  ListUserAchievementsResponse._();

  factory ListUserAchievementsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUserAchievementsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUserAchievementsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..pPM<UserAchievement>(1, _omitFieldNames ? '' : 'achievements',
        subBuilder: UserAchievement.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserAchievementsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUserAchievementsResponse copyWith(
          void Function(ListUserAchievementsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListUserAchievementsResponse))
          as ListUserAchievementsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUserAchievementsResponse create() =>
      ListUserAchievementsResponse._();
  @$core.override
  ListUserAchievementsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListUserAchievementsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUserAchievementsResponse>(create);
  static ListUserAchievementsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UserAchievement> get achievements => $_getList(0);
}

class ListAffirmationsRequest extends $pb.GeneratedMessage {
  factory ListAffirmationsRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  ListAffirmationsRequest._();

  factory ListAffirmationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAffirmationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAffirmationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAffirmationsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAffirmationsRequest copyWith(
          void Function(ListAffirmationsRequest) updates) =>
      super.copyWith((message) => updates(message as ListAffirmationsRequest))
          as ListAffirmationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAffirmationsRequest create() => ListAffirmationsRequest._();
  @$core.override
  ListAffirmationsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListAffirmationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAffirmationsRequest>(create);
  static ListAffirmationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class ListAffirmationsResponse extends $pb.GeneratedMessage {
  factory ListAffirmationsResponse({
    $core.Iterable<Affirmation>? affirmations,
  }) {
    final result = create();
    if (affirmations != null) result.affirmations.addAll(affirmations);
    return result;
  }

  ListAffirmationsResponse._();

  factory ListAffirmationsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAffirmationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAffirmationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..pPM<Affirmation>(1, _omitFieldNames ? '' : 'affirmations',
        subBuilder: Affirmation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAffirmationsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAffirmationsResponse copyWith(
          void Function(ListAffirmationsResponse) updates) =>
      super.copyWith((message) => updates(message as ListAffirmationsResponse))
          as ListAffirmationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAffirmationsResponse create() => ListAffirmationsResponse._();
  @$core.override
  ListAffirmationsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListAffirmationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAffirmationsResponse>(create);
  static ListAffirmationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Affirmation> get affirmations => $_getList(0);
}

class DeleteAffirmationRequest extends $pb.GeneratedMessage {
  factory DeleteAffirmationRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteAffirmationRequest._();

  factory DeleteAffirmationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteAffirmationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteAffirmationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.games'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAffirmationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAffirmationRequest copyWith(
          void Function(DeleteAffirmationRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteAffirmationRequest))
          as DeleteAffirmationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAffirmationRequest create() => DeleteAffirmationRequest._();
  @$core.override
  DeleteAffirmationRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteAffirmationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteAffirmationRequest>(create);
  static DeleteAffirmationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GamesServiceApi {
  final $pb.RpcClient _client;

  GamesServiceApi(this._client);

  $async.Future<GameSession> saveGameSession(
          $pb.ClientContext? ctx, SaveGameSessionRequest request) =>
      _client.invoke<GameSession>(
          ctx, 'GamesService', 'SaveGameSession', request, GameSession());
  $async.Future<MoodEntry> saveMoodEntry(
          $pb.ClientContext? ctx, SaveMoodEntryRequest request) =>
      _client.invoke<MoodEntry>(
          ctx, 'GamesService', 'SaveMoodEntry', request, MoodEntry());
  $async.Future<ListMoodEntriesResponse> listMoodEntries(
          $pb.ClientContext? ctx, ListMoodEntriesRequest request) =>
      _client.invoke<ListMoodEntriesResponse>(ctx, 'GamesService',
          'ListMoodEntries', request, ListMoodEntriesResponse());
  $async.Future<ListUserAchievementsResponse> listUserAchievements(
          $pb.ClientContext? ctx, ListUserAchievementsRequest request) =>
      _client.invoke<ListUserAchievementsResponse>(ctx, 'GamesService',
          'ListUserAchievements', request, ListUserAchievementsResponse());
  $async.Future<Affirmation> saveAffirmation(
          $pb.ClientContext? ctx, SaveAffirmationRequest request) =>
      _client.invoke<Affirmation>(
          ctx, 'GamesService', 'SaveAffirmation', request, Affirmation());
  $async.Future<ListAffirmationsResponse> listAffirmations(
          $pb.ClientContext? ctx, ListAffirmationsRequest request) =>
      _client.invoke<ListAffirmationsResponse>(ctx, 'GamesService',
          'ListAffirmations', request, ListAffirmationsResponse());
  $async.Future<$0.Empty> deleteAffirmation(
          $pb.ClientContext? ctx, DeleteAffirmationRequest request) =>
      _client.invoke<$0.Empty>(
          ctx, 'GamesService', 'DeleteAffirmation', request, $0.Empty());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
