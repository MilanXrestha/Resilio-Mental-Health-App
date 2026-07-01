import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import '../bloc/admin_revenue_cubit.dart';
import 'widgets/admin_widgets.dart';

class AdminRevenueScreen extends StatefulWidget {
  const AdminRevenueScreen({super.key});

  @override
  State<AdminRevenueScreen> createState() => _AdminRevenueScreenState();
}

class _AdminRevenueScreenState extends State<AdminRevenueScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminRevenueCubit>().loadAll();
      context.read<AdminRevenueCubit>().loadSubscriptions();
      context.read<AdminRevenueCubit>().loadTherapistPayments();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: context.textPrimaryColor),
          onPressed: () => context.pop(),
        ),
        title: Text('Revenue & Finance', style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_rounded, color: context.primaryColor),
            onPressed: () {
              context.read<AdminRevenueCubit>().loadAll();
              context.read<AdminRevenueCubit>().loadSubscriptions();
              context.read<AdminRevenueCubit>().loadTherapistPayments();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w700),
          unselectedLabelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp),
          labelColor: context.primaryColor,
          unselectedLabelColor: context.textSecondaryColor,
          indicatorColor: context.primaryColor,
          tabs: const [Tab(text: 'Overview'), Tab(text: 'Subscriptions'), Tab(text: 'Therapists')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _OverviewTab(),
          _SubscriptionsTab(),
          _TherapistPaymentsTab(),
        ],
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminRevenueCubit, AdminRevenueState>(
      builder: (context, state) {
        if (state.status == AdminRevenueStatus.loading) return const Center(child: CircularProgressIndicator());
        final stats = state.revenueStats;
        final totalRevenue = stats['grandTotal'] as num? ?? 0;
        final adminCut = (stats['adminCut'] as num? ?? 0) + (stats['therapistAdminCut'] as num? ?? 0);
        final therapistTotal = stats['therapistTotal'] as num? ?? 0;
        final therapistPayout = stats['therapistPayout'] as num? ?? 0;
        final monthly = (stats['monthlyRevenue'] as List<dynamic>?) ?? [];
        final plans = (stats['planDistribution'] as List<dynamic>?) ?? [];

        final itemWidth = (MediaQuery.of(context).size.width - 32.w - 12.w) / 2;

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  SizedBox(width: itemWidth, child: AdminStatCard(title: 'Total Revenue', value: 'Rs. ${_fmt(totalRevenue)}', icon: Icons.account_balance_rounded, iconColor: const Color(0xFF0D9488)).animate().fadeIn()),
                  SizedBox(width: itemWidth, child: AdminStatCard(title: 'Admin Earnings', value: 'Rs. ${_fmt(adminCut)}', subtitle: 'Platform Cut', icon: Icons.percent_rounded, iconColor: const Color(0xFF8B5CF6)).animate().fadeIn(delay: 100.ms)),
                  SizedBox(width: itemWidth, child: AdminStatCard(title: 'Therapist Total', value: 'Rs. ${_fmt(therapistTotal)}', icon: Icons.psychology_rounded, iconColor: const Color(0xFF6366F1)).animate().fadeIn(delay: 150.ms)),
                  SizedBox(width: itemWidth, child: AdminStatCard(title: 'Therapist Payout', value: 'Rs. ${_fmt(therapistPayout)}', subtitle: '90% default split', icon: Icons.payments_rounded, iconColor: const Color(0xFF10B981)).animate().fadeIn(delay: 200.ms)),
                ],
              ),
              SizedBox(height: 20.h),

              // Commission explanation
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded, color: const Color(0xFF8B5CF6), size: 24.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Admin receives a 10% commission on all completed therapist sessions. Therapists retain the remaining 90%.',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: const Color(0xFF8B5CF6)),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 250.ms),
              SizedBox(height: 24.h),

              // Monthly chart
              if (monthly.isNotEmpty) ...[
                AdminSectionHeader(title: 'Monthly Revenue (NPR)'),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(color: context.surfaceColor, borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                  child: SizedBox(height: 200.h, child: _monthlyBarChart(context, monthly)),
                ),
                SizedBox(height: 24.h),
              ],

              // Plan distribution pie
              if (plans.isNotEmpty) ...[
                AdminSectionHeader(title: 'Subscription Plans'),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(color: context.surfaceColor, borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                  child: SizedBox(height: 160.h, child: _planPieChart(context, plans)),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _monthlyBarChart(BuildContext context, List<dynamic> monthly) {
    final colors = [const Color(0xFF0D9488), const Color(0xFF6366F1), const Color(0xFF10B981), const Color(0xFF8B5CF6), const Color(0xFFF59E0B), const Color(0xFFEC4899)];
    double maxY = 1;
    for (final m in monthly) {
      final v = (m['amount'] as num?)?.toDouble() ?? 0;
      if (v > maxY) maxY = v;
    }

    return BarChart(BarChartData(
      maxY: maxY * 1.2,
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              'Rs. ${rod.toY.toInt()}',
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (v, m) {
            final idx = v.toInt();
            if (idx >= monthly.length || idx < 0) return const SizedBox.shrink();
            final label = monthly[idx]['month']?.toString().substring(5) ?? '';
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp, color: context.textSecondaryColor, fontWeight: FontWeight.bold)),
            );
          },
        )),
      ),
      gridData: FlGridData(drawVerticalLine: false, getDrawingHorizontalLine: (_) => FlLine(color: context.dividerColor, strokeWidth: 1, dashArray: [5, 5])),
      borderData: FlBorderData(show: false),
      barGroups: List.generate(monthly.length, (i) {
        final v = (monthly[i]['amount'] as num?)?.toDouble() ?? 0;
        return BarChartGroupData(x: i, barRods: [
          BarChartRodData(
            toY: v,
            color: colors[i % colors.length],
            width: 22.w,
            borderRadius: BorderRadius.circular(6.r),
            backDrawRodData: BackgroundBarChartRodData(show: true, toY: maxY * 1.2, color: colors[i % colors.length].withOpacity(0.1)),
          ),
        ]);
      }),
    ));
  }

  Widget _planPieChart(BuildContext context, List<dynamic> plans) {
    final colors = [const Color(0xFF0D9488), const Color(0xFF6366F1), const Color(0xFF10B981), const Color(0xFFF59E0B)];
    return Row(
      children: [
        SizedBox(
          width: 130.w,
          child: PieChart(PieChartData(
            sectionsSpace: 4,
            centerSpaceRadius: 28,
            sections: List.generate(plans.length, (i) {
              final count = (plans[i]['count'] as num?)?.toDouble() ?? 1;
              return PieChartSectionData(
                value: count,
                color: colors[i % colors.length],
                title: count.toInt().toString(),
                radius: 32,
                titleStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),
              );
            }),
          )),
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(plans.length, (i) {
              final plan = plans[i]['planId']?.toString() ?? 'Unknown';
              final count = plans[i]['count']?.toString() ?? '0';
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    Container(width: 14.w, height: 14.w, decoration: BoxDecoration(color: colors[i % colors.length], borderRadius: BorderRadius.circular(4.r))),
                    SizedBox(width: 10.w),
                    Expanded(child: Text(plan, style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textSecondaryColor, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  String _fmt(num n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return n.toStringAsFixed(0);
  }
}

class _SubscriptionsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminRevenueCubit, AdminRevenueState>(
      builder: (context, state) {
        final subs = state.subscriptions;
        if (subs.isEmpty && state.status == AdminRevenueStatus.loading) return const Center(child: CircularProgressIndicator());
        
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['all', 'active', 'expired', 'cancelled'].map((s) => Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: AdminFilterChip(label: s.toUpperCase(), isSelected: state.subscriptionFilter == s, onTap: () => context.read<AdminRevenueCubit>().loadSubscriptions(status: s), selectedColor: const Color(0xFF8B5CF6)),
                  )).toList(),
                ),
              ),
            ),
            if (subs.isEmpty) 
              Expanded(child: AdminEmptyState(icon: Icons.card_membership_rounded, title: 'No subscriptions found')),
            if (subs.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: subs.length,
                  itemBuilder: (_, i) {
                    final sub = subs[i];
                    final name = sub['displayName']?.toString() ?? 'Unknown';
                    final plan = sub['plan_id']?.toString() ?? 'Free';
                    final status = sub['status']?.toString() ?? 'unknown';
                    final endDate = sub['end_date']?.toString().substring(0, 10) ?? '';
                    final photo = sub['photoUrl']?.toString();
                    final statusColor = status == 'active' ? const Color(0xFF10B981) : const Color(0xFFEF4444);

                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(color: context.surfaceColor, borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24.r, 
                            backgroundColor: const Color(0xFF8B5CF6).withOpacity(0.1),
                            backgroundImage: photo != null && photo.isNotEmpty ? NetworkImage(photo) : null,
                            child: photo == null || photo.isEmpty ? Icon(Icons.person_rounded, size: 24.sp, color: const Color(0xFF8B5CF6)) : null
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, 
                              children: [
                                Text(name, style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor), maxLines: 1, overflow: TextOverflow.ellipsis),
                                Text(sub['email']?.toString() ?? '', style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor), maxLines: 1, overflow: TextOverflow.ellipsis),
                              ]
                            )
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end, 
                            children: [
                              AdminStatusBadge(label: plan.toUpperCase(), color: const Color(0xFF8B5CF6)),
                              SizedBox(height: 6.h),
                              AdminStatusBadge(label: status.toUpperCase(), color: statusColor),
                              SizedBox(height: 6.h),
                              Text('Expires: $endDate', style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp, color: context.textHintColor)),
                            ]
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class _TherapistPaymentsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminRevenueCubit, AdminRevenueState>(
      builder: (context, state) {
        final payments = state.therapistPayments;
        if (payments.isEmpty && state.status == AdminRevenueStatus.loading) return const Center(child: CircularProgressIndicator());
        if (payments.isEmpty) return AdminEmptyState(icon: Icons.payments_rounded, title: 'No completed sessions yet');

        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: payments.length,
          itemBuilder: (_, i) {
            final p = payments[i];
            final total = p['totalAmount'] as num? ?? 0;
            final commission = p['adminCommission'] as num? ?? 0;
            final payout = p['therapistPayout'] as num? ?? 0;
            final date = p['appointmentDate']?.toString().substring(0, 10) ?? '';
            final therapistName = p['therapistName']?.toString() ?? 'Unknown';
            final photo = p['therapistPhoto']?.toString();

            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(color: context.surfaceColor, borderRadius: BorderRadius.circular(16.r),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24.r, backgroundColor: const Color(0xFF0D9488).withOpacity(0.1),
                    backgroundImage: photo != null && photo.isNotEmpty ? NetworkImage(photo) : null,
                    child: photo == null || photo.isEmpty ? Icon(Icons.psychology_rounded, size: 24.sp, color: const Color(0xFF0D9488)) : null
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                        Text(therapistName, style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor), maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text(date, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor)),
                      ]
                    )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end, 
                    children: [
                      Text('Rs. $total', style: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp, fontWeight: FontWeight.w800, color: context.textPrimaryColor)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withOpacity(0.1), borderRadius: BorderRadius.circular(6.r)),
                        child: Text('Admin (10%): Rs. $commission', style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp, fontWeight: FontWeight.w600, color: const Color(0xFF8B5CF6))),
                      ),
                      SizedBox(height: 2.h),
                      Text('Payout: Rs. $payout', style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, fontWeight: FontWeight.w700, color: const Color(0xFF10B981))),
                    ]
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
