import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_state.freezed.dart';

@freezed
class AdminState with _$AdminState {
  const factory AdminState.initial() = _Initial;
  const factory AdminState.loading() = _Loading;
  
  const factory AdminState.loaded({
    // Dashboard
    required Map<String, dynamic> stats,
    
    // Therapists
    @Default([]) List<dynamic> therapists,
    @Default(0) int totalTherapists,
    @Default('all') String therapistFilter,
    @Default('') String therapistSearch,
    
    // Users
    @Default([]) List<dynamic> users,
    @Default(0) int totalUsers,
    @Default('all') String userRoleFilter,
    @Default('') String userSearch,
    
    // Appointments
    @Default([]) List<dynamic> appointments,
    @Default(0) int totalAppointments,
    @Default('all') String appointmentFilter,
    
    // Content
    @Default([]) List<dynamic> content,
    @Default(0) int totalContent,
    @Default('all') String contentFilter,
    
    // Loading states for operations
    @Default(false) bool isVerifyingTherapist,
    @Default(false) bool isDeletingTherapist,
    @Default(false) bool isUpdatingUser,
    @Default(false) bool isDeletingContent,
  }) = _Loaded;

  const factory AdminState.error(String message) = _Error;
}
