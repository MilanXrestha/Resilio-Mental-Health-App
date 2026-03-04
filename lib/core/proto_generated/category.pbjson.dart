// This is a generated file - do not edit.
//
// Generated from category.proto.

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

@$core.Deprecated('Use categoryDescriptor instead')
const Category$json = {
  '1': 'Category',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'image_url', '3': 3, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    {'1': 'preference_ids', '3': 5, '4': 3, '5': 9, '10': 'preferenceIds'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 7, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Category`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryDescriptor = $convert.base64Decode(
    'CghDYXRlZ29yeRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIbCglpbWFnZV'
    '91cmwYAyABKAlSCGltYWdlVXJsEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIl'
    'Cg5wcmVmZXJlbmNlX2lkcxgFIAMoCVINcHJlZmVyZW5jZUlkcxIdCgpjcmVhdGVkX2F0GAYgAS'
    'gJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgHIAEoCVIJdXBkYXRlZEF0');

@$core.Deprecated('Use listCategoriesResponseDescriptor instead')
const ListCategoriesResponse$json = {
  '1': 'ListCategoriesResponse',
  '2': [
    {
      '1': 'categories',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.category.Category',
      '10': 'categories'
    },
  ],
};

/// Descriptor for `ListCategoriesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCategoriesResponseDescriptor =
    $convert.base64Decode(
        'ChZMaXN0Q2F0ZWdvcmllc1Jlc3BvbnNlEjoKCmNhdGVnb3JpZXMYASADKAsyGi5yZXNpbGlvLm'
        'NhdGVnb3J5LkNhdGVnb3J5UgpjYXRlZ29yaWVz');

@$core.Deprecated('Use getCategoryRequestDescriptor instead')
const GetCategoryRequest$json = {
  '1': 'GetCategoryRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetCategoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCategoryRequestDescriptor =
    $convert.base64Decode('ChJHZXRDYXRlZ29yeVJlcXVlc3QSDgoCaWQYASABKAlSAmlk');

const $core.Map<$core.String, $core.dynamic> CategoryServiceBase$json = {
  '1': 'CategoryService',
  '2': [
    {
      '1': 'GetCategories',
      '2': '.resilio.common.Empty',
      '3': '.resilio.category.ListCategoriesResponse'
    },
    {
      '1': 'GetCategory',
      '2': '.resilio.category.GetCategoryRequest',
      '3': '.resilio.category.Category'
    },
  ],
};

@$core.Deprecated('Use categoryServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    CategoryServiceBase$messageJson = {
  '.resilio.common.Empty': $0.Empty$json,
  '.resilio.category.ListCategoriesResponse': ListCategoriesResponse$json,
  '.resilio.category.Category': Category$json,
  '.resilio.category.GetCategoryRequest': GetCategoryRequest$json,
};

/// Descriptor for `CategoryService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List categoryServiceDescriptor = $convert.base64Decode(
    'Cg9DYXRlZ29yeVNlcnZpY2USUAoNR2V0Q2F0ZWdvcmllcxIVLnJlc2lsaW8uY29tbW9uLkVtcH'
    'R5GigucmVzaWxpby5jYXRlZ29yeS5MaXN0Q2F0ZWdvcmllc1Jlc3BvbnNlEk8KC0dldENhdGVn'
    'b3J5EiQucmVzaWxpby5jYXRlZ29yeS5HZXRDYXRlZ29yeVJlcXVlc3QaGi5yZXNpbGlvLmNhdG'
    'Vnb3J5LkNhdGVnb3J5');
