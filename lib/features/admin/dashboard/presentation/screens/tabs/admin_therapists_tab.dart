import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../bloc/admin_cubit.dart';
import '../../bloc/admin_state.dart';

class AdminTherapistsTab extends StatefulWidget {
  const AdminTherapistsTab({super.key});

  @override
  State<AdminTherapistsTab> createState() => _AdminTherapistsTabState();
}

class _AdminTherapistsTabState extends State<AdminTherapistsTab> {
  final _searchController = TextEditingController();

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
      body: SafeArea(
        child: Column(
          children: [
            // Header with Search
            _buildHeader(),
            
            // Filter Chips
            _buildFilterChips(),
            
            // Therapist List
            Expanded(
              child: BlocBuilder<AdminCubit, AdminState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (msg) => _ErrorState(message: msg, onRetry: () {
                      context.read<AdminCubit>().loadTherapists();
                    }),
                    loaded: (
                      stats,
                      therapists,
                      totalTherapists,
                      therapistFilter,
                      therapistSearch,
                      users,
                      totalUsers,
                      userRoleFilter,
                      userSearch,
                      appointments,
                      totalAppointments,
                      appointmentFilter,
                      content,
                      totalContent,
                      contentFilter,
                      isVerifyingTherapist,
                      isDeletingTherapist,
                      isUpdatingUser,
                      isDeletingContent,
                    ) {
                      if (therapists.isEmpty && therapistSearch.isEmpty) {
                        return const _EmptyState(message: 'No therapists found');
                      }

                      if (therapists.isEmpty && therapistSearch.isNotEmpty) {
                        return _EmptyState(message: 'No therapists match "$therapistSearch"');
                      }

                      return RefreshIndicator(
                        onRefresh: () => context.read<AdminCubit>().loadTherapists(),
                        child: ListView.builder(
                          padding: EdgeInsets.all(16.w),
                          itemCount: therapists.length,
                          itemBuilder: (context, index) {
                            final therapist = therapists[index];
                            return _TherapistCard(
                              therapist: therapist,
                              isVerifying: isVerifyingTherapist,
                              isDeleting: isDeletingTherapist,
                            );
                          },
                        ),
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Therapist Management',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by specialty...',
              prefixIcon: Icon(Icons.search_rounded, size: 20.sp),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear_rounded, size: 20.sp),
                      onPressed: () {
                        _searchController.clear();
                        context.read<AdminCubit>().clearTherapistSearch();
                      },
                    )
                  : null,
              filled: true,
              fillColor: context.surfaceColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            onChanged: (value) {
              context.read<AdminCubit>().loadTherapists(search: value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        final currentFilter = state.maybeMap(
          loaded: (l) => l.therapistFilter,
          orElse: () => 'all',
        );

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              _FilterChip(
                label: 'All',
                isSelected: currentFilter == 'all',
                onTap: () => context.read<AdminCubit>().loadTherapists(verified: 'all'),
              ),
              SizedBox(width: 8.w),
              _FilterChip(
                label: 'Verified',
                isSelected: currentFilter == 'true',
                onTap: () => context.read<AdminCubit>().loadTherapists(verified: 'true'),
              ),
              SizedBox(width: 8.w),
              _FilterChip(
                label: 'Pending',
                isSelected: currentFilter == 'false',
                onTap: () => context.read<AdminCubit>().loadTherapists(verified: 'false'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? context.primaryColor : context.surfaceColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : context.textSecondaryColor,
          ),
        ),
      ),
    );
  }
}

class _TherapistCard extends StatelessWidget {
  final dynamic therapist;
  final bool isVerifying;
  final bool isDeleting;

  const _TherapistCard({
    required this.therapist,
    required this.isVerifying,
    required this.isDeleting,
  });

  @override
  Widget build(BuildContext context) {
    final isVerified = therapist['isVerified'] as bool? ?? false;
    final name = therapist['displayName'] as String? ?? 'Unknown';
    final email = therapist['email'] as String? ?? '';
    final specialty = therapist['specialty'] as String? ?? 'Not specified';
    final experience = therapist['yearsOfExperience'] as int? ?? 0;
    final rating = (therapist['rating'] as num?)?.toDouble() ?? 0.0;
    final profileImageUrl = therapist['profileImageUrl'] as String?;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: isVerified
            ? Border.all(color: const Color(0xFF10B981).withOpacity(0.3), width: 2)
            : Border.all(color: const Color(0xFFF59E0B).withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with avatar and verification badge
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 28.r,
                backgroundColor: context.primaryColor.withOpacity(0.1),
                backgroundImage: profileImageUrl != null && profileImageUrl.isNotEmpty
                    ? NetworkImage(profileImageUrl)
                    : null,
                child: profileImageUrl == null || profileImageUrl.isEmpty
                    ? Icon(Icons.person_rounded, size: 28.sp, color: context.primaryColor)
                    : null,
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
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      email,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Verification Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isVerified
                      ? const Color(0xFF10B981).withOpacity(0.1)
                      : const Color(0xFFF59E0B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isVerified ? Icons.verified_rounded : Icons.pending_rounded,
                      size: 14.sp,
                      color: isVerified ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      isVerified ? 'Verified' : 'Pending',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: isVerified ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: context.textSecondaryColor.withOpacity(0.1)),
          SizedBox(height: 12.h),
          
          // Details
          Row(
            children: [
              Expanded(
                child: _DetailItem(
                  icon: Icons.psychology_outlined,
                  label: 'Specialty',
                  value: specialty,
                ),
              ),
              Expanded(
                child: _DetailItem(
                  icon: Icons.work_outline_rounded,
                  label: 'Experience',
                  value: '$experience years',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: _DetailItem(
                  icon: Icons.star_rounded,
                  label: 'Rating',
                  value: rating > 0 ? '${rating.toStringAsFixed(1)} ★' : 'No ratings',
                  color: rating > 0 ? const Color(0xFFF59E0B) : null,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          // Action Buttons
          if (!isVerified)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isVerifying
                        ? null
                        : () => _showApproveDialog(context, therapist['id'], name),
                    icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
                    label: const Text('Approve'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isVerifying
                        ? null
                        : () => _showRejectDialog(context, therapist['id'], name),
                    icon: const Icon(Icons.cancel_rounded),
                    label: const Text('Reject'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFEF4444),
                      side: const BorderSide(color: Color(0xFFEF4444)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // View full profile
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('View profile - Coming soon'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.visibility_rounded),
                    label: const Text('View Profile'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                IconButton(
                  onPressed: isDeleting
                      ? null
                      : () => _showDeleteDialog(context, therapist['id'], name),
                  icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444)),
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.all(12.w),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _showApproveDialog(BuildContext context, String therapistId, String name) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Approve Therapist'),
        content: Text('Are you sure you want to approve $name as a verified therapist?'),
        actions: [
          TextButton(
            onPressed: () => dialogContext.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AdminCubit>().verifyTherapist(therapistId, isVerified: true);
              dialogContext.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$name has been approved'),
                  backgroundColor: const Color(0xFF10B981),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: const Text('Approve'),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context, String therapistId, String name) {
    final reasonController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Reject Therapist'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Provide a reason for rejecting $name:'),
            SizedBox(height: 12.h),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Rejection reason...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => dialogContext.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AdminCubit>().verifyTherapist(
                therapistId,
                isVerified: false,
                rejectionReason: reasonController.text,
              );
              dialogContext.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$name has been rejected'),
                  backgroundColor: const Color(0xFFEF4444),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String therapistId, String name) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Delete Therapist'),
        content: Text('Are you sure you want to delete $name? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => dialogContext.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AdminCubit>().deleteTherapist(therapistId);
              dialogContext.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$name has been deleted'),
                  backgroundColor: const Color(0xFFEF4444),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: color ?? context.primaryColor),
        SizedBox(width: 6.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10.sp,
                  color: context.textSecondaryColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: color ?? context.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;

  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 64.sp, color: context.textSecondaryColor),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.sp,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded, size: 64.sp, color: context.errorColor),
          SizedBox(height: 16.h),
          Text(
            'Error: $message',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.sp,
              color: context.errorColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
