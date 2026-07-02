import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import '../bloc/admin_notification_cubit.dart';
import 'widgets/admin_widgets.dart';

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() => _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminNotificationCubit>().loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Broadcast Center', style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor, letterSpacing: -0.3)),
            Text('Send push notifications to users', style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_rounded, color: context.primaryColor),
            onPressed: () => context.read<AdminNotificationCubit>().loadHistory(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showBroadcastDialog(context),
        backgroundColor: context.primaryColor,
        elevation: 0,
        icon: const Icon(Icons.campaign_rounded, color: Colors.white),
        label: const Text('New Broadcast', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
      ),
      body: Column(
        children: [
          _buildStatusBanner(),
          _buildQuickStats(),
          Expanded(child: _buildHistory()),
        ],
      ),
    );
  }

  Widget _buildStatusBanner() {
    return BlocBuilder<AdminNotificationCubit, AdminNotifState>(
      builder: (context, state) {
        if (state.status == AdminNotifStatus.success && state.lastSentCount != null) {
          return Container(
            margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.08),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.15), shape: BoxShape.circle),
                  child: Icon(Icons.check_circle_rounded, color: const Color(0xFF10B981), size: 16.sp),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Broadcast sent successfully!', style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w700, color: const Color(0xFF10B981))),
                      Text('Reached ${state.lastSentCount} device${state.lastSentCount == 1 ? "" : "s"}', style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: const Color(0xFF10B981).withOpacity(0.8))),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: -0.2);
        }
        if (state.status == AdminNotifStatus.loading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(color: context.primaryColor, backgroundColor: context.primaryColor.withOpacity(0.1)),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildQuickStats() {
    return BlocBuilder<AdminNotificationCubit, AdminNotifState>(
      builder: (context, state) {
        final count = state.history.length;
        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: Row(
            children: [
              _StatPill(label: 'Total Broadcasts', value: '$count', color: context.primaryColor),
              SizedBox(width: 10.w),
              _StatPill(label: 'Last Sent', value: state.lastSentCount != null ? '${state.lastSentCount}' : '--', color: const Color(0xFF10B981)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHistory() {
    return BlocBuilder<AdminNotificationCubit, AdminNotifState>(
      builder: (context, state) {
        if (state.history.isEmpty && state.status != AdminNotifStatus.loading) {
          return AdminEmptyState(
            icon: Icons.campaign_outlined,
            title: 'No broadcasts yet',
            subtitle: 'Tap "New Broadcast" to send your first notification to users',
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 12.h),
              child: Text('Broadcast History', style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
                itemCount: state.history.length,
                itemBuilder: (_, i) => _buildHistoryItem(state.history[i] as Map, i),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHistoryItem(Map notif, int index) {
    final title = notif['title']?.toString() ?? '';
    final body = notif['body']?.toString() ?? '';
    final rawDate = notif['created_at']?.toString() ?? '';
    final date = rawDate.length >= 16 ? rawDate.substring(0, 16).replaceAll('T', '  ') : rawDate;
    final target = notif['target']?.toString() ?? 'all';
    final actionType = notif['action_type']?.toString() ?? '';

    final targetColor = target == 'therapist'
        ? const Color(0xFF8B5CF6)
        : target == 'user'
            ? const Color(0xFF6366F1)
            : const Color(0xFF0D9488);
    final targetLabel = target == 'therapist' ? 'Therapists' : target == 'user' ? 'Users' : 'Everyone';

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.dividerColor, width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(color: context.primaryColor.withOpacity(0.08), borderRadius: BorderRadius.circular(10.r)),
                  child: Icon(Icons.campaign_rounded, color: context.primaryColor, size: 18.sp),
                ),
                SizedBox(width: 10.w),
                Expanded(child: Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor))),
                AdminStatusBadge(label: targetLabel, color: targetColor),
              ],
            ),
            SizedBox(height: 8.h),
            Text(body, style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textSecondaryColor, height: 1.4), maxLines: 3, overflow: TextOverflow.ellipsis),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.access_time_rounded, size: 12.sp, color: context.textHintColor),
                SizedBox(width: 4.w),
                Text(date, style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp, color: context.textHintColor)),
                if (actionType.isNotEmpty && actionType != 'GENERAL') ...[
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(color: context.primaryColor.withOpacity(0.08), borderRadius: BorderRadius.circular(6.r)),
                    child: Text(actionType, style: TextStyle(fontFamily: 'Poppins', fontSize: 9.sp, fontWeight: FontWeight.w600, color: context.primaryColor)),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    ).animate(delay: (index * 40).ms).fadeIn().slideY(begin: 0.05);
  }

  void _showBroadcastDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<AdminNotificationCubit>(),
        child: const _BroadcastDialog(),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatPill({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w800, color: color)),
            SizedBox(height: 2.h),
            Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp, fontWeight: FontWeight.w500, color: color.withOpacity(0.7))),
          ],
        ),
      ),
    );
  }
}

class _BroadcastDialog extends StatefulWidget {
  const _BroadcastDialog();

  @override
  State<_BroadcastDialog> createState() => _BroadcastDialogState();
}

class _BroadcastDialogState extends State<_BroadcastDialog> {
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  String _targetRole = 'all';
  bool _isSending = false;

  final _targetOptions = [
    _TargetOption('all', 'All Users', Icons.people_rounded, const Color(0xFF0D9488)),
    _TargetOption('user', 'Customers Only', Icons.person_rounded, const Color(0xFF6366F1)),
    _TargetOption('therapist', 'Therapists Only', Icons.psychology_rounded, const Color(0xFF8B5CF6)),
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(BuildContext context, String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textSecondaryColor),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: context.dividerColor)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: context.primaryColor, width: 1.5)),
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      filled: true,
      fillColor: context.backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.surfaceColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(color: context.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
                  child: Icon(Icons.campaign_rounded, color: context.primaryColor, size: 22.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New Broadcast', style: TextStyle(fontFamily: 'Poppins', fontSize: 17.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
                      Text('Send push notification to users', style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor)),
                    ],
                  ),
                ),
                IconButton(icon: Icon(Icons.close_rounded, color: context.textSecondaryColor, size: 20.sp), onPressed: () => Navigator.pop(context)),
              ],
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: _titleCtrl,
              style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, color: context.textPrimaryColor),
              decoration: _inputDecoration(context, 'Notification Title'),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _bodyCtrl,
              maxLines: 4,
              style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textPrimaryColor),
              decoration: _inputDecoration(context, 'Message Body'),
            ),
            SizedBox(height: 20.h),
            Text('Send To:', style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
            SizedBox(height: 10.h),
            ..._targetOptions.map((opt) => GestureDetector(
              onTap: () => setState(() => _targetRole = opt.role),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: _targetRole == opt.role ? opt.color.withOpacity(0.08) : context.backgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: _targetRole == opt.role ? opt.color : context.dividerColor, width: _targetRole == opt.role ? 1.5 : 1),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(color: opt.color.withOpacity(0.12), borderRadius: BorderRadius.circular(8.r)),
                      child: Icon(opt.icon, size: 16.sp, color: opt.color),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(child: Text(opt.label, style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w600, color: _targetRole == opt.role ? opt.color : context.textPrimaryColor))),
                    if (_targetRole == opt.role) Icon(Icons.check_circle_rounded, color: opt.color, size: 18.sp),
                  ],
                ),
              ),
            )),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSending ? null : _send,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                  disabledBackgroundColor: context.primaryColor.withOpacity(0.5),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  elevation: 0,
                ),
                icon: _isSending
                    ? SizedBox(width: 18.w, height: 18.w, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.send_rounded, color: Colors.white),
                label: Text(_isSending ? 'Sending...' : 'Send Broadcast', style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _send() async {
    if (_titleCtrl.text.trim().isEmpty || _bodyCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both title and message'), behavior: SnackBarBehavior.floating, backgroundColor: Color(0xFFEF4444)),
      );
      return;
    }
    setState(() => _isSending = true);
    final ok = await context.read<AdminNotificationCubit>().broadcast(
      title: _titleCtrl.text.trim(),
      body: _bodyCtrl.text.trim(),
      targetRole: _targetRole,
    );
    if (mounted) setState(() => _isSending = false);
    if (ok && mounted) Navigator.pop(context);
  }
}

class _TargetOption {
  final String role;
  final String label;
  final IconData icon;
  final Color color;
  const _TargetOption(this.role, this.label, this.icon, this.color);
}
