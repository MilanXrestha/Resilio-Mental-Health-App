import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/theme/app_colors.dart';

class AppointmentChatScreen extends StatefulWidget {
  final String appointmentId;

  /// Full appointment map passed as route extra (optional — used for the header).
  final Map<String, dynamic>? appointment;

  const AppointmentChatScreen({
    super.key,
    required this.appointmentId,
    this.appointment,
  });

  @override
  State<AppointmentChatScreen> createState() => _AppointmentChatScreenState();
}

class _AppointmentChatScreenState extends State<AppointmentChatScreen> {
  final _dio = getIt<Dio>();
  final _textCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  List<Map<String, dynamic>> _messages = [];
  bool _loadingMessages = true;
  bool _sending = false;
  String? _msgError;
  Timer? _pollTimer;

  late final Map<String, dynamic>? _appt;
  late final Map<String, dynamic>? _therapist;

  // ── Participant IDs extracted from appointment extra ──────────────────────
  late final String? _therapistId;
  late final String? _patientId;

  @override
  void initState() {
    super.initState();
    _appt = widget.appointment;
    _therapist = _appt?['therapist'] as Map<String, dynamic>?;

    // Resolve therapist + patient IDs for shared conversation endpoint
    _therapistId = _appt?['therapistId'] as String? ??
        _appt?['therapist_id'] as String?;
    _patientId = _appt?['patientId'] as String? ??
        _appt?['patient_id'] as String?;

    _fetchMessages();
    // Poll every 8 s for new messages
    _pollTimer = Timer.periodic(const Duration(seconds: 8), (_) {
      _fetchMessages(silent: true);
    });
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _textCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  /// Returns the shared-conversation URL if we know both IDs, otherwise
  /// falls back to the per-appointment URL.
  String get _messagesUrl {
    if (_therapistId != null && _patientId != null) {
      return '/appointments/conversation/$_therapistId/$_patientId/messages';
    }
    return '/appointments/${widget.appointmentId}/messages';
  }

  Future<void> _fetchMessages({bool silent = false}) async {
    if (!silent && mounted) setState(() => _loadingMessages = true);
    try {
      final res = await _dio.get(_messagesUrl);
      final raw = res.data;
      final list = (raw is Map
              ? (raw['messages'] ?? raw['data'] ?? raw['items'] ?? [])
              : raw is List
                  ? raw
                  : []) as List<dynamic>;
      if (mounted) {
        setState(() {
          _messages = list.cast<Map<String, dynamic>>();
          _loadingMessages = false;
          _msgError = null;
        });
        _scrollToBottom();
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() {
          _loadingMessages = false;
          if (!silent) {
            _msgError = e.response?.data?['error']?.toString() ??
                'Could not load messages';
          }
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingMessages = false);
    }
  }

  Future<void> _sendMessage() async {
    final text = _textCtrl.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() => _sending = true);
    _textCtrl.clear();

    final optimistic = <String, dynamic>{
      'content': text,
      'senderRole': 'patient',
      'createdAt': DateTime.now().toIso8601String(),
      '_optimistic': true,
    };
    setState(() => _messages = [..._messages, optimistic]);
    _scrollToBottom();

    try {
      // Always send to the specific appointment (even if we display shared convo)
      await _dio.post(
        '/appointments/${widget.appointmentId}/messages',
        data: {'content': text},
      );
      await _fetchMessages(silent: true);
    } on DioException catch (e) {
      if (mounted) {
        setState(() {
          _messages = _messages.where((m) => m['_optimistic'] != true).toList();
          _sending = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.response?.data?['error']?.toString() ?? 'Failed to send'),
          backgroundColor: context.errorColor,
        ));
        return;
      }
    } catch (_) {}

    if (mounted) setState(() => _sending = false);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ── Session time gate ─────────────────────────────────────────────────────
  bool get _canJoinNow {
    final s = _appt?['scheduledTime'] as String? ??
        _appt?['scheduled_time'] as String?;
    if (s == null) return false;
    final dt = DateTime.tryParse(s)?.toLocal();
    if (dt == null) return false;
    final now = DateTime.now();
    final status = (_appt?['status'] as String? ?? '').toLowerCase();
    if (status != 'confirmed' && status != 'accepted' && status != 'scheduled') {
      return false;
    }
    return dt.isBefore(now.add(const Duration(minutes: 15))) &&
        dt.isAfter(now.subtract(const Duration(hours: 2)));
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _therapistName() {
    if (_therapist != null) {
      return _therapist!['displayName'] as String? ??
          _therapist!['display_name'] as String? ??
          _therapist!['name'] as String? ??
          'Therapist';
    }
    return 'Therapist';
  }

  String? _therapistAvatar() {
    if (_therapist == null) return null;
    return _therapist!['profileImageUrl'] as String? ??
        _therapist!['profile_image_url'] as String?;
  }

  String _sessionLabel() {
    final s = _appt?['scheduledTime'] as String? ??
        _appt?['scheduled_time'] as String?;
    if (s == null) return 'Session';
    final dt = DateTime.tryParse(s)?.toLocal();
    if (dt == null) return 'Session';
    return DateFormat('EEE, MMM d · h:mm a').format(dt);
  }

  String _statusLabel() {
    final status = (_appt?['status'] as String? ?? 'pending');
    return '${status[0].toUpperCase()}${status.substring(1)}';
  }

  Color _statusColor() {
    switch ((_appt?['status'] as String? ?? '').toLowerCase()) {
      case 'confirmed':
      case 'accepted':
      case 'scheduled':
        return const Color(0xFF10B981);
      case 'cancelled':
      case 'rejected':
        return const Color(0xFFEF4444);
      case 'pending':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6B7280);
    }
  }

  bool _isFromMe(Map<String, dynamic> msg) {
    final role = (msg['senderRole'] as String? ?? '').toLowerCase();
    return role == 'patient' || role == 'customer' || role == 'user';
  }

  @override
  Widget build(BuildContext context) {
    final name = _therapistName();
    final avatar = _therapistAvatar();
    final canJoin = _canJoinNow;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: context.textPrimaryColor),
          onPressed: () => context.pop(),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: context.primaryColor.withValues(alpha: 0.12),
              backgroundImage: avatar != null ? NetworkImage(avatar) : null,
              child: avatar == null
                  ? Text(
                      name.isNotEmpty ? name[0].toUpperCase() : 'T',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: context.primaryColor,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Dr. $name',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: context.textPrimaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 6.w, height: 6.w,
                        decoration: BoxDecoration(
                          color: _statusColor(), shape: BoxShape.circle),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _statusLabel(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.sp,
                          color: _statusColor(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // ── Join Session (only active within session window) ───────────
          if (canJoin)
            TextButton.icon(
              onPressed: () async {
                final apptId = widget.appointmentId;
                final userId = _patientId ?? '';
                // Notify therapist
                try {
                  await _dio.post('/appointments/$apptId/call/notify');
                } catch (_) {}
                if (!context.mounted) return;
                context.push('/video-call/$apptId/$userId',
                    extra: {'callerName': name});
              },
              icon: Icon(Icons.video_call_rounded,
                  size: 20.sp, color: context.primaryColor),
              label: Text(
                'Join',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: context.primaryColor,
                ),
              ),
            )
          else
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Icon(Icons.videocam_off_rounded,
                  color: context.textSecondaryColor, size: 22.sp),
            ),
        ],
      ),

      body: Column(
        children: [
          // ── Session info banner ─────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            color: context.primaryColor.withValues(alpha: 0.06),
            child: Row(
              children: [
                Icon(Icons.event_rounded, size: 14.sp, color: context.primaryColor),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    _sessionLabel(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      color: context.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (!canJoin)
                  Text(
                    'Call available 15 min before',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.sp,
                      color: context.textSecondaryColor,
                    ),
                  ),
              ],
            ),
          ),

          // ── Message list ────────────────────────────────────────────────
          Expanded(
            child: _loadingMessages
                ? const Center(child: CircularProgressIndicator())
                : _msgError != null
                    ? _EmptyChat(
                        icon: Icons.error_outline_rounded,
                        message: _msgError!,
                        subtitle: 'Pull down to retry',
                        iconColor: context.errorColor,
                      )
                    : _messages.isEmpty
                        ? _EmptyChat(
                            icon: Icons.chat_bubble_outline_rounded,
                            message: 'No messages yet',
                            subtitle:
                                'Send a message to start the conversation.',
                            iconColor: context.textSecondaryColor,
                          )
                        : ListView.builder(
                            controller: _scrollCtrl,
                            padding:
                                EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                            itemCount: _messages.length,
                            itemBuilder: (context, i) {
                              final msg = _messages[i];
                              final fromMe = _isFromMe(msg);
                              final showDate = i == 0 ||
                                  _shouldShowDate(_messages[i - 1], msg);
                              return Column(
                                children: [
                                  if (showDate) _DateSeparator(msg),
                                  _MessageBubble(
                                    message: msg,
                                    fromMe: fromMe,
                                    isOptimistic: msg['_optimistic'] == true,
                                    therapistName: name,
                                    therapistAvatar: avatar,
                                  ),
                                ],
                              );
                            },
                          ),
          ),

          // ── Input bar ───────────────────────────────────────────────────
          _InputBar(
            controller: _textCtrl,
            sending: _sending,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }

  bool _shouldShowDate(Map<String, dynamic> prev, Map<String, dynamic> curr) {
    final p = _msgDate(prev);
    final c = _msgDate(curr);
    if (p == null || c == null) return false;
    return !DateUtils.isSameDay(p, c);
  }

  DateTime? _msgDate(Map<String, dynamic> msg) {
    final s = msg['createdAt'] as String? ??
        msg['created_at'] as String? ??
        msg['timestamp'] as String?;
    return s != null ? DateTime.tryParse(s)?.toLocal() : null;
  }
}

// ── Date separator ─────────────────────────────────────────────────────────────

class _DateSeparator extends StatelessWidget {
  final Map<String, dynamic> msg;
  const _DateSeparator(this.msg);

  @override
  Widget build(BuildContext context) {
    final s = msg['createdAt'] as String? ??
        msg['created_at'] as String? ??
        msg['timestamp'] as String?;
    final dt = s != null ? DateTime.tryParse(s)?.toLocal() : null;
    final label = dt != null ? DateFormat('MMMM d, y').format(dt) : 'Earlier';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: context.dividerColor)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.sp,
                  color: context.textSecondaryColor,
                )),
          ),
          Expanded(child: Divider(color: context.dividerColor)),
        ],
      ),
    );
  }
}

// ── Message bubble ─────────────────────────────────────────────────────────────

class _MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  final bool fromMe;
  final bool isOptimistic;
  final String therapistName;
  final String? therapistAvatar;

  const _MessageBubble({
    required this.message,
    required this.fromMe,
    required this.isOptimistic,
    required this.therapistName,
    required this.therapistAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final text = message['content'] as String? ?? '';
    final s = message['createdAt'] as String? ??
        message['created_at'] as String? ??
        message['timestamp'] as String?;
    final dt = s != null ? DateTime.tryParse(s)?.toLocal() : null;
    final timeStr = dt != null ? DateFormat('h:mm a').format(dt) : '';

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment:
            fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!fromMe) ...[
            CircleAvatar(
              radius: 14.r,
              backgroundColor: context.primaryColor.withValues(alpha: 0.12),
              backgroundImage: therapistAvatar != null
                  ? NetworkImage(therapistAvatar!)
                  : null,
              child: therapistAvatar == null
                  ? Text(
                      therapistName.isNotEmpty
                          ? therapistName[0].toUpperCase()
                          : 'T',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: context.primaryColor),
                    )
                  : null,
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: fromMe ? context.primaryColor : context.surfaceColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.r),
                      topRight: Radius.circular(18.r),
                      bottomLeft: fromMe
                          ? Radius.circular(18.r)
                          : Radius.circular(4.r),
                      bottomRight: fromMe
                          ? Radius.circular(4.r)
                          : Radius.circular(18.r),
                    ),
                    border: fromMe
                        ? null
                        : Border.all(color: context.borderColor, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      color: fromMe ? Colors.white : context.textPrimaryColor,
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(timeStr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.sp,
                          color: context.textSecondaryColor,
                        )),
                    if (fromMe) ...[
                      SizedBox(width: 4.w),
                      Icon(
                        isOptimistic
                            ? Icons.access_time_rounded
                            : Icons.done_all_rounded,
                        size: 12.sp,
                        color: isOptimistic
                            ? context.textSecondaryColor
                            : context.primaryColor,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (fromMe) SizedBox(width: 4.w),
        ],
      ),
    );
  }
}

// ── Input bar ──────────────────────────────────────────────────────────────────

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSend;

  const _InputBar({
    required this.controller,
    required this.sending,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          12.w, 10.h, 12.w, MediaQuery.of(context).padding.bottom + 10.h),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        border:
            Border(top: BorderSide(color: context.borderColor, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: context.surfaceColor,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: context.borderColor, width: 0.5),
              ),
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  color: context.textPrimaryColor,
                ),
                decoration: InputDecoration(
                  hintText: 'Type a message…',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    color: context.textSecondaryColor,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: sending ? null : onSend,
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: sending
                    ? context.primaryColor.withValues(alpha: 0.5)
                    : context.primaryColor,
                shape: BoxShape.circle,
              ),
              child: sending
                  ? Padding(
                      padding: EdgeInsets.all(12.w),
                      child: const CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Icon(Icons.send_rounded, size: 20.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Empty state ────────────────────────────────────────────────────────────────

class _EmptyChat extends StatelessWidget {
  final IconData icon;
  final String message;
  final String subtitle;
  final Color iconColor;

  const _EmptyChat({
    required this.icon,
    required this.message,
    required this.subtitle,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56.sp, color: iconColor.withValues(alpha: 0.4)),
            SizedBox(height: 14.h),
            Text(message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                )),
            SizedBox(height: 6.h),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  color: context.textSecondaryColor,
                  height: 1.5,
                )),
          ],
        ),
      ),
    );
  }
}
