// This is a generated file - do not edit.
//
// Generated from quote.proto.

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

@$core.Deprecated('Use quoteDescriptor instead')
const Quote$json = {
  '1': 'Quote',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'quote_text', '3': 2, '4': 1, '5': 9, '10': 'quoteText'},
    {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
    {'1': 'author_icon_url', '3': 4, '4': 1, '5': 9, '10': 'authorIconUrl'},
    {'1': 'category_id', '3': 5, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'preference_ids', '3': 6, '4': 3, '5': 9, '10': 'preferenceIds'},
    {'1': 'is_featured', '3': 7, '4': 1, '5': 8, '10': 'isFeatured'},
    {'1': 'is_premium', '3': 8, '4': 1, '5': 8, '10': 'isPremium'},
    {'1': 'quote_type', '3': 9, '4': 1, '5': 9, '10': 'quoteType'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 11, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Quote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quoteDescriptor = $convert.base64Decode(
    'CgVRdW90ZRIOCgJpZBgBIAEoCVICaWQSHQoKcXVvdGVfdGV4dBgCIAEoCVIJcXVvdGVUZXh0Eh'
    'YKBmF1dGhvchgDIAEoCVIGYXV0aG9yEiYKD2F1dGhvcl9pY29uX3VybBgEIAEoCVINYXV0aG9y'
    'SWNvblVybBIfCgtjYXRlZ29yeV9pZBgFIAEoCVIKY2F0ZWdvcnlJZBIlCg5wcmVmZXJlbmNlX2'
    'lkcxgGIAMoCVINcHJlZmVyZW5jZUlkcxIfCgtpc19mZWF0dXJlZBgHIAEoCFIKaXNGZWF0dXJl'
    'ZBIdCgppc19wcmVtaXVtGAggASgIUglpc1ByZW1pdW0SHQoKcXVvdGVfdHlwZRgJIAEoCVIJcX'
    'VvdGVUeXBlEh0KCmNyZWF0ZWRfYXQYCiABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVkX2F0GAsg'
    'ASgJUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use getFeaturedQuotesRequestDescriptor instead')
const GetFeaturedQuotesRequest$json = {
  '1': 'GetFeaturedQuotesRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'preference_ids', '3': 2, '4': 3, '5': 9, '10': 'preferenceIds'},
  ],
};

/// Descriptor for `GetFeaturedQuotesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeaturedQuotesRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRGZWF0dXJlZFF1b3Rlc1JlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0EiUKDnByZW'
        'ZlcmVuY2VfaWRzGAIgAygJUg1wcmVmZXJlbmNlSWRz');

@$core.Deprecated('Use getFeaturedQuotesResponseDescriptor instead')
const GetFeaturedQuotesResponse$json = {
  '1': 'GetFeaturedQuotesResponse',
  '2': [
    {
      '1': 'quotes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.quote.Quote',
      '10': 'quotes'
    },
  ],
};

/// Descriptor for `GetFeaturedQuotesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeaturedQuotesResponseDescriptor =
    $convert.base64Decode(
        'ChlHZXRGZWF0dXJlZFF1b3Rlc1Jlc3BvbnNlEiwKBnF1b3RlcxgBIAMoCzIULnJlc2lsaW8ucX'
        'VvdGUuUXVvdGVSBnF1b3Rlcw==');

@$core.Deprecated('Use getQuoteByIdRequestDescriptor instead')
const GetQuoteByIdRequest$json = {
  '1': 'GetQuoteByIdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetQuoteByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQuoteByIdRequestDescriptor = $convert
    .base64Decode('ChNHZXRRdW90ZUJ5SWRSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use listQuotesRequestDescriptor instead')
const ListQuotesRequest$json = {
  '1': 'ListQuotesRequest',
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
    {'1': 'quote_type', '3': 5, '4': 1, '5': 9, '10': 'quoteType'},
    {'1': 'preference_ids', '3': 6, '4': 3, '5': 9, '10': 'preferenceIds'},
  ],
};

/// Descriptor for `ListQuotesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listQuotesRequestDescriptor = $convert.base64Decode(
    'ChFMaXN0UXVvdGVzUmVxdWVzdBJBCgpwYWdpbmF0aW9uGAEgASgLMiEucmVzaWxpby5jb21tb2'
    '4uUGFnaW5hdGlvblJlcXVlc3RSCnBhZ2luYXRpb24SHwoLY2F0ZWdvcnlfaWQYAiABKAlSCmNh'
    'dGVnb3J5SWQSHwoLaXNfZmVhdHVyZWQYAyABKAhSCmlzRmVhdHVyZWQSHQoKaXNfcHJlbWl1bR'
    'gEIAEoCFIJaXNQcmVtaXVtEh0KCnF1b3RlX3R5cGUYBSABKAlSCXF1b3RlVHlwZRIlCg5wcmVm'
    'ZXJlbmNlX2lkcxgGIAMoCVINcHJlZmVyZW5jZUlkcw==');

@$core.Deprecated('Use listQuotesResponseDescriptor instead')
const ListQuotesResponse$json = {
  '1': 'ListQuotesResponse',
  '2': [
    {
      '1': 'quotes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.quote.Quote',
      '10': 'quotes'
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

/// Descriptor for `ListQuotesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listQuotesResponseDescriptor = $convert.base64Decode(
    'ChJMaXN0UXVvdGVzUmVzcG9uc2USLAoGcXVvdGVzGAEgAygLMhQucmVzaWxpby5xdW90ZS5RdW'
    '90ZVIGcXVvdGVzEkIKCnBhZ2luYXRpb24YAiABKAsyIi5yZXNpbGlvLmNvbW1vbi5QYWdpbmF0'
    'aW9uUmVzcG9uc2VSCnBhZ2luYXRpb24=');

@$core.Deprecated('Use createQuoteRequestDescriptor instead')
const CreateQuoteRequest$json = {
  '1': 'CreateQuoteRequest',
  '2': [
    {'1': 'quote_text', '3': 1, '4': 1, '5': 9, '10': 'quoteText'},
    {'1': 'author', '3': 2, '4': 1, '5': 9, '10': 'author'},
    {'1': 'author_icon_url', '3': 3, '4': 1, '5': 9, '10': 'authorIconUrl'},
    {'1': 'category_id', '3': 4, '4': 1, '5': 9, '10': 'categoryId'},
    {'1': 'preference_ids', '3': 5, '4': 3, '5': 9, '10': 'preferenceIds'},
    {'1': 'is_featured', '3': 6, '4': 1, '5': 8, '10': 'isFeatured'},
    {'1': 'is_premium', '3': 7, '4': 1, '5': 8, '10': 'isPremium'},
    {'1': 'quote_type', '3': 8, '4': 1, '5': 9, '10': 'quoteType'},
  ],
};

/// Descriptor for `CreateQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createQuoteRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVRdW90ZVJlcXVlc3QSHQoKcXVvdGVfdGV4dBgBIAEoCVIJcXVvdGVUZXh0EhYKBm'
    'F1dGhvchgCIAEoCVIGYXV0aG9yEiYKD2F1dGhvcl9pY29uX3VybBgDIAEoCVINYXV0aG9ySWNv'
    'blVybBIfCgtjYXRlZ29yeV9pZBgEIAEoCVIKY2F0ZWdvcnlJZBIlCg5wcmVmZXJlbmNlX2lkcx'
    'gFIAMoCVINcHJlZmVyZW5jZUlkcxIfCgtpc19mZWF0dXJlZBgGIAEoCFIKaXNGZWF0dXJlZBId'
    'Cgppc19wcmVtaXVtGAcgASgIUglpc1ByZW1pdW0SHQoKcXVvdGVfdHlwZRgIIAEoCVIJcXVvdG'
    'VUeXBl');

@$core.Deprecated('Use updateQuoteRequestDescriptor instead')
const UpdateQuoteRequest$json = {
  '1': 'UpdateQuoteRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'quote_text',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'quoteText',
      '17': true
    },
    {'1': 'author', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'author', '17': true},
    {
      '1': 'author_icon_url',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'authorIconUrl',
      '17': true
    },
    {
      '1': 'category_id',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'categoryId',
      '17': true
    },
    {'1': 'preference_ids', '3': 6, '4': 3, '5': 9, '10': 'preferenceIds'},
    {
      '1': 'is_featured',
      '3': 7,
      '4': 1,
      '5': 8,
      '9': 4,
      '10': 'isFeatured',
      '17': true
    },
    {
      '1': 'is_premium',
      '3': 8,
      '4': 1,
      '5': 8,
      '9': 5,
      '10': 'isPremium',
      '17': true
    },
    {
      '1': 'quote_type',
      '3': 9,
      '4': 1,
      '5': 9,
      '9': 6,
      '10': 'quoteType',
      '17': true
    },
  ],
  '8': [
    {'1': '_quote_text'},
    {'1': '_author'},
    {'1': '_author_icon_url'},
    {'1': '_category_id'},
    {'1': '_is_featured'},
    {'1': '_is_premium'},
    {'1': '_quote_type'},
  ],
};

/// Descriptor for `UpdateQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateQuoteRequestDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVRdW90ZVJlcXVlc3QSDgoCaWQYASABKAlSAmlkEiIKCnF1b3RlX3RleHQYAiABKA'
    'lIAFIJcXVvdGVUZXh0iAEBEhsKBmF1dGhvchgDIAEoCUgBUgZhdXRob3KIAQESKwoPYXV0aG9y'
    'X2ljb25fdXJsGAQgASgJSAJSDWF1dGhvckljb25VcmyIAQESJAoLY2F0ZWdvcnlfaWQYBSABKA'
    'lIA1IKY2F0ZWdvcnlJZIgBARIlCg5wcmVmZXJlbmNlX2lkcxgGIAMoCVINcHJlZmVyZW5jZUlk'
    'cxIkCgtpc19mZWF0dXJlZBgHIAEoCEgEUgppc0ZlYXR1cmVkiAEBEiIKCmlzX3ByZW1pdW0YCC'
    'ABKAhIBVIJaXNQcmVtaXVtiAEBEiIKCnF1b3RlX3R5cGUYCSABKAlIBlIJcXVvdGVUeXBliAEB'
    'Qg0KC19xdW90ZV90ZXh0QgkKB19hdXRob3JCEgoQX2F1dGhvcl9pY29uX3VybEIOCgxfY2F0ZW'
    'dvcnlfaWRCDgoMX2lzX2ZlYXR1cmVkQg0KC19pc19wcmVtaXVtQg0KC19xdW90ZV90eXBl');

@$core.Deprecated('Use deleteQuoteRequestDescriptor instead')
const DeleteQuoteRequest$json = {
  '1': 'DeleteQuoteRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DeleteQuoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteQuoteRequestDescriptor =
    $convert.base64Decode('ChJEZWxldGVRdW90ZVJlcXVlc3QSDgoCaWQYASABKAlSAmlk');

const $core.Map<$core.String, $core.dynamic> QuoteServiceBase$json = {
  '1': 'QuoteService',
  '2': [
    {
      '1': 'GetFeaturedQuotes',
      '2': '.resilio.quote.GetFeaturedQuotesRequest',
      '3': '.resilio.quote.GetFeaturedQuotesResponse'
    },
    {
      '1': 'GetQuoteById',
      '2': '.resilio.quote.GetQuoteByIdRequest',
      '3': '.resilio.quote.Quote'
    },
    {
      '1': 'ListQuotes',
      '2': '.resilio.quote.ListQuotesRequest',
      '3': '.resilio.quote.ListQuotesResponse'
    },
    {
      '1': 'CreateQuote',
      '2': '.resilio.quote.CreateQuoteRequest',
      '3': '.resilio.quote.Quote'
    },
    {
      '1': 'UpdateQuote',
      '2': '.resilio.quote.UpdateQuoteRequest',
      '3': '.resilio.quote.Quote'
    },
    {
      '1': 'DeleteQuote',
      '2': '.resilio.quote.DeleteQuoteRequest',
      '3': '.resilio.common.Empty'
    },
  ],
};

@$core.Deprecated('Use quoteServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    QuoteServiceBase$messageJson = {
  '.resilio.quote.GetFeaturedQuotesRequest': GetFeaturedQuotesRequest$json,
  '.resilio.quote.GetFeaturedQuotesResponse': GetFeaturedQuotesResponse$json,
  '.resilio.quote.Quote': Quote$json,
  '.resilio.quote.GetQuoteByIdRequest': GetQuoteByIdRequest$json,
  '.resilio.quote.ListQuotesRequest': ListQuotesRequest$json,
  '.resilio.common.PaginationRequest': $0.PaginationRequest$json,
  '.resilio.quote.ListQuotesResponse': ListQuotesResponse$json,
  '.resilio.common.PaginationResponse': $0.PaginationResponse$json,
  '.resilio.quote.CreateQuoteRequest': CreateQuoteRequest$json,
  '.resilio.quote.UpdateQuoteRequest': UpdateQuoteRequest$json,
  '.resilio.quote.DeleteQuoteRequest': DeleteQuoteRequest$json,
  '.resilio.common.Empty': $0.Empty$json,
};

/// Descriptor for `QuoteService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List quoteServiceDescriptor = $convert.base64Decode(
    'CgxRdW90ZVNlcnZpY2USZgoRR2V0RmVhdHVyZWRRdW90ZXMSJy5yZXNpbGlvLnF1b3RlLkdldE'
    'ZlYXR1cmVkUXVvdGVzUmVxdWVzdBooLnJlc2lsaW8ucXVvdGUuR2V0RmVhdHVyZWRRdW90ZXNS'
    'ZXNwb25zZRJICgxHZXRRdW90ZUJ5SWQSIi5yZXNpbGlvLnF1b3RlLkdldFF1b3RlQnlJZFJlcX'
    'Vlc3QaFC5yZXNpbGlvLnF1b3RlLlF1b3RlElEKCkxpc3RRdW90ZXMSIC5yZXNpbGlvLnF1b3Rl'
    'Lkxpc3RRdW90ZXNSZXF1ZXN0GiEucmVzaWxpby5xdW90ZS5MaXN0UXVvdGVzUmVzcG9uc2USRg'
    'oLQ3JlYXRlUXVvdGUSIS5yZXNpbGlvLnF1b3RlLkNyZWF0ZVF1b3RlUmVxdWVzdBoULnJlc2ls'
    'aW8ucXVvdGUuUXVvdGUSRgoLVXBkYXRlUXVvdGUSIS5yZXNpbGlvLnF1b3RlLlVwZGF0ZVF1b3'
    'RlUmVxdWVzdBoULnJlc2lsaW8ucXVvdGUuUXVvdGUSRwoLRGVsZXRlUXVvdGUSIS5yZXNpbGlv'
    'LnF1b3RlLkRlbGV0ZVF1b3RlUmVxdWVzdBoVLnJlc2lsaW8uY29tbW9uLkVtcHR5');
