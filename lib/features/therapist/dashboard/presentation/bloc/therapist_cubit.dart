import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/features/therapist/dashboard/domain/repositories/therapist_repository.dart';
import 'therapist_state.dart';

@injectable
class TherapistCubit extends Cubit<TherapistState> {
  final TherapistRepository _repository;

  TherapistCubit(this._repository) : super(const TherapistState.initial());

  Future<void> loadDashboard() async {
    emit(const TherapistState.loading());
    try {
      final profile = await _repository.getMyProfile();
      final allAppointments = await _repository.getMyAppointments();

      // Separate into today and upcoming based on basic date logic
      final today = <dynamic>[];
      final upcoming = <dynamic>[];
      final now = DateTime.now();

      for (var app in allAppointments) {
        final startTimeStr = app['startTime'];
        if (startTimeStr != null) {
          final date = DateTime.tryParse(startTimeStr);
          if (date != null && 
              date.year == now.year && 
              date.month == now.month && 
              date.day == now.day) {
            today.add(app);
          } else {
            upcoming.add(app);
          }
        } else {
          upcoming.add(app);
        }
      }
      
      emit(TherapistState.loaded(
        profile: profile,
        todayAppointments: today,
        upcomingAppointments: upcoming,
      ));
    } catch (e) {
      emit(TherapistState.error(e.toString()));
    }
  }

  Future<void> updateAvailability(Map<String, dynamic> data) async {
    try {
      await _repository.updateAvailability(data);
      // reload after update
      await loadDashboard();
    } catch (e) {
      // Handle error gracefully via UI
    }
  }
}
