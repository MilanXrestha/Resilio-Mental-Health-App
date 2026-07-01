import '../../widgets/shimmer_therapist_widgets.dart';
import 'package:Resilio/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../features/customer/auth/presentation/bloc/auth_bloc.dart';
import '../../../../../../features/customer/auth/presentation/bloc/auth_state.dart';
import '../../bloc/therapist_cubit.dart';
import '../../bloc/therapist_state.dart';

class TherapistAppointmentsTab extends StatefulWidget {
  const TherapistAppointmentsTab({super.key});

  @override
  State<TherapistAppointmentsTab> createState() =>
      _TherapistAppointmentsTabState();
}

class _TherapistAppointmentsTabState extends State<TherapistAppointmentsTab> {
  String _activeFilter = 'all';

  static const _filters = ['all', 'today', 'upcoming', 'pending', 'completed'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TherapistCubit>().loadAppointments(filter: _activeFilter);
    });
  }

  /// Returns true when now is within the joinable window:
  /// up to 15 min before the session starts, up to 2 h after.
  bool _canJoinNow(Map<String, dynamic> appt) {
    final timeStr = appt['scheduledTime'] as String?;
    if (timeStr == null) return false;
    final dt = DateTime.tryParse(timeStr)?.toLocal();
    if (dt == null) return false;
    final now = DateTime.now();
    return dt.isBefore(now.add(const Duration(minutes: 15))) &&
        dt.isAfter(now.subtract(const Duration(hours: 2)));
  }

  void _setFilter(String f) {
    setState(() => _activeFilter = f);
    context.read<TherapistCubit>().loadAppointments(filter: f);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              child: Text(
                AppLocalizations.of(context)!.thrSessions,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // ── Filter Chips ──────────────────────────────────────────────────
            SizedBox(
              height: 36.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                separatorBuilder: (_, _) => SizedBox(width: 8.w),
                itemCount: _filters.length,
                itemBuilder: (context, i) {
                  final f = _filters[i];
                  final selected = _activeFilter == f;
                  return GestureDetector(
                    onTap: () => _setFilter(f),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? context.primaryColor
                            : context.surfaceColor,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: selected
                              ? context.primaryColor
                              : context.borderColor,
                        ),
                      ),
                      child: Text(
                        _capitalize(f),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? Colors.white
                              : context.textSecondaryColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            // ── List ──────────────────────────────────────────────────────────
            Expanded(
              child: BlocBuilder<TherapistCubit, TherapistState>(
                builder: (context, state) {
                  if (state.isLoading && !state.hasAppointments) {
                    return const TherapistListShimmer();
                  }
                  if (state.errorMessage != null && !state.hasAppointments) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 48.sp,
                            color: context.errorColor,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            AppLocalizations.of(context)!.thrCouldNotLoadSessions,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.sp,
                              color: context.textSecondaryColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextButton(
                            onPressed: () => _setFilter(_activeFilter),
                            child: Text(AppLocalizations.of(context)!.thrRetry),
                          ),
                        ],
                      ),
                    );
                  }
                  if (!state.hasAppointments) {
                    return const SizedBox.shrink();
                  }
                  if (state.appointments!.isEmpty) {
                    return _emptyState(context);
                  }
                  return RefreshIndicator(
                    color: context.primaryColor,
                    onRefresh: () async => _setFilter(_activeFilter),
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: state.appointments!.length,
                      separatorBuilder: (_, _) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final appt = state.appointments![index];
                        final id = appt['id'] as String? ?? '';
                        final room = appt['meetingRoomId'] as String? ?? id;
                        final patientName =
                            (appt['patient']
                                    as Map<String, dynamic>?)?['displayName']
                                as String? ??
                            'Patient';
                        final joinable = _canJoinNow(appt);
                        return _SessionCard(
                          appointment: appt,
                          canJoin: joinable,
                          onAccept: () => context
                              .read<TherapistCubit>()
                              .updateAppointmentStatus(
                                id,
                                'confirmed',
                                currentFilter: _activeFilter,
                              ),
                          onDecline: () => context
                              .read<TherapistCubit>()
                              .updateAppointmentStatus(
                                id,
                                'cancelled',
                                currentFilter: _activeFilter,
                              ),
                          onJoin: joinable
                              ? () {
                                  final auth = context.read<AuthBloc>().state;
                                  final currentUserId =
                                      auth is AuthAuthenticated
                                      ? auth.user.id
                                      : room;
                                  context
                                      .read<TherapistCubit>()
                                      .notifyCallStart(id);
                                  context.push(
                                    '/video-call/$id/$currentUserId',
                                    extra: {'callerName': patientName},
                                  );
                                }
                              : null,
                          onChat: () => context.push(
                            '/appointments/$id/chat',
                            extra: appt,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_busy_rounded,
            size: 64.sp,
            color: context.textSecondaryColor.withOpacity(0.4),
          ),
          SizedBox(height: 16.h),
          Text(
            AppLocalizations.of(context)!.thrNoSessionsFound,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            AppLocalizations.of(context)!.thrSessionsForFilterAppearHere(_activeFilter),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Session Card ───────────────────────────────────────────────────────────────
class _SessionCard extends StatelessWidget {
  final Map<String, dynamic> appointment;
  final bool canJoin;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback? onJoin;
  final VoidCallback onChat;

  const _SessionCard({
    required this.appointment,
    required this.canJoin,
    required this.onAccept,
    required this.onDecline,
    required this.onJoin,
    required this.onChat,
  });

  Color _statusColor(String status) {
    switch (status) {
      case 'confirmed':
        return const Color(0xFF10B981);
      case 'completed':
        return const Color(0xFF6366F1);
      case 'pending':
        return const Color(0xFFF59E0B);
      case 'cancelled':
        return const Color(0xFFE11D48);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  @override
  Widget build(BuildContext context) {
    final patient = appointment['patient'] as Map<String, dynamic>? ?? {};
    final name = patient['displayName'] as String? ?? 'Patient';
    final status = appointment['status'] as String? ?? 'pending';
    final timeStr = appointment['scheduledTime'] as String?;
    DateTime? time;
    if (timeStr != null) time = DateTime.tryParse(timeStr);
    final timeFormatted = time != null
        ? DateFormat('EEE, MMM d · h:mm a').format(time.toLocal())
        : 'TBD';
    final statusColor = _statusColor(status);

    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.borderColor, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: context.primaryColor.withOpacity(0.1),
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : 'P',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: context.primaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        timeFormatted,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Action buttons
          if (status == 'pending') ...[
            Divider(height: 0, color: context.dividerColor),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onDecline,
                          icon: Icon(Icons.close_rounded, size: 16.sp),
                          label: Text(AppLocalizations.of(context)!.thrDecline),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: context.errorColor,
                            side: BorderSide(
                              color: context.errorColor.withOpacity(0.4),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onAccept,
                          icon: Icon(Icons.check_rounded, size: 16.sp),
                          label: Text(AppLocalizations.of(context)!.thrAccept),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.primaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: onChat,
                      icon: Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 16.sp,
                      ),
                      label: Text(AppLocalizations.of(context)!.thrMessagePatient),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: context.primaryColor,
                        side: BorderSide(
                          color: context.primaryColor.withOpacity(0.35),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        textStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (status == 'confirmed') ...[
            Divider(height: 0, color: context.dividerColor),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onJoin,
                      icon: Icon(Icons.video_call_rounded, size: 18.sp),
                      label: Text(
                        canJoin
                            ? AppLocalizations.of(context)!.thrJoinSession
                            : AppLocalizations.of(context)!.thrNotSessionTime,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: canJoin
                            ? context.primaryColor
                            : context.textSecondaryColor.withOpacity(0.3),
                        foregroundColor: canJoin
                            ? Colors.white
                            : context.textSecondaryColor,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        textStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  if (!canJoin) ...[
                    SizedBox(height: 4.h),
                    Text(
                      AppLocalizations.of(context)!.thrJoinButtonActivatesHint,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10.sp,
                        color: context.textSecondaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: 6.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: onChat,
                      icon: Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 16.sp,
                      ),
                      label: Text(AppLocalizations.of(context)!.thrMessagePatient),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: context.primaryColor,
                        side: BorderSide(
                          color: context.primaryColor.withOpacity(0.35),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        textStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
