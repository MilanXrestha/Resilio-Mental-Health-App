import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/proto_generated/audio.pb.dart';

@LazySingleton()
class AudioRemoteDataSource {
  final Dio _dio;

  AudioRemoteDataSource(this._dio);

  Future<List<AudioTrack>> getFeaturedAudio({
    int limit = 10,
    List<String>? moodFilters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'limit': limit.toString(),
      };
      
      if (moodFilters != null && moodFilters.isNotEmpty) {
        queryParams['mood_filters'] = moodFilters.join(',');
      }

      final response = await _dio.get(
        ApiEndpoints.audioFeatured,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Accept': 'application/x-protobuf',
          },
        ),
      );

      if (response.statusCode == 200) {
        final result = GetFeaturedAudioResponse.fromBuffer(response.data as Uint8List);
        return result.tracks;
      } else {
        throw ServerFailure('Failed to get featured audio: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure('Network error: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw ServerFailure('Failed to get featured audio: $e');
    }
  }

  /// Fetch all audio tracks (no featured filter) — used by Explore / See All.
  Future<List<AudioTrack>> getAllAudio({int limit = 100}) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.audio,
        queryParameters: {'limit': limit.toString()},
        options: Options(
          headers: {'Accept': 'application/x-protobuf'},
          responseType: ResponseType.bytes,
        ),
      );
      if (response.statusCode == 200 && response.data != null) {
        final result = GetAudioTracksResponse.fromBuffer(response.data as List<int>);
        return result.tracks;
      }
      throw ServerFailure('Failed to fetch audio: status ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerFailure('Network error: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw ServerFailure('Failed to get all audio: $e');
    }
  }

  Future<GetAudioTracksResponse> getAudioByCategory({
    required String categoryId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.audioCategory}/$categoryId',
        queryParameters: {
          'limit': limit.toString(),
          'offset': offset.toString(),
        },
        options: Options(
          headers: {
            'Accept': 'application/x-protobuf',
          },
        ),
      );

      if (response.statusCode == 200) {
        return GetAudioTracksResponse.fromBuffer(response.data as Uint8List);
      } else {
        throw ServerFailure('Failed to get audio by category: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure('Network error: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw ServerFailure('Failed to get audio by category: $e');
    }
  }

  Future<AudioTrack> getAudioTrackById(String audioId) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.audio}/$audioId',
        options: Options(
          headers: {
            'Accept': 'application/x-protobuf',
          },
        ),
      );

      if (response.statusCode == 200) {
        final result = GetAudioTrackResponse.fromBuffer(response.data as Uint8List);
        return result.track;
      } else {
        throw ServerFailure('Audio track not found');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw ServerFailure('Audio track not found');
      }
      throw ServerFailure('Network error: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw ServerFailure('Failed to get audio track: $e');
    }
  }

  Future<void> incrementPlayCount(String audioId) async {
    try {
      await _dio.post(
        '${ApiEndpoints.audio}/$audioId/play',
      );
    } on DioException catch (e) {
      throw ServerFailure('Failed to increment play count: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw ServerFailure('Failed to increment play count: $e');
    }
  }
}
