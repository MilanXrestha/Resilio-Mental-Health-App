// This is a generated file - do not edit.
//
// Generated from tips.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;
import 'tips.pb.dart' as $1;
import 'tips.pbjson.dart';

export 'tips.pb.dart';

abstract class TipServiceBase extends $pb.GeneratedService {
  $async.Future<$1.GetFeaturedTipsResponse> getFeaturedTips(
      $pb.ServerContext ctx, $1.GetFeaturedTipsRequest request);
  $async.Future<$1.Tip> getTipById(
      $pb.ServerContext ctx, $1.GetTipByIdRequest request);
  $async.Future<$1.ListTipsResponse> listTips(
      $pb.ServerContext ctx, $1.ListTipsRequest request);
  $async.Future<$1.GetTipsByTypeResponse> getTipsByType(
      $pb.ServerContext ctx, $1.GetTipsByTypeRequest request);
  $async.Future<$1.Tip> createTip(
      $pb.ServerContext ctx, $1.CreateTipRequest request);
  $async.Future<$1.Tip> updateTip(
      $pb.ServerContext ctx, $1.UpdateTipRequest request);
  $async.Future<$0.Empty> deleteTip(
      $pb.ServerContext ctx, $1.DeleteTipRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetFeaturedTips':
        return $1.GetFeaturedTipsRequest();
      case 'GetTipById':
        return $1.GetTipByIdRequest();
      case 'ListTips':
        return $1.ListTipsRequest();
      case 'GetTipsByType':
        return $1.GetTipsByTypeRequest();
      case 'CreateTip':
        return $1.CreateTipRequest();
      case 'UpdateTip':
        return $1.UpdateTipRequest();
      case 'DeleteTip':
        return $1.DeleteTipRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetFeaturedTips':
        return getFeaturedTips(ctx, request as $1.GetFeaturedTipsRequest);
      case 'GetTipById':
        return getTipById(ctx, request as $1.GetTipByIdRequest);
      case 'ListTips':
        return listTips(ctx, request as $1.ListTipsRequest);
      case 'GetTipsByType':
        return getTipsByType(ctx, request as $1.GetTipsByTypeRequest);
      case 'CreateTip':
        return createTip(ctx, request as $1.CreateTipRequest);
      case 'UpdateTip':
        return updateTip(ctx, request as $1.UpdateTipRequest);
      case 'DeleteTip':
        return deleteTip(ctx, request as $1.DeleteTipRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => TipServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => TipServiceBase$messageJson;
}
