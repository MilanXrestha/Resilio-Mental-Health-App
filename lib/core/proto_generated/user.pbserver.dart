// This is a generated file - do not edit.
//
// Generated from user.proto.

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
import 'user.pb.dart' as $1;
import 'user.pbjson.dart';

export 'user.pb.dart';

abstract class UserServiceBase extends $pb.GeneratedService {
  $async.Future<$1.CreateUserResponse> createUser(
      $pb.ServerContext ctx, $1.CreateUserRequest request);
  $async.Future<$1.User> getUser(
      $pb.ServerContext ctx, $1.GetUserRequest request);
  $async.Future<$1.User> getUserByFirebaseUid(
      $pb.ServerContext ctx, $1.GetUserByFirebaseUidRequest request);
  $async.Future<$1.User> updateUser(
      $pb.ServerContext ctx, $1.UpdateUserRequest request);
  $async.Future<$0.Empty> deleteUser(
      $pb.ServerContext ctx, $1.DeleteUserRequest request);
  $async.Future<$1.ListUsersResponse> listUsers(
      $pb.ServerContext ctx, $1.ListUsersRequest request);
  $async.Future<$1.User> syncUser(
      $pb.ServerContext ctx, $1.SyncUserRequest request);
  $async.Future<$1.UserPreferences> getUserPreferences(
      $pb.ServerContext ctx, $1.GetUserRequest request);
  $async.Future<$1.UserPreferences> updateUserPreferences(
      $pb.ServerContext ctx, $1.UpdateUserPreferencesRequest request);
  $async.Future<$1.WellnessProfile> getWellnessProfile(
      $pb.ServerContext ctx, $1.GetUserRequest request);
  $async.Future<$1.WellnessProfile> updateWellnessProfile(
      $pb.ServerContext ctx, $1.UpdateWellnessProfileRequest request);
  $async.Future<$1.ListPreferencesResponse> getPreferences(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$1.ListPreferencesResponse> getUserSelectedPreferences(
      $pb.ServerContext ctx, $0.Empty request);
  $async.Future<$1.ListPreferencesResponse> saveUserPreferences(
      $pb.ServerContext ctx, $1.SavePreferencesRequest request);
  $async.Future<$1.PreferenceCompletionStatus> checkPreferencesCompletion(
      $pb.ServerContext ctx, $0.Empty request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'CreateUser':
        return $1.CreateUserRequest();
      case 'GetUser':
        return $1.GetUserRequest();
      case 'GetUserByFirebaseUid':
        return $1.GetUserByFirebaseUidRequest();
      case 'UpdateUser':
        return $1.UpdateUserRequest();
      case 'DeleteUser':
        return $1.DeleteUserRequest();
      case 'ListUsers':
        return $1.ListUsersRequest();
      case 'SyncUser':
        return $1.SyncUserRequest();
      case 'GetUserPreferences':
        return $1.GetUserRequest();
      case 'UpdateUserPreferences':
        return $1.UpdateUserPreferencesRequest();
      case 'GetWellnessProfile':
        return $1.GetUserRequest();
      case 'UpdateWellnessProfile':
        return $1.UpdateWellnessProfileRequest();
      case 'GetPreferences':
        return $0.Empty();
      case 'GetUserSelectedPreferences':
        return $0.Empty();
      case 'SaveUserPreferences':
        return $1.SavePreferencesRequest();
      case 'CheckPreferencesCompletion':
        return $0.Empty();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'CreateUser':
        return createUser(ctx, request as $1.CreateUserRequest);
      case 'GetUser':
        return getUser(ctx, request as $1.GetUserRequest);
      case 'GetUserByFirebaseUid':
        return getUserByFirebaseUid(
            ctx, request as $1.GetUserByFirebaseUidRequest);
      case 'UpdateUser':
        return updateUser(ctx, request as $1.UpdateUserRequest);
      case 'DeleteUser':
        return deleteUser(ctx, request as $1.DeleteUserRequest);
      case 'ListUsers':
        return listUsers(ctx, request as $1.ListUsersRequest);
      case 'SyncUser':
        return syncUser(ctx, request as $1.SyncUserRequest);
      case 'GetUserPreferences':
        return getUserPreferences(ctx, request as $1.GetUserRequest);
      case 'UpdateUserPreferences':
        return updateUserPreferences(
            ctx, request as $1.UpdateUserPreferencesRequest);
      case 'GetWellnessProfile':
        return getWellnessProfile(ctx, request as $1.GetUserRequest);
      case 'UpdateWellnessProfile':
        return updateWellnessProfile(
            ctx, request as $1.UpdateWellnessProfileRequest);
      case 'GetPreferences':
        return getPreferences(ctx, request as $0.Empty);
      case 'GetUserSelectedPreferences':
        return getUserSelectedPreferences(ctx, request as $0.Empty);
      case 'SaveUserPreferences':
        return saveUserPreferences(ctx, request as $1.SavePreferencesRequest);
      case 'CheckPreferencesCompletion':
        return checkPreferencesCompletion(ctx, request as $0.Empty);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => UserServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => UserServiceBase$messageJson;
}
