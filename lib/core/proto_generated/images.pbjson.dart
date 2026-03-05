// This is a generated file - do not edit.
//
// Generated from images.proto.

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

@$core.Deprecated('Use imageDescriptor instead')
const Image$json = {
  '1': 'Image',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'image_url', '3': 4, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'thumbnail_url', '3': 5, '4': 1, '5': 9, '10': 'thumbnailUrl'},
    {'1': 'author', '3': 6, '4': 1, '5': 9, '10': 'author'},
    {'1': 'author_icon_url', '3': 7, '4': 1, '5': 9, '10': 'authorIconUrl'},
    {'1': 'category_id', '3': 8, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'preference_ids', '3': 9, '4': 3, '5': 9, '10': 'preferenceIds'},
    {'1': 'image_type', '3': 10, '4': 1, '5': 9, '10': 'imageType'},
    {'1': 'is_featured', '3': 11, '4': 1, '5': 8, '10': 'isFeatured'},
    {'1': 'is_premium', '3': 12, '4': 1, '5': 8, '10': 'isPremium'},
    {'1': 'resolution_width', '3': 13, '4': 1, '5': 5, '10': 'resolutionWidth'},
    {
      '1': 'resolution_height',
      '3': 14,
      '4': 1,
      '5': 5,
      '10': 'resolutionHeight'
    },
    {'1': 'file_size_bytes', '3': 15, '4': 1, '5': 3, '10': 'fileSizeBytes'},
    {'1': 'download_count', '3': 16, '4': 1, '5': 5, '10': 'downloadCount'},
    {'1': 'sort_order', '3': 17, '4': 1, '5': 5, '10': 'sortOrder'},
    {'1': 'metadata', '3': 18, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'created_at', '3': 19, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 20, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Image`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageDescriptor = $convert.base64Decode(
    'CgVJbWFnZRIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEiAKC2Rlc2NyaX'
    'B0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhIbCglpbWFnZV91cmwYBCABKAlSCGltYWdlVXJsEiMK'
    'DXRodW1ibmFpbF91cmwYBSABKAlSDHRodW1ibmFpbFVybBIWCgZhdXRob3IYBiABKAlSBmF1dG'
    'hvchImCg9hdXRob3JfaWNvbl91cmwYByABKAlSDWF1dGhvckljb25VcmwSHwoLY2F0ZWdvcnlf'
    'aWQYCCABKAlSCmNhdGVnb3J5SWQSJQoOcHJlZmVyZW5jZV9pZHMYCSADKAlSDXByZWZlcmVuY2'
    'VJZHMSHQoKaW1hZ2VfdHlwZRgKIAEoCVIJaW1hZ2VUeXBlEh8KC2lzX2ZlYXR1cmVkGAsgASgI'
    'Ugppc0ZlYXR1cmVkEh0KCmlzX3ByZW1pdW0YDCABKAhSCWlzUHJlbWl1bRIpChByZXNvbHV0aW'
    '9uX3dpZHRoGA0gASgFUg9yZXNvbHV0aW9uV2lkdGgSKwoRcmVzb2x1dGlvbl9oZWlnaHQYDiAB'
    'KAVSEHJlc29sdXRpb25IZWlnaHQSJgoPZmlsZV9zaXplX2J5dGVzGA8gASgDUg1maWxlU2l6ZU'
    'J5dGVzEiUKDmRvd25sb2FkX2NvdW50GBAgASgFUg1kb3dubG9hZENvdW50Eh0KCnNvcnRfb3Jk'
    'ZXIYESABKAVSCXNvcnRPcmRlchIaCghtZXRhZGF0YRgSIAEoCVIIbWV0YWRhdGESHQoKY3JlYX'
    'RlZF9hdBgTIAEoCVIJY3JlYXRlZEF0Eh0KCnVwZGF0ZWRfYXQYFCABKAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use getFeaturedImagesRequestDescriptor instead')
const GetFeaturedImagesRequest$json = {
  '1': 'GetFeaturedImagesRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'preference_ids', '3': 2, '4': 3, '5': 9, '10': 'preferenceIds'},
    {'1': 'image_type', '3': 3, '4': 1, '5': 9, '10': 'imageType'},
  ],
};

/// Descriptor for `GetFeaturedImagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeaturedImagesRequestDescriptor = $convert.base64Decode(
    'ChhHZXRGZWF0dXJlZEltYWdlc1JlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0EiUKDnByZW'
    'ZlcmVuY2VfaWRzGAIgAygJUg1wcmVmZXJlbmNlSWRzEh0KCmltYWdlX3R5cGUYAyABKAlSCWlt'
    'YWdlVHlwZQ==');

@$core.Deprecated('Use getFeaturedImagesResponseDescriptor instead')
const GetFeaturedImagesResponse$json = {
  '1': 'GetFeaturedImagesResponse',
  '2': [
    {
      '1': 'images',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.images.Image',
      '10': 'images'
    },
  ],
};

/// Descriptor for `GetFeaturedImagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeaturedImagesResponseDescriptor =
    $convert.base64Decode(
        'ChlHZXRGZWF0dXJlZEltYWdlc1Jlc3BvbnNlEi0KBmltYWdlcxgBIAMoCzIVLnJlc2lsaW8uaW'
        '1hZ2VzLkltYWdlUgZpbWFnZXM=');

@$core.Deprecated('Use getImageByIdRequestDescriptor instead')
const GetImageByIdRequest$json = {
  '1': 'GetImageByIdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetImageByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getImageByIdRequestDescriptor = $convert
    .base64Decode('ChNHZXRJbWFnZUJ5SWRSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use listImagesRequestDescriptor instead')
const ListImagesRequest$json = {
  '1': 'ListImagesRequest',
  '2': [
    {
      '1': 'pagination',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resilio.common.PaginationRequest',
      '10': 'pagination'
    },
    {'1': 'category_id', '3': 2, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'is_featured', '3': 3, '4': 1, '5': 8, '10': 'isFeatured'},
    {'1': 'is_premium', '3': 4, '4': 1, '5': 8, '10': 'isPremium'},
    {'1': 'image_type', '3': 5, '4': 1, '5': 9, '10': 'imageType'},
    {'1': 'preference_ids', '3': 6, '4': 3, '5': 9, '10': 'preferenceIds'},
  ],
};

/// Descriptor for `ListImagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listImagesRequestDescriptor = $convert.base64Decode(
    'ChFMaXN0SW1hZ2VzUmVxdWVzdBJBCgpwYWdpbmF0aW9uGAEgASgLMiEucmVzaWxpby5jb21tb2'
    '4uUGFnaW5hdGlvblJlcXVlc3RSCnBhZ2luYXRpb24SHwoLY2F0ZWdvcnlfaWQYAiABKAlSCmNh'
    'dGVnb3J5SWQSHwoLaXNfZmVhdHVyZWQYAyABKAhSCmlzRmVhdHVyZWQSHQoKaXNfcHJlbWl1bR'
    'gEIAEoCFIJaXNQcmVtaXVtEh0KCmltYWdlX3R5cGUYBSABKAlSCWltYWdlVHlwZRIlCg5wcmVm'
    'ZXJlbmNlX2lkcxgGIAMoCVINcHJlZmVyZW5jZUlkcw==');

@$core.Deprecated('Use listImagesResponseDescriptor instead')
const ListImagesResponse$json = {
  '1': 'ListImagesResponse',
  '2': [
    {
      '1': 'images',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.images.Image',
      '10': 'images'
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

/// Descriptor for `ListImagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listImagesResponseDescriptor = $convert.base64Decode(
    'ChJMaXN0SW1hZ2VzUmVzcG9uc2USLQoGaW1hZ2VzGAEgAygLMhUucmVzaWxpby5pbWFnZXMuSW'
    '1hZ2VSBmltYWdlcxJCCgpwYWdpbmF0aW9uGAIgASgLMiIucmVzaWxpby5jb21tb24uUGFnaW5h'
    'dGlvblJlc3BvbnNlUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use getImagesByTypeRequestDescriptor instead')
const GetImagesByTypeRequest$json = {
  '1': 'GetImagesByTypeRequest',
  '2': [
    {'1': 'image_type', '3': 1, '4': 1, '5': 9, '10': 'imageType'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetImagesByTypeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getImagesByTypeRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRJbWFnZXNCeVR5cGVSZXF1ZXN0Eh0KCmltYWdlX3R5cGUYASABKAlSCWltYWdlVHlwZR'
        'IUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getImagesByTypeResponseDescriptor instead')
const GetImagesByTypeResponse$json = {
  '1': 'GetImagesByTypeResponse',
  '2': [
    {
      '1': 'images',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.images.Image',
      '10': 'images'
    },
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetImagesByTypeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getImagesByTypeResponseDescriptor =
    $convert.base64Decode(
        'ChdHZXRJbWFnZXNCeVR5cGVSZXNwb25zZRItCgZpbWFnZXMYASADKAsyFS5yZXNpbGlvLmltYW'
        'dlcy5JbWFnZVIGaW1hZ2VzEh8KC3RvdGFsX2NvdW50GAIgASgFUgp0b3RhbENvdW50');

@$core.Deprecated('Use createImageRequestDescriptor instead')
const CreateImageRequest$json = {
  '1': 'CreateImageRequest',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'image_url', '3': 3, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'thumbnail_url', '3': 4, '4': 1, '5': 9, '10': 'thumbnailUrl'},
    {'1': 'author', '3': 5, '4': 1, '5': 9, '10': 'author'},
    {'1': 'author_icon_url', '3': 6, '4': 1, '5': 9, '10': 'authorIconUrl'},
    {'1': 'category_id', '3': 7, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'preference_ids', '3': 8, '4': 3, '5': 9, '10': 'preferenceIds'},
    {'1': 'image_type', '3': 9, '4': 1, '5': 9, '10': 'imageType'},
    {'1': 'is_featured', '3': 10, '4': 1, '5': 8, '10': 'isFeatured'},
    {'1': 'is_premium', '3': 11, '4': 1, '5': 8, '10': 'isPremium'},
    {'1': 'resolution_width', '3': 12, '4': 1, '5': 5, '10': 'resolutionWidth'},
    {
      '1': 'resolution_height',
      '3': 13,
      '4': 1,
      '5': 5,
      '10': 'resolutionHeight'
    },
    {'1': 'file_size_bytes', '3': 14, '4': 1, '5': 3, '10': 'fileSizeBytes'},
    {'1': 'sort_order', '3': 15, '4': 1, '5': 5, '10': 'sortOrder'},
    {'1': 'metadata', '3': 16, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `CreateImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createImageRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVJbWFnZVJlcXVlc3QSFAoFdGl0bGUYASABKAlSBXRpdGxlEiAKC2Rlc2NyaXB0aW'
    '9uGAIgASgJUgtkZXNjcmlwdGlvbhIbCglpbWFnZV91cmwYAyABKAlSCGltYWdlVXJsEiMKDXRo'
    'dW1ibmFpbF91cmwYBCABKAlSDHRodW1ibmFpbFVybBIWCgZhdXRob3IYBSABKAlSBmF1dGhvch'
    'ImCg9hdXRob3JfaWNvbl91cmwYBiABKAlSDWF1dGhvckljb25VcmwSHwoLY2F0ZWdvcnlfaWQY'
    'ByABKAlSCmNhdGVnb3J5SWQSJQoOcHJlZmVyZW5jZV9pZHMYCCADKAlSDXByZWZlcmVuY2VJZH'
    'MSHQoKaW1hZ2VfdHlwZRgJIAEoCVIJaW1hZ2VUeXBlEh8KC2lzX2ZlYXR1cmVkGAogASgIUgpp'
    'c0ZlYXR1cmVkEh0KCmlzX3ByZW1pdW0YCyABKAhSCWlzUHJlbWl1bRIpChByZXNvbHV0aW9uX3'
    'dpZHRoGAwgASgFUg9yZXNvbHV0aW9uV2lkdGgSKwoRcmVzb2x1dGlvbl9oZWlnaHQYDSABKAVS'
    'EHJlc29sdXRpb25IZWlnaHQSJgoPZmlsZV9zaXplX2J5dGVzGA4gASgDUg1maWxlU2l6ZUJ5dG'
    'VzEh0KCnNvcnRfb3JkZXIYDyABKAVSCXNvcnRPcmRlchIaCghtZXRhZGF0YRgQIAEoCVIIbWV0'
    'YWRhdGE=');

@$core.Deprecated('Use updateImageRequestDescriptor instead')
const UpdateImageRequest$json = {
  '1': 'UpdateImageRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'image_url', '3': 4, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'thumbnail_url', '3': 5, '4': 1, '5': 9, '10': 'thumbnailUrl'},
    {'1': 'author', '3': 6, '4': 1, '5': 9, '10': 'author'},
    {'1': 'author_icon_url', '3': 7, '4': 1, '5': 9, '10': 'authorIconUrl'},
    {'1': 'category_id', '3': 8, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'preference_ids', '3': 9, '4': 3, '5': 9, '10': 'preferenceIds'},
    {'1': 'image_type', '3': 10, '4': 1, '5': 9, '10': 'imageType'},
    {'1': 'is_featured', '3': 11, '4': 1, '5': 8, '10': 'isFeatured'},
    {'1': 'is_premium', '3': 12, '4': 1, '5': 8, '10': 'isPremium'},
    {'1': 'resolution_width', '3': 13, '4': 1, '5': 5, '10': 'resolutionWidth'},
    {
      '1': 'resolution_height',
      '3': 14,
      '4': 1,
      '5': 5,
      '10': 'resolutionHeight'
    },
    {'1': 'file_size_bytes', '3': 15, '4': 1, '5': 3, '10': 'fileSizeBytes'},
    {'1': 'sort_order', '3': 16, '4': 1, '5': 5, '10': 'sortOrder'},
    {'1': 'metadata', '3': 17, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `UpdateImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateImageRequestDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVJbWFnZVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEhQKBXRpdGxlGAIgASgJUgV0aX'
    'RsZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SGwoJaW1hZ2VfdXJsGAQgASgJ'
    'UghpbWFnZVVybBIjCg10aHVtYm5haWxfdXJsGAUgASgJUgx0aHVtYm5haWxVcmwSFgoGYXV0aG'
    '9yGAYgASgJUgZhdXRob3ISJgoPYXV0aG9yX2ljb25fdXJsGAcgASgJUg1hdXRob3JJY29uVXJs'
    'Eh8KC2NhdGVnb3J5X2lkGAggASgJUgpjYXRlZ29yeUlkEiUKDnByZWZlcmVuY2VfaWRzGAkgAy'
    'gJUg1wcmVmZXJlbmNlSWRzEh0KCmltYWdlX3R5cGUYCiABKAlSCWltYWdlVHlwZRIfCgtpc19m'
    'ZWF0dXJlZBgLIAEoCFIKaXNGZWF0dXJlZBIdCgppc19wcmVtaXVtGAwgASgIUglpc1ByZW1pdW'
    '0SKQoQcmVzb2x1dGlvbl93aWR0aBgNIAEoBVIPcmVzb2x1dGlvbldpZHRoEisKEXJlc29sdXRp'
    'b25faGVpZ2h0GA4gASgFUhByZXNvbHV0aW9uSGVpZ2h0EiYKD2ZpbGVfc2l6ZV9ieXRlcxgPIA'
    'EoA1INZmlsZVNpemVCeXRlcxIdCgpzb3J0X29yZGVyGBAgASgFUglzb3J0T3JkZXISGgoIbWV0'
    'YWRhdGEYESABKAlSCG1ldGFkYXRh');

@$core.Deprecated('Use deleteImageRequestDescriptor instead')
const DeleteImageRequest$json = {
  '1': 'DeleteImageRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteImageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteImageRequestDescriptor =
    $convert.base64Decode('ChJEZWxldGVJbWFnZVJlcXVlc3QSDgoCaWQYASABKAlSAmlk');

@$core.Deprecated('Use incrementDownloadCountRequestDescriptor instead')
const IncrementDownloadCountRequest$json = {
  '1': 'IncrementDownloadCountRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `IncrementDownloadCountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incrementDownloadCountRequestDescriptor =
    $convert.base64Decode(
        'Ch1JbmNyZW1lbnREb3dubG9hZENvdW50UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

const $core.Map<$core.String, $core.dynamic> ImagesServiceBase$json = {
  '1': 'ImagesService',
  '2': [
    {
      '1': 'GetFeaturedImages',
      '2': '.resilio.images.GetFeaturedImagesRequest',
      '3': '.resilio.images.GetFeaturedImagesResponse'
    },
    {
      '1': 'GetImageById',
      '2': '.resilio.images.GetImageByIdRequest',
      '3': '.resilio.images.Image'
    },
    {
      '1': 'ListImages',
      '2': '.resilio.images.ListImagesRequest',
      '3': '.resilio.images.ListImagesResponse'
    },
    {
      '1': 'GetImagesByType',
      '2': '.resilio.images.GetImagesByTypeRequest',
      '3': '.resilio.images.GetImagesByTypeResponse'
    },
    {
      '1': 'CreateImage',
      '2': '.resilio.images.CreateImageRequest',
      '3': '.resilio.images.Image'
    },
    {
      '1': 'UpdateImage',
      '2': '.resilio.images.UpdateImageRequest',
      '3': '.resilio.images.Image'
    },
    {
      '1': 'DeleteImage',
      '2': '.resilio.images.DeleteImageRequest',
      '3': '.resilio.common.Empty'
    },
    {
      '1': 'IncrementDownloadCount',
      '2': '.resilio.images.IncrementDownloadCountRequest',
      '3': '.resilio.images.Image'
    },
  ],
};

@$core.Deprecated('Use imagesServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ImagesServiceBase$messageJson = {
  '.resilio.images.GetFeaturedImagesRequest': GetFeaturedImagesRequest$json,
  '.resilio.images.GetFeaturedImagesResponse': GetFeaturedImagesResponse$json,
  '.resilio.images.Image': Image$json,
  '.resilio.images.GetImageByIdRequest': GetImageByIdRequest$json,
  '.resilio.images.ListImagesRequest': ListImagesRequest$json,
  '.resilio.common.PaginationRequest': $0.PaginationRequest$json,
  '.resilio.images.ListImagesResponse': ListImagesResponse$json,
  '.resilio.common.PaginationResponse': $0.PaginationResponse$json,
  '.resilio.images.GetImagesByTypeRequest': GetImagesByTypeRequest$json,
  '.resilio.images.GetImagesByTypeResponse': GetImagesByTypeResponse$json,
  '.resilio.images.CreateImageRequest': CreateImageRequest$json,
  '.resilio.images.UpdateImageRequest': UpdateImageRequest$json,
  '.resilio.images.DeleteImageRequest': DeleteImageRequest$json,
  '.resilio.common.Empty': $0.Empty$json,
  '.resilio.images.IncrementDownloadCountRequest':
      IncrementDownloadCountRequest$json,
};

/// Descriptor for `ImagesService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List imagesServiceDescriptor = $convert.base64Decode(
    'Cg1JbWFnZXNTZXJ2aWNlEmgKEUdldEZlYXR1cmVkSW1hZ2VzEigucmVzaWxpby5pbWFnZXMuR2'
    'V0RmVhdHVyZWRJbWFnZXNSZXF1ZXN0GikucmVzaWxpby5pbWFnZXMuR2V0RmVhdHVyZWRJbWFn'
    'ZXNSZXNwb25zZRJKCgxHZXRJbWFnZUJ5SWQSIy5yZXNpbGlvLmltYWdlcy5HZXRJbWFnZUJ5SW'
    'RSZXF1ZXN0GhUucmVzaWxpby5pbWFnZXMuSW1hZ2USUwoKTGlzdEltYWdlcxIhLnJlc2lsaW8u'
    'aW1hZ2VzLkxpc3RJbWFnZXNSZXF1ZXN0GiIucmVzaWxpby5pbWFnZXMuTGlzdEltYWdlc1Jlc3'
    'BvbnNlEmIKD0dldEltYWdlc0J5VHlwZRImLnJlc2lsaW8uaW1hZ2VzLkdldEltYWdlc0J5VHlw'
    'ZVJlcXVlc3QaJy5yZXNpbGlvLmltYWdlcy5HZXRJbWFnZXNCeVR5cGVSZXNwb25zZRJICgtDcm'
    'VhdGVJbWFnZRIiLnJlc2lsaW8uaW1hZ2VzLkNyZWF0ZUltYWdlUmVxdWVzdBoVLnJlc2lsaW8u'
    'aW1hZ2VzLkltYWdlEkgKC1VwZGF0ZUltYWdlEiIucmVzaWxpby5pbWFnZXMuVXBkYXRlSW1hZ2'
    'VSZXF1ZXN0GhUucmVzaWxpby5pbWFnZXMuSW1hZ2USSAoLRGVsZXRlSW1hZ2USIi5yZXNpbGlv'
    'LmltYWdlcy5EZWxldGVJbWFnZVJlcXVlc3QaFS5yZXNpbGlvLmNvbW1vbi5FbXB0eRJeChZJbm'
    'NyZW1lbnREb3dubG9hZENvdW50Ei0ucmVzaWxpby5pbWFnZXMuSW5jcmVtZW50RG93bmxvYWRD'
    'b3VudFJlcXVlc3QaFS5yZXNpbGlvLmltYWdlcy5JbWFnZQ==');
