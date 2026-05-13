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
        title: Text('Push Notifications', style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
        actions: [
          IconButton(icon: Icon(Icons.refresh_rounded, color: context.primaryColor), onPressed: () => context.read<AdminNotificationCubit>().loadHistory()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showBroadcastDialog(context),
        backgroundColor: context.primaryColor,
        icon: const Icon(Icons.send_rounded, color: Colors.white),
        label: Text('Broadcast', style: const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
      ),
      body: Column(
        children: [
          _buildStatusBanner(),
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
            margin: EdgeInsets.all(16.w),
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_rounded, color: const Color(0xFF10B981), size: 20.sp),
                SizedBox(width: 10.w),
                Text('Notification sent to ${state.lastSentCount} users! 🚀', style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF10B981))),
              ],
            ),
          ).animate().fadeIn().slideY(begin: -0.1);
        }
        if (state.status == AdminNotifStatus.loading) {
          return Padding(padding: EdgeInsets.all(16.w), child: const LinearProgressIndicator());
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHistory() {
    return BlocBuilder<AdminNotificationCubit, AdminNotifState>(
      builder: (context, state) {
        if (state.history.isEmpty) {
          return AdminEmptyState(
            icon: Icons.notifications_none_rounded,
            title: 'No broadcasts yet',
            subtitle: 'Tap the Broadcast button to send your first notification',
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
              child: AdminSectionHeader(title: 'Broadcast History'),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: state.history.length,
                itemBuilder: (_, i) {
                  final notif = state.history[i];
                  final title = notif['title']?.toString() ?? '';
                  final body = notif['body']?.toString() ?? '';
                  final date = notif['created_at']?.toString().substring(0, 16).replaceAll('T', ' ') ?? '';
                  final action = notif['action_type']?.toString() ?? '';

                  return Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: context.surfaceColor,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(color: context.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10.r)),
                          child: Icon(Icons.notifications_rounded, color: context.primaryColor, size: 20.sp),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
                              SizedBox(height: 2.h),
                              Text(body, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor), maxLines: 2, overflow: TextOverflow.ellipsis),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Text(date, style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp, color: context.textHintColor)),
                                  if (action.isNotEmpty) ...[
                                    SizedBox(width: 8.w),
                                    AdminStatusBadge(label: action, color: context.primaryColor),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate(delay: (i * 40).ms).fadeIn();
                },
              ),
            ),
          ],
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Broadcast Notification', style: TextStyle(fontFamily: 'Poppins', fontSize: 18.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
                IconButton(icon: Icon(Icons.close_rounded, color: context.textSecondaryColor), onPressed: () => Navigator.pop(context)),
              ],
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: _titleCtrl,
              decoration: InputDecoration(
                labelText: 'Notification Title',
                labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _bodyCtrl,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Message Body',
                labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              ),
            ),
            SizedBox(height: 16.h),
            Text('Send To:', style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w600, color: context.textPrimaryColor)),
            SizedBox(height: 10.h),
            ..._targetOptions.map((opt) => RadioListTile<String>(
              value: opt.role,
              groupValue: _targetRole,
              onChanged: (v) => setState(() => _targetRole = v!),
              title: Row(children: [
                Icon(opt.icon, size: 18.sp, color: opt.color),
                SizedBox(width: 8.w),
                Text(opt.label, style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp)),
              ]),
              activeColor: context.primaryColor,
              contentPadding: EdgeInsets.zero,
            )),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSending ? null : _send,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  elevation: 0,
                ),
                icon: _isSending ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Icon(Icons.send_rounded, color: Colors.white),
                label: Text('Send Broadcast', style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _send() async {
    if (_titleCtrl.text.trim().isEmpty || _bodyCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill title and message'), behavior: SnackBarBehavior.floating));
      return;
    }
    setState(() => _isSending = true);
    final ok = await context.read<AdminNotificationCubit>().broadcast(
      title: _titleCtrl.text.trim(),
      body: _bodyCtrl.text.trim(),
      targetRole: _targetRole,
    );
    setState(() => _isSending = false);
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
