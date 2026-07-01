import 'package:dio/dio.dart';

import 'package:Resilio/core/constants/api_endpoints.dart';
import 'package:Resilio/core/di/injection.dart';

/// A therapist the patient has booked, and whether mood logs are shared.
class TherapistShareCandidate {
  final String therapistId;
  final String displayName;
  final String photoUrl;
  final bool shared;

  const TherapistShareCandidate({
    required this.therapistId,
    required this.displayName,
    required this.photoUrl,
    required this.shared,
  });

  factory TherapistShareCandidate.fromJson(Map<String, dynamic> j) =>
      TherapistShareCandidate(
        therapistId: j['therapistId'] as String? ?? '',
        displayName: j['displayName'] as String? ?? 'Therapist',
        photoUrl: j['photoUrl'] as String? ?? '',
        shared: j['shared'] as bool? ?? false,
      );
}

/// Calls the /mood/* endpoints. Lets a patient share/revoke their mood logs
/// with therapists they have booked.
class MoodShareService {
  final Dio _dio = getIt<Dio>();

  // ST/JSON endpoints — override the global protobuf bytes response type.
  Options get _json => Options(
        responseType: ResponseType.json,
        headers: const {'Accept': 'application/json'},
      );

  Future<List<TherapistShareCandidate>> getCandidates() async {
    final res = await _dio.get(ApiEndpoints.moodShareCandidates, options: _json);
    final list = (res.data['data'] as List?) ?? [];
    return list
        .map((e) => TherapistShareCandidate.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> share(String therapistId) async {
    await _dio.post(
      ApiEndpoints.moodShare,
      data: {'therapistId': therapistId},
      options: Options(
        responseType: ResponseType.json,
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<void> revoke(String therapistId) async {
    await _dio.delete('${ApiEndpoints.moodShare}/$therapistId', options: _json);
  }
}
