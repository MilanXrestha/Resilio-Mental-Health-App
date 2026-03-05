// This is a generated file - do not edit.
//
// Generated from video.proto.

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

@$core.Deprecated('Use videoDescriptor instead')
const Video$json = {
  '1': 'Video',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'artist_name', '3': 4, '4': 1, '5': 9, '10': 'artistName'},
    {'1': 'video_url', '3': 5, '4': 1, '5': 9, '10': 'videoUrl'},
    {'1': 'thumbnail_url', '3': 6, '4': 1, '5': 9, '10': 'thumbnailUrl'},
    {'1': 'cover_image_url', '3': 7, '4': 1, '5': 9, '10': 'coverImageUrl'},
    {'1': 'duration_seconds', '3': 8, '4': 1, '5': 5, '10': 'durationSeconds'},
    {'1': 'category_id', '3': 9, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'mood_tags', '3': 10, '4': 3, '5': 9, '10': 'moodTags'},
    {'1': 'video_type', '3': 11, '4': 1, '5': 9, '10': 'videoType'},
    {'1': 'aspect_ratio', '3': 12, '4': 1, '5': 1, '10': 'aspectRatio'},
    {'1': 'is_featured', '3': 13, '4': 1, '5': 8, '10': 'isFeatured'},
    {'1': 'is_premium', '3': 14, '4': 1, '5': 8, '10': 'isPremium'},
    {'1': 'is_active', '3': 15, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'sort_order', '3': 16, '4': 1, '5': 5, '10': 'sortOrder'},
    {'1': 'play_count', '3': 17, '4': 1, '5': 5, '10': 'playCount'},
    {'1': 'like_count', '3': 18, '4': 1, '5': 5, '10': 'likeCount'},
    {'1': 'share_count', '3': 19, '4': 1, '5': 5, '10': 'shareCount'},
    {'1': 'created_at', '3': 20, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 21, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Video`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoDescriptor = $convert.base64Decode(
    'CgVWaWRlbxIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaX'
    'B0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIfCgthcnRpc3RfbmFtZRgEIAEoCVIKYXJ0aXN0TmFt'
    'ZRIbCgl2aWRlb191cmwYBSABKAlSCHZpZGVvVXJsEiMKDXRodW1ibmFpbF91cmwYBiABKAlSDH'
    'RodW1ibmFpbFVybBImCg9jb3Zlcl9pbWFnZV91cmwYByABKAlSDWNvdmVySW1hZ2VVcmwSKQoQ'
    'ZHVyYXRpb25fc2Vjb25kcxgIIAEoBVIPZHVyYXRpb25TZWNvbmRzEh8KC2NhdGVnb3J5X2lkGA'
    'kgASgJUgpjYXRlZ29yeUlkEhsKCW1vb2RfdGFncxgKIAMoCVIIbW9vZFRhZ3MSHQoKdmlkZW9f'
    'dHlwZRgLIAEoCVIJdmlkZW9UeXBlEiEKDGFzcGVjdF9yYXRpbxgMIAEoAVILYXNwZWN0UmF0aW'
    '8SHwoLaXNfZmVhdHVyZWQYDSABKAhSCmlzRmVhdHVyZWQSHQoKaXNfcHJlbWl1bRgOIAEoCFIJ'
    'aXNQcmVtaXVtEhsKCWlzX2FjdGl2ZRgPIAEoCFIIaXNBY3RpdmUSHQoKc29ydF9vcmRlchgQIA'
    'EoBVIJc29ydE9yZGVyEh0KCnBsYXlfY291bnQYESABKAVSCXBsYXlDb3VudBIdCgpsaWtlX2Nv'
    'dW50GBIgASgFUglsaWtlQ291bnQSHwoLc2hhcmVfY291bnQYEyABKAVSCnNoYXJlQ291bnQSHQ'
    'oKY3JlYXRlZF9hdBgUIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFSABKAlSCXVwZGF0'
    'ZWRBdA==');

@$core.Deprecated('Use getVideosRequestDescriptor instead')
const GetVideosRequest$json = {
  '1': 'GetVideosRequest',
  '2': [
    {'1': 'video_type', '3': 1, '4': 1, '5': 9, '10': 'videoType'},
    {'1': 'category_id', '3': 2, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'featured_only', '3': 3, '4': 1, '5': 8, '10': 'featuredOnly'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 5, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetVideosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVideosRequestDescriptor = $convert.base64Decode(
    'ChBHZXRWaWRlb3NSZXF1ZXN0Eh0KCnZpZGVvX3R5cGUYASABKAlSCXZpZGVvVHlwZRIfCgtjYX'
    'RlZ29yeV9pZBgCIAEoCVIKY2F0ZWdvcnlJZBIjCg1mZWF0dXJlZF9vbmx5GAMgASgIUgxmZWF0'
    'dXJlZE9ubHkSFAoFbGltaXQYBCABKAVSBWxpbWl0EhYKBm9mZnNldBgFIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use getVideosResponseDescriptor instead')
const GetVideosResponse$json = {
  '1': 'GetVideosResponse',
  '2': [
    {
      '1': 'videos',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.video.Video',
      '10': 'videos'
    },
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetVideosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVideosResponseDescriptor = $convert.base64Decode(
    'ChFHZXRWaWRlb3NSZXNwb25zZRIkCgZ2aWRlb3MYASADKAsyDC52aWRlby5WaWRlb1IGdmlkZW'
    '9zEh8KC3RvdGFsX2NvdW50GAIgASgFUgp0b3RhbENvdW50');

@$core.Deprecated('Use getVideoByIdRequestDescriptor instead')
const GetVideoByIdRequest$json = {
  '1': 'GetVideoByIdRequest',
  '2': [
    {'1': 'video_id', '3': 1, '4': 1, '5': 9, '10': 'videoId'},
  ],
};

/// Descriptor for `GetVideoByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVideoByIdRequestDescriptor =
    $convert.base64Decode(
        'ChNHZXRWaWRlb0J5SWRSZXF1ZXN0EhkKCHZpZGVvX2lkGAEgASgJUgd2aWRlb0lk');

@$core.Deprecated('Use videoResponseDescriptor instead')
const VideoResponse$json = {
  '1': 'VideoResponse',
  '2': [
    {'1': 'video', '3': 1, '4': 1, '5': 11, '6': '.video.Video', '10': 'video'},
  ],
};

/// Descriptor for `VideoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoResponseDescriptor = $convert.base64Decode(
    'Cg1WaWRlb1Jlc3BvbnNlEiIKBXZpZGVvGAEgASgLMgwudmlkZW8uVmlkZW9SBXZpZGVv');

@$core.Deprecated('Use incrementPlayCountRequestDescriptor instead')
const IncrementPlayCountRequest$json = {
  '1': 'IncrementPlayCountRequest',
  '2': [
    {'1': 'video_id', '3': 1, '4': 1, '5': 9, '10': 'videoId'},
  ],
};

/// Descriptor for `IncrementPlayCountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incrementPlayCountRequestDescriptor =
    $convert.base64Decode(
        'ChlJbmNyZW1lbnRQbGF5Q291bnRSZXF1ZXN0EhkKCHZpZGVvX2lkGAEgASgJUgd2aWRlb0lk');

@$core.Deprecated('Use playCountResponseDescriptor instead')
const PlayCountResponse$json = {
  '1': 'PlayCountResponse',
  '2': [
    {'1': 'new_count', '3': 1, '4': 1, '5': 5, '10': 'newCount'},
  ],
};

/// Descriptor for `PlayCountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playCountResponseDescriptor = $convert.base64Decode(
    'ChFQbGF5Q291bnRSZXNwb25zZRIbCgluZXdfY291bnQYASABKAVSCG5ld0NvdW50');
