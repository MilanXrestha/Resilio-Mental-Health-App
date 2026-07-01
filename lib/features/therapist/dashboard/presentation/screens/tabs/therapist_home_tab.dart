import '../../widgets/shimmer_therapist_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../bloc/therapist_cubit.dart';
import '../../bloc/therapist_state.dart';
import 'package:intl/intl.dart';

class TherapistHomeTab extends StatelessWidget {
  final VoidCallback? onNavigateToSessions;
  final VoidCallback? onNavigateToContent;
  final VoidCallback? onNavigateToSettings;
  const TherapistHomeTab({super.key, this.onNavigateToSessions, this.onNavigateToContent, this.onNavigateToSettings});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TherapistCubit, TherapistState>(
      builder: (context, state) {
        // Show full shimmer (including app bar) while loading
        if (state.isLoading && !state.hasDashboard) {
          return Scaffold(
            backgroundColor: context.backgroundColor,
            body: const TherapistHomeShimmer(),
          );
        }
        
        // Show error state
        if (state.errorMessage != null && !state.hasDashboard) {
          return Scaffold(
            backgroundColor: context.backgroundColor,
            body: Center(
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
                    'Could not load dashboard',
                    style: AppTextStyles.titleMedium,
                  ),
                  SizedBox(height: 8.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<TherapistCubit>().loadDashboard(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }
        
        // Show real content with app bar
        return Scaffold(
          backgroundColor: context.backgroundColor,
          body: RefreshIndicator(
            color: context.primaryColor,
            onRefresh: () => context.read<TherapistCubit>().loadDashboard(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                _buildAppBar(context, state),
                if (state.hasDashboard)
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(height: 20.h),
                        _KpiRow(data: state.dashboardData!),
                        SizedBox(height: 24.h),
                        if (state.dashboardData!['nextAppointment'] != null)
                          _NextSessionCard(appointment: state.dashboardData!['nextAppointment'] as Map<String, dynamic>),
                        if ((state.dashboardData!['pendingRequests'] as num?)?.toInt() != null && ((state.dashboardData!['pendingRequests'] as num?)!.toInt()) > 0) ...[
                          SizedBox(height: 24.h),
                          _PendingRequestsBanner(
                            count: (state.dashboardData!['pendingRequests'] as num).toInt(),
                            onNavigate: onNavigateToSessions,
                          ),
                        ],
                        SizedBox(height: 28.h),
                        _SessionChart(chart: (state.dashboardData!['sessionChart'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>()),
                        SizedBox(height: 28.h),
                        _RecentActivitySnippet(
                          onNavigateToSessions: onNavigateToSessions,
                          onNavigateToContent: onNavigateToContent,
                        ),
                      ]),
                    ),
                  )
                else
                  const SliverFillRemaining(child: SizedBox.shrink()),
              ],
            ),
          ),
        );
      },
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, TherapistState state) {
    // Get therapist name from profile or dashboard data
    String? firstName;
    String? profilePicUrl;
    
    if (state.hasProfile && state.profile != null) {
      final displayName = state.profile!['displayName'] as String? ?? '';
      if (displayName.isNotEmpty) {
        // Extract first name
        firstName = displayName.split(' ')[0];
      }
      // Get profile picture
      profilePicUrl = state.profile!['profilePictureUrl'] as String?;
    } else if (state.hasDashboard && state.dashboardData!['nextAppointment'] != null) {
      final therapistInfo = state.dashboardData!['nextAppointment']?['therapist'];
      if (therapistInfo != null) {
        final displayName = therapistInfo['displayName'] as String? ?? '';
        if (displayName.isNotEmpty) {
          firstName = displayName.split(' ')[0];
        }
      }
    }
    
    // Show shimmer for app bar if no data yet
    if (firstName == null) {
      return SliverAppBar(
        backgroundColor: context.backgroundColor,
        surfaceTintColor: Colors.transparent,
        floating: true,
        snap: true,
        elevation: 0,
        expandedHeight: 100.h,
        flexibleSpace: FlexibleSpaceBar(
          background: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                children: [
                  // Avatar shimmer
                  Container(
                    width: 52.w,
                    height: 52.w,
                    decoration: BoxDecoration(
                      color: context.textSecondaryColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          height: 13.h,
                          decoration: BoxDecoration(
                            color: context.textSecondaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          width: 150.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: context.textSecondaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Notification bell shimmer
                  Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      color: context.textSecondaryColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good morning'
        : hour < 17
        ? 'Good afternoon'
        : 'Good evening';

    return SliverAppBar(
      backgroundColor: context.backgroundColor,
      surfaceTintColor: Colors.transparent,
      floating: true,
      snap: true,
      elevation: 0,
      expandedHeight: 100.h,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Row(
              children: [
                // Avatar
                GestureDetector(
                  onTap: onNavigateToSettings,
                  child: Container(
                    padding: EdgeInsets.all(2.5.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          context.primaryColor,
                          context.primaryColor.withOpacity(0.4),
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 24.r,
                      backgroundColor: context.surfaceColor,
                      backgroundImage: profilePicUrl != null && profilePicUrl.isNotEmpty
                          ? NetworkImage(profilePicUrl)
                          : null,
                      child: profilePicUrl == null || profilePicUrl.isEmpty
                          ? Icon(
                              Icons.person_rounded,
                              size: 22.sp,
                              color: context.primaryColor,
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$greeting,',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                          color: context.textSecondaryColor,
                        ),
                      ),
                      Text(
                        firstName,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: context.textPrimaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Notification Bell
                _NotifBell(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Notification Bell ──────────────────────────────────────────────────────────
class _NotifBell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        shape: BoxShape.circle,
        border: Border.all(color: context.borderColor, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.push('/therapist/notifications'),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  size: 22.sp,
                  color: context.textPrimaryColor,
                ),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: context.errorColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.surfaceColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── KPI Row ────────────────────────────────────────────────────────────────────
class _KpiRow extends StatelessWidget {
  final Map<String, dynamic> data;
  const _KpiRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _KpiCard(
                label: "Today's Sessions",
                value: '${data['todaySessions'] ?? 0}',
                icon: Icons.video_call_rounded,
                iconColor: const Color(0xFF6366F1),
                bgColor: const Color(0xFF6366F1).withOpacity(0.1),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _KpiCard(
                label: 'Pending Requests',
                value: '${data['pendingRequests'] ?? 0}',
                icon: Icons.pending_actions_rounded,
                iconColor: const Color(0xFFF59E0B),
                bgColor: const Color(0xFFF59E0B).withOpacity(0.1),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _KpiCard(
                label: 'Total Patients',
                value: '${data['totalPatients'] ?? 0}',
                icon: Icons.people_rounded,
                iconColor: const Color(0xFF0D9488),
                bgColor: const Color(0xFF0D9488).withOpacity(0.1),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _KpiCard(
                label: 'Week Earnings',
                value: 'Rs.${((data['weeklyEarnings'] as num?)?.toDouble() ?? 0.0).toStringAsFixed(0)}',
                icon: Icons.account_balance_wallet_rounded,
                iconColor: const Color(0xFF10B981),
                bgColor: const Color(0xFF10B981).withOpacity(0.1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  const _KpiCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: iconColor.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [bgColor, bgColor.withOpacity(0.5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimaryColor,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.sp,
                    color: context.textSecondaryColor,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Next Session Card ──────────────────────────────────────────────────────────
class _NextSessionCard extends StatelessWidget {
  final Map<String, dynamic> appointment;
  const _NextSessionCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final patient = appointment['patient'] as Map<String, dynamic>? ?? {};
    final patientName = patient['displayName'] ?? 'Patient';
    final timeStr = appointment['scheduledTime'] as String?;
    DateTime? time;
    if (timeStr != null) time = DateTime.tryParse(timeStr);
    final timeFormatted = time != null
        ? DateFormat('h:mm a · MMM d').format(time.toLocal())
        : 'Soon';
    final appointmentId = appointment['id'] as String? ?? '';
    final roomId = appointment['meetingRoomId'] as String? ?? '';

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.primaryColor,
            context.primaryColor.withBlue(context.primaryColor.blue + 30),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'NEXT SESSION',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.access_time_rounded,
                color: Colors.white70,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                timeFormatted,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: Colors.white.withOpacity(0.25),
                child: Text(
                  patientName.isNotEmpty ? patientName[0].toUpperCase() : 'P',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientName,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Video Session',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              // Join Button
              GestureDetector(
                onTap: () {
                  if (appointmentId.isNotEmpty) {
                    context.read<TherapistCubit>().notifyCallStart(
                      appointmentId,
                    );
                    context.push(
                      '/video-call/$appointmentId/${roomId.isNotEmpty ? roomId : appointmentId}',
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'Join',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: context.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Pending Requests Banner ────────────────────────────────────────────────────
class _PendingRequestsBanner extends StatelessWidget {
  final int count;
  final VoidCallback? onNavigate;
  const _PendingRequestsBanner({required this.count, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<TherapistCubit>().loadAppointments(filter: 'pending');
        onNavigate?.call();
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF59E0B).withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFF59E0B).withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.pending_actions_rounded,
                color: const Color(0xFFF59E0B),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$count Pending Request${count > 1 ? 's' : ''}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  Text(
                    'Tap to review and accept',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: const Color(0xFFF59E0B)),
          ],
        ),
      ),
    );
  }
}

// ── Session Chart ──────────────────────────────────────────────────────────────
class _SessionChart extends StatelessWidget {
  final List<Map<String, dynamic>> chart;
  const _SessionChart({required this.chart});

  @override
  Widget build(BuildContext context) {
    if (chart.isEmpty) return const SizedBox.shrink();

    final max = chart
        .map((e) => (e['count'] as num?)?.toDouble() ?? 0.0)
        .fold(0.0, (a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sessions — Last 7 Days',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: context.textPrimaryColor,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          height: 160.h,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 12),
            ],
          ),
          child: BarChart(
            BarChartData(
              maxY: (max + 1).clamp(2.0, double.infinity),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (_) =>
                    FlLine(color: context.borderColor, strokeWidth: 0.5),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: (value, meta) {
                      final idx = value.toInt();
                      if (idx < 0 || idx >= chart.length) {
                        return const SizedBox.shrink();
                      }
                      final date = chart[idx]['date'] as String? ?? '';
                      final short = date.length >= 10
                          ? date.substring(5)
                          : date;
                      return Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          short,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 9.sp,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(chart.length, (i) {
                final count = (chart[i]['count'] as num?)?.toDouble() ?? 0.0;
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: count,
                      color: context.primaryColor,
                      width: 16.w,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(6.r),
                      ),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: (max + 1).clamp(2.0, double.infinity),
                        color: context.primaryColor.withOpacity(0.07),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Recent Activity Snippet ────────────────────────────────────────────────────
class _RecentActivitySnippet extends StatelessWidget {
  final VoidCallback? onNavigateToSessions;
  final VoidCallback? onNavigateToContent;
  
  const _RecentActivitySnippet({this.onNavigateToSessions, this.onNavigateToContent});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: context.textPrimaryColor,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                icon: Icons.calendar_month_rounded,
                label: 'View Schedule',
                color: const Color(0xFF6366F1),
                onTap: () {
                  // Navigate to appointments tab
                  onNavigateToSessions?.call();
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _QuickActionCard(
                icon: Icons.article_rounded,
                label: 'Add Content',
                color: const Color(0xFF10B981),
                onTap: () {
                  onNavigateToContent?.call();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: context.borderColor, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            SizedBox(height: 12.h),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
