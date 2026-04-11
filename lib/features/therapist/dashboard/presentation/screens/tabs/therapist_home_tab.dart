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
  const TherapistHomeTab({super.key, this.onNavigateToSessions});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TherapistCubit, TherapistState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.backgroundColor,
          body: RefreshIndicator(
            color: context.primaryColor,
            onRefresh: () => context.read<TherapistCubit>().loadDashboard(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              slivers: [
                _buildAppBar(context, state),
                if (state is TherapistLoading)
                  const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
                else if (state is TherapistError)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.error_outline_rounded, size: 48.sp, color: context.errorColor),
                          SizedBox(height: 12.h),
                          Text('Could not load dashboard', style: AppTextStyles.titleMedium),
                          SizedBox(height: 8.h),
                          ElevatedButton(
                            onPressed: () => context.read<TherapistCubit>().loadDashboard(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (state is TherapistDashboardLoaded)
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(height: 20.h),
                        _KpiRow(state: state),
                        SizedBox(height: 24.h),
                        if (state.nextAppointment != null)
                          _NextSessionCard(appointment: state.nextAppointment!),
                        if (state.pendingRequests > 0) ...[
                          SizedBox(height: 24.h),
                          _PendingRequestsBanner(
                            count: state.pendingRequests,
                            onNavigate: onNavigateToSessions,
                          ),
                        ],
                        SizedBox(height: 28.h),
                        _SessionChart(chart: state.sessionChart),
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
    final name = state is TherapistDashboardLoaded
        ? (state.nextAppointment?['therapist']?['displayName'] ?? 'Doctor')
        : 'Doctor';
    final hour = DateTime.now().hour;
    final greeting = hour < 12 ? 'Good morning' : hour < 17 ? 'Good afternoon' : 'Good evening';

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
                Container(
                  padding: EdgeInsets.all(2.5.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [context.primaryColor, context.primaryColor.withOpacity(0.4)],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 24.r,
                    backgroundColor: context.surfaceColor,
                    child: Icon(Icons.person_rounded, size: 22.sp, color: context.primaryColor),
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
                        'Dr. $name',
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
        border: Border.all(color: context.borderColor, width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.notifications_none_rounded, size: 22.sp, color: context.textPrimaryColor),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: context.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: context.surfaceColor, width: 1.5),
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
  final TherapistDashboardLoaded state;
  const _KpiRow({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _KpiCard(
                label: "Today's Sessions",
                value: '${state.todaySessions}',
                icon: Icons.video_call_rounded,
                iconColor: const Color(0xFF6366F1),
                bgColor: const Color(0xFF6366F1).withOpacity(0.1),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _KpiCard(
                label: 'Pending Requests',
                value: '${state.pendingRequests}',
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
                value: '${state.totalPatients}',
                icon: Icons.people_rounded,
                iconColor: const Color(0xFF0D9488),
                bgColor: const Color(0xFF0D9488).withOpacity(0.1),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _KpiCard(
                label: 'Week Earnings',
                value: '\$${state.weeklyEarnings.toStringAsFixed(0)}',
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
        border: Border.all(color: context.borderColor, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12.r)),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: context.textPrimaryColor,
                    )),
                Text(label,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.sp,
                      color: context.textSecondaryColor,
                    ),
                    maxLines: 2),
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
    final timeFormatted = time != null ? DateFormat('h:mm a · MMM d').format(time.toLocal()) : 'Soon';
    final appointmentId = appointment['id'] as String? ?? '';
    final roomId = appointment['meetingRoomId'] as String? ?? '';

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.primaryColor, const Color(0xFF0F766E)],
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
              Icon(Icons.access_time_rounded, color: Colors.white70, size: 16.sp),
              SizedBox(width: 4.w),
              Text(timeFormatted,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    color: Colors.white70,
                  )),
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
                    context.read<TherapistCubit>().notifyCallStart(appointmentId);
                    context.push('/video-call/$appointmentId/${roomId.isNotEmpty ? roomId : appointmentId}');
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 4)),
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
              child: Icon(Icons.pending_actions_rounded, color: const Color(0xFFF59E0B), size: 20.sp),
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

    final max = chart.map((e) => (e['count'] as num?)?.toDouble() ?? 0.0).fold(0.0, (a, b) => a > b ? a : b);

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
            border: Border.all(color: context.borderColor, width: 0.5),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
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
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: (value, meta) {
                      final idx = value.toInt();
                      if (idx < 0 || idx >= chart.length) return const SizedBox.shrink();
                      final date = chart[idx]['date'] as String? ?? '';
                      final short = date.length >= 10 ? date.substring(5) : date;
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
                      borderRadius: BorderRadius.vertical(top: Radius.circular(6.r)),
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
