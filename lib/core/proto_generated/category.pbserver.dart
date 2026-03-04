// This is a generated file - do not edit.
//
// Generated from category.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'category.pb.dart' as $1;
import 'category.pbjson.dart';
import 'common.pb.dart' as $0;

export 'category.pb.dart';

abstract class CategoryServiceBase extends $pb.GeneratedService {
  $async.Future<$1.ListCategoriesResponse> getCategories(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$1.Category> getCategory(
      $pb.ServerContext ctx, $1.GetCategoryRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetCategories':
        return $0.Empty();
      case 'GetCategory':
        return $1.GetCategoryRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetCategories':
        return getCategories(ctx, request as $0.Empty);
      case 'GetCategory':
        return getCategory(ctx, request as $1.GetCategoryRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => CategoryServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => CategoryServiceBase$messageJson;
}
