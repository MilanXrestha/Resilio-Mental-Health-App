// This is a generated file - do not edit.
//
// Generated from tips.proto.

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

@$core.Deprecated('Use tipDescriptor instead')
const Tip$json = {
  '1': 'Tip',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'tip_text', '3': 3, '4': 1, '5': 9, '10': 'tipText'},
    {'1': 'author', '3': 4, '4': 1, '5': 9, '10': 'author'},
    {'1': 'author_icon_url', '3': 5, '4': 1, '5': 9, '10': 'authorIconUrl'},
    {'1': 'category_id', '3': 6, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'preference_ids', '3': 7, '4': 3, '5': 9, '10': 'preferenceIds'},
    {'1': 'tip_type', '3': 8, '4': 1, '5': 9, '10': 'tipType'},
    {'1': 'is_featured', '3': 9, '4': 1, '5': 8, '10': 'isFeatured'},
    {'1': 'is_premium', '3': 10, '4': 1, '5': 8, '10': 'isPremium'},
    {'1': 'sort_order', '3': 11, '4': 1, '5': 5, '10': 'sortOrder'},
    {'1': 'metadata', '3': 12, '4': 1, '5': 9, '10': 'metadata'},
    {'1': 'created_at', '3': 13, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 14, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Tip`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tipDescriptor = $convert.base64Decode(
    'CgNUaXASDgoCaWQYASABKAlSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIZCgh0aXBfdGV4dB'
    'gDIAEoCVIHdGlwVGV4dBIWCgZhdXRob3IYBCABKAlSBmF1dGhvchImCg9hdXRob3JfaWNvbl91'
    'cmwYBSABKAlSDWF1dGhvckljb25VcmwSHwoLY2F0ZWdvcnlfaWQYBiABKAlSCmNhdGVnb3J5SW'
    'QSJQoOcHJlZmVyZW5jZV9pZHMYByADKAlSDXByZWZlcmVuY2VJZHMSGQoIdGlwX3R5cGUYCCAB'
    'KAlSB3RpcFR5cGUSHwoLaXNfZmVhdHVyZWQYCSABKAhSCmlzRmVhdHVyZWQSHQoKaXNfcHJlbW'
    'l1bRgKIAEoCFIJaXNQcmVtaXVtEh0KCnNvcnRfb3JkZXIYCyABKAVSCXNvcnRPcmRlchIaCght'
    'ZXRhZGF0YRgMIAEoCVIIbWV0YWRhdGESHQoKY3JlYXRlZF9hdBgNIAEoCVIJY3JlYXRlZEF0Eh'
    '0KCnVwZGF0ZWRfYXQYDiABKAlSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use getFeaturedTipsRequestDescriptor instead')
const GetFeaturedTipsRequest$json = {
  '1': 'GetFeaturedTipsRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'preference_ids', '3': 2, '4': 3, '5': 9, '10': 'preferenceIds'},
    {'1': 'tip_type', '3': 3, '4': 1, '5': 9, '10': 'tipType'},
  ],
};

/// Descriptor for `GetFeaturedTipsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeaturedTipsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRGZWF0dXJlZFRpcHNSZXF1ZXN0EhQKBWxpbWl0GAEgASgFUgVsaW1pdBIlCg5wcmVmZX'
    'JlbmNlX2lkcxgCIAMoCVINcHJlZmVyZW5jZUlkcxIZCgh0aXBfdHlwZRgDIAEoCVIHdGlwVHlw'
    'ZQ==');

@$core.Deprecated('Use getFeaturedTipsResponseDescriptor instead')
const GetFeaturedTipsResponse$json = {
  '1': 'GetFeaturedTipsResponse',
  '2': [
    {
      '1': 'tips',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.tips.Tip',
      '10': 'tips'
    },
  ],
};

/// Descriptor for `GetFeaturedTipsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeaturedTipsResponseDescriptor =
    $convert.base64Decode(
        'ChdHZXRGZWF0dXJlZFRpcHNSZXNwb25zZRIlCgR0aXBzGAEgAygLMhEucmVzaWxpby50aXBzLl'
        'RpcFIEdGlwcw==');

@$core.Deprecated('Use getTipByIdRequestDescriptor instead')
const GetTipByIdRequest$json = {
  '1': 'GetTipByIdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetTipByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTipByIdRequestDescriptor =
    $convert.base64Decode('ChFHZXRUaXBCeUlkUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use listTipsRequestDescriptor instead')
const ListTipsRequest$json = {
  '1': 'ListTipsRequest',
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
    {'1': 'tip_type', '3': 5, '4': 1, '5': 9, '10': 'tipType'},
    {'1': 'preference_ids', '3': 6, '4': 3, '5': 9, '10': 'preferenceIds'},
    {'1': 'sort_order', '3': 7, '4': 1, '5': 5, '10': 'sortOrder'},
  ],
};

/// Descriptor for `ListTipsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTipsRequestDescriptor = $convert.base64Decode(
    'Cg9MaXN0VGlwc1JlcXVlc3QSQQoKcGFnaW5hdGlvbhgBIAEoCzIhLnJlc2lsaW8uY29tbW9uLl'
    'BhZ2luYXRpb25SZXF1ZXN0UgpwYWdpbmF0aW9uEh8KC2NhdGVnb3J5X2lkGAIgASgJUgpjYXRl'
    'Z29yeUlkEh8KC2lzX2ZlYXR1cmVkGAMgASgIUgppc0ZlYXR1cmVkEh0KCmlzX3ByZW1pdW0YBC'
    'ABKAhSCWlzUHJlbWl1bRIZCgh0aXBfdHlwZRgFIAEoCVIHdGlwVHlwZRIlCg5wcmVmZXJlbmNl'
    'X2lkcxgGIAMoCVINcHJlZmVyZW5jZUlkcxIdCgpzb3J0X29yZGVyGAcgASgFUglzb3J0T3JkZX'
    'I=');

@$core.Deprecated('Use listTipsResponseDescriptor instead')
const ListTipsResponse$json = {
  '1': 'ListTipsResponse',
  '2': [
    {
      '1': 'tips',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.tips.Tip',
      '10': 'tips'
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

/// Descriptor for `ListTipsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTipsResponseDescriptor = $convert.base64Decode(
    'ChBMaXN0VGlwc1Jlc3BvbnNlEiUKBHRpcHMYASADKAsyES5yZXNpbGlvLnRpcHMuVGlwUgR0aX'
    'BzEkIKCnBhZ2luYXRpb24YAiABKAsyIi5yZXNpbGlvLmNvbW1vbi5QYWdpbmF0aW9uUmVzcG9u'
    'c2VSCnBhZ2luYXRpb24=');

@$core.Deprecated('Use createTipRequestDescriptor instead')
const CreateTipRequest$json = {
  '1': 'CreateTipRequest',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'tip_text', '3': 2, '4': 1, '5': 9, '10': 'tipText'},
    {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
    {'1': 'author_icon_url', '3': 4, '4': 1, '5': 9, '10': 'authorIconUrl'},
    {'1': 'category_id', '3': 5, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'preference_ids', '3': 6, '4': 3, '5': 9, '10': 'preferenceIds'},
    {'1': 'tip_type', '3': 7, '4': 1, '5': 9, '10': 'tipType'},
    {'1': 'is_featured', '3': 8, '4': 1, '5': 8, '10': 'isFeatured'},
    {'1': 'is_premium', '3': 9, '4': 1, '5': 8, '10': 'isPremium'},
    {'1': 'sort_order', '3': 10, '4': 1, '5': 5, '10': 'sortOrder'},
    {'1': 'metadata', '3': 11, '4': 1, '5': 9, '10': 'metadata'},
  ],
};

/// Descriptor for `CreateTipRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTipRequestDescriptor = $convert.base64Decode(
    'ChBDcmVhdGVUaXBSZXF1ZXN0EhQKBXRpdGxlGAEgASgJUgV0aXRsZRIZCgh0aXBfdGV4dBgCIA'
    'EoCVIHdGlwVGV4dBIWCgZhdXRob3IYAyABKAlSBmF1dGhvchImCg9hdXRob3JfaWNvbl91cmwY'
    'BCABKAlSDWF1dGhvckljb25VcmwSHwoLY2F0ZWdvcnlfaWQYBSABKAlSCmNhdGVnb3J5SWQSJQ'
    'oOcHJlZmVyZW5jZV9pZHMYBiADKAlSDXByZWZlcmVuY2VJZHMSGQoIdGlwX3R5cGUYByABKAlS'
    'B3RpcFR5cGUSHwoLaXNfZmVhdHVyZWQYCCABKAhSCmlzRmVhdHVyZWQSHQoKaXNfcHJlbWl1bR'
    'gJIAEoCFIJaXNQcmVtaXVtEh0KCnNvcnRfb3JkZXIYCiABKAVSCXNvcnRPcmRlchIaCghtZXRh'
    'ZGF0YRgLIAEoCVIIbWV0YWRhdGE=');

@$core.Deprecated('Use updateTipRequestDescriptor instead')
const UpdateTipRequest$json = {
  '1': 'UpdateTipRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'title', '17': true},
    {
      '1': 'tip_text',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'tipText',
      '17': true
    },
    {'1': 'author', '3': 4, '4': 1, '5': 9, '9': 2, '10': 'author', '17': true},
    {
      '1': 'author_icon_url',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'authorIconUrl',
      '17': true
    },
    {
      '1': 'category_id',
      '3': 6,
      '4': 1,
      '5': 9,
      '9': 4,
      '10': 'categoryId',
      '17': true
    },
    {'1': 'preference_ids', '3': 7, '4': 3, '5': 9, '10': 'preferenceIds'},
    {
      '1': 'tip_type',
      '3': 8,
      '4': 1,
      '5': 9,
      '9': 5,
      '10': 'tipType',
      '17': true
    },
    {
      '1': 'is_featured',
      '3': 9,
      '4': 1,
      '5': 8,
      '9': 6,
      '10': 'isFeatured',
      '17': true
    },
    {
      '1': 'is_premium',
      '3': 10,
      '4': 1,
      '5': 8,
      '9': 7,
      '10': 'isPremium',
      '17': true
    },
    {
      '1': 'sort_order',
      '3': 11,
      '4': 1,
      '5': 5,
      '9': 8,
      '10': 'sortOrder',
      '17': true
    },
    {
      '1': 'metadata',
      '3': 12,
      '4': 1,
      '5': 9,
      '9': 9,
      '10': 'metadata',
      '17': true
    },
  ],
  '8': [
    {'1': '_title'},
    {'1': '_tip_text'},
    {'1': '_author'},
    {'1': '_author_icon_url'},
    {'1': '_category_id'},
    {'1': '_tip_type'},
    {'1': '_is_featured'},
    {'1': '_is_premium'},
    {'1': '_sort_order'},
    {'1': '_metadata'},
  ],
};

/// Descriptor for `UpdateTipRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTipRequestDescriptor = $convert.base64Decode(
    'ChBVcGRhdGVUaXBSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZBIZCgV0aXRsZRgCIAEoCUgAUgV0aX'
    'RsZYgBARIeCgh0aXBfdGV4dBgDIAEoCUgBUgd0aXBUZXh0iAEBEhsKBmF1dGhvchgEIAEoCUgC'
    'UgZhdXRob3KIAQESKwoPYXV0aG9yX2ljb25fdXJsGAUgASgJSANSDWF1dGhvckljb25VcmyIAQ'
    'ESJAoLY2F0ZWdvcnlfaWQYBiABKAlIBFIKY2F0ZWdvcnlJZIgBARIlCg5wcmVmZXJlbmNlX2lk'
    'cxgHIAMoCVINcHJlZmVyZW5jZUlkcxIeCgh0aXBfdHlwZRgIIAEoCUgFUgd0aXBUeXBliAEBEi'
    'QKC2lzX2ZlYXR1cmVkGAkgASgISAZSCmlzRmVhdHVyZWSIAQESIgoKaXNfcHJlbWl1bRgKIAEo'
    'CEgHUglpc1ByZW1pdW2IAQESIgoKc29ydF9vcmRlchgLIAEoBUgIUglzb3J0T3JkZXKIAQESHw'
    'oIbWV0YWRhdGEYDCABKAlICVIIbWV0YWRhdGGIAQFCCAoGX3RpdGxlQgsKCV90aXBfdGV4dEIJ'
    'CgdfYXV0aG9yQhIKEF9hdXRob3JfaWNvbl91cmxCDgoMX2NhdGVnb3J5X2lkQgsKCV90aXBfdH'
    'lwZUIOCgxfaXNfZmVhdHVyZWRCDQoLX2lzX3ByZW1pdW1CDQoLX3NvcnRfb3JkZXJCCwoJX21l'
    'dGFkYXRh');

@$core.Deprecated('Use deleteTipRequestDescriptor instead')
const DeleteTipRequest$json = {
  '1': 'DeleteTipRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteTipRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteTipRequestDescriptor =
    $convert.base64Decode('ChBEZWxldGVUaXBSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use getTipsByTypeRequestDescriptor instead')
const GetTipsByTypeRequest$json = {
  '1': 'GetTipsByTypeRequest',
  '2': [
    {'1': 'tip_type', '3': 1, '4': 1, '5': 9, '10': 'tipType'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetTipsByTypeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTipsByTypeRequestDescriptor = $convert.base64Decode(
    'ChRHZXRUaXBzQnlUeXBlUmVxdWVzdBIZCgh0aXBfdHlwZRgBIAEoCVIHdGlwVHlwZRIUCgVsaW'
    '1pdBgCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getTipsByTypeResponseDescriptor instead')
const GetTipsByTypeResponse$json = {
  '1': 'GetTipsByTypeResponse',
  '2': [
    {
      '1': 'tips',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.tips.Tip',
      '10': 'tips'
    },
    {'1': 'total_count', '3': 2, '4': 1, '5': 5, '10': 'totalCount'},
  ],
};

/// Descriptor for `GetTipsByTypeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTipsByTypeResponseDescriptor = $convert.base64Decode(
    'ChVHZXRUaXBzQnlUeXBlUmVzcG9uc2USJQoEdGlwcxgBIAMoCzIRLnJlc2lsaW8udGlwcy5UaX'
    'BSBHRpcHMSHwoLdG90YWxfY291bnQYAiABKAVSCnRvdGFsQ291bnQ=');

const $core.Map<$core.String, $core.dynamic> TipServiceBase$json = {
  '1': 'TipService',
  '2': [
    {
      '1': 'GetFeaturedTips',
      '2': '.resilio.tips.GetFeaturedTipsRequest',
      '3': '.resilio.tips.GetFeaturedTipsResponse'
    },
    {
      '1': 'GetTipById',
      '2': '.resilio.tips.GetTipByIdRequest',
      '3': '.resilio.tips.Tip'
    },
    {
      '1': 'ListTips',
      '2': '.resilio.tips.ListTipsRequest',
      '3': '.resilio.tips.ListTipsResponse'
    },
    {
      '1': 'GetTipsByType',
      '2': '.resilio.tips.GetTipsByTypeRequest',
      '3': '.resilio.tips.GetTipsByTypeResponse'
    },
    {
      '1': 'CreateTip',
      '2': '.resilio.tips.CreateTipRequest',
      '3': '.resilio.tips.Tip'
    },
    {
      '1': 'UpdateTip',
      '2': '.resilio.tips.UpdateTipRequest',
      '3': '.resilio.tips.Tip'
    },
    {
      '1': 'DeleteTip',
      '2': '.resilio.tips.DeleteTipRequest',
      '3': '.resilio.common.Empty'
    },
  ],
};

@$core.Deprecated('Use tipServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    TipServiceBase$messageJson = {
  '.resilio.tips.GetFeaturedTipsRequest': GetFeaturedTipsRequest$json,
  '.resilio.tips.GetFeaturedTipsResponse': GetFeaturedTipsResponse$json,
  '.resilio.tips.Tip': Tip$json,
  '.resilio.tips.GetTipByIdRequest': GetTipByIdRequest$json,
  '.resilio.tips.ListTipsRequest': ListTipsRequest$json,
  '.resilio.common.PaginationRequest': $0.PaginationRequest$json,
  '.resilio.tips.ListTipsResponse': ListTipsResponse$json,
  '.resilio.common.PaginationResponse': $0.PaginationResponse$json,
  '.resilio.tips.GetTipsByTypeRequest': GetTipsByTypeRequest$json,
  '.resilio.tips.GetTipsByTypeResponse': GetTipsByTypeResponse$json,
  '.resilio.tips.CreateTipRequest': CreateTipRequest$json,
  '.resilio.tips.UpdateTipRequest': UpdateTipRequest$json,
  '.resilio.tips.DeleteTipRequest': DeleteTipRequest$json,
  '.resilio.common.Empty': $0.Empty$json,
};

/// Descriptor for `TipService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List tipServiceDescriptor = $convert.base64Decode(
    'CgpUaXBTZXJ2aWNlEl4KD0dldEZlYXR1cmVkVGlwcxIkLnJlc2lsaW8udGlwcy5HZXRGZWF0dX'
    'JlZFRpcHNSZXF1ZXN0GiUucmVzaWxpby50aXBzLkdldEZlYXR1cmVkVGlwc1Jlc3BvbnNlEkAK'
    'CkdldFRpcEJ5SWQSHy5yZXNpbGlvLnRpcHMuR2V0VGlwQnlJZFJlcXVlc3QaES5yZXNpbGlvLn'
    'RpcHMuVGlwEkkKCExpc3RUaXBzEh0ucmVzaWxpby50aXBzLkxpc3RUaXBzUmVxdWVzdBoeLnJl'
    'c2lsaW8udGlwcy5MaXN0VGlwc1Jlc3BvbnNlElgKDUdldFRpcHNCeVR5cGUSIi5yZXNpbGlvLn'
    'RpcHMuR2V0VGlwc0J5VHlwZVJlcXVlc3QaIy5yZXNpbGlvLnRpcHMuR2V0VGlwc0J5VHlwZVJl'
    'c3BvbnNlEj4KCUNyZWF0ZVRpcBIeLnJlc2lsaW8udGlwcy5DcmVhdGVUaXBSZXF1ZXN0GhEucm'
    'VzaWxpby50aXBzLlRpcBI+CglVcGRhdGVUaXASHi5yZXNpbGlvLnRpcHMuVXBkYXRlVGlwUmVx'
    'dWVzdBoRLnJlc2lsaW8udGlwcy5UaXASQgoJRGVsZXRlVGlwEh4ucmVzaWxpby50aXBzLkRlbG'
    'V0ZVRpcFJlcXVlc3QaFS5yZXNpbGlvLmNvbW1vbi5FbXB0eQ==');
