// This is a generated file - do not edit.
//
// Generated from common.proto.

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

@$core.Deprecated('Use sortOrderDescriptor instead')
const SortOrder$json = {
  '1': 'SortOrder',
  '2': [
    {'1': 'SORT_ORDER_UNSPECIFIED', '2': 0},
    {'1': 'ASC', '2': 1},
    {'1': 'DESC', '2': 2},
  ],
};

/// Descriptor for `SortOrder`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List sortOrderDescriptor = $convert.base64Decode(
    'CglTb3J0T3JkZXISGgoWU09SVF9PUkRFUl9VTlNQRUNJRklFRBAAEgcKA0FTQxABEggKBERFU0'
    'MQAg==');

@$core.Deprecated('Use paginationRequestDescriptor instead')
const PaginationRequest$json = {
  '1': 'PaginationRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'cursor', '3': 3, '4': 1, '5': 9, '10': 'cursor'},
  ],
};

/// Descriptor for `PaginationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginationRequestDescriptor = $convert.base64Decode(
    'ChFQYWdpbmF0aW9uUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhQKBWxpbWl0GAIgASgFUg'
    'VsaW1pdBIWCgZjdXJzb3IYAyABKAlSBmN1cnNvcg==');

@$core.Deprecated('Use paginationResponseDescriptor instead')
const PaginationResponse$json = {
  '1': 'PaginationResponse',
  '2': [
    {'1': 'total', '3': 1, '4': 1, '5': 5, '10': 'total'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'total_pages', '3': 4, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'has_next', '3': 5, '4': 1, '5': 8, '10': 'hasNext'},
    {'1': 'has_previous', '3': 6, '4': 1, '5': 8, '10': 'hasPrevious'},
    {'1': 'next_cursor', '3': 7, '4': 1, '5': 9, '10': 'nextCursor'},
    {'1': 'previous_cursor', '3': 8, '4': 1, '5': 9, '10': 'previousCursor'},
  ],
};

/// Descriptor for `PaginationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paginationResponseDescriptor = $convert.base64Decode(
    'ChJQYWdpbmF0aW9uUmVzcG9uc2USFAoFdG90YWwYASABKAVSBXRvdGFsEhIKBHBhZ2UYAiABKA'
    'VSBHBhZ2USFAoFbGltaXQYAyABKAVSBWxpbWl0Eh8KC3RvdGFsX3BhZ2VzGAQgASgFUgp0b3Rh'
    'bFBhZ2VzEhkKCGhhc19uZXh0GAUgASgIUgdoYXNOZXh0EiEKDGhhc19wcmV2aW91cxgGIAEoCF'
    'ILaGFzUHJldmlvdXMSHwoLbmV4dF9jdXJzb3IYByABKAlSCm5leHRDdXJzb3ISJwoPcHJldmlv'
    'dXNfY3Vyc29yGAggASgJUg5wcmV2aW91c0N1cnNvcg==');

@$core.Deprecated('Use timestampDescriptor instead')
const Timestamp$json = {
  '1': 'Timestamp',
  '2': [
    {'1': 'seconds', '3': 1, '4': 1, '5': 3, '10': 'seconds'},
    {'1': 'nanos', '3': 2, '4': 1, '5': 5, '10': 'nanos'},
  ],
};

/// Descriptor for `Timestamp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timestampDescriptor = $convert.base64Decode(
    'CglUaW1lc3RhbXASGAoHc2Vjb25kcxgBIAEoA1IHc2Vjb25kcxIUCgVuYW5vcxgCIAEoBVIFbm'
    'Fub3M=');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');

@$core.Deprecated('Use errorDetailDescriptor instead')
const ErrorDetail$json = {
  '1': 'ErrorDetail',
  '2': [
    {'1': 'field', '3': 1, '4': 1, '5': 9, '10': 'field'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `ErrorDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorDetailDescriptor = $convert.base64Decode(
    'CgtFcnJvckRldGFpbBIUCgVmaWVsZBgBIAEoCVIFZmllbGQSGAoHbWVzc2FnZRgCIAEoCVIHbW'
    'Vzc2FnZRISCgRjb2RlGAMgASgJUgRjb2Rl');

@$core.Deprecated('Use errorResponseDescriptor instead')
const ErrorResponse$json = {
  '1': 'ErrorResponse',
  '2': [
    {'1': 'status_code', '3': 1, '4': 1, '5': 5, '10': 'statusCode'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'error_code', '3': 3, '4': 1, '5': 9, '10': 'errorCode'},
    {
      '1': 'details',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.resilio.common.ErrorDetail',
      '10': 'details'
    },
    {
      '1': 'timestamp',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.resilio.common.Timestamp',
      '10': 'timestamp'
    },
  ],
};

/// Descriptor for `ErrorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorResponseDescriptor = $convert.base64Decode(
    'Cg1FcnJvclJlc3BvbnNlEh8KC3N0YXR1c19jb2RlGAEgASgFUgpzdGF0dXNDb2RlEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2USHQoKZXJyb3JfY29kZRgDIAEoCVIJZXJyb3JDb2RlEjUKB2Rl'
    'dGFpbHMYBCADKAsyGy5yZXNpbGlvLmNvbW1vbi5FcnJvckRldGFpbFIHZGV0YWlscxI3Cgl0aW'
    '1lc3RhbXAYBSABKAsyGS5yZXNpbGlvLmNvbW1vbi5UaW1lc3RhbXBSCXRpbWVzdGFtcA==');

@$core.Deprecated('Use sortOptionDescriptor instead')
const SortOption$json = {
  '1': 'SortOption',
  '2': [
    {'1': 'field', '3': 1, '4': 1, '5': 9, '10': 'field'},
    {
      '1': 'order',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.resilio.common.SortOrder',
      '10': 'order'
    },
  ],
};

/// Descriptor for `SortOption`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sortOptionDescriptor = $convert.base64Decode(
    'CgpTb3J0T3B0aW9uEhQKBWZpZWxkGAEgASgJUgVmaWVsZBIvCgVvcmRlchgCIAEoDjIZLnJlc2'
    'lsaW8uY29tbW9uLlNvcnRPcmRlclIFb3JkZXI=');

@$core.Deprecated('Use dateRangeDescriptor instead')
const DateRange$json = {
  '1': 'DateRange',
  '2': [
    {'1': 'start_date', '3': 1, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'end_date', '3': 2, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `DateRange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dateRangeDescriptor = $convert.base64Decode(
    'CglEYXRlUmFuZ2USHQoKc3RhcnRfZGF0ZRgBIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGA'
    'IgASgJUgdlbmREYXRl');
