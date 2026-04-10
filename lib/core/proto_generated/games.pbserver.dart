// This is a generated file - do not edit.
//
// Generated from games.proto.

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
import 'games.pb.dart' as $1;
import 'games.pbjson.dart';

export 'games.pb.dart';

abstract class GamesServiceBase extends $pb.GeneratedService {
  $async.Future<$1.GameSession> saveGameSession(
      $pb.ServerContext ctx, $1.SaveGameSessionRequest request);
  $async.Future<$1.MoodEntry> saveMoodEntry(
      $pb.ServerContext ctx, $1.SaveMoodEntryRequest request);
  $async.Future<$1.ListMoodEntriesResponse> listMoodEntries(
      $pb.ServerContext ctx, $1.ListMoodEntriesRequest request);
  $async.Future<$1.ListUserAchievementsResponse> listUserAchievements(
      $pb.ServerContext ctx, $1.ListUserAchievementsRequest request);
  $async.Future<$1.Affirmation> saveAffirmation(
      $pb.ServerContext ctx, $1.SaveAffirmationRequest request);
  $async.Future<$1.ListAffirmationsResponse> listAffirmations(
      $pb.ServerContext ctx, $1.ListAffirmationsRequest request);
  $async.Future<$0.Empty> deleteAffirmation(
      $pb.ServerContext ctx, $1.DeleteAffirmationRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'SaveGameSession':
        return $1.SaveGameSessionRequest();
      case 'SaveMoodEntry':
        return $1.SaveMoodEntryRequest();
      case 'ListMoodEntries':
        return $1.ListMoodEntriesRequest();
      case 'ListUserAchievements':
        return $1.ListUserAchievementsRequest();
      case 'SaveAffirmation':
        return $1.SaveAffirmationRequest();
      case 'ListAffirmations':
        return $1.ListAffirmationsRequest();
      case 'DeleteAffirmation':
        return $1.DeleteAffirmationRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'SaveGameSession':
        return saveGameSession(ctx, request as $1.SaveGameSessionRequest);
      case 'SaveMoodEntry':
        return saveMoodEntry(ctx, request as $1.SaveMoodEntryRequest);
      case 'ListMoodEntries':
        return listMoodEntries(ctx, request as $1.ListMoodEntriesRequest);
      case 'ListUserAchievements':
        return listUserAchievements(
            ctx, request as $1.ListUserAchievementsRequest);
      case 'SaveAffirmation':
        return saveAffirmation(ctx, request as $1.SaveAffirmationRequest);
      case 'ListAffirmations':
        return listAffirmations(ctx, request as $1.ListAffirmationsRequest);
      case 'DeleteAffirmation':
        return deleteAffirmation(ctx, request as $1.DeleteAffirmationRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => GamesServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => GamesServiceBase$messageJson;
}
