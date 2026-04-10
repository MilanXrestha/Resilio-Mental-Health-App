import 'package:freezed_annotation/freezed_annotation.dart';

part 'therapist_state.freezed.dart';

@freezed
class TherapistState with _$TherapistState {
  const factory TherapistState.initial() = _Initial;
  const factory TherapistState.loading() = _Loading;
  
  const factory TherapistState.loaded({
    required Map<String, dynamic> profile,
    @Default([]) List<dynamic> todayAppointments,
    @Default([]) List<dynamic> upcomingAppointments,
  }) = _Loaded;

  const factory TherapistState.error(String message) = _Error;
}
