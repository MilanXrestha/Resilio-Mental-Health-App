import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../bloc/therapist_cubit.dart';
import '../../bloc/therapist_state.dart';

class TherapistAppointmentsTab extends StatelessWidget {
  const TherapistAppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sessions')),
      body: BlocBuilder<TherapistCubit, TherapistState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(child: Text('Error: $msg')),
            loaded: (profile, today, upcoming) {
              final allSessions = [...today, ...upcoming];
              if (allSessions.isEmpty) {
                return const Center(child: Text('No sessions right now.'));
              }
              return ListView.builder(
                padding: EdgeInsets.all(24.w),
                itemCount: allSessions.length,
                itemBuilder: (context, index) {
                  final session = allSessions[index];
                  final patientName = session['userName'] ?? 'Patient';
                  final time = session['startTime'] ?? 'TBD';
                  final status = session['status'] ?? 'Scheduled';

                  return Card(
                    margin: EdgeInsets.only(bottom: 16.h),
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(patientName),
                      subtitle: Text('$time\nStatus: $status'),
                      isThreeLine: true,
                      trailing: ElevatedButton(
                        onPressed: () {
                          final userId = profile['id'] ?? '';
                          final appointmentId = session['id'] ?? '';
                          context.push('/video-call/$appointmentId/$userId');
                        },
                        child: const Text('Join'),
                      ),
                    ),
                  );
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

