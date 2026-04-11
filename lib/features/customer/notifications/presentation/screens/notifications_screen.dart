import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _dio = getIt<Dio>();

  List<Map<String, dynamic>> _notifications = [];
  bool _loading = true;
  String? _error;
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await _dio.get('/notifications', queryParameters: {'limit': 50});
      // Handle various backend response shapes
      final raw = res.data;
      final rawList = (raw is Map
          ? (raw['notifications'] ?? raw['data'] ?? raw['items'] ?? [])
          : raw is List
              ? raw
              : []) as List<dynamic>;
      final list = rawList.cast<Map<String, dynamic>>();
      final unread = list.where((n) => n['is_read'] == false).length;
      if (mounted) {
        setState(() {
          _notifications = list;
          _unreadCount = unread;
          _loading = false;
        });
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() {
          _error = e.response?.data?['error']?.toString() ?? e.message ?? 'Failed to load notifications';
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

  Future<void> _markRead(String id) async {
    try {
      await _dio.patch('/notifications/$id/read');
      setState(() {
        final idx = _notifications.indexWhere((n) => n['id'] == id);
        if (idx != -1 && _notifications[idx]['is_read'] == false) {
          _notifications[idx] = Map.from(_notifications[idx])..['is_read'] = true;
          _unreadCount = (_unreadCount - 1).clamp(0, 999);
        }
      });
    } catch (_) {}
  }

  Future<void> _markAllRead() async {
    try {
      await _dio.patch('/notifications/read-all');
      setState(() {
        _notifications = _notifications
            .map((n) => Map<String, dynamic>.from(n)..['is_read'] = true)
            .toList();
        _unreadCount = 0;
      });
    } catch (_) {}
  }

  Future<void> _delete(String id) async {
    try {
      await _dio.delete('/notifications/$id');
      setState(() {
        _notifications.removeWhere((n) => n['id'] == id);
        if (_unreadCount > _notifications.where((n) => n['is_read'] == false).length) {
          _unreadCount = _notifications.where((n) => n['is_read'] == false).length;
        }
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: [
          SliverAppBar(
            backgroundColor: context.backgroundColor,
            surfaceTintColor: Colors.transparent,
            floating: true,
            snap: true,
            elevation: 0,
            title: Row(
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimaryColor,
                  ),
                ),
                if (_unreadCount > 0) ...[
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: context.primaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '$_unreadCount',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ],
              ],
            ),
            actions: [
              if (_unreadCount > 0)
                TextButton(
                  onPressed: _markAllRead,
                  child: Text(
                    'Mark all read',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      color: context.primaryColor,
                    ),
                  ),
                ),
            ],
          ),
          if (_loading)
            const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
          else if (_error != null)
            SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(32.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.wifi_off_rounded,
                          size: 56.sp, color: context.textSecondaryColor.withValues(alpha: 0.4)),
                      SizedBox(height: 16.h),
                      Text(
                        'Could not load notifications',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimaryColor),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            color: context.textSecondaryColor,
                            height: 1.5),
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton.icon(
                        onPressed: _load,
                        icon: Icon(Icons.refresh_rounded, size: 16.sp),
                        label: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                          elevation: 0,
                          textStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else if (_notifications.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.notifications_off_outlined,
                        size: 64.sp, color: context.textSecondaryColor.withValues(alpha: 0.4)),
                    SizedBox(height: 16.h),
                    Text(
                      'No notifications yet',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "You're all caught up!\nBooking confirmations and updates will appear here.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.sp,
                        color: context.textSecondaryColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 100.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _NotificationTile(
                    notification: _notifications[i],
                    onTap: () => _markRead(_notifications[i]['id']),
                    onDismiss: () => _delete(_notifications[i]['id']),
                    parentContext: context,
                  ),
                  childCount: _notifications.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Notification tile ──────────────────────────────────────────────────────────
class _NotificationTile extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;
  final BuildContext parentContext;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
    required this.onDismiss,
    required this.parentContext,
  });

  IconData _iconForType(String? type) {
    switch (type) {
      case 'appointment_confirmed': return Icons.event_available_rounded;
      case 'appointment_cancelled': return Icons.event_busy_rounded;
      case 'appointment_reminder': return Icons.alarm_rounded;
      case 'incoming_call': return Icons.video_call_rounded;
      case 'payment': return Icons.payment_rounded;
      case 'reminder': return Icons.wb_sunny_rounded;
      default: return Icons.notifications_rounded;
    }
  }

  Color _colorForType(String? type, BuildContext context) {
    switch (type) {
      case 'appointment_confirmed': return context.successColor;
      case 'appointment_cancelled': return context.errorColor;
      case 'incoming_call': return const Color(0xFF6366F1);
      case 'payment': return const Color(0xFF0D9488);
      case 'reminder': return const Color(0xFFF59E0B);
      default: return context.primaryColor;
    }
  }

  void _navigateForType(BuildContext context, String? type) {
    switch (type) {
      case 'incoming_call':
        final appointmentId = notification['appointment_id'] as String?;
        final userId = notification['user_id'] as String? ?? '';
        if (appointmentId != null && appointmentId.isNotEmpty) {
          context.push('/video-call/$appointmentId/$userId');
        }
        break;
      case 'appointment_confirmed':
      case 'appointment_cancelled':
      case 'appointment_reminder':
        context.pushNamed(RouteNames.myAppointments);
        break;
      case 'payment':
        context.pushNamed(RouteNames.transactionHistory);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRead = notification['is_read'] == true;
    final type = notification['type'] as String?;
    final title = notification['title'] as String? ?? '';
    final body = notification['body'] as String? ?? '';
    final createdAt = notification['created_at'] as String?;
    DateTime? date;
    if (createdAt != null) date = DateTime.tryParse(createdAt)?.toLocal();
    final timeStr = date != null ? _formatTime(date) : '';
    final color = _colorForType(type, context);

    return Dismissible(
      key: ValueKey(notification['id']),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          color: context.errorColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        child: Icon(Icons.delete_outline_rounded, color: Colors.white, size: 22.sp),
      ),
      child: GestureDetector(
        onTap: () {
          onTap();
          _navigateForType(parentContext, notification['type'] as String?);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(vertical: 4.h),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: isRead ? context.surfaceColor : context.primaryColor.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isRead ? context.borderColor : context.primaryColor.withValues(alpha: 0.2),
              width: 0.8,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(9.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(_iconForType(type), color: color, size: 18.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.sp,
                              fontWeight: isRead ? FontWeight.w500 : FontWeight.w700,
                              color: context.textPrimaryColor,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8.w,
                            height: 8.w,
                            margin: EdgeInsets.only(left: 6.w),
                            decoration: BoxDecoration(
                              color: context.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    if (body.isNotEmpty) ...[
                      SizedBox(height: 3.h),
                      Text(
                        body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          color: context.textSecondaryColor,
                          height: 1.4,
                        ),
                      ),
                    ],
                    SizedBox(height: 6.h),
                    Text(
                      timeStr,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10.sp,
                        color: context.textSecondaryColor.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(date);
  }
}
