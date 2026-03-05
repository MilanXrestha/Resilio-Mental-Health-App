// This is a generated file - do not edit.
//
// Generated from audio.proto.

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

@$core.Deprecated('Use audioTrackDescriptor instead')
const AudioTrack$json = {
  '1': 'AudioTrack',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'artist_name', '3': 4, '4': 1, '5': 9, '10': 'artistName'},
    {'1': 'audio_url', '3': 5, '4': 1, '5': 9, '10': 'audioUrl'},
    {'1': 'cover_image_url', '3': 6, '4': 1, '5': 9, '10': 'coverImageUrl'},
    {'1': 'thumbnail_url', '3': 7, '4': 1, '5': 9, '10': 'thumbnailUrl'},
    {'1': 'duration_seconds', '3': 8, '4': 1, '5': 5, '10': 'durationSeconds'},
    {'1': 'category_id', '3': 9, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'mood_tags', '3': 10, '4': 3, '5': 9, '10': 'moodTags'},
    {'1': 'is_featured', '3': 11, '4': 1, '5': 8, '10': 'isFeatured'},
    {'1': 'is_premium', '3': 12, '4': 1, '5': 8, '10': 'isPremium'},
    {'1': 'sort_order', '3': 13, '4': 1, '5': 5, '10': 'sortOrder'},
    {'1': 'play_count', '3': 14, '4': 1, '5': 5, '10': 'playCount'},
    {'1': 'like_count', '3': 15, '4': 1, '5': 5, '10': 'likeCount'},
    {'1': 'is_active', '3': 16, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'created_at', '3': 17, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 18, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `AudioTrack`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioTrackDescriptor = $convert.base64Decode(
    'CgpBdWRpb1RyYWNrEg4KAmlkGAEgASgJUgJpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZG'
    'VzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEh8KC2FydGlzdF9uYW1lGAQgASgJUgphcnRp'
    'c3ROYW1lEhsKCWF1ZGlvX3VybBgFIAEoCVIIYXVkaW9VcmwSJgoPY292ZXJfaW1hZ2VfdXJsGA'
    'YgASgJUg1jb3ZlckltYWdlVXJsEiMKDXRodW1ibmFpbF91cmwYByABKAlSDHRodW1ibmFpbFVy'
    'bBIpChBkdXJhdGlvbl9zZWNvbmRzGAggASgFUg9kdXJhdGlvblNlY29uZHMSHwoLY2F0ZWdvcn'
    'lfaWQYCSABKAlSCmNhdGVnb3J5SWQSGwoJbW9vZF90YWdzGAogAygJUghtb29kVGFncxIfCgtp'
    'c19mZWF0dXJlZBgLIAEoCFIKaXNGZWF0dXJlZBIdCgppc19wcmVtaXVtGAwgASgIUglpc1ByZW'
    '1pdW0SHQoKc29ydF9vcmRlchgNIAEoBVIJc29ydE9yZGVyEh0KCnBsYXlfY291bnQYDiABKAVS'
    'CXBsYXlDb3VudBIdCgpsaWtlX2NvdW50GA8gASgFUglsaWtlQ291bnQSGwoJaXNfYWN0aXZlGB'
    'AgASgIUghpc0FjdGl2ZRIdCgpjcmVhdGVkX2F0GBEgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRl'
    'ZF9hdBgSIAEoCVIJdXBkYXRlZEF0');

@$core.Deprecated('Use getFeaturedAudioRequestDescriptor instead')
const GetFeaturedAudioRequest$json = {
  '1': 'GetFeaturedAudioRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'mood_filters', '3': 2, '4': 3, '5': 9, '10': 'moodFilters'},
  ],
};

/// Descriptor for `GetFeaturedAudioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeaturedAudioRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRGZWF0dXJlZEF1ZGlvUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSIQoMbW9vZF'
        '9maWx0ZXJzGAIgAygJUgttb29kRmlsdGVycw==');

@$core.Deprecated('Use getFeaturedAudioResponseDescriptor instead')
const GetFeaturedAudioResponse$json = {
  '1': 'GetFeaturedAudioResponse',
  '2': [
    {
      '1': 'tracks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.audio.AudioTrack',
      '10': 'tracks'
    },
  ],
};

/// Descriptor for `GetFeaturedAudioResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeaturedAudioResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRGZWF0dXJlZEF1ZGlvUmVzcG9uc2USMQoGdHJhY2tzGAEgAygLMhkucmVzaWxpby5hdW'
        'Rpby5BdWRpb1RyYWNrUgZ0cmFja3M=');

@$core.Deprecated('Use getAudioByCategoryRequestDescriptor instead')
const GetAudioByCategoryRequest$json = {
  '1': 'GetAudioByCategoryRequest',
  '2': [
    {'1': 'category_id', '3': 1, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetAudioByCategoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAudioByCategoryRequestDescriptor =
    $convert.base64Decode(
        'ChlHZXRBdWRpb0J5Q2F0ZWdvcnlSZXF1ZXN0Eh8KC2NhdGVnb3J5X2lkGAEgASgJUgpjYXRlZ2'
        '9yeUlkEhQKBWxpbWl0GAIgASgFUgVsaW1pdBIWCgZvZmZzZXQYAyABKAVSBm9mZnNldA==');

@$core.Deprecated('Use getAudioTracksResponseDescriptor instead')
const GetAudioTracksResponse$json = {
  '1': 'GetAudioTracksResponse',
  '2': [
    {
      '1': 'tracks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.audio.AudioTrack',
      '10': 'tracks'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetAudioTracksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAudioTracksResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXRBdWRpb1RyYWNrc1Jlc3BvbnNlEjEKBnRyYWNrcxgBIAMoCzIZLnJlc2lsaW8uYXVkaW'
        '8uQXVkaW9UcmFja1IGdHJhY2tzEhQKBXRvdGFsGAIgASgFUgV0b3RhbA==');

@$core.Deprecated('Use getAudioTrackRequestDescriptor instead')
const GetAudioTrackRequest$json = {
  '1': 'GetAudioTrackRequest',
  '2': [
    {'1': 'audio_id', '3': 1, '4': 1, '5': 9, '10': 'audioId'},
  ],
};

/// Descriptor for `GetAudioTrackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAudioTrackRequestDescriptor =
    $convert.base64Decode(
        'ChRHZXRBdWRpb1RyYWNrUmVxdWVzdBIZCghhdWRpb19pZBgBIAEoCVIHYXVkaW9JZA==');

@$core.Deprecated('Use getAudioTrackResponseDescriptor instead')
const GetAudioTrackResponse$json = {
  '1': 'GetAudioTrackResponse',
  '2': [
    {
      '1': 'track',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resilio.audio.AudioTrack',
      '10': 'track'
    },
  ],
};

/// Descriptor for `GetAudioTrackResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAudioTrackResponseDescriptor = $convert.base64Decode(
    'ChVHZXRBdWRpb1RyYWNrUmVzcG9uc2USLwoFdHJhY2sYASABKAsyGS5yZXNpbGlvLmF1ZGlvLk'
    'F1ZGlvVHJhY2tSBXRyYWNr');

@$core.Deprecated('Use incrementPlayCountRequestDescriptor instead')
const IncrementPlayCountRequest$json = {
  '1': 'IncrementPlayCountRequest',
  '2': [
    {'1': 'audio_id', '3': 1, '4': 1, '5': 9, '10': 'audioId'},
  ],
};

/// Descriptor for `IncrementPlayCountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incrementPlayCountRequestDescriptor =
    $convert.base64Decode(
        'ChlJbmNyZW1lbnRQbGF5Q291bnRSZXF1ZXN0EhkKCGF1ZGlvX2lkGAEgASgJUgdhdWRpb0lk');

@$core.Deprecated('Use incrementPlayCountResponseDescriptor instead')
const IncrementPlayCountResponse$json = {
  '1': 'IncrementPlayCountResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'new_count', '3': 2, '4': 1, '5': 5, '10': 'newCount'},
  ],
};

/// Descriptor for `IncrementPlayCountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incrementPlayCountResponseDescriptor =
    $convert.base64Decode(
        'ChpJbmNyZW1lbnRQbGF5Q291bnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEh'
        'sKCW5ld19jb3VudBgCIAEoBVIIbmV3Q291bnQ=');
