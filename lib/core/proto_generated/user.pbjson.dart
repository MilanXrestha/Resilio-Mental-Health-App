// This is a generated file - do not edit.
//
// Generated from user.proto.

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

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'firebase_uid', '3': 2, '4': 1, '5': 9, '10': 'firebaseUid'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    {'1': 'display_name', '3': 5, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'photo_url', '3': 6, '4': 1, '5': 9, '10': 'photoUrl'},
    {'1': 'phone_number', '3': 7, '4': 1, '5': 9, '10': 'phoneNumber'},
    {'1': 'date_of_birth', '3': 8, '4': 1, '5': 9, '10': 'dateOfBirth'},
    {'1': 'gender', '3': 9, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'user_role', '3': 10, '4': 1, '5': 9, '10': 'userRole'},
    {'1': 'account_status', '3': 11, '4': 1, '5': 9, '10': 'accountStatus'},
    {
      '1': 'preferences_completed',
      '3': 12,
      '4': 1,
      '5': 8,
      '10': 'preferencesCompleted'
    },
    {'1': 'fcm_token', '3': 13, '4': 1, '5': 9, '10': 'fcmToken'},
    {'1': 'timezone', '3': 14, '4': 1, '5': 9, '10': 'timezone'},
    {'1': 'language', '3': 15, '4': 1, '5': 9, '10': 'language'},
    {'1': 'created_at', '3': 16, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 17, '4': 1, '5': 9, '10': 'updatedAt'},
    {'1': 'last_login_at', '3': 18, '4': 1, '5': 9, '10': 'lastLoginAt'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBIhCgxmaXJlYmFzZV91aWQYAiABKAlSC2ZpcmViYXNlVW'
    'lkEhQKBWVtYWlsGAMgASgJUgVlbWFpbBIaCgh1c2VybmFtZRgEIAEoCVIIdXNlcm5hbWUSIQoM'
    'ZGlzcGxheV9uYW1lGAUgASgJUgtkaXNwbGF5TmFtZRIbCglwaG90b191cmwYBiABKAlSCHBob3'
    'RvVXJsEiEKDHBob25lX251bWJlchgHIAEoCVILcGhvbmVOdW1iZXISIgoNZGF0ZV9vZl9iaXJ0'
    'aBgIIAEoCVILZGF0ZU9mQmlydGgSFgoGZ2VuZGVyGAkgASgJUgZnZW5kZXISGwoJdXNlcl9yb2'
    'xlGAogASgJUgh1c2VyUm9sZRIlCg5hY2NvdW50X3N0YXR1cxgLIAEoCVINYWNjb3VudFN0YXR1'
    'cxIzChVwcmVmZXJlbmNlc19jb21wbGV0ZWQYDCABKAhSFHByZWZlcmVuY2VzQ29tcGxldGVkEh'
    'sKCWZjbV90b2tlbhgNIAEoCVIIZmNtVG9rZW4SGgoIdGltZXpvbmUYDiABKAlSCHRpbWV6b25l'
    'EhoKCGxhbmd1YWdlGA8gASgJUghsYW5ndWFnZRIdCgpjcmVhdGVkX2F0GBAgASgJUgljcmVhdG'
    'VkQXQSHQoKdXBkYXRlZF9hdBgRIAEoCVIJdXBkYXRlZEF0EiIKDWxhc3RfbG9naW5fYXQYEiAB'
    'KAlSC2xhc3RMb2dpbkF0');

@$core.Deprecated('Use userPreferencesDescriptor instead')
const UserPreferences$json = {
  '1': 'UserPreferences',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'theme', '3': 3, '4': 1, '5': 9, '10': 'theme'},
    {'1': 'language', '3': 4, '4': 1, '5': 9, '10': 'language'},
    {
      '1': 'notification_enabled',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'notificationEnabled'
    },
    {
      '1': 'daily_reminder_time',
      '3': 6,
      '4': 1,
      '5': 9,
      '10': 'dailyReminderTime'
    },
    {'1': 'weekly_report_day', '3': 7, '4': 1, '5': 5, '10': 'weeklyReportDay'},
    {'1': 'privacy_level', '3': 8, '4': 1, '5': 9, '10': 'privacyLevel'},
    {
      '1': 'data_sharing_enabled',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'dataSharingEnabled'
    },
    {'1': 'created_at', '3': 10, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 11, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `UserPreferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userPreferencesDescriptor = $convert.base64Decode(
    'Cg9Vc2VyUHJlZmVyZW5jZXMSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZX'
    'JJZBIUCgV0aGVtZRgDIAEoCVIFdGhlbWUSGgoIbGFuZ3VhZ2UYBCABKAlSCGxhbmd1YWdlEjEK'
    'FG5vdGlmaWNhdGlvbl9lbmFibGVkGAUgASgIUhNub3RpZmljYXRpb25FbmFibGVkEi4KE2RhaW'
    'x5X3JlbWluZGVyX3RpbWUYBiABKAlSEWRhaWx5UmVtaW5kZXJUaW1lEioKEXdlZWtseV9yZXBv'
    'cnRfZGF5GAcgASgFUg93ZWVrbHlSZXBvcnREYXkSIwoNcHJpdmFjeV9sZXZlbBgIIAEoCVIMcH'
    'JpdmFjeUxldmVsEjAKFGRhdGFfc2hhcmluZ19lbmFibGVkGAkgASgIUhJkYXRhU2hhcmluZ0Vu'
    'YWJsZWQSHQoKY3JlYXRlZF9hdBgKIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYCyABKA'
    'lSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use wellnessProfileDescriptor instead')
const WellnessProfile$json = {
  '1': 'WellnessProfile',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'stress_level', '3': 3, '4': 1, '5': 5, '10': 'stressLevel'},
    {'1': 'sleep_quality', '3': 4, '4': 1, '5': 5, '10': 'sleepQuality'},
    {'1': 'mood_average', '3': 5, '4': 1, '5': 5, '10': 'moodAverage'},
    {'1': 'primary_concern', '3': 6, '4': 1, '5': 9, '10': 'primaryConcern'},
    {'1': 'goals', '3': 7, '4': 3, '5': 9, '10': 'goals'},
    {
      '1': 'preferred_activities',
      '3': 8,
      '4': 3,
      '5': 9,
      '10': 'preferredActivities'
    },
    {
      '1': 'emergency_contact_name',
      '3': 9,
      '4': 1,
      '5': 9,
      '10': 'emergencyContactName'
    },
    {
      '1': 'emergency_contact_phone',
      '3': 10,
      '4': 1,
      '5': 9,
      '10': 'emergencyContactPhone'
    },
    {
      '1': 'emergency_contact_relationship',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'emergencyContactRelationship'
    },
    {'1': 'therapist_id', '3': 12, '4': 1, '5': 9, '10': 'therapistId'},
    {
      '1': 'onboarding_completed',
      '3': 13,
      '4': 1,
      '5': 8,
      '10': 'onboardingCompleted'
    },
    {'1': 'created_at', '3': 14, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 15, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `WellnessProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wellnessProfileDescriptor = $convert.base64Decode(
    'Cg9XZWxsbmVzc1Byb2ZpbGUSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZX'
    'JJZBIhCgxzdHJlc3NfbGV2ZWwYAyABKAVSC3N0cmVzc0xldmVsEiMKDXNsZWVwX3F1YWxpdHkY'
    'BCABKAVSDHNsZWVwUXVhbGl0eRIhCgxtb29kX2F2ZXJhZ2UYBSABKAVSC21vb2RBdmVyYWdlEi'
    'cKD3ByaW1hcnlfY29uY2VybhgGIAEoCVIOcHJpbWFyeUNvbmNlcm4SFAoFZ29hbHMYByADKAlS'
    'BWdvYWxzEjEKFHByZWZlcnJlZF9hY3Rpdml0aWVzGAggAygJUhNwcmVmZXJyZWRBY3Rpdml0aW'
    'VzEjQKFmVtZXJnZW5jeV9jb250YWN0X25hbWUYCSABKAlSFGVtZXJnZW5jeUNvbnRhY3ROYW1l'
    'EjYKF2VtZXJnZW5jeV9jb250YWN0X3Bob25lGAogASgJUhVlbWVyZ2VuY3lDb250YWN0UGhvbm'
    'USRAoeZW1lcmdlbmN5X2NvbnRhY3RfcmVsYXRpb25zaGlwGAsgASgJUhxlbWVyZ2VuY3lDb250'
    'YWN0UmVsYXRpb25zaGlwEiEKDHRoZXJhcGlzdF9pZBgMIAEoCVILdGhlcmFwaXN0SWQSMQoUb2'
    '5ib2FyZGluZ19jb21wbGV0ZWQYDSABKAhSE29uYm9hcmRpbmdDb21wbGV0ZWQSHQoKY3JlYXRl'
    'ZF9hdBgOIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYDyABKAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use preferenceDescriptor instead')
const Preference$json = {
  '1': 'Preference',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'preference_id', '3': 2, '4': 1, '5': 9, '10': 'preferenceId'},
    {'1': 'preference_name', '3': 3, '4': 1, '5': 9, '10': 'preferenceName'},
    {
      '1': 'preference_description',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'preferenceDescription'
    },
    {'1': 'preference_icon', '3': 5, '4': 1, '5': 9, '10': 'preferenceIcon'},
    {'1': 'is_svg', '3': 6, '4': 1, '5': 8, '10': 'isSvg'},
    {'1': 'sort_order', '3': 7, '4': 1, '5': 5, '10': 'sortOrder'},
    {'1': 'is_active', '3': 8, '4': 1, '5': 8, '10': 'isActive'},
  ],
};

/// Descriptor for `Preference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List preferenceDescriptor = $convert.base64Decode(
    'CgpQcmVmZXJlbmNlEg4KAmlkGAEgASgJUgJpZBIjCg1wcmVmZXJlbmNlX2lkGAIgASgJUgxwcm'
    'VmZXJlbmNlSWQSJwoPcHJlZmVyZW5jZV9uYW1lGAMgASgJUg5wcmVmZXJlbmNlTmFtZRI1ChZw'
    'cmVmZXJlbmNlX2Rlc2NyaXB0aW9uGAQgASgJUhVwcmVmZXJlbmNlRGVzY3JpcHRpb24SJwoPcH'
    'JlZmVyZW5jZV9pY29uGAUgASgJUg5wcmVmZXJlbmNlSWNvbhIVCgZpc19zdmcYBiABKAhSBWlz'
    'U3ZnEh0KCnNvcnRfb3JkZXIYByABKAVSCXNvcnRPcmRlchIbCglpc19hY3RpdmUYCCABKAhSCG'
    'lzQWN0aXZl');

@$core.Deprecated('Use listPreferencesResponseDescriptor instead')
const ListPreferencesResponse$json = {
  '1': 'ListPreferencesResponse',
  '2': [
    {
      '1': 'preferences',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.user.Preference',
      '10': 'preferences'
    },
  ],
};

/// Descriptor for `ListPreferencesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPreferencesResponseDescriptor =
    $convert.base64Decode(
        'ChdMaXN0UHJlZmVyZW5jZXNSZXNwb25zZRI6CgtwcmVmZXJlbmNlcxgBIAMoCzIYLnJlc2lsaW'
        '8udXNlci5QcmVmZXJlbmNlUgtwcmVmZXJlbmNlcw==');

@$core.Deprecated('Use savePreferencesRequestDescriptor instead')
const SavePreferencesRequest$json = {
  '1': 'SavePreferencesRequest',
  '2': [
    {'1': 'preference_ids', '3': 1, '4': 3, '5': 9, '10': 'preferenceIds'},
  ],
};

/// Descriptor for `SavePreferencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List savePreferencesRequestDescriptor =
    $convert.base64Decode(
        'ChZTYXZlUHJlZmVyZW5jZXNSZXF1ZXN0EiUKDnByZWZlcmVuY2VfaWRzGAEgAygJUg1wcmVmZX'
        'JlbmNlSWRz');

@$core.Deprecated('Use preferenceCompletionStatusDescriptor instead')
const PreferenceCompletionStatus$json = {
  '1': 'PreferenceCompletionStatus',
  '2': [
    {'1': 'completed', '3': 1, '4': 1, '5': 8, '10': 'completed'},
  ],
};

/// Descriptor for `PreferenceCompletionStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List preferenceCompletionStatusDescriptor =
    $convert.base64Decode(
        'ChpQcmVmZXJlbmNlQ29tcGxldGlvblN0YXR1cxIcCgljb21wbGV0ZWQYASABKAhSCWNvbXBsZX'
        'RlZA==');

@$core.Deprecated('Use createUserRequestDescriptor instead')
const CreateUserRequest$json = {
  '1': 'CreateUserRequest',
  '2': [
    {'1': 'firebase_uid', '3': 1, '4': 1, '5': 9, '10': 'firebaseUid'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'photo_url', '3': 5, '4': 1, '5': 9, '10': 'photoUrl'},
    {'1': 'fcm_token', '3': 6, '4': 1, '5': 9, '10': 'fcmToken'},
    {'1': 'language', '3': 7, '4': 1, '5': 9, '10': 'language'},
  ],
};

/// Descriptor for `CreateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVVc2VyUmVxdWVzdBIhCgxmaXJlYmFzZV91aWQYASABKAlSC2ZpcmViYXNlVWlkEh'
    'QKBWVtYWlsGAIgASgJUgVlbWFpbBIaCgh1c2VybmFtZRgDIAEoCVIIdXNlcm5hbWUSIQoMZGlz'
    'cGxheV9uYW1lGAQgASgJUgtkaXNwbGF5TmFtZRIbCglwaG90b191cmwYBSABKAlSCHBob3RvVX'
    'JsEhsKCWZjbV90b2tlbhgGIAEoCVIIZmNtVG9rZW4SGgoIbGFuZ3VhZ2UYByABKAlSCGxhbmd1'
    'YWdl');

@$core.Deprecated('Use createUserResponseDescriptor instead')
const CreateUserResponse$json = {
  '1': 'CreateUserResponse',
  '2': [
    {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resilio.user.User',
      '10': 'user'
    },
    {'1': 'is_new_user', '3': 2, '4': 1, '5': 8, '10': 'isNewUser'},
  ],
};

/// Descriptor for `CreateUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserResponseDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVVc2VyUmVzcG9uc2USJgoEdXNlchgBIAEoCzISLnJlc2lsaW8udXNlci5Vc2VyUg'
    'R1c2VyEh4KC2lzX25ld191c2VyGAIgASgIUglpc05ld1VzZXI=');

@$core.Deprecated('Use getUserRequestDescriptor instead')
const GetUserRequest$json = {
  '1': 'GetUserRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserRequestDescriptor =
    $convert.base64Decode('Cg5HZXRVc2VyUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use getUserByFirebaseUidRequestDescriptor instead')
const GetUserByFirebaseUidRequest$json = {
  '1': 'GetUserByFirebaseUidRequest',
  '2': [
    {'1': 'firebase_uid', '3': 1, '4': 1, '5': 9, '10': 'firebaseUid'},
  ],
};

/// Descriptor for `GetUserByFirebaseUidRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserByFirebaseUidRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRVc2VyQnlGaXJlYmFzZVVpZFJlcXVlc3QSIQoMZmlyZWJhc2VfdWlkGAEgASgJUgtmaX'
        'JlYmFzZVVpZA==');

@$core.Deprecated('Use updateUserRequestDescriptor instead')
const UpdateUserRequest$json = {
  '1': 'UpdateUserRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'username',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'username',
      '17': true
    },
    {
      '1': 'display_name',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'displayName',
      '17': true
    },
    {
      '1': 'photo_url',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'photoUrl',
      '17': true
    },
    {
      '1': 'phone_number',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'phoneNumber',
      '17': true
    },
    {
      '1': 'date_of_birth',
      '3': 6,
      '4': 1,
      '5': 9,
      '9': 4,
      '10': 'dateOfBirth',
      '17': true
    },
    {'1': 'gender', '3': 7, '4': 1, '5': 9, '9': 5, '10': 'gender', '17': true},
    {
      '1': 'timezone',
      '3': 8,
      '4': 1,
      '5': 9,
      '9': 6,
      '10': 'timezone',
      '17': true
    },
    {
      '1': 'language',
      '3': 9,
      '4': 1,
      '5': 9,
      '9': 7,
      '10': 'language',
      '17': true
    },
    {
      '1': 'fcm_token',
      '3': 10,
      '4': 1,
      '5': 9,
      '9': 8,
      '10': 'fcmToken',
      '17': true
    },
  ],
  '8': [
    {'1': '_username'},
    {'1': '_display_name'},
    {'1': '_photo_url'},
    {'1': '_phone_number'},
    {'1': '_date_of_birth'},
    {'1': '_gender'},
    {'1': '_timezone'},
    {'1': '_language'},
    {'1': '_fcm_token'},
  ],
};

/// Descriptor for `UpdateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserRequestDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVVc2VyUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSHwoIdXNlcm5hbWUYAiABKAlIAF'
    'IIdXNlcm5hbWWIAQESJgoMZGlzcGxheV9uYW1lGAMgASgJSAFSC2Rpc3BsYXlOYW1liAEBEiAK'
    'CXBob3RvX3VybBgEIAEoCUgCUghwaG90b1VybIgBARImCgxwaG9uZV9udW1iZXIYBSABKAlIA1'
    'ILcGhvbmVOdW1iZXKIAQESJwoNZGF0ZV9vZl9iaXJ0aBgGIAEoCUgEUgtkYXRlT2ZCaXJ0aIgB'
    'ARIbCgZnZW5kZXIYByABKAlIBVIGZ2VuZGVyiAEBEh8KCHRpbWV6b25lGAggASgJSAZSCHRpbW'
    'V6b25liAEBEh8KCGxhbmd1YWdlGAkgASgJSAdSCGxhbmd1YWdliAEBEiAKCWZjbV90b2tlbhgK'
    'IAEoCUgIUghmY21Ub2tlbogBAUILCglfdXNlcm5hbWVCDwoNX2Rpc3BsYXlfbmFtZUIMCgpfcG'
    'hvdG9fdXJsQg8KDV9waG9uZV9udW1iZXJCEAoOX2RhdGVfb2ZfYmlydGhCCQoHX2dlbmRlckIL'
    'CglfdGltZXpvbmVCCwoJX2xhbmd1YWdlQgwKCl9mY21fdG9rZW4=');

@$core.Deprecated('Use updateUserPreferencesRequestDescriptor instead')
const UpdateUserPreferencesRequest$json = {
  '1': 'UpdateUserPreferencesRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'theme', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'theme', '17': true},
    {
      '1': 'language',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'language',
      '17': true
    },
    {
      '1': 'notification_enabled',
      '3': 4,
      '4': 1,
      '5': 8,
      '9': 2,
      '10': 'notificationEnabled',
      '17': true
    },
    {
      '1': 'daily_reminder_time',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'dailyReminderTime',
      '17': true
    },
    {
      '1': 'weekly_report_day',
      '3': 6,
      '4': 1,
      '5': 5,
      '9': 4,
      '10': 'weeklyReportDay',
      '17': true
    },
    {
      '1': 'privacy_level',
      '3': 7,
      '4': 1,
      '5': 9,
      '9': 5,
      '10': 'privacyLevel',
      '17': true
    },
    {
      '1': 'data_sharing_enabled',
      '3': 8,
      '4': 1,
      '5': 8,
      '9': 6,
      '10': 'dataSharingEnabled',
      '17': true
    },
  ],
  '8': [
    {'1': '_theme'},
    {'1': '_language'},
    {'1': '_notification_enabled'},
    {'1': '_daily_reminder_time'},
    {'1': '_weekly_report_day'},
    {'1': '_privacy_level'},
    {'1': '_data_sharing_enabled'},
  ],
};

/// Descriptor for `UpdateUserPreferencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserPreferencesRequestDescriptor = $convert.base64Decode(
    'ChxVcGRhdGVVc2VyUHJlZmVyZW5jZXNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZB'
    'IZCgV0aGVtZRgCIAEoCUgAUgV0aGVtZYgBARIfCghsYW5ndWFnZRgDIAEoCUgBUghsYW5ndWFn'
    'ZYgBARI2ChRub3RpZmljYXRpb25fZW5hYmxlZBgEIAEoCEgCUhNub3RpZmljYXRpb25FbmFibG'
    'VkiAEBEjMKE2RhaWx5X3JlbWluZGVyX3RpbWUYBSABKAlIA1IRZGFpbHlSZW1pbmRlclRpbWWI'
    'AQESLwoRd2Vla2x5X3JlcG9ydF9kYXkYBiABKAVIBFIPd2Vla2x5UmVwb3J0RGF5iAEBEigKDX'
    'ByaXZhY3lfbGV2ZWwYByABKAlIBVIMcHJpdmFjeUxldmVsiAEBEjUKFGRhdGFfc2hhcmluZ19l'
    'bmFibGVkGAggASgISAZSEmRhdGFTaGFyaW5nRW5hYmxlZIgBAUIICgZfdGhlbWVCCwoJX2xhbm'
    'd1YWdlQhcKFV9ub3RpZmljYXRpb25fZW5hYmxlZEIWChRfZGFpbHlfcmVtaW5kZXJfdGltZUIU'
    'ChJfd2Vla2x5X3JlcG9ydF9kYXlCEAoOX3ByaXZhY3lfbGV2ZWxCFwoVX2RhdGFfc2hhcmluZ1'
    '9lbmFibGVk');

@$core.Deprecated('Use updateWellnessProfileRequestDescriptor instead')
const UpdateWellnessProfileRequest$json = {
  '1': 'UpdateWellnessProfileRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {
      '1': 'stress_level',
      '3': 2,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'stressLevel',
      '17': true
    },
    {
      '1': 'sleep_quality',
      '3': 3,
      '4': 1,
      '5': 5,
      '9': 1,
      '10': 'sleepQuality',
      '17': true
    },
    {
      '1': 'mood_average',
      '3': 4,
      '4': 1,
      '5': 5,
      '9': 2,
      '10': 'moodAverage',
      '17': true
    },
    {
      '1': 'primary_concern',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'primaryConcern',
      '17': true
    },
    {'1': 'goals', '3': 6, '4': 3, '5': 9, '10': 'goals'},
    {
      '1': 'preferred_activities',
      '3': 7,
      '4': 3,
      '5': 9,
      '10': 'preferredActivities'
    },
    {
      '1': 'emergency_contact_name',
      '3': 8,
      '4': 1,
      '5': 9,
      '9': 4,
      '10': 'emergencyContactName',
      '17': true
    },
    {
      '1': 'emergency_contact_phone',
      '3': 9,
      '4': 1,
      '5': 9,
      '9': 5,
      '10': 'emergencyContactPhone',
      '17': true
    },
    {
      '1': 'emergency_contact_relationship',
      '3': 10,
      '4': 1,
      '5': 9,
      '9': 6,
      '10': 'emergencyContactRelationship',
      '17': true
    },
    {
      '1': 'onboarding_completed',
      '3': 11,
      '4': 1,
      '5': 8,
      '9': 7,
      '10': 'onboardingCompleted',
      '17': true
    },
  ],
  '8': [
    {'1': '_stress_level'},
    {'1': '_sleep_quality'},
    {'1': '_mood_average'},
    {'1': '_primary_concern'},
    {'1': '_emergency_contact_name'},
    {'1': '_emergency_contact_phone'},
    {'1': '_emergency_contact_relationship'},
    {'1': '_onboarding_completed'},
  ],
};

/// Descriptor for `UpdateWellnessProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateWellnessProfileRequestDescriptor = $convert.base64Decode(
    'ChxVcGRhdGVXZWxsbmVzc1Byb2ZpbGVSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZB'
    'ImCgxzdHJlc3NfbGV2ZWwYAiABKAVIAFILc3RyZXNzTGV2ZWyIAQESKAoNc2xlZXBfcXVhbGl0'
    'eRgDIAEoBUgBUgxzbGVlcFF1YWxpdHmIAQESJgoMbW9vZF9hdmVyYWdlGAQgASgFSAJSC21vb2'
    'RBdmVyYWdliAEBEiwKD3ByaW1hcnlfY29uY2VybhgFIAEoCUgDUg5wcmltYXJ5Q29uY2VybogB'
    'ARIUCgVnb2FscxgGIAMoCVIFZ29hbHMSMQoUcHJlZmVycmVkX2FjdGl2aXRpZXMYByADKAlSE3'
    'ByZWZlcnJlZEFjdGl2aXRpZXMSOQoWZW1lcmdlbmN5X2NvbnRhY3RfbmFtZRgIIAEoCUgEUhRl'
    'bWVyZ2VuY3lDb250YWN0TmFtZYgBARI7ChdlbWVyZ2VuY3lfY29udGFjdF9waG9uZRgJIAEoCU'
    'gFUhVlbWVyZ2VuY3lDb250YWN0UGhvbmWIAQESSQoeZW1lcmdlbmN5X2NvbnRhY3RfcmVsYXRp'
    'b25zaGlwGAogASgJSAZSHGVtZXJnZW5jeUNvbnRhY3RSZWxhdGlvbnNoaXCIAQESNgoUb25ib2'
    'FyZGluZ19jb21wbGV0ZWQYCyABKAhIB1ITb25ib2FyZGluZ0NvbXBsZXRlZIgBAUIPCg1fc3Ry'
    'ZXNzX2xldmVsQhAKDl9zbGVlcF9xdWFsaXR5Qg8KDV9tb29kX2F2ZXJhZ2VCEgoQX3ByaW1hcn'
    'lfY29uY2VybkIZChdfZW1lcmdlbmN5X2NvbnRhY3RfbmFtZUIaChhfZW1lcmdlbmN5X2NvbnRh'
    'Y3RfcGhvbmVCIQofX2VtZXJnZW5jeV9jb250YWN0X3JlbGF0aW9uc2hpcEIXChVfb25ib2FyZG'
    'luZ19jb21wbGV0ZWQ=');

@$core.Deprecated('Use listUsersRequestDescriptor instead')
const ListUsersRequest$json = {
  '1': 'ListUsersRequest',
  '2': [
    {
      '1': 'pagination',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resilio.common.PaginationRequest',
      '10': 'pagination'
    },
    {'1': 'search_query', '3': 2, '4': 1, '5': 9, '10': 'searchQuery'},
    {'1': 'role', '3': 3, '4': 1, '5': 9, '10': 'role'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `ListUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUsersRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0VXNlcnNSZXF1ZXN0EkEKCnBhZ2luYXRpb24YASABKAsyIS5yZXNpbGlvLmNvbW1vbi'
    '5QYWdpbmF0aW9uUmVxdWVzdFIKcGFnaW5hdGlvbhIhCgxzZWFyY2hfcXVlcnkYAiABKAlSC3Nl'
    'YXJjaFF1ZXJ5EhIKBHJvbGUYAyABKAlSBHJvbGUSFgoGc3RhdHVzGAQgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use listUsersResponseDescriptor instead')
const ListUsersResponse$json = {
  '1': 'ListUsersResponse',
  '2': [
    {
      '1': 'users',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.user.User',
      '10': 'users'
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

/// Descriptor for `ListUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUsersResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0VXNlcnNSZXNwb25zZRIoCgV1c2VycxgBIAMoCzISLnJlc2lsaW8udXNlci5Vc2VyUg'
    'V1c2VycxJCCgpwYWdpbmF0aW9uGAIgASgLMiIucmVzaWxpby5jb21tb24uUGFnaW5hdGlvblJl'
    'c3BvbnNlUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use deleteUserRequestDescriptor instead')
const DeleteUserRequest$json = {
  '1': 'DeleteUserRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'soft_delete', '3': 2, '4': 1, '5': 8, '10': 'softDelete'},
  ],
};

/// Descriptor for `DeleteUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteUserRequestDescriptor = $convert.base64Decode(
    'ChFEZWxldGVVc2VyUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSHwoLc29mdF9kZWxldGUYAiABKA'
    'hSCnNvZnREZWxldGU=');

@$core.Deprecated('Use syncUserRequestDescriptor instead')
const SyncUserRequest$json = {
  '1': 'SyncUserRequest',
  '2': [
    {'1': 'firebase_uid', '3': 1, '4': 1, '5': 9, '10': 'firebaseUid'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'photo_url', '3': 4, '4': 1, '5': 9, '10': 'photoUrl'},
  ],
};

/// Descriptor for `SyncUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncUserRequestDescriptor = $convert.base64Decode(
    'Cg9TeW5jVXNlclJlcXVlc3QSIQoMZmlyZWJhc2VfdWlkGAEgASgJUgtmaXJlYmFzZVVpZBIUCg'
    'VlbWFpbBgCIAEoCVIFZW1haWwSIQoMZGlzcGxheV9uYW1lGAMgASgJUgtkaXNwbGF5TmFtZRIb'
    'CglwaG90b191cmwYBCABKAlSCHBob3RvVXJs');

const $core.Map<$core.String, $core.dynamic> UserServiceBase$json = {
  '1': 'UserService',
  '2': [
    {
      '1': 'CreateUser',
      '2': '.resilio.user.CreateUserRequest',
      '3': '.resilio.user.CreateUserResponse'
    },
    {
      '1': 'GetUser',
      '2': '.resilio.user.GetUserRequest',
      '3': '.resilio.user.User'
    },
    {
      '1': 'GetUserByFirebaseUid',
      '2': '.resilio.user.GetUserByFirebaseUidRequest',
      '3': '.resilio.user.User'
    },
    {
      '1': 'UpdateUser',
      '2': '.resilio.user.UpdateUserRequest',
      '3': '.resilio.user.User'
    },
    {
      '1': 'DeleteUser',
      '2': '.resilio.user.DeleteUserRequest',
      '3': '.resilio.common.Empty'
    },
    {
      '1': 'ListUsers',
      '2': '.resilio.user.ListUsersRequest',
      '3': '.resilio.user.ListUsersResponse'
    },
    {
      '1': 'SyncUser',
      '2': '.resilio.user.SyncUserRequest',
      '3': '.resilio.user.User'
    },
    {
      '1': 'GetUserPreferences',
      '2': '.resilio.user.GetUserRequest',
      '3': '.resilio.user.UserPreferences'
    },
    {
      '1': 'UpdateUserPreferences',
      '2': '.resilio.user.UpdateUserPreferencesRequest',
      '3': '.resilio.user.UserPreferences'
    },
    {
      '1': 'GetWellnessProfile',
      '2': '.resilio.user.GetUserRequest',
      '3': '.resilio.user.WellnessProfile'
    },
    {
      '1': 'UpdateWellnessProfile',
      '2': '.resilio.user.UpdateWellnessProfileRequest',
      '3': '.resilio.user.WellnessProfile'
    },
    {
      '1': 'GetPreferences',
      '2': '.resilio.common.Empty',
      '3': '.resilio.user.ListPreferencesResponse'
    },
    {
      '1': 'GetUserSelectedPreferences',
      '2': '.resilio.common.Empty',
      '3': '.resilio.user.ListPreferencesResponse'
    },
    {
      '1': 'SaveUserPreferences',
      '2': '.resilio.user.SavePreferencesRequest',
      '3': '.resilio.user.ListPreferencesResponse'
    },
    {
      '1': 'CheckPreferencesCompletion',
      '2': '.resilio.common.Empty',
      '3': '.resilio.user.PreferenceCompletionStatus'
    },
  ],
};

@$core.Deprecated('Use userServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    UserServiceBase$messageJson = {
  '.resilio.user.CreateUserRequest': CreateUserRequest$json,
  '.resilio.user.CreateUserResponse': CreateUserResponse$json,
  '.resilio.user.User': User$json,
  '.resilio.user.GetUserRequest': GetUserRequest$json,
  '.resilio.user.GetUserByFirebaseUidRequest': GetUserByFirebaseUidRequest$json,
  '.resilio.user.UpdateUserRequest': UpdateUserRequest$json,
  '.resilio.user.DeleteUserRequest': DeleteUserRequest$json,
  '.resilio.common.Empty': $0.Empty$json,
  '.resilio.user.ListUsersRequest': ListUsersRequest$json,
  '.resilio.common.PaginationRequest': $0.PaginationRequest$json,
  '.resilio.user.ListUsersResponse': ListUsersResponse$json,
  '.resilio.common.PaginationResponse': $0.PaginationResponse$json,
  '.resilio.user.SyncUserRequest': SyncUserRequest$json,
  '.resilio.user.UserPreferences': UserPreferences$json,
  '.resilio.user.UpdateUserPreferencesRequest':
      UpdateUserPreferencesRequest$json,
  '.resilio.user.WellnessProfile': WellnessProfile$json,
  '.resilio.user.UpdateWellnessProfileRequest':
      UpdateWellnessProfileRequest$json,
  '.resilio.user.ListPreferencesResponse': ListPreferencesResponse$json,
  '.resilio.user.Preference': Preference$json,
  '.resilio.user.SavePreferencesRequest': SavePreferencesRequest$json,
  '.resilio.user.PreferenceCompletionStatus': PreferenceCompletionStatus$json,
};

/// Descriptor for `UserService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List userServiceDescriptor = $convert.base64Decode(
    'CgtVc2VyU2VydmljZRJPCgpDcmVhdGVVc2VyEh8ucmVzaWxpby51c2VyLkNyZWF0ZVVzZXJSZX'
    'F1ZXN0GiAucmVzaWxpby51c2VyLkNyZWF0ZVVzZXJSZXNwb25zZRI7CgdHZXRVc2VyEhwucmVz'
    'aWxpby51c2VyLkdldFVzZXJSZXF1ZXN0GhIucmVzaWxpby51c2VyLlVzZXISVQoUR2V0VXNlck'
    'J5RmlyZWJhc2VVaWQSKS5yZXNpbGlvLnVzZXIuR2V0VXNlckJ5RmlyZWJhc2VVaWRSZXF1ZXN0'
    'GhIucmVzaWxpby51c2VyLlVzZXISQQoKVXBkYXRlVXNlchIfLnJlc2lsaW8udXNlci5VcGRhdG'
    'VVc2VyUmVxdWVzdBoSLnJlc2lsaW8udXNlci5Vc2VyEkQKCkRlbGV0ZVVzZXISHy5yZXNpbGlv'
    'LnVzZXIuRGVsZXRlVXNlclJlcXVlc3QaFS5yZXNpbGlvLmNvbW1vbi5FbXB0eRJMCglMaXN0VX'
    'NlcnMSHi5yZXNpbGlvLnVzZXIuTGlzdFVzZXJzUmVxdWVzdBofLnJlc2lsaW8udXNlci5MaXN0'
    'VXNlcnNSZXNwb25zZRI9CghTeW5jVXNlchIdLnJlc2lsaW8udXNlci5TeW5jVXNlclJlcXVlc3'
    'QaEi5yZXNpbGlvLnVzZXIuVXNlchJRChJHZXRVc2VyUHJlZmVyZW5jZXMSHC5yZXNpbGlvLnVz'
    'ZXIuR2V0VXNlclJlcXVlc3QaHS5yZXNpbGlvLnVzZXIuVXNlclByZWZlcmVuY2VzEmIKFVVwZG'
    'F0ZVVzZXJQcmVmZXJlbmNlcxIqLnJlc2lsaW8udXNlci5VcGRhdGVVc2VyUHJlZmVyZW5jZXNS'
    'ZXF1ZXN0Gh0ucmVzaWxpby51c2VyLlVzZXJQcmVmZXJlbmNlcxJRChJHZXRXZWxsbmVzc1Byb2'
    'ZpbGUSHC5yZXNpbGlvLnVzZXIuR2V0VXNlclJlcXVlc3QaHS5yZXNpbGlvLnVzZXIuV2VsbG5l'
    'c3NQcm9maWxlEmIKFVVwZGF0ZVdlbGxuZXNzUHJvZmlsZRIqLnJlc2lsaW8udXNlci5VcGRhdG'
    'VXZWxsbmVzc1Byb2ZpbGVSZXF1ZXN0Gh0ucmVzaWxpby51c2VyLldlbGxuZXNzUHJvZmlsZRJO'
    'Cg5HZXRQcmVmZXJlbmNlcxIVLnJlc2lsaW8uY29tbW9uLkVtcHR5GiUucmVzaWxpby51c2VyLk'
    'xpc3RQcmVmZXJlbmNlc1Jlc3BvbnNlEloKGkdldFVzZXJTZWxlY3RlZFByZWZlcmVuY2VzEhUu'
    'cmVzaWxpby5jb21tb24uRW1wdHkaJS5yZXNpbGlvLnVzZXIuTGlzdFByZWZlcmVuY2VzUmVzcG'
    '9uc2USYgoTU2F2ZVVzZXJQcmVmZXJlbmNlcxIkLnJlc2lsaW8udXNlci5TYXZlUHJlZmVyZW5j'
    'ZXNSZXF1ZXN0GiUucmVzaWxpby51c2VyLkxpc3RQcmVmZXJlbmNlc1Jlc3BvbnNlEl0KGkNoZW'
    'NrUHJlZmVyZW5jZXNDb21wbGV0aW9uEhUucmVzaWxpby5jb21tb24uRW1wdHkaKC5yZXNpbGlv'
    'LnVzZXIuUHJlZmVyZW5jZUNvbXBsZXRpb25TdGF0dXM=');
