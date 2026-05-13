import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import '../bloc/admin_cubit.dart';
import '../bloc/admin_state.dart';
import 'widgets/admin_widgets.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final _searchController = TextEditingController();
  String _roleFilter = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminCubit>().loadUsers();
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
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('User Management', style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
        actions: [
          IconButton(icon: Icon(Icons.refresh_rounded, color: context.primaryColor),
            onPressed: () => context.read<AdminCubit>().loadUsers(role: _roleFilter, search: _searchController.text)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
            child: Column(
              children: [
                AdminSearchBar(
                  controller: _searchController,
                  hint: 'Search by name or email...',
                  onChanged: (v) => context.read<AdminCubit>().loadUsers(role: _roleFilter, search: v),
                  onClear: () => context.read<AdminCubit>().loadUsers(role: _roleFilter),
                ),
                SizedBox(height: 10.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      AdminFilterChip(label: 'All', isSelected: _roleFilter == 'all', onTap: () => _filter('all')),
                      SizedBox(width: 8.w),
                      AdminFilterChip(label: '👤 Customers', isSelected: _roleFilter == 'user', onTap: () => _filter('user'), selectedColor: const Color(0xFF6366F1)),
                      SizedBox(width: 8.w),
                      AdminFilterChip(label: '🧠 Therapists', isSelected: _roleFilter == 'therapist', onTap: () => _filter('therapist'), selectedColor: const Color(0xFF0D9488)),
                      SizedBox(width: 8.w),
                      AdminFilterChip(label: '⚙️ Admins', isSelected: _roleFilter == 'admin', onTap: () => _filter('admin'), selectedColor: const Color(0xFF8B5CF6)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  void _filter(String role) {
    setState(() => _roleFilter = role);
    context.read<AdminCubit>().loadUsers(role: role, search: _searchController.text);
  }

  Widget _buildBody() {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        return state.maybeMap(
          loading: (_) => const Center(child: CircularProgressIndicator()),
          error: (e) => Center(child: Text('Error: ${e.message}')),
          loaded: (loaded) {
            if (loaded.users.isEmpty) {
              return AdminEmptyState(icon: Icons.people_outline_rounded, title: 'No users found', subtitle: 'Try adjusting the search or filter');
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: loaded.users.length,
              itemBuilder: (_, i) => _UserCard(user: loaded.users[i], isUpdating: loaded.isUpdatingUser),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class _UserCard extends StatelessWidget {
  final dynamic user;
  final bool isUpdating;

  const _UserCard({required this.user, required this.isUpdating});

  @override
  Widget build(BuildContext context) {
    final name = user['displayName'] as String? ?? 'Unknown';
    final email = user['email'] as String? ?? '';
    final role = user['userRole'] as String? ?? 'user';
    final isActive = user['isActive'] as bool? ?? true;
    final photoUrl = user['photoUrl'] as String?;
    final sub = user['subscription'] as Map<String, dynamic>?;
    final joinDate = user['createdAt'] as String? ?? '';
    final shortDate = joinDate.length >= 10 ? joinDate.substring(0, 10) : joinDate;

    final roleColor = role == 'admin' ? const Color(0xFF8B5CF6) : role == 'therapist' ? const Color(0xFF0D9488) : const Color(0xFF6366F1);

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: roleColor.withOpacity(0.12),
            backgroundImage: photoUrl != null && photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
            child: photoUrl == null || photoUrl.isEmpty ? Icon(Icons.person_rounded, size: 22.sp, color: roleColor) : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(name, style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w600, color: context.textPrimaryColor), overflow: TextOverflow.ellipsis)),
                    AdminStatusBadge(label: role.toUpperCase(), color: roleColor),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(email, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor), overflow: TextOverflow.ellipsis),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(!isActive ? Icons.block_rounded : Icons.check_circle_outline_rounded, size: 12.sp, color: isActive ? const Color(0xFF10B981) : const Color(0xFFEF4444)),
                    SizedBox(width: 4.w),
                    Text(isActive ? 'Active' : 'Suspended', style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp, color: isActive ? const Color(0xFF10B981) : const Color(0xFFEF4444))),
                    if (sub != null) ...[
                      SizedBox(width: 8.w),
                      Icon(Icons.card_membership_rounded, size: 12.sp, color: const Color(0xFF8B5CF6)),
                      SizedBox(width: 3.w),
                      Text(sub['plan_id'] ?? 'Free', style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp, color: const Color(0xFF8B5CF6))),
                    ],
                    const Spacer(),
                    Text(shortDate, style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp, color: context.textHintColor)),
                  ],
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert_rounded, color: context.textSecondaryColor, size: 20.sp),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            onSelected: (value) => _handleAction(context, value),
            itemBuilder: (_) => [
              PopupMenuItem(value: 'toggle', child: Row(children: [
                Icon(isActive ? Icons.block_rounded : Icons.check_circle_outline_rounded, size: 16.sp, color: isActive ? const Color(0xFFEF4444) : const Color(0xFF10B981)),
                SizedBox(width: 8.w),
                Text(isActive ? 'Suspend' : 'Activate', style: const TextStyle(fontFamily: 'Poppins')),
              ])),
              if (role != 'admin') PopupMenuItem(value: 'make_admin', child: Row(children: [
                Icon(Icons.admin_panel_settings_rounded, size: 16.sp, color: const Color(0xFF8B5CF6)),
                SizedBox(width: 8.w),
                const Text('Make Admin', style: TextStyle(fontFamily: 'Poppins')),
              ])),
              PopupMenuItem(value: 'delete', child: Row(children: [
                Icon(Icons.delete_outline_rounded, size: 16.sp, color: const Color(0xFFEF4444)),
                SizedBox(width: 8.w),
                const Text('Delete', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFFEF4444))),
              ])),
            ],
          ),
        ],
      ),
    );
  }

  void _handleAction(BuildContext context, String action) {
    final id = user['id'] as String? ?? '';
    final name = user['displayName'] as String? ?? '';
    final isActive = user['isActive'] as bool? ?? true;

    if (action == 'toggle') {
      context.read<AdminCubit>().updateUserStatus(id, isActive: !isActive);
    } else if (action == 'make_admin') {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: const Text('Make Admin', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
          content: Text('Grant admin privileges to $name?'),
          actions: [
            TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6)),
              onPressed: () {
                context.read<AdminCubit>().updateUserRole(id, userRole: 'admin');
                context.pop();
              },
              child: const Text('Confirm', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
            ),
          ],
        ),
      );
    } else if (action == 'delete') {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: const Text('Delete User', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
          content: Text('Permanently delete $name? This cannot be undone.'),
          actions: [
            TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
              onPressed: () {
                context.read<AdminCubit>().deleteUser(id);
                context.pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
            ),
          ],
        ),
      );
    }
  }
}
