import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import '../bloc/admin_cubit.dart';
import '../bloc/admin_state.dart';
import 'widgets/admin_widgets.dart';

class AdminTherapistsScreen extends StatefulWidget {
  const AdminTherapistsScreen({super.key});

  @override
  State<AdminTherapistsScreen> createState() => _AdminTherapistsScreenState();
}

class _AdminTherapistsScreenState extends State<AdminTherapistsScreen> {
  final _searchController = TextEditingController();
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminCubit>().loadTherapists();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildSearchAndFilters(context),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        'Therapist Management',
        style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh_rounded, color: context.primaryColor),
          onPressed: () => context.read<AdminCubit>().loadTherapists(verified: _filter, search: _searchController.text),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
      child: Column(
        children: [
          AdminSearchBar(
            controller: _searchController,
            hint: 'Search by specialty...',
            onChanged: (v) => context.read<AdminCubit>().loadTherapists(verified: _filter, search: v),
            onClear: () => context.read<AdminCubit>().loadTherapists(verified: _filter),
          ),
          SizedBox(height: 10.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AdminFilterChip(label: 'All', isSelected: _filter == 'all', onTap: () => _applyFilter('all')),
                SizedBox(width: 8.w),
                AdminFilterChip(label: '✅ Verified', isSelected: _filter == 'true', onTap: () => _applyFilter('true'), selectedColor: const Color(0xFF10B981)),
                SizedBox(width: 8.w),
                AdminFilterChip(label: '⏳ Pending', isSelected: _filter == 'false', onTap: () => _applyFilter('false'), selectedColor: const Color(0xFFF59E0B)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _applyFilter(String f) {
    setState(() => _filter = f);
    context.read<AdminCubit>().loadTherapists(verified: f, search: _searchController.text);
  }

  Widget _buildBody() {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        return state.maybeMap(
          loading: (_) => const Center(child: CircularProgressIndicator()),
          error: (e) => AdminEmptyState(icon: Icons.error_outline_rounded, title: 'Error: ${e.message}', subtitle: 'Tap to retry', onAction: () => context.read<AdminCubit>().loadTherapists()),
          loaded: (loaded) {
            if (loaded.therapists.isEmpty) {
              return AdminEmptyState(icon: Icons.psychology_outlined, title: 'No therapists found', subtitle: 'Try adjusting the filters');
            }
            return RefreshIndicator(
              onRefresh: () => context.read<AdminCubit>().loadTherapists(verified: _filter, search: _searchController.text),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                itemCount: loaded.therapists.length,
                itemBuilder: (_, i) => _TherapistCard(
                  therapist: loaded.therapists[i],
                  isVerifying: loaded.isVerifyingTherapist,
                  isDeleting: loaded.isDeletingTherapist,
                ),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class _TherapistCard extends StatelessWidget {
  final dynamic therapist;
  final bool isVerifying;
  final bool isDeleting;

  const _TherapistCard({required this.therapist, required this.isVerifying, required this.isDeleting});

  @override
  Widget build(BuildContext context) {
    final isVerified = therapist['isVerified'] as bool? ?? false;
    final name = therapist['displayName'] as String? ?? 'Unknown';
    final email = therapist['email'] as String? ?? '';
    final specialty = therapist['specialty'] as String? ?? 'Not specified';
    final experience = therapist['yearsOfExperience'] as int? ?? 0;
    final rating = (therapist['rating'] as num?)?.toDouble() ?? 0.0;
    final photo = therapist['profileImageUrl'] as String?;
    final fee = (therapist['consultationFee'] as num?)?.toDouble() ?? 0.0;
    final commission = therapist['commissionRate'] as int? ?? 10;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isVerified ? const Color(0xFF10B981).withOpacity(0.3) : const Color(0xFFF59E0B).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26.r,
                backgroundColor: context.primaryColor.withOpacity(0.1),
                backgroundImage: photo != null && photo.isNotEmpty ? NetworkImage(photo) : null,
                child: photo == null || photo.isEmpty ? Icon(Icons.person_rounded, size: 26.sp, color: context.primaryColor) : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
                    Text(email, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor)),
                  ],
                ),
              ),
              AdminStatusBadge(label: isVerified ? 'Verified' : 'Pending', color: isVerified ? const Color(0xFF10B981) : const Color(0xFFF59E0B)),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: context.dividerColor),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(child: _InfoChip(Icons.psychology_outlined, specialty, context)),
              Expanded(child: _InfoChip(Icons.work_outline_rounded, '$experience yrs', context)),
              Expanded(child: _InfoChip(Icons.star_rounded, rating > 0 ? '${rating.toStringAsFixed(1)}★' : 'N/A', context, color: const Color(0xFFF59E0B))),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(child: _InfoChip(Icons.payments_outlined, 'Rs. ${fee.toStringAsFixed(0)}', context, color: const Color(0xFF0D9488))),
              Expanded(child: _InfoChip(Icons.percent_rounded, '$commission% commission', context, color: const Color(0xFF8B5CF6))),
            ],
          ),
          SizedBox(height: 12.h),
          if (!isVerified)
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    label: 'Approve',
                    icon: Icons.check_circle_rounded,
                    color: const Color(0xFF10B981),
                    loading: isVerifying,
                    onTap: () => _showApproveDialog(context, therapist['id'], name),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _ActionButton(
                    label: 'Reject',
                    icon: Icons.cancel_rounded,
                    color: const Color(0xFFEF4444),
                    loading: isVerifying,
                    outlined: true,
                    onTap: () => _showRejectDialog(context, therapist['id'], name),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    label: 'Revoke',
                    icon: Icons.remove_circle_outline_rounded,
                    color: const Color(0xFFF59E0B),
                    loading: isVerifying,
                    outlined: true,
                    onTap: () => context.read<AdminCubit>().verifyTherapist(therapist['id'], isVerified: false),
                  ),
                ),
                SizedBox(width: 8.w),
                _ActionButton(
                  label: 'Delete',
                  icon: Icons.delete_outline_rounded,
                  color: const Color(0xFFEF4444),
                  loading: isDeleting,
                  outlined: true,
                  onTap: () => _showDeleteDialog(context, therapist['id'], name),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _showApproveDialog(BuildContext context, String id, String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: const Text('Approve Therapist', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: Text('Approve $name as a verified therapist? They will receive a push notification.'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
            onPressed: () {
              context.read<AdminCubit>().verifyTherapist(id, isVerified: true);
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$name approved! ✅'), backgroundColor: const Color(0xFF10B981), behavior: SnackBarBehavior.floating));
            },
            child: const Text('Approve', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context, String id, String name) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: const Text('Reject Therapist', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Reason for rejecting $name:'),
            SizedBox(height: 12.h),
            TextField(
              controller: ctrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter rejection reason...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
            onPressed: () {
              context.read<AdminCubit>().verifyTherapist(id, isVerified: false, rejectionReason: ctrl.text);
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$name rejected'), backgroundColor: const Color(0xFFEF4444), behavior: SnackBarBehavior.floating));
            },
            child: const Text('Reject', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String id, String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: const Text('Delete Therapist', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: Text('Permanently delete $name? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
            onPressed: () {
              context.read<AdminCubit>().deleteTherapist(id);
              context.pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final BuildContext ctx;
  final Color? color;
  const _InfoChip(this.icon, this.label, this.ctx, {this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13.sp, color: color ?? ctx.textSecondaryColor),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: color ?? ctx.textSecondaryColor), overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool loading;
  final bool outlined;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.loading,
    required this.onTap,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    if (outlined) {
      return OutlinedButton.icon(
        onPressed: loading ? null : onTap,
        icon: Icon(icon, size: 16.sp),
        label: Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp)),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
      );
    }
    return ElevatedButton.icon(
      onPressed: loading ? null : onTap,
      icon: Icon(icon, size: 16.sp, color: Colors.white),
      label: Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}
