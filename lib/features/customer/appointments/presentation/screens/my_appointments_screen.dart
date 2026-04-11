import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  final _dio = getIt<Dio>();
  final _notifPlugin = FlutterLocalNotificationsPlugin();

  late final TabController _tabController;

  List<Map<String, dynamic>> _upcoming = [];
  List<Map<String, dynamic>> _past = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initNotifications();
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _initNotifications() async {
    tz_data.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    await _notifPlugin.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
    );
  }

  Future<void> _scheduleSessionReminder(
      Map<String, dynamic> appt, Map<String, dynamic>? therapist) async {
    final dt = _parseDate(appt);
    if (dt == null) return;

    final reminderTime = dt.subtract(const Duration(minutes: 15));
    if (reminderTime.isBefore(DateTime.now())) return;

    final therapistName =
        _extractTherapistName(therapist) ?? 'your therapist';
    final idHash = appt['id'].toString().hashCode.abs() % 100000;

    try {
      final tzReminder = tz.TZDateTime.from(reminderTime, tz.local);
      await _notifPlugin.zonedSchedule(
        id: idHash,
        title: 'Session in 15 minutes',
        body: 'Your session with $therapistName starts soon.',
        scheduledDate: tzReminder,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'appointment_reminders',
            'Appointment Reminders',
            channelDescription: 'Upcoming session reminders',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (_) {}
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      // 1. Load appointments
      final res = await _dio.get('/appointments');
      final raw = res.data;
      final rawList = (raw is Map
          ? (raw['appointments'] ?? raw['data'] ?? raw['items'] ?? [])
          : raw is List
              ? raw
              : []) as List<dynamic>;
      var all = rawList.cast<Map<String, dynamic>>();

      // 2. Load all therapists and build a lookup map by profile id
      final Map<String, Map<String, dynamic>> therapistById = {};
      try {
        final tRes = await _dio.get('/therapists', queryParameters: {'limit': 100});
        final tList =
            (tRes.data['therapists'] as List<dynamic>? ?? [])
                .cast<Map<String, dynamic>>();
        for (final t in tList) {
          final tid = t['id'] as String?;
          final uid = t['userId'] as String? ?? t['user_id'] as String?;
          if (tid != null) therapistById[tid] = t;
          if (uid != null) therapistById[uid] = t;
        }
      } catch (_) {}

      // 3. Inject therapist profile into each appointment
      all = all.map((a) {
        final tid = a['therapistId'] as String?;
        if (tid != null && therapistById.containsKey(tid)) {
          return Map<String, dynamic>.from(a)
            ..['therapist'] = therapistById[tid];
        }
        return a;
      }).toList();

      // 4. Split into upcoming / past
      final now = DateTime.now();
      final upcoming = <Map<String, dynamic>>[];
      final past = <Map<String, dynamic>>[];

      for (final appt in all) {
        final dt = _parseDate(appt);
        if (dt != null && dt.isAfter(now)) {
          upcoming.add(appt);
        } else {
          past.add(appt);
        }
      }

      upcoming.sort((a, b) => (_parseDate(a) ?? DateTime(2000))
          .compareTo(_parseDate(b) ?? DateTime(2000)));
      past.sort((a, b) => (_parseDate(b) ?? DateTime(2000))
          .compareTo(_parseDate(a) ?? DateTime(2000)));

      // 5. Schedule session-start reminders for upcoming confirmed sessions
      for (final appt in upcoming) {
        final status = (appt['status'] as String? ?? '').toLowerCase();
        if (status == 'confirmed' || status == 'accepted' || status == 'scheduled') {
          _scheduleSessionReminder(
              appt, appt['therapist'] as Map<String, dynamic>?);
        }
      }

      if (mounted) {
        setState(() {
          _upcoming = upcoming;
          _past = past;
          _loading = false;
        });
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() {
          _error = e.response?.data?['error']?.toString() ??
              e.message ??
              'Failed to load appointments';
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  static String? _extractTherapistName(Map<String, dynamic>? t) {
    if (t == null) return null;
    final name = t['displayName'] as String? ??
        t['display_name'] as String? ??
        t['name'] as String? ??
        t['fullName'] as String? ??
        t['full_name'] as String?;
    if (name != null && name.isNotEmpty) return name;
    return null;
  }

  /// Handles both camelCase and snake_case field names from the API
  static DateTime? _parseDate(Map<String, dynamic> appt) {
    final s = appt['scheduledTime'] as String? ??
        appt['scheduled_time'] as String? ??
        appt['scheduled_at'] as String? ??
        appt['start_time'] as String? ??
        appt['date'] as String?;
    if (s == null) return null;
    return DateTime.tryParse(s)?.toLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: context.textPrimaryColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'My Therapy',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: context.primaryColor,
          unselectedLabelColor: context.textSecondaryColor,
          indicatorColor: context.primaryColor,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Upcoming'),
                  if (_upcoming.isNotEmpty) ...[
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: context.primaryColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        '${_upcoming.length}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Tab(text: 'Past'),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _ErrorView(error: _error!, onRetry: _load)
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _AppointmentList(
                      appointments: _upcoming,
                      emptyIcon: Icons.event_available_rounded,
                      emptyTitle: 'No upcoming sessions',
                      emptySubtitle:
                          'Book a session with a therapist to get started.',
                      showJoinButton: true,
                      onFindTherapist: () =>
                          context.pushNamed(RouteNames.matching),
                    ),
                    _AppointmentList(
                      appointments: _past,
                      emptyIcon: Icons.history_rounded,
                      emptyTitle: 'No past sessions',
                      emptySubtitle:
                          'Your completed sessions will appear here.',
                      showJoinButton: false,
                      onFindTherapist: null,
                    ),
                  ],
                ),
    );
  }
}

// ── Error view ─────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded,
                size: 56.sp,
                color: context.textSecondaryColor.withValues(alpha: 0.4)),
            SizedBox(height: 16.h),
            Text(
              'Could not load appointments',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                color: context.textSecondaryColor,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh_rounded, size: 16.sp),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
                textStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Appointment list ───────────────────────────────────────────────────────────

class _AppointmentList extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;
  final IconData emptyIcon;
  final String emptyTitle;
  final String emptySubtitle;
  final bool showJoinButton;
  final VoidCallback? onFindTherapist;

  const _AppointmentList({
    required this.appointments,
    required this.emptyIcon,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.showJoinButton,
    required this.onFindTherapist,
  });

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(emptyIcon,
                  size: 64.sp,
                  color:
                      context.textSecondaryColor.withValues(alpha: 0.4)),
              SizedBox(height: 16.h),
              Text(
                emptyTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                emptySubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.sp,
                  color: context.textSecondaryColor,
                  height: 1.5,
                ),
              ),
              if (onFindTherapist != null) ...[
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: onFindTherapist,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    elevation: 0,
                    textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Find a Therapist'),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 100.h),
      itemCount: appointments.length,
      itemBuilder: (context, i) => _AppointmentCard(
        appointment: appointments[i],
        showJoinButton: showJoinButton,
      ),
    );
  }
}

// ── Appointment card ───────────────────────────────────────────────────────────

class _AppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointment;
  final bool showJoinButton;

  const _AppointmentCard({
    required this.appointment,
    required this.showJoinButton,
  });

  String _therapistName() {
    final t = appointment['therapist'] as Map<String, dynamic>?;
    if (t != null) {
      return t['displayName'] as String? ??
          t['display_name'] as String? ??
          t['name'] as String? ??
          t['fullName'] as String? ??
          t['full_name'] as String? ??
          'Therapist';
    }
    return appointment['therapistName'] as String? ??
        appointment['therapist_name'] as String? ??
        'Therapist';
  }

  String _therapistTitle() {
    final t = appointment['therapist'] as Map<String, dynamic>?;
    if (t != null) {
      return t['specialty'] as String? ??
          t['specialization'] as String? ??
          t['title'] as String? ??
          '';
    }
    return '';
  }

  String? _avatarUrl() {
    final t = appointment['therapist'] as Map<String, dynamic>?;
    if (t != null) {
      return t['profileImageUrl'] as String? ??
          t['profile_image_url'] as String? ??
          t['profilePictureUrl'] as String? ??
          t['profile_picture_url'] as String?;
    }
    return null;
  }

  num? _fee() {
    final t = appointment['therapist'] as Map<String, dynamic>?;
    if (t != null) {
      final f = t['consultationFee'] ?? t['consultation_fee'];
      if (f != null) return f as num;
    }
    return null;
  }

  DateTime? _parseDate() {
    final s = appointment['scheduledTime'] as String? ??
        appointment['scheduled_time'] as String? ??
        appointment['scheduled_at'] as String? ??
        appointment['start_time'] as String? ??
        appointment['date'] as String?;
    if (s == null) return null;
    return DateTime.tryParse(s)?.toLocal();
  }

  @override
  Widget build(BuildContext context) {
    final therapistName = _therapistName();
    final therapistTitle = _therapistTitle();
    final avatarUrl = _avatarUrl();
    final fee = _fee();
    final dt = _parseDate();
    final status =
        (appointment['status'] as String? ?? 'pending').toLowerCase();
    final appointmentId = appointment['id'] as String? ?? '';

    final statusColor = _statusColor(status, context);
    final statusLabel = _statusLabel(status);

    final now = DateTime.now();
    final canJoin = showJoinButton &&
        dt != null &&
        dt.isBefore(now.add(const Duration(minutes: 15))) &&
        dt.isAfter(now.subtract(const Duration(hours: 2))) &&
        (status == 'confirmed' ||
            status == 'accepted' ||
            status == 'scheduled');

    final userId = appointment['patientId'] as String? ??
        appointment['patient_id'] as String? ??
        appointment['userId'] as String? ??
        '';

    return GestureDetector(
      onTap: () => context.push('/appointments/$appointmentId/chat',
          extra: appointment),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: context.borderColor, width: 0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Therapist + status ──────────────────────────────────
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor:
                      context.primaryColor.withValues(alpha: 0.12),
                  backgroundImage:
                      avatarUrl != null ? NetworkImage(avatarUrl) : null,
                  child: avatarUrl == null
                      ? Text(
                          therapistName.isNotEmpty
                              ? therapistName[0].toUpperCase()
                              : 'T',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: context.primaryColor,
                            fontSize: 16.sp,
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. $therapistName',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      if (therapistTitle.isNotEmpty)
                        Text(
                          therapistTitle,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.sp,
                            color: context.textSecondaryColor,
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 14.h),
            Divider(color: context.dividerColor, height: 1),
            SizedBox(height: 12.h),

            // ── Date / time + fee ───────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: dt != null
                      ? Row(
                          children: [
                            Icon(Icons.calendar_today_rounded,
                                size: 14.sp,
                                color: context.textSecondaryColor),
                            SizedBox(width: 6.w),
                            Flexible(
                              child: Text(
                                DateFormat('EEE, MMM d · h:mm a').format(dt),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13.sp,
                                  color: context.textSecondaryColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'Date not set',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            color: context.textSecondaryColor
                                .withValues(alpha: 0.6),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                ),
                if (fee != null) ...[
                  SizedBox(width: 8.w),
                  Row(
                    children: [
                      Icon(Icons.payments_outlined,
                          size: 14.sp, color: context.primaryColor),
                      SizedBox(width: 4.w),
                      Text(
                        'NPR ${fee.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: context.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),

            // ── Chat hint ───────────────────────────────────────────
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.chat_bubble_outline_rounded,
                    size: 13.sp, color: context.textSecondaryColor),
                SizedBox(width: 5.w),
                Text(
                  'Tap to message your therapist',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.sp,
                    color: context.textSecondaryColor,
                  ),
                ),
                const Spacer(),
                Icon(Icons.chevron_right_rounded,
                    size: 18.sp, color: context.textSecondaryColor),
              ],
            ),

            // ── Join button ─────────────────────────────────────────
            if (canJoin) ...[
              SizedBox(height: 14.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.push('/video-call/$appointmentId/$userId');
                  },
                  icon: Icon(Icons.video_call_rounded, size: 18.sp),
                  label: const Text('Join Session'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    textStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ] else if (showJoinButton &&
                dt != null &&
                dt.isAfter(DateTime.now())) ...[
              SizedBox(height: 10.h),
              _CountdownChip(sessionTime: dt),
            ],
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status, BuildContext context) {
    switch (status) {
      case 'confirmed':
      case 'accepted':
      case 'scheduled':
        return context.successColor;
      case 'cancelled':
      case 'rejected':
        return context.errorColor;
      case 'completed':
        return context.primaryColor;
      case 'pending':
        return const Color(0xFFF59E0B);
      default:
        return context.textSecondaryColor;
    }
  }

  String _statusLabel(String status) {
    if (status.isEmpty) return 'Unknown';
    return '${status[0].toUpperCase()}${status.substring(1)}';
  }
}

// ── Countdown chip ─────────────────────────────────────────────────────────────

class _CountdownChip extends StatelessWidget {
  final DateTime sessionTime;

  const _CountdownChip({required this.sessionTime});

  @override
  Widget build(BuildContext context) {
    final diff = sessionTime.difference(DateTime.now());
    String label;
    if (diff.inDays > 0) {
      label = 'In ${diff.inDays}d ${diff.inHours.remainder(24)}h';
    } else if (diff.inHours > 0) {
      label = 'In ${diff.inHours}h ${diff.inMinutes.remainder(60)}m';
    } else {
      label = 'In ${diff.inMinutes}m';
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer_outlined,
            size: 13.sp, color: context.textSecondaryColor),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11.sp,
            color: context.textSecondaryColor,
          ),
        ),
      ],
    );
  }
}
