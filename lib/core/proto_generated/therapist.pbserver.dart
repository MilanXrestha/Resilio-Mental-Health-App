// This is a generated file - do not edit.
//
// Generated from therapist.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'therapist.pb.dart' as $1;
import 'therapist.pbjson.dart';

export 'therapist.pb.dart';

abstract class TherapistServiceBase extends $pb.GeneratedService {
  $async.Future<$1.TherapistProfile> getProfile(
      $pb.ServerContext ctx, $1.GetTherapistProfileRequest request);
  $async.Future<$1.TherapistProfile> getProfileByUserId(
      $pb.ServerContext ctx, $1.GetTherapistByUserIdRequest request);
  $async.Future<$1.ListTherapistsResponse> listProfiles(
      $pb.ServerContext ctx, $1.ListTherapistsRequest request);
  $async.Future<$1.TherapistProfile> createProfile(
      $pb.ServerContext ctx, $1.CreateTherapistProfileRequest request);
  $async.Future<$1.TherapistProfile> updateProfile(
      $pb.ServerContext ctx, $1.UpdateTherapistProfileRequest request);
  $async.Future<$1.ListTherapistsResponse> matchTherapists(
      $pb.ServerContext ctx, $1.MatchTherapistsRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetProfile':
        return $1.GetTherapistProfileRequest();
      case 'GetProfileByUserId':
        return $1.GetTherapistByUserIdRequest();
      case 'ListProfiles':
        return $1.ListTherapistsRequest();
      case 'CreateProfile':
        return $1.CreateTherapistProfileRequest();
      case 'UpdateProfile':
        return $1.UpdateTherapistProfileRequest();
      case 'MatchTherapists':
        return $1.MatchTherapistsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetProfile':
        return getProfile(ctx, request as $1.GetTherapistProfileRequest);
      case 'GetProfileByUserId':
        return getProfileByUserId(
            ctx, request as $1.GetTherapistByUserIdRequest);
      case 'ListProfiles':
        return listProfiles(ctx, request as $1.ListTherapistsRequest);
      case 'CreateProfile':
        return createProfile(ctx, request as $1.CreateTherapistProfileRequest);
      case 'UpdateProfile':
        return updateProfile(ctx, request as $1.UpdateTherapistProfileRequest);
      case 'MatchTherapists':
        return matchTherapists(ctx, request as $1.MatchTherapistsRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => TherapistServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => TherapistServiceBase$messageJson;
}
