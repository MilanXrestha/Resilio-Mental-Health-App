import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_state.freezed.dart';

@freezed
class AdminState with _$AdminState {
  const factory AdminState.initial() = _Initial;
  const factory AdminState.loading() = _Loading;
  
  const factory AdminState.loaded({
    required Map<String, dynamic> stats,
    @Default([]) List<dynamic> users,
    @Default([]) List<dynamic> pendingTherapists,
    @Default([]) List<dynamic> approvedTherapists,
  }) = _Loaded;

  const factory AdminState.error(String message) = _Error;
}
