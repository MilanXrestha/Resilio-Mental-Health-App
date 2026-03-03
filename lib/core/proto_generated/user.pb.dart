// This is a generated file - do not edit.
//
// Generated from user.proto.

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

/// User entity
class User extends $pb.GeneratedMessage {
  factory User({
    $core.String? id,
    $core.String? firebaseUid,
    $core.String? email,
    $core.String? username,
    $core.String? displayName,
    $core.String? photoUrl,
    $core.String? phoneNumber,
    $core.String? dateOfBirth,
    $core.String? gender,
    $core.String? userRole,
    $core.String? accountStatus,
    $core.bool? preferencesCompleted,
    $core.String? fcmToken,
    $core.String? timezone,
    $core.String? language,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? lastLoginAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (firebaseUid != null) result.firebaseUid = firebaseUid;
    if (email != null) result.email = email;
    if (username != null) result.username = username;
    if (displayName != null) result.displayName = displayName;
    if (photoUrl != null) result.photoUrl = photoUrl;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (gender != null) result.gender = gender;
    if (userRole != null) result.userRole = userRole;
    if (accountStatus != null) result.accountStatus = accountStatus;
    if (preferencesCompleted != null)
      result.preferencesCompleted = preferencesCompleted;
    if (fcmToken != null) result.fcmToken = fcmToken;
    if (timezone != null) result.timezone = timezone;
    if (language != null) result.language = language;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (lastLoginAt != null) result.lastLoginAt = lastLoginAt;
    return result;
  }

  User._();

  factory User.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory User.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'User',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'firebaseUid')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOS(4, _omitFieldNames ? '' : 'username')
    ..aOS(5, _omitFieldNames ? '' : 'displayName')
    ..aOS(6, _omitFieldNames ? '' : 'photoUrl')
    ..aOS(7, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(8, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(9, _omitFieldNames ? '' : 'gender')
    ..aOS(10, _omitFieldNames ? '' : 'userRole')
    ..aOS(11, _omitFieldNames ? '' : 'accountStatus')
    ..aOB(12, _omitFieldNames ? '' : 'preferencesCompleted')
    ..aOS(13, _omitFieldNames ? '' : 'fcmToken')
    ..aOS(14, _omitFieldNames ? '' : 'timezone')
    ..aOS(15, _omitFieldNames ? '' : 'language')
    ..aOS(16, _omitFieldNames ? '' : 'createdAt')
    ..aOS(17, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(18, _omitFieldNames ? '' : 'lastLoginAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User copyWith(void Function(User) updates) =>
      super.copyWith((message) => updates(message as User)) as User;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  @$core.override
  User createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static User getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get firebaseUid => $_getSZ(1);
  @$pb.TagNumber(2)
  set firebaseUid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFirebaseUid() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirebaseUid() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get username => $_getSZ(3);
  @$pb.TagNumber(4)
  set username($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsername() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get displayName => $_getSZ(4);
  @$pb.TagNumber(5)
  set displayName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDisplayName() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisplayName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get photoUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set photoUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPhotoUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhotoUrl() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get phoneNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set phoneNumber($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPhoneNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoneNumber() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get dateOfBirth => $_getSZ(7);
  @$pb.TagNumber(8)
  set dateOfBirth($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDateOfBirth() => $_has(7);
  @$pb.TagNumber(8)
  void clearDateOfBirth() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get gender => $_getSZ(8);
  @$pb.TagNumber(9)
  set gender($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasGender() => $_has(8);
  @$pb.TagNumber(9)
  void clearGender() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get userRole => $_getSZ(9);
  @$pb.TagNumber(10)
  set userRole($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasUserRole() => $_has(9);
  @$pb.TagNumber(10)
  void clearUserRole() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get accountStatus => $_getSZ(10);
  @$pb.TagNumber(11)
  set accountStatus($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAccountStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearAccountStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get preferencesCompleted => $_getBF(11);
  @$pb.TagNumber(12)
  set preferencesCompleted($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasPreferencesCompleted() => $_has(11);
  @$pb.TagNumber(12)
  void clearPreferencesCompleted() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get fcmToken => $_getSZ(12);
  @$pb.TagNumber(13)
  set fcmToken($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasFcmToken() => $_has(12);
  @$pb.TagNumber(13)
  void clearFcmToken() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get timezone => $_getSZ(13);
  @$pb.TagNumber(14)
  set timezone($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasTimezone() => $_has(13);
  @$pb.TagNumber(14)
  void clearTimezone() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get language => $_getSZ(14);
  @$pb.TagNumber(15)
  set language($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasLanguage() => $_has(14);
  @$pb.TagNumber(15)
  void clearLanguage() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get createdAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set createdAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get updatedAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set updatedAt($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasUpdatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearUpdatedAt() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get lastLoginAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set lastLoginAt($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasLastLoginAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearLastLoginAt() => $_clearField(18);
}

/// User preferences
class UserPreferences extends $pb.GeneratedMessage {
  factory UserPreferences({
    $core.String? id,
    $core.String? userId,
    $core.String? theme,
    $core.String? language,
    $core.bool? notificationEnabled,
    $core.String? dailyReminderTime,
    $core.int? weeklyReportDay,
    $core.String? privacyLevel,
    $core.bool? dataSharingEnabled,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (theme != null) result.theme = theme;
    if (language != null) result.language = language;
    if (notificationEnabled != null)
      result.notificationEnabled = notificationEnabled;
    if (dailyReminderTime != null) result.dailyReminderTime = dailyReminderTime;
    if (weeklyReportDay != null) result.weeklyReportDay = weeklyReportDay;
    if (privacyLevel != null) result.privacyLevel = privacyLevel;
    if (dataSharingEnabled != null)
      result.dataSharingEnabled = dataSharingEnabled;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  UserPreferences._();

  factory UserPreferences.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserPreferences.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserPreferences',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'theme')
    ..aOS(4, _omitFieldNames ? '' : 'language')
    ..aOB(5, _omitFieldNames ? '' : 'notificationEnabled')
    ..aOS(6, _omitFieldNames ? '' : 'dailyReminderTime')
    ..aI(7, _omitFieldNames ? '' : 'weeklyReportDay')
    ..aOS(8, _omitFieldNames ? '' : 'privacyLevel')
    ..aOB(9, _omitFieldNames ? '' : 'dataSharingEnabled')
    ..aOS(10, _omitFieldNames ? '' : 'createdAt')
    ..aOS(11, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPreferences clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserPreferences copyWith(void Function(UserPreferences) updates) =>
      super.copyWith((message) => updates(message as UserPreferences))
          as UserPreferences;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserPreferences create() => UserPreferences._();
  @$core.override
  UserPreferences createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserPreferences getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserPreferences>(create);
  static UserPreferences? _defaultInstance;

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
  $core.String get theme => $_getSZ(2);
  @$pb.TagNumber(3)
  set theme($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTheme() => $_has(2);
  @$pb.TagNumber(3)
  void clearTheme() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get language => $_getSZ(3);
  @$pb.TagNumber(4)
  set language($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLanguage() => $_has(3);
  @$pb.TagNumber(4)
  void clearLanguage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get notificationEnabled => $_getBF(4);
  @$pb.TagNumber(5)
  set notificationEnabled($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNotificationEnabled() => $_has(4);
  @$pb.TagNumber(5)
  void clearNotificationEnabled() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get dailyReminderTime => $_getSZ(5);
  @$pb.TagNumber(6)
  set dailyReminderTime($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDailyReminderTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearDailyReminderTime() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get weeklyReportDay => $_getIZ(6);
  @$pb.TagNumber(7)
  set weeklyReportDay($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasWeeklyReportDay() => $_has(6);
  @$pb.TagNumber(7)
  void clearWeeklyReportDay() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get privacyLevel => $_getSZ(7);
  @$pb.TagNumber(8)
  set privacyLevel($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPrivacyLevel() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrivacyLevel() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get dataSharingEnabled => $_getBF(8);
  @$pb.TagNumber(9)
  set dataSharingEnabled($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDataSharingEnabled() => $_has(8);
  @$pb.TagNumber(9)
  void clearDataSharingEnabled() => $_clearField(9);

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

class WellnessProfile extends $pb.GeneratedMessage {
  factory WellnessProfile({
    $core.String? id,
    $core.String? userId,
    $core.int? stressLevel,
    $core.int? sleepQuality,
    $core.int? moodAverage,
    $core.String? primaryConcern,
    $core.Iterable<$core.String>? goals,
    $core.Iterable<$core.String>? preferredActivities,
    $core.String? emergencyContactName,
    $core.String? emergencyContactPhone,
    $core.String? emergencyContactRelationship,
    $core.String? therapistId,
    $core.bool? onboardingCompleted,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (stressLevel != null) result.stressLevel = stressLevel;
    if (sleepQuality != null) result.sleepQuality = sleepQuality;
    if (moodAverage != null) result.moodAverage = moodAverage;
    if (primaryConcern != null) result.primaryConcern = primaryConcern;
    if (goals != null) result.goals.addAll(goals);
    if (preferredActivities != null)
      result.preferredActivities.addAll(preferredActivities);
    if (emergencyContactName != null)
      result.emergencyContactName = emergencyContactName;
    if (emergencyContactPhone != null)
      result.emergencyContactPhone = emergencyContactPhone;
    if (emergencyContactRelationship != null)
      result.emergencyContactRelationship = emergencyContactRelationship;
    if (therapistId != null) result.therapistId = therapistId;
    if (onboardingCompleted != null)
      result.onboardingCompleted = onboardingCompleted;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  WellnessProfile._();

  factory WellnessProfile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WellnessProfile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WellnessProfile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aI(3, _omitFieldNames ? '' : 'stressLevel')
    ..aI(4, _omitFieldNames ? '' : 'sleepQuality')
    ..aI(5, _omitFieldNames ? '' : 'moodAverage')
    ..aOS(6, _omitFieldNames ? '' : 'primaryConcern')
    ..pPS(7, _omitFieldNames ? '' : 'goals')
    ..pPS(8, _omitFieldNames ? '' : 'preferredActivities')
    ..aOS(9, _omitFieldNames ? '' : 'emergencyContactName')
    ..aOS(10, _omitFieldNames ? '' : 'emergencyContactPhone')
    ..aOS(11, _omitFieldNames ? '' : 'emergencyContactRelationship')
    ..aOS(12, _omitFieldNames ? '' : 'therapistId')
    ..aOB(13, _omitFieldNames ? '' : 'onboardingCompleted')
    ..aOS(14, _omitFieldNames ? '' : 'createdAt')
    ..aOS(15, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WellnessProfile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WellnessProfile copyWith(void Function(WellnessProfile) updates) =>
      super.copyWith((message) => updates(message as WellnessProfile))
          as WellnessProfile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WellnessProfile create() => WellnessProfile._();
  @$core.override
  WellnessProfile createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WellnessProfile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WellnessProfile>(create);
  static WellnessProfile? _defaultInstance;

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
  $core.int get stressLevel => $_getIZ(2);
  @$pb.TagNumber(3)
  set stressLevel($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStressLevel() => $_has(2);
  @$pb.TagNumber(3)
  void clearStressLevel() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get sleepQuality => $_getIZ(3);
  @$pb.TagNumber(4)
  set sleepQuality($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSleepQuality() => $_has(3);
  @$pb.TagNumber(4)
  void clearSleepQuality() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get moodAverage => $_getIZ(4);
  @$pb.TagNumber(5)
  set moodAverage($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMoodAverage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMoodAverage() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get primaryConcern => $_getSZ(5);
  @$pb.TagNumber(6)
  set primaryConcern($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPrimaryConcern() => $_has(5);
  @$pb.TagNumber(6)
  void clearPrimaryConcern() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get goals => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get preferredActivities => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get emergencyContactName => $_getSZ(8);
  @$pb.TagNumber(9)
  set emergencyContactName($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasEmergencyContactName() => $_has(8);
  @$pb.TagNumber(9)
  void clearEmergencyContactName() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get emergencyContactPhone => $_getSZ(9);
  @$pb.TagNumber(10)
  set emergencyContactPhone($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasEmergencyContactPhone() => $_has(9);
  @$pb.TagNumber(10)
  void clearEmergencyContactPhone() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get emergencyContactRelationship => $_getSZ(10);
  @$pb.TagNumber(11)
  set emergencyContactRelationship($core.String value) =>
      $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasEmergencyContactRelationship() => $_has(10);
  @$pb.TagNumber(11)
  void clearEmergencyContactRelationship() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get therapistId => $_getSZ(11);
  @$pb.TagNumber(12)
  set therapistId($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTherapistId() => $_has(11);
  @$pb.TagNumber(12)
  void clearTherapistId() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get onboardingCompleted => $_getBF(12);
  @$pb.TagNumber(13)
  set onboardingCompleted($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasOnboardingCompleted() => $_has(12);
  @$pb.TagNumber(13)
  void clearOnboardingCompleted() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get createdAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set createdAt($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get updatedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set updatedAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasUpdatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearUpdatedAt() => $_clearField(15);
}

/// Content Preference
class Preference extends $pb.GeneratedMessage {
  factory Preference({
    $core.String? id,
    $core.String? preferenceId,
    $core.String? preferenceName,
    $core.String? preferenceDescription,
    $core.String? preferenceIcon,
    $core.bool? isSvg,
    $core.int? sortOrder,
    $core.bool? isActive,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (preferenceId != null) result.preferenceId = preferenceId;
    if (preferenceName != null) result.preferenceName = preferenceName;
    if (preferenceDescription != null)
      result.preferenceDescription = preferenceDescription;
    if (preferenceIcon != null) result.preferenceIcon = preferenceIcon;
    if (isSvg != null) result.isSvg = isSvg;
    if (sortOrder != null) result.sortOrder = sortOrder;
    if (isActive != null) result.isActive = isActive;
    return result;
  }

  Preference._();

  factory Preference.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Preference.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Preference',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'preferenceId')
    ..aOS(3, _omitFieldNames ? '' : 'preferenceName')
    ..aOS(4, _omitFieldNames ? '' : 'preferenceDescription')
    ..aOS(5, _omitFieldNames ? '' : 'preferenceIcon')
    ..aOB(6, _omitFieldNames ? '' : 'isSvg')
    ..aI(7, _omitFieldNames ? '' : 'sortOrder')
    ..aOB(8, _omitFieldNames ? '' : 'isActive')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preference clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preference copyWith(void Function(Preference) updates) =>
      super.copyWith((message) => updates(message as Preference)) as Preference;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Preference create() => Preference._();
  @$core.override
  Preference createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Preference getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Preference>(create);
  static Preference? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get preferenceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set preferenceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPreferenceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreferenceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get preferenceName => $_getSZ(2);
  @$pb.TagNumber(3)
  set preferenceName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPreferenceName() => $_has(2);
  @$pb.TagNumber(3)
  void clearPreferenceName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get preferenceDescription => $_getSZ(3);
  @$pb.TagNumber(4)
  set preferenceDescription($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPreferenceDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearPreferenceDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get preferenceIcon => $_getSZ(4);
  @$pb.TagNumber(5)
  set preferenceIcon($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPreferenceIcon() => $_has(4);
  @$pb.TagNumber(5)
  void clearPreferenceIcon() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isSvg => $_getBF(5);
  @$pb.TagNumber(6)
  set isSvg($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsSvg() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsSvg() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get sortOrder => $_getIZ(6);
  @$pb.TagNumber(7)
  set sortOrder($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSortOrder() => $_has(6);
  @$pb.TagNumber(7)
  void clearSortOrder() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isActive => $_getBF(7);
  @$pb.TagNumber(8)
  set isActive($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIsActive() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsActive() => $_clearField(8);
}

class ListPreferencesResponse extends $pb.GeneratedMessage {
  factory ListPreferencesResponse({
    $core.Iterable<Preference>? preferences,
  }) {
    final result = create();
    if (preferences != null) result.preferences.addAll(preferences);
    return result;
  }

  ListPreferencesResponse._();

  factory ListPreferencesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPreferencesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPreferencesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..pPM<Preference>(1, _omitFieldNames ? '' : 'preferences',
        subBuilder: Preference.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPreferencesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPreferencesResponse copyWith(
          void Function(ListPreferencesResponse) updates) =>
      super.copyWith((message) => updates(message as ListPreferencesResponse))
          as ListPreferencesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPreferencesResponse create() => ListPreferencesResponse._();
  @$core.override
  ListPreferencesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListPreferencesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPreferencesResponse>(create);
  static ListPreferencesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Preference> get preferences => $_getList(0);
}

class SavePreferencesRequest extends $pb.GeneratedMessage {
  factory SavePreferencesRequest({
    $core.Iterable<$core.String>? preferenceIds,
  }) {
    final result = create();
    if (preferenceIds != null) result.preferenceIds.addAll(preferenceIds);
    return result;
  }

  SavePreferencesRequest._();

  factory SavePreferencesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SavePreferencesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SavePreferencesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'preferenceIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SavePreferencesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SavePreferencesRequest copyWith(
          void Function(SavePreferencesRequest) updates) =>
      super.copyWith((message) => updates(message as SavePreferencesRequest))
          as SavePreferencesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SavePreferencesRequest create() => SavePreferencesRequest._();
  @$core.override
  SavePreferencesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SavePreferencesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SavePreferencesRequest>(create);
  static SavePreferencesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get preferenceIds => $_getList(0);
}

class PreferenceCompletionStatus extends $pb.GeneratedMessage {
  factory PreferenceCompletionStatus({
    $core.bool? completed,
  }) {
    final result = create();
    if (completed != null) result.completed = completed;
    return result;
  }

  PreferenceCompletionStatus._();

  factory PreferenceCompletionStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PreferenceCompletionStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PreferenceCompletionStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'completed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PreferenceCompletionStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PreferenceCompletionStatus copyWith(
          void Function(PreferenceCompletionStatus) updates) =>
      super.copyWith(
              (message) => updates(message as PreferenceCompletionStatus))
          as PreferenceCompletionStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PreferenceCompletionStatus create() => PreferenceCompletionStatus._();
  @$core.override
  PreferenceCompletionStatus createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PreferenceCompletionStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PreferenceCompletionStatus>(create);
  static PreferenceCompletionStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get completed => $_getBF(0);
  @$pb.TagNumber(1)
  set completed($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCompleted() => $_has(0);
  @$pb.TagNumber(1)
  void clearCompleted() => $_clearField(1);
}

/// Create user request
class CreateUserRequest extends $pb.GeneratedMessage {
  factory CreateUserRequest({
    $core.String? firebaseUid,
    $core.String? email,
    $core.String? username,
    $core.String? displayName,
    $core.String? photoUrl,
    $core.String? fcmToken,
    $core.String? language,
  }) {
    final result = create();
    if (firebaseUid != null) result.firebaseUid = firebaseUid;
    if (email != null) result.email = email;
    if (username != null) result.username = username;
    if (displayName != null) result.displayName = displayName;
    if (photoUrl != null) result.photoUrl = photoUrl;
    if (fcmToken != null) result.fcmToken = fcmToken;
    if (language != null) result.language = language;
    return result;
  }

  CreateUserRequest._();

  factory CreateUserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'firebaseUid')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'username')
    ..aOS(4, _omitFieldNames ? '' : 'displayName')
    ..aOS(5, _omitFieldNames ? '' : 'photoUrl')
    ..aOS(6, _omitFieldNames ? '' : 'fcmToken')
    ..aOS(7, _omitFieldNames ? '' : 'language')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserRequest copyWith(void Function(CreateUserRequest) updates) =>
      super.copyWith((message) => updates(message as CreateUserRequest))
          as CreateUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserRequest create() => CreateUserRequest._();
  @$core.override
  CreateUserRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateUserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUserRequest>(create);
  static CreateUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firebaseUid => $_getSZ(0);
  @$pb.TagNumber(1)
  set firebaseUid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFirebaseUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirebaseUid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get username => $_getSZ(2);
  @$pb.TagNumber(3)
  set username($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsername() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get displayName => $_getSZ(3);
  @$pb.TagNumber(4)
  set displayName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDisplayName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get photoUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set photoUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhotoUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhotoUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get fcmToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set fcmToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFcmToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearFcmToken() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get language => $_getSZ(6);
  @$pb.TagNumber(7)
  set language($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLanguage() => $_has(6);
  @$pb.TagNumber(7)
  void clearLanguage() => $_clearField(7);
}

/// Create user response
class CreateUserResponse extends $pb.GeneratedMessage {
  factory CreateUserResponse({
    User? user,
    $core.bool? isNewUser,
  }) {
    final result = create();
    if (user != null) result.user = user;
    if (isNewUser != null) result.isNewUser = isNewUser;
    return result;
  }

  CreateUserResponse._();

  factory CreateUserResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateUserResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUserResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..aOB(2, _omitFieldNames ? '' : 'isNewUser')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserResponse copyWith(void Function(CreateUserResponse) updates) =>
      super.copyWith((message) => updates(message as CreateUserResponse))
          as CreateUserResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserResponse create() => CreateUserResponse._();
  @$core.override
  CreateUserResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateUserResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUserResponse>(create);
  static CreateUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get isNewUser => $_getBF(1);
  @$pb.TagNumber(2)
  set isNewUser($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsNewUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsNewUser() => $_clearField(2);
}

/// Get user request
class GetUserRequest extends $pb.GeneratedMessage {
  factory GetUserRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetUserRequest._();

  factory GetUserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserRequest copyWith(void Function(GetUserRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserRequest))
          as GetUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserRequest create() => GetUserRequest._();
  @$core.override
  GetUserRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetUserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserRequest>(create);
  static GetUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

/// Get user by Firebase UID request
class GetUserByFirebaseUidRequest extends $pb.GeneratedMessage {
  factory GetUserByFirebaseUidRequest({
    $core.String? firebaseUid,
  }) {
    final result = create();
    if (firebaseUid != null) result.firebaseUid = firebaseUid;
    return result;
  }

  GetUserByFirebaseUidRequest._();

  factory GetUserByFirebaseUidRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserByFirebaseUidRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserByFirebaseUidRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'firebaseUid')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserByFirebaseUidRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserByFirebaseUidRequest copyWith(
          void Function(GetUserByFirebaseUidRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetUserByFirebaseUidRequest))
          as GetUserByFirebaseUidRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserByFirebaseUidRequest create() =>
      GetUserByFirebaseUidRequest._();
  @$core.override
  GetUserByFirebaseUidRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetUserByFirebaseUidRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserByFirebaseUidRequest>(create);
  static GetUserByFirebaseUidRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firebaseUid => $_getSZ(0);
  @$pb.TagNumber(1)
  set firebaseUid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFirebaseUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirebaseUid() => $_clearField(1);
}

/// Update user request
class UpdateUserRequest extends $pb.GeneratedMessage {
  factory UpdateUserRequest({
    $core.String? id,
    $core.String? username,
    $core.String? displayName,
    $core.String? photoUrl,
    $core.String? phoneNumber,
    $core.String? dateOfBirth,
    $core.String? gender,
    $core.String? timezone,
    $core.String? language,
    $core.String? fcmToken,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (username != null) result.username = username;
    if (displayName != null) result.displayName = displayName;
    if (photoUrl != null) result.photoUrl = photoUrl;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (gender != null) result.gender = gender;
    if (timezone != null) result.timezone = timezone;
    if (language != null) result.language = language;
    if (fcmToken != null) result.fcmToken = fcmToken;
    return result;
  }

  UpdateUserRequest._();

  factory UpdateUserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'photoUrl')
    ..aOS(5, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(6, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(7, _omitFieldNames ? '' : 'gender')
    ..aOS(8, _omitFieldNames ? '' : 'timezone')
    ..aOS(9, _omitFieldNames ? '' : 'language')
    ..aOS(10, _omitFieldNames ? '' : 'fcmToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserRequest copyWith(void Function(UpdateUserRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateUserRequest))
          as UpdateUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserRequest create() => UpdateUserRequest._();
  @$core.override
  UpdateUserRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateUserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateUserRequest>(create);
  static UpdateUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get photoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set photoUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPhotoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhotoUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get phoneNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set phoneNumber($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhoneNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhoneNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get dateOfBirth => $_getSZ(5);
  @$pb.TagNumber(6)
  set dateOfBirth($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDateOfBirth() => $_has(5);
  @$pb.TagNumber(6)
  void clearDateOfBirth() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get gender => $_getSZ(6);
  @$pb.TagNumber(7)
  set gender($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasGender() => $_has(6);
  @$pb.TagNumber(7)
  void clearGender() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get timezone => $_getSZ(7);
  @$pb.TagNumber(8)
  set timezone($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTimezone() => $_has(7);
  @$pb.TagNumber(8)
  void clearTimezone() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get language => $_getSZ(8);
  @$pb.TagNumber(9)
  set language($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasLanguage() => $_has(8);
  @$pb.TagNumber(9)
  void clearLanguage() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get fcmToken => $_getSZ(9);
  @$pb.TagNumber(10)
  set fcmToken($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasFcmToken() => $_has(9);
  @$pb.TagNumber(10)
  void clearFcmToken() => $_clearField(10);
}

/// Update user preferences request
class UpdateUserPreferencesRequest extends $pb.GeneratedMessage {
  factory UpdateUserPreferencesRequest({
    $core.String? userId,
    $core.String? theme,
    $core.String? language,
    $core.bool? notificationEnabled,
    $core.String? dailyReminderTime,
    $core.int? weeklyReportDay,
    $core.String? privacyLevel,
    $core.bool? dataSharingEnabled,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (theme != null) result.theme = theme;
    if (language != null) result.language = language;
    if (notificationEnabled != null)
      result.notificationEnabled = notificationEnabled;
    if (dailyReminderTime != null) result.dailyReminderTime = dailyReminderTime;
    if (weeklyReportDay != null) result.weeklyReportDay = weeklyReportDay;
    if (privacyLevel != null) result.privacyLevel = privacyLevel;
    if (dataSharingEnabled != null)
      result.dataSharingEnabled = dataSharingEnabled;
    return result;
  }

  UpdateUserPreferencesRequest._();

  factory UpdateUserPreferencesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateUserPreferencesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateUserPreferencesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'theme')
    ..aOS(3, _omitFieldNames ? '' : 'language')
    ..aOB(4, _omitFieldNames ? '' : 'notificationEnabled')
    ..aOS(5, _omitFieldNames ? '' : 'dailyReminderTime')
    ..aI(6, _omitFieldNames ? '' : 'weeklyReportDay')
    ..aOS(7, _omitFieldNames ? '' : 'privacyLevel')
    ..aOB(8, _omitFieldNames ? '' : 'dataSharingEnabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserPreferencesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserPreferencesRequest copyWith(
          void Function(UpdateUserPreferencesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateUserPreferencesRequest))
          as UpdateUserPreferencesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserPreferencesRequest create() =>
      UpdateUserPreferencesRequest._();
  @$core.override
  UpdateUserPreferencesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateUserPreferencesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateUserPreferencesRequest>(create);
  static UpdateUserPreferencesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get theme => $_getSZ(1);
  @$pb.TagNumber(2)
  set theme($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTheme() => $_has(1);
  @$pb.TagNumber(2)
  void clearTheme() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get language => $_getSZ(2);
  @$pb.TagNumber(3)
  set language($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLanguage() => $_has(2);
  @$pb.TagNumber(3)
  void clearLanguage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get notificationEnabled => $_getBF(3);
  @$pb.TagNumber(4)
  set notificationEnabled($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNotificationEnabled() => $_has(3);
  @$pb.TagNumber(4)
  void clearNotificationEnabled() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get dailyReminderTime => $_getSZ(4);
  @$pb.TagNumber(5)
  set dailyReminderTime($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDailyReminderTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearDailyReminderTime() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get weeklyReportDay => $_getIZ(5);
  @$pb.TagNumber(6)
  set weeklyReportDay($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasWeeklyReportDay() => $_has(5);
  @$pb.TagNumber(6)
  void clearWeeklyReportDay() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get privacyLevel => $_getSZ(6);
  @$pb.TagNumber(7)
  set privacyLevel($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPrivacyLevel() => $_has(6);
  @$pb.TagNumber(7)
  void clearPrivacyLevel() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get dataSharingEnabled => $_getBF(7);
  @$pb.TagNumber(8)
  set dataSharingEnabled($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDataSharingEnabled() => $_has(7);
  @$pb.TagNumber(8)
  void clearDataSharingEnabled() => $_clearField(8);
}

/// Update wellness profile request
class UpdateWellnessProfileRequest extends $pb.GeneratedMessage {
  factory UpdateWellnessProfileRequest({
    $core.String? userId,
    $core.int? stressLevel,
    $core.int? sleepQuality,
    $core.int? moodAverage,
    $core.String? primaryConcern,
    $core.Iterable<$core.String>? goals,
    $core.Iterable<$core.String>? preferredActivities,
    $core.String? emergencyContactName,
    $core.String? emergencyContactPhone,
    $core.String? emergencyContactRelationship,
    $core.bool? onboardingCompleted,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (stressLevel != null) result.stressLevel = stressLevel;
    if (sleepQuality != null) result.sleepQuality = sleepQuality;
    if (moodAverage != null) result.moodAverage = moodAverage;
    if (primaryConcern != null) result.primaryConcern = primaryConcern;
    if (goals != null) result.goals.addAll(goals);
    if (preferredActivities != null)
      result.preferredActivities.addAll(preferredActivities);
    if (emergencyContactName != null)
      result.emergencyContactName = emergencyContactName;
    if (emergencyContactPhone != null)
      result.emergencyContactPhone = emergencyContactPhone;
    if (emergencyContactRelationship != null)
      result.emergencyContactRelationship = emergencyContactRelationship;
    if (onboardingCompleted != null)
      result.onboardingCompleted = onboardingCompleted;
    return result;
  }

  UpdateWellnessProfileRequest._();

  factory UpdateWellnessProfileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateWellnessProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateWellnessProfileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aI(2, _omitFieldNames ? '' : 'stressLevel')
    ..aI(3, _omitFieldNames ? '' : 'sleepQuality')
    ..aI(4, _omitFieldNames ? '' : 'moodAverage')
    ..aOS(5, _omitFieldNames ? '' : 'primaryConcern')
    ..pPS(6, _omitFieldNames ? '' : 'goals')
    ..pPS(7, _omitFieldNames ? '' : 'preferredActivities')
    ..aOS(8, _omitFieldNames ? '' : 'emergencyContactName')
    ..aOS(9, _omitFieldNames ? '' : 'emergencyContactPhone')
    ..aOS(10, _omitFieldNames ? '' : 'emergencyContactRelationship')
    ..aOB(11, _omitFieldNames ? '' : 'onboardingCompleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateWellnessProfileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateWellnessProfileRequest copyWith(
          void Function(UpdateWellnessProfileRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateWellnessProfileRequest))
          as UpdateWellnessProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateWellnessProfileRequest create() =>
      UpdateWellnessProfileRequest._();
  @$core.override
  UpdateWellnessProfileRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateWellnessProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateWellnessProfileRequest>(create);
  static UpdateWellnessProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get stressLevel => $_getIZ(1);
  @$pb.TagNumber(2)
  set stressLevel($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStressLevel() => $_has(1);
  @$pb.TagNumber(2)
  void clearStressLevel() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get sleepQuality => $_getIZ(2);
  @$pb.TagNumber(3)
  set sleepQuality($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSleepQuality() => $_has(2);
  @$pb.TagNumber(3)
  void clearSleepQuality() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get moodAverage => $_getIZ(3);
  @$pb.TagNumber(4)
  set moodAverage($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMoodAverage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMoodAverage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get primaryConcern => $_getSZ(4);
  @$pb.TagNumber(5)
  set primaryConcern($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPrimaryConcern() => $_has(4);
  @$pb.TagNumber(5)
  void clearPrimaryConcern() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get goals => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get preferredActivities => $_getList(6);

  @$pb.TagNumber(8)
  $core.String get emergencyContactName => $_getSZ(7);
  @$pb.TagNumber(8)
  set emergencyContactName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasEmergencyContactName() => $_has(7);
  @$pb.TagNumber(8)
  void clearEmergencyContactName() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get emergencyContactPhone => $_getSZ(8);
  @$pb.TagNumber(9)
  set emergencyContactPhone($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasEmergencyContactPhone() => $_has(8);
  @$pb.TagNumber(9)
  void clearEmergencyContactPhone() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get emergencyContactRelationship => $_getSZ(9);
  @$pb.TagNumber(10)
  set emergencyContactRelationship($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasEmergencyContactRelationship() => $_has(9);
  @$pb.TagNumber(10)
  void clearEmergencyContactRelationship() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get onboardingCompleted => $_getBF(10);
  @$pb.TagNumber(11)
  set onboardingCompleted($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasOnboardingCompleted() => $_has(10);
  @$pb.TagNumber(11)
  void clearOnboardingCompleted() => $_clearField(11);
}

/// List users request
class ListUsersRequest extends $pb.GeneratedMessage {
  factory ListUsersRequest({
    $0.PaginationRequest? pagination,
    $core.String? searchQuery,
    $core.String? role,
    $core.String? status,
  }) {
    final result = create();
    if (pagination != null) result.pagination = pagination;
    if (searchQuery != null) result.searchQuery = searchQuery;
    if (role != null) result.role = role;
    if (status != null) result.status = status;
    return result;
  }

  ListUsersRequest._();

  factory ListUsersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUsersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUsersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOM<$0.PaginationRequest>(1, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationRequest.create)
    ..aOS(2, _omitFieldNames ? '' : 'searchQuery')
    ..aOS(3, _omitFieldNames ? '' : 'role')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUsersRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUsersRequest copyWith(void Function(ListUsersRequest) updates) =>
      super.copyWith((message) => updates(message as ListUsersRequest))
          as ListUsersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUsersRequest create() => ListUsersRequest._();
  @$core.override
  ListUsersRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListUsersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUsersRequest>(create);
  static ListUsersRequest? _defaultInstance;

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
  $core.String get searchQuery => $_getSZ(1);
  @$pb.TagNumber(2)
  set searchQuery($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSearchQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearSearchQuery() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get role => $_getSZ(2);
  @$pb.TagNumber(3)
  set role($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);
}

/// List users response
class ListUsersResponse extends $pb.GeneratedMessage {
  factory ListUsersResponse({
    $core.Iterable<User>? users,
    $0.PaginationResponse? pagination,
  }) {
    final result = create();
    if (users != null) result.users.addAll(users);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListUsersResponse._();

  factory ListUsersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListUsersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListUsersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..pPM<User>(1, _omitFieldNames ? '' : 'users', subBuilder: User.create)
    ..aOM<$0.PaginationResponse>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUsersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListUsersResponse copyWith(void Function(ListUsersResponse) updates) =>
      super.copyWith((message) => updates(message as ListUsersResponse))
          as ListUsersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUsersResponse create() => ListUsersResponse._();
  @$core.override
  ListUsersResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListUsersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListUsersResponse>(create);
  static ListUsersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<User> get users => $_getList(0);

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

/// Delete user request
class DeleteUserRequest extends $pb.GeneratedMessage {
  factory DeleteUserRequest({
    $core.String? id,
    $core.bool? softDelete,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (softDelete != null) result.softDelete = softDelete;
    return result;
  }

  DeleteUserRequest._();

  factory DeleteUserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOB(2, _omitFieldNames ? '' : 'softDelete')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteUserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteUserRequest copyWith(void Function(DeleteUserRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteUserRequest))
          as DeleteUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteUserRequest create() => DeleteUserRequest._();
  @$core.override
  DeleteUserRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteUserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteUserRequest>(create);
  static DeleteUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get softDelete => $_getBF(1);
  @$pb.TagNumber(2)
  set softDelete($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSoftDelete() => $_has(1);
  @$pb.TagNumber(2)
  void clearSoftDelete() => $_clearField(2);
}

/// Sync user from Firebase request
class SyncUserRequest extends $pb.GeneratedMessage {
  factory SyncUserRequest({
    $core.String? firebaseUid,
    $core.String? email,
    $core.String? displayName,
    $core.String? photoUrl,
  }) {
    final result = create();
    if (firebaseUid != null) result.firebaseUid = firebaseUid;
    if (email != null) result.email = email;
    if (displayName != null) result.displayName = displayName;
    if (photoUrl != null) result.photoUrl = photoUrl;
    return result;
  }

  SyncUserRequest._();

  factory SyncUserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'resilio.user'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'firebaseUid')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'photoUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncUserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncUserRequest copyWith(void Function(SyncUserRequest) updates) =>
      super.copyWith((message) => updates(message as SyncUserRequest))
          as SyncUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncUserRequest create() => SyncUserRequest._();
  @$core.override
  SyncUserRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SyncUserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncUserRequest>(create);
  static SyncUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firebaseUid => $_getSZ(0);
  @$pb.TagNumber(1)
  set firebaseUid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFirebaseUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirebaseUid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get photoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set photoUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPhotoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhotoUrl() => $_clearField(4);
}

/// User service definition
class UserServiceApi {
  final $pb.RpcClient _client;

  UserServiceApi(this._client);

  /// Create a new user
  $async.Future<CreateUserResponse> createUser(
          $pb.ClientContext? ctx, CreateUserRequest request) =>
      _client.invoke<CreateUserResponse>(
          ctx, 'UserService', 'CreateUser', request, CreateUserResponse());

  /// Get user by ID
  $async.Future<User> getUser($pb.ClientContext? ctx, GetUserRequest request) =>
      _client.invoke<User>(ctx, 'UserService', 'GetUser', request, User());

  /// Get user by Firebase UID
  $async.Future<User> getUserByFirebaseUid(
          $pb.ClientContext? ctx, GetUserByFirebaseUidRequest request) =>
      _client.invoke<User>(
          ctx, 'UserService', 'GetUserByFirebaseUid', request, User());

  /// Update user profile
  $async.Future<User> updateUser(
          $pb.ClientContext? ctx, UpdateUserRequest request) =>
      _client.invoke<User>(ctx, 'UserService', 'UpdateUser', request, User());

  /// Delete user
  $async.Future<$0.Empty> deleteUser(
          $pb.ClientContext? ctx, DeleteUserRequest request) =>
      _client.invoke<$0.Empty>(
          ctx, 'UserService', 'DeleteUser', request, $0.Empty());

  /// List users (admin only)
  $async.Future<ListUsersResponse> listUsers(
          $pb.ClientContext? ctx, ListUsersRequest request) =>
      _client.invoke<ListUsersResponse>(
          ctx, 'UserService', 'ListUsers', request, ListUsersResponse());

  /// Sync user from Firebase
  $async.Future<User> syncUser(
          $pb.ClientContext? ctx, SyncUserRequest request) =>
      _client.invoke<User>(ctx, 'UserService', 'SyncUser', request, User());

  /// Get user preferences
  $async.Future<UserPreferences> getUserPreferences(
          $pb.ClientContext? ctx, GetUserRequest request) =>
      _client.invoke<UserPreferences>(
          ctx, 'UserService', 'GetUserPreferences', request, UserPreferences());

  /// Update user preferences
  $async.Future<UserPreferences> updateUserPreferences(
          $pb.ClientContext? ctx, UpdateUserPreferencesRequest request) =>
      _client.invoke<UserPreferences>(ctx, 'UserService',
          'UpdateUserPreferences', request, UserPreferences());

  /// Get wellness profile
  $async.Future<WellnessProfile> getWellnessProfile(
          $pb.ClientContext? ctx, GetUserRequest request) =>
      _client.invoke<WellnessProfile>(
          ctx, 'UserService', 'GetWellnessProfile', request, WellnessProfile());

  /// Update wellness profile
  $async.Future<WellnessProfile> updateWellnessProfile(
          $pb.ClientContext? ctx, UpdateWellnessProfileRequest request) =>
      _client.invoke<WellnessProfile>(ctx, 'UserService',
          'UpdateWellnessProfile', request, WellnessProfile());

  /// Get all available content preferences
  $async.Future<ListPreferencesResponse> getPreferences(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<ListPreferencesResponse>(ctx, 'UserService',
          'GetPreferences', request, ListPreferencesResponse());

  /// Get user's selected preferences
  $async.Future<ListPreferencesResponse> getUserSelectedPreferences(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<ListPreferencesResponse>(ctx, 'UserService',
          'GetUserSelectedPreferences', request, ListPreferencesResponse());

  /// Save user's selected preferences
  $async.Future<ListPreferencesResponse> saveUserPreferences(
          $pb.ClientContext? ctx, SavePreferencesRequest request) =>
      _client.invoke<ListPreferencesResponse>(ctx, 'UserService',
          'SaveUserPreferences', request, ListPreferencesResponse());

  /// Check if user has completed preferences
  $async.Future<PreferenceCompletionStatus> checkPreferencesCompletion(
          $pb.ClientContext? ctx, $0.Empty request) =>
      _client.invoke<PreferenceCompletionStatus>(ctx, 'UserService',
          'CheckPreferencesCompletion', request, PreferenceCompletionStatus());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
