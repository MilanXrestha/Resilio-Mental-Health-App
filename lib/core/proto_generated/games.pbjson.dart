// This is a generated file - do not edit.
//
// Generated from games.proto.

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

@$core.Deprecated('Use gameSessionDescriptor instead')
const GameSession$json = {
  '1': 'GameSession',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'game_type', '3': 3, '4': 1, '5': 9, '10': 'gameType'},
    {'1': 'start_time', '3': 4, '4': 1, '5': 9, '10': 'startTime'},
    {'1': 'end_time', '3': 5, '4': 1, '5': 9, '10': 'endTime'},
    {'1': 'duration_seconds', '3': 6, '4': 1, '5': 5, '10': 'durationSeconds'},
    {'1': 'score', '3': 7, '4': 1, '5': 5, '10': 'score'},
    {'1': 'metadata', '3': 8, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `GameSession`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameSessionDescriptor = $convert.base64Decode(
    'CgtHYW1lU2Vzc2lvbhIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh'
    'sKCWdhbWVfdHlwZRgDIAEoCVIIZ2FtZVR5cGUSHQoKc3RhcnRfdGltZRgEIAEoCVIJc3RhcnRU'
    'aW1lEhkKCGVuZF90aW1lGAUgASgJUgdlbmRUaW1lEikKEGR1cmF0aW9uX3NlY29uZHMYBiABKA'
    'VSD2R1cmF0aW9uU2Vjb25kcxIUCgVzY29yZRgHIAEoBVIFc2NvcmUSGgoIbWV0YWRhdGEYCCAB'
    'KAlSCG1ldGFkYXRhEh0KCmNyZWF0ZWRfYXQYCSABKAlSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use moodEntryDescriptor instead')
const MoodEntry$json = {
  '1': 'MoodEntry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'mood_score', '3': 3, '4': 1, '5': 5, '10': 'moodScore'},
    {'1': 'mood_label', '3': 4, '4': 1, '5': 9, '10': 'moodLabel'},
    {'1': 'note', '3': 5, '4': 1, '5': 9, '10': 'note'},
    {'1': 'entry_date', '3': 6, '4': 1, '5': 9, '10': 'entryDate'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 9, '10': 'createdAt'},
  ],
};

/// Descriptor for `MoodEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moodEntryDescriptor = $convert.base64Decode(
    'CglNb29kRW50cnkSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIdCg'
    'ptb29kX3Njb3JlGAMgASgFUgltb29kU2NvcmUSHQoKbW9vZF9sYWJlbBgEIAEoCVIJbW9vZExh'
    'YmVsEhIKBG5vdGUYBSABKAlSBG5vdGUSHQoKZW50cnlfZGF0ZRgGIAEoCVIJZW50cnlEYXRlEh'
    '0KCmNyZWF0ZWRfYXQYByABKAlSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use achievementDescriptor instead')
const Achievement$json = {
  '1': 'Achievement',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'icon_url', '3': 5, '4': 1, '5': 9, '10': 'iconUrl'},
    {'1': 'requirement_type', '3': 6, '4': 1, '5': 9, '10': 'requirementType'},
    {
      '1': 'requirement_value',
      '3': 7,
      '4': 1,
      '5': 5,
      '10': 'requirementValue'
    },
  ],
};

/// Descriptor for `Achievement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List achievementDescriptor = $convert.base64Decode(
    'CgtBY2hpZXZlbWVudBIOCgJpZBgBIAEoCVICaWQSEgoEY29kZRgCIAEoCVIEY29kZRISCgRuYW'
    '1lGAMgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIZCghpY29u'
    'X3VybBgFIAEoCVIHaWNvblVybBIpChByZXF1aXJlbWVudF90eXBlGAYgASgJUg9yZXF1aXJlbW'
    'VudFR5cGUSKwoRcmVxdWlyZW1lbnRfdmFsdWUYByABKAVSEHJlcXVpcmVtZW50VmFsdWU=');

@$core.Deprecated('Use userAchievementDescriptor instead')
const UserAchievement$json = {
  '1': 'UserAchievement',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'achievement_id', '3': 3, '4': 1, '5': 9, '10': 'achievementId'},
    {'1': 'unlocked_at', '3': 4, '4': 1, '5': 9, '10': 'unlockedAt'},
    {
      '1': 'achievement',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.resilio.games.Achievement',
      '10': 'achievement'
    },
  ],
};

/// Descriptor for `UserAchievement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userAchievementDescriptor = $convert.base64Decode(
    'Cg9Vc2VyQWNoaWV2ZW1lbnQSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZX'
    'JJZBIlCg5hY2hpZXZlbWVudF9pZBgDIAEoCVINYWNoaWV2ZW1lbnRJZBIfCgt1bmxvY2tlZF9h'
    'dBgEIAEoCVIKdW5sb2NrZWRBdBI8CgthY2hpZXZlbWVudBgFIAEoCzIaLnJlc2lsaW8uZ2FtZX'
    'MuQWNoaWV2ZW1lbnRSC2FjaGlldmVtZW50');

@$core.Deprecated('Use affirmationDescriptor instead')
const Affirmation$json = {
  '1': 'Affirmation',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'text', '3': 3, '4': 1, '5': 9, '10': 'text'},
    {'1': 'background_color', '3': 4, '4': 1, '5': 9, '10': 'backgroundColor'},
    {'1': 'icon_name', '3': 5, '4': 1, '5': 9, '10': 'iconName'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'words', '3': 7, '4': 3, '5': 9, '10': 'words'},
    {'1': 'difficulty', '3': 8, '4': 1, '5': 5, '10': 'difficulty'},
    {'1': 'category', '3': 9, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `Affirmation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List affirmationDescriptor = $convert.base64Decode(
    'CgtBZmZpcm1hdGlvbhIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh'
    'IKBHRleHQYAyABKAlSBHRleHQSKQoQYmFja2dyb3VuZF9jb2xvchgEIAEoCVIPYmFja2dyb3Vu'
    'ZENvbG9yEhsKCWljb25fbmFtZRgFIAEoCVIIaWNvbk5hbWUSHQoKY3JlYXRlZF9hdBgGIAEoCV'
    'IJY3JlYXRlZEF0EhQKBXdvcmRzGAcgAygJUgV3b3JkcxIeCgpkaWZmaWN1bHR5GAggASgFUgpk'
    'aWZmaWN1bHR5EhoKCGNhdGVnb3J5GAkgASgJUghjYXRlZ29yeQ==');

@$core.Deprecated('Use saveGameSessionRequestDescriptor instead')
const SaveGameSessionRequest$json = {
  '1': 'SaveGameSessionRequest',
  '2': [
    {'1': 'game_type', '3': 1, '4': 1, '5': 9, '10': 'gameType'},
    {'1': 'duration_seconds', '3': 2, '4': 1, '5': 5, '10': 'durationSeconds'},
    {'1': 'score', '3': 3, '4': 1, '5': 5, '10': 'score'},
    {'1': 'metadata', '3': 4, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `SaveGameSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveGameSessionRequestDescriptor = $convert.base64Decode(
    'ChZTYXZlR2FtZVNlc3Npb25SZXF1ZXN0EhsKCWdhbWVfdHlwZRgBIAEoCVIIZ2FtZVR5cGUSKQ'
    'oQZHVyYXRpb25fc2Vjb25kcxgCIAEoBVIPZHVyYXRpb25TZWNvbmRzEhQKBXNjb3JlGAMgASgF'
    'UgVzY29yZRIaCghtZXRhZGF0YRgEIAEoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use saveMoodEntryRequestDescriptor instead')
const SaveMoodEntryRequest$json = {
  '1': 'SaveMoodEntryRequest',
  '2': [
    {'1': 'mood_score', '3': 1, '4': 1, '5': 5, '10': 'moodScore'},
    {'1': 'mood_label', '3': 2, '4': 1, '5': 9, '10': 'moodLabel'},
    {'1': 'note', '3': 3, '4': 1, '5': 9, '10': 'note'},
    {'1': 'entry_date', '3': 4, '4': 1, '5': 9, '10': 'entryDate'},
  ],
};

/// Descriptor for `SaveMoodEntryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveMoodEntryRequestDescriptor = $convert.base64Decode(
    'ChRTYXZlTW9vZEVudHJ5UmVxdWVzdBIdCgptb29kX3Njb3JlGAEgASgFUgltb29kU2NvcmUSHQ'
    'oKbW9vZF9sYWJlbBgCIAEoCVIJbW9vZExhYmVsEhIKBG5vdGUYAyABKAlSBG5vdGUSHQoKZW50'
    'cnlfZGF0ZRgEIAEoCVIJZW50cnlEYXRl');

@$core.Deprecated('Use saveAffirmationRequestDescriptor instead')
const SaveAffirmationRequest$json = {
  '1': 'SaveAffirmationRequest',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {'1': 'background_color', '3': 2, '4': 1, '5': 9, '10': 'backgroundColor'},
    {'1': 'icon_name', '3': 3, '4': 1, '5': 9, '10': 'iconName'},
    {'1': 'words', '3': 4, '4': 3, '5': 9, '10': 'words'},
    {'1': 'difficulty', '3': 5, '4': 1, '5': 5, '10': 'difficulty'},
    {'1': 'category', '3': 6, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `SaveAffirmationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List saveAffirmationRequestDescriptor = $convert.base64Decode(
    'ChZTYXZlQWZmaXJtYXRpb25SZXF1ZXN0EhIKBHRleHQYASABKAlSBHRleHQSKQoQYmFja2dyb3'
    'VuZF9jb2xvchgCIAEoCVIPYmFja2dyb3VuZENvbG9yEhsKCWljb25fbmFtZRgDIAEoCVIIaWNv'
    'bk5hbWUSFAoFd29yZHMYBCADKAlSBXdvcmRzEh4KCmRpZmZpY3VsdHkYBSABKAVSCmRpZmZpY3'
    'VsdHkSGgoIY2F0ZWdvcnkYBiABKAlSCGNhdGVnb3J5');

@$core.Deprecated('Use getUserGamesProgressRequestDescriptor instead')
const GetUserGamesProgressRequest$json = {
  '1': 'GetUserGamesProgressRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserGamesProgressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserGamesProgressRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRVc2VyR2FtZXNQcm9ncmVzc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use listMoodEntriesRequestDescriptor instead')
const ListMoodEntriesRequest$json = {
  '1': 'ListMoodEntriesRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'from_date', '3': 2, '4': 1, '5': 9, '10': 'fromDate'},
    {'1': 'to_date', '3': 3, '4': 1, '5': 9, '10': 'toDate'},
  ],
};

/// Descriptor for `ListMoodEntriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMoodEntriesRequestDescriptor =
    $convert.base64Decode(
        'ChZMaXN0TW9vZEVudHJpZXNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIbCglmcm'
        '9tX2RhdGUYAiABKAlSCGZyb21EYXRlEhcKB3RvX2RhdGUYAyABKAlSBnRvRGF0ZQ==');

@$core.Deprecated('Use listMoodEntriesResponseDescriptor instead')
const ListMoodEntriesResponse$json = {
  '1': 'ListMoodEntriesResponse',
  '2': [
    {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.games.MoodEntry',
      '10': 'entries'
    },
  ],
};

/// Descriptor for `ListMoodEntriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMoodEntriesResponseDescriptor =
    $convert.base64Decode(
        'ChdMaXN0TW9vZEVudHJpZXNSZXNwb25zZRIyCgdlbnRyaWVzGAEgAygLMhgucmVzaWxpby5nYW'
        '1lcy5Nb29kRW50cnlSB2VudHJpZXM=');

@$core.Deprecated('Use listUserAchievementsRequestDescriptor instead')
const ListUserAchievementsRequest$json = {
  '1': 'ListUserAchievementsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `ListUserAchievementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUserAchievementsRequestDescriptor =
    $convert.base64Decode(
        'ChtMaXN0VXNlckFjaGlldmVtZW50c1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use listUserAchievementsResponseDescriptor instead')
const ListUserAchievementsResponse$json = {
  '1': 'ListUserAchievementsResponse',
  '2': [
    {
      '1': 'achievements',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.games.UserAchievement',
      '10': 'achievements'
    },
  ],
};

/// Descriptor for `ListUserAchievementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUserAchievementsResponseDescriptor =
    $convert.base64Decode(
        'ChxMaXN0VXNlckFjaGlldmVtZW50c1Jlc3BvbnNlEkIKDGFjaGlldmVtZW50cxgBIAMoCzIeLn'
        'Jlc2lsaW8uZ2FtZXMuVXNlckFjaGlldmVtZW50UgxhY2hpZXZlbWVudHM=');

@$core.Deprecated('Use listAffirmationsRequestDescriptor instead')
const ListAffirmationsRequest$json = {
  '1': 'ListAffirmationsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `ListAffirmationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAffirmationsRequestDescriptor =
    $convert.base64Decode(
        'ChdMaXN0QWZmaXJtYXRpb25zUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use listAffirmationsResponseDescriptor instead')
const ListAffirmationsResponse$json = {
  '1': 'ListAffirmationsResponse',
  '2': [
    {
      '1': 'affirmations',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.games.Affirmation',
      '10': 'affirmations'
    },
  ],
};

/// Descriptor for `ListAffirmationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAffirmationsResponseDescriptor =
    $convert.base64Decode(
        'ChhMaXN0QWZmaXJtYXRpb25zUmVzcG9uc2USPgoMYWZmaXJtYXRpb25zGAEgAygLMhoucmVzaW'
        'xpby5nYW1lcy5BZmZpcm1hdGlvblIMYWZmaXJtYXRpb25z');

@$core.Deprecated('Use deleteAffirmationRequestDescriptor instead')
const DeleteAffirmationRequest$json = {
  '1': 'DeleteAffirmationRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteAffirmationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAffirmationRequestDescriptor = $convert
    .base64Decode('ChhEZWxldGVBZmZpcm1hdGlvblJlcXVlc3QSDgoCaWQYASABKAlSAmlk');

const $core.Map<$core.String, $core.dynamic> GamesServiceBase$json = {
  '1': 'GamesService',
  '2': [
    {
      '1': 'SaveGameSession',
      '2': '.resilio.games.SaveGameSessionRequest',
      '3': '.resilio.games.GameSession'
    },
    {
      '1': 'SaveMoodEntry',
      '2': '.resilio.games.SaveMoodEntryRequest',
      '3': '.resilio.games.MoodEntry'
    },
    {
      '1': 'ListMoodEntries',
      '2': '.resilio.games.ListMoodEntriesRequest',
      '3': '.resilio.games.ListMoodEntriesResponse'
    },
    {
      '1': 'ListUserAchievements',
      '2': '.resilio.games.ListUserAchievementsRequest',
      '3': '.resilio.games.ListUserAchievementsResponse'
    },
    {
      '1': 'SaveAffirmation',
      '2': '.resilio.games.SaveAffirmationRequest',
      '3': '.resilio.games.Affirmation'
    },
    {
      '1': 'ListAffirmations',
      '2': '.resilio.games.ListAffirmationsRequest',
      '3': '.resilio.games.ListAffirmationsResponse'
    },
    {
      '1': 'DeleteAffirmation',
      '2': '.resilio.games.DeleteAffirmationRequest',
      '3': '.resilio.common.Empty'
    },
  ],
};

@$core.Deprecated('Use gamesServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    GamesServiceBase$messageJson = {
  '.resilio.games.SaveGameSessionRequest': SaveGameSessionRequest$json,
  '.resilio.games.GameSession': GameSession$json,
  '.resilio.games.SaveMoodEntryRequest': SaveMoodEntryRequest$json,
  '.resilio.games.MoodEntry': MoodEntry$json,
  '.resilio.games.ListMoodEntriesRequest': ListMoodEntriesRequest$json,
  '.resilio.games.ListMoodEntriesResponse': ListMoodEntriesResponse$json,
  '.resilio.games.ListUserAchievementsRequest':
      ListUserAchievementsRequest$json,
  '.resilio.games.ListUserAchievementsResponse':
      ListUserAchievementsResponse$json,
  '.resilio.games.UserAchievement': UserAchievement$json,
  '.resilio.games.Achievement': Achievement$json,
  '.resilio.games.SaveAffirmationRequest': SaveAffirmationRequest$json,
  '.resilio.games.Affirmation': Affirmation$json,
  '.resilio.games.ListAffirmationsRequest': ListAffirmationsRequest$json,
  '.resilio.games.ListAffirmationsResponse': ListAffirmationsResponse$json,
  '.resilio.games.DeleteAffirmationRequest': DeleteAffirmationRequest$json,
  '.resilio.common.Empty': $0.Empty$json,
};

/// Descriptor for `GamesService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List gamesServiceDescriptor = $convert.base64Decode(
    'CgxHYW1lc1NlcnZpY2USVAoPU2F2ZUdhbWVTZXNzaW9uEiUucmVzaWxpby5nYW1lcy5TYXZlR2'
    'FtZVNlc3Npb25SZXF1ZXN0GhoucmVzaWxpby5nYW1lcy5HYW1lU2Vzc2lvbhJOCg1TYXZlTW9v'
    'ZEVudHJ5EiMucmVzaWxpby5nYW1lcy5TYXZlTW9vZEVudHJ5UmVxdWVzdBoYLnJlc2lsaW8uZ2'
    'FtZXMuTW9vZEVudHJ5EmAKD0xpc3RNb29kRW50cmllcxIlLnJlc2lsaW8uZ2FtZXMuTGlzdE1v'
    'b2RFbnRyaWVzUmVxdWVzdBomLnJlc2lsaW8uZ2FtZXMuTGlzdE1vb2RFbnRyaWVzUmVzcG9uc2'
    'USbwoUTGlzdFVzZXJBY2hpZXZlbWVudHMSKi5yZXNpbGlvLmdhbWVzLkxpc3RVc2VyQWNoaWV2'
    'ZW1lbnRzUmVxdWVzdBorLnJlc2lsaW8uZ2FtZXMuTGlzdFVzZXJBY2hpZXZlbWVudHNSZXNwb2'
    '5zZRJUCg9TYXZlQWZmaXJtYXRpb24SJS5yZXNpbGlvLmdhbWVzLlNhdmVBZmZpcm1hdGlvblJl'
    'cXVlc3QaGi5yZXNpbGlvLmdhbWVzLkFmZmlybWF0aW9uEmMKEExpc3RBZmZpcm1hdGlvbnMSJi'
    '5yZXNpbGlvLmdhbWVzLkxpc3RBZmZpcm1hdGlvbnNSZXF1ZXN0GicucmVzaWxpby5nYW1lcy5M'
    'aXN0QWZmaXJtYXRpb25zUmVzcG9uc2USUwoRRGVsZXRlQWZmaXJtYXRpb24SJy5yZXNpbGlvLm'
    'dhbWVzLkRlbGV0ZUFmZmlybWF0aW9uUmVxdWVzdBoVLnJlc2lsaW8uY29tbW9uLkVtcHR5');
