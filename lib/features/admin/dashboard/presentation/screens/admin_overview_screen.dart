import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import '../bloc/admin_cubit.dart';
import '../bloc/admin_state.dart';
import '../bloc/admin_revenue_cubit.dart';
import 'widgets/admin_widgets.dart';

class AdminOverviewScreen extends StatefulWidget {
  final ValueChanged<int>? onNavigateTab;
  const AdminOverviewScreen({super.key, this.onNavigateTab});

  @override
  State<AdminOverviewScreen> createState() => _AdminOverviewScreenState();
}

class _AdminOverviewScreenState extends State<AdminOverviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminCubit>().loadDashboard();
      context.read<AdminRevenueCubit>().loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<AdminCubit>().loadDashboard();
            await context.read<AdminRevenueCubit>().loadAll();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                _buildHeader(context),
                SizedBox(height: 24.h),
                _buildRevenueCard(context),
                SizedBox(height: 24.h),
                _buildStatsGrid(),
                SizedBox(height: 24.h),
                _buildUserDistribution(),
                SizedBox(height: 24.h),
                _buildContentStats(),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // In a real app we'd fetch the authenticated admin's photoUrl from auth state
    // Let's use a placeholder or check if AdminCubit holds user details
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin Panel',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 26.sp, fontWeight: FontWeight.w800, color: context.textPrimaryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Overview & Analytics',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textSecondaryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: () => context.push('/admin-settings'),
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [context.primaryColor, context.primaryColor.withOpacity(0.7)]),
              shape: BoxShape.circle,
              border: Border.all(color: context.primaryColor.withOpacity(0.3), width: 2),
              boxShadow: [BoxShadow(color: context.primaryColor.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Center(
              child: Icon(Icons.person_rounded, color: Colors.white, size: 24.sp),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1);
  }

  Widget _buildRevenueCard(BuildContext context) {
    return BlocBuilder<AdminRevenueCubit, AdminRevenueState>(
      builder: (context, state) {
        if (state.status == AdminRevenueStatus.loading) {
          return Shimmer.fromColors(
            baseColor: context.surfaceColor,
            highlightColor: context.backgroundColor,
            child: Container(
              height: 240.h,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24.r)),
            ),
          );
        }

        final stats = state.revenueStats;
        final totalRevenue = stats['grandTotal'] ?? 0;
        final adminCut = (stats['adminCut'] ?? 0) + (stats['therapistAdminCut'] ?? 0);
        final monthly = (stats['monthlyRevenue'] as List<dynamic>?) ?? [];

        return GestureDetector(
          onTap: () => context.push('/admin-revenue'),
          child: Stack(
            children: [
              // Fill the card so the gradient actually paints behind the
              // content — without Positioned.fill this sized to ~0, leaving the
              // white text on the light scaffold (invisible in light mode).
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D9488),
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [BoxShadow(color: const Color(0xFF0D9488).withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 8))],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(24.r), border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text('Total Platform Revenue', style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: Colors.white.withOpacity(0.85)), overflow: TextOverflow.ellipsis)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(12.r)),
                              child: Text('NPR', style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text('Rs. ${_formatNum(totalRevenue)}', style: TextStyle(fontFamily: 'Poppins', fontSize: 32.sp, fontWeight: FontWeight.w800, color: Colors.white)),
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withOpacity(0.8), borderRadius: BorderRadius.circular(8.r)),
                          child: Text('Admin Profit: Rs. ${_formatNum(adminCut)}', style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, fontWeight: FontWeight.w600, color: Colors.white), overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(height: 24.h),
                        if (monthly.isNotEmpty) _buildAdvancedMonthlyChart(monthly),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.05),
        );
      },
    );
  }

  Widget _buildAdvancedMonthlyChart(List<dynamic> monthly) {
    final spots = <FlSpot>[];
    for (int i = 0; i < monthly.length; i++) {
      final amount = (monthly[i]['amount'] as num?)?.toDouble() ?? 0;
      spots.add(FlSpot(i.toDouble(), amount));
    }

    double maxY = spots.map((s) => s.y).fold(0.0, (a, b) => a > b ? a : b);
    if (maxY == 0) maxY = 1000;

    return SizedBox(
      height: 100.h,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true, drawVerticalLine: false, horizontalInterval: maxY / 2 == 0 ? 1 : maxY / 2,
            getDrawingHorizontalLine: (value) => FlLine(color: Colors.white.withOpacity(0.15), strokeWidth: 1, dashArray: [5, 5]),
          ),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0, maxX: (spots.length > 1 ? spots.length - 1 : 1).toDouble(), minY: 0, maxY: maxY * 1.3,
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipPadding: EdgeInsets.all(8.w), tooltipMargin: 8,
              getTooltipItems: (touchedSpots) => touchedSpots.map((spot) => LineTooltipItem('Rs. ${spot.y.toInt()}', TextStyle(fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10.sp))).toList(),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots, isCurved: true, curveSmoothness: 0.35, color: Colors.white, barWidth: 3, isStrokeCapRound: true,
              dotData: FlDotData(show: true, getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(radius: 3.r, color: Colors.white, strokeWidth: 2, strokeColor: const Color(0xFF6366F1))),
              belowBarData: BarAreaData(show: true, gradient: LinearGradient(colors: [Colors.white.withOpacity(0.4), Colors.white.withOpacity(0.0)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        final isLoading = state.maybeMap(loading: (_) => true, orElse: () => false);
        if (isLoading) {
          final itemWidth = (MediaQuery.of(context).size.width - 32.w - 12.w) / 2;
          return Wrap(
            spacing: 12.w, runSpacing: 12.h,
            children: List.generate(4, (i) => Shimmer.fromColors(
              baseColor: context.surfaceColor, highlightColor: context.backgroundColor,
              child: Container(width: itemWidth, height: 140.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r))),
            )),
          );
        }

        final stats = state.maybeMap(loaded: (s) => s.stats, orElse: () => <String, dynamic>{});
        final cards = [
          _StatData('Total Users', stats['totalUsers']?.toString() ?? '0', Icons.people_rounded, const Color(0xFF6366F1), () => widget.onNavigateTab?.call(3)),
          _StatData('Therapists', stats['totalTherapists']?.toString() ?? '0', Icons.psychology_rounded, const Color(0xFF0D9488), () => widget.onNavigateTab?.call(2)),
          _StatData('Pending', stats['pendingVerifications']?.toString() ?? '0', Icons.pending_actions_rounded, const Color(0xFFF59E0B), () => widget.onNavigateTab?.call(2)),
          _StatData('Content', _totalContent(stats), Icons.folder_rounded, const Color(0xFFEC4899), () => widget.onNavigateTab?.call(1)),
        ];

        final itemWidth = (MediaQuery.of(context).size.width - 32.w - 12.w) / 2;
        return Wrap(
          spacing: 12.w, runSpacing: 12.h,
          children: cards.asMap().entries.map((entry) {
            final card = entry.value;
            return SizedBox(
              width: itemWidth,
              child: AdminStatCard(title: card.title, value: card.value, icon: card.icon, iconColor: card.color, onTap: card.onTap)
                  .animate(delay: (entry.key * 50).ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),
            );
          }).toList(),
        );
      },
    );
  }

  String _totalContent(Map<String, dynamic> stats) {
    final tips = stats['totalTips'] as int? ?? 0;
    final quotes = stats['totalQuotes'] as int? ?? 0;
    final audio = stats['totalAudio'] as int? ?? 0;
    final videos = stats['totalVideos'] as int? ?? 0;
    return (tips + quotes + audio + videos).toString();
  }

  Widget _buildUserDistribution() {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        if (state.maybeMap(loading: (_) => true, orElse: () => false)) return const SizedBox();

        final stats = state.maybeMap(loaded: (s) => s.stats, orElse: () => <String, dynamic>{});
        final total = (stats['totalUsers'] as int? ?? 1).toDouble();
        final therapists = (stats['totalTherapists'] as int? ?? 0).toDouble();
        final customers = (total - therapists).clamp(0.0, total).toDouble();

        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(color: context.surfaceColor, borderRadius: BorderRadius.circular(20.r), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminSectionHeader(title: 'User Distribution'),
              SizedBox(height: 20.h),
              Row(
                children: [
                  SizedBox(
                    width: 120.w, height: 120.w,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 4, centerSpaceRadius: 28,
                        sections: [
                          PieChartSectionData(value: customers == 0 ? 0.01 : customers, color: const Color(0xFF6366F1), title: '${((customers / total) * 100).toStringAsFixed(0)}%', radius: 32, titleStyle: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins')),
                          PieChartSectionData(value: therapists == 0 ? 0.01 : therapists, color: const Color(0xFF0D9488), title: '${((therapists / total) * 100).toStringAsFixed(0)}%', radius: 32, titleStyle: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins')),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LegendItem(color: const Color(0xFF6366F1), label: 'Customers', value: customers.toInt().toString()),
                        SizedBox(height: 16.h),
                        _LegendItem(color: const Color(0xFF0D9488), label: 'Therapists', value: therapists.toInt().toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContentStats() {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        if (state.maybeMap(loading: (_) => true, orElse: () => false)) return const SizedBox();

        final stats = state.maybeMap(loaded: (s) => s.stats, orElse: () => <String, dynamic>{});
        final bars = [
          _BarData('Tips', (stats['totalTips'] as int? ?? 0).toDouble(), const Color(0xFF10B981)),
          _BarData('Quotes', (stats['totalQuotes'] as int? ?? 0).toDouble(), const Color(0xFF6366F1)),
          _BarData('Audio', (stats['totalAudio'] as int? ?? 0).toDouble(), const Color(0xFFF59E0B)),
          _BarData('Video', (stats['totalVideos'] as int? ?? 0).toDouble(), const Color(0xFFEC4899)),
        ];

        double maxY = bars.map((b) => b.value).fold(0, (a, b) => a > b ? a : b);
        if (maxY == 0) maxY = 10;
        
        final tooltipColor = context.isDarkMode ? Colors.white : Colors.black87;

        return GestureDetector(
          onTap: () => widget.onNavigateTab?.call(1),
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(color: context.surfaceColor, borderRadius: BorderRadius.circular(20.r), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdminSectionHeader(title: 'Content Breakdown', action: 'Manage', onAction: () => widget.onNavigateTab?.call(1)),
                SizedBox(height: 24.h),
                SizedBox(
                  height: 160.h,
                  child: BarChart(
                    BarChartData(
                      maxY: maxY * 1.3,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) => BarTooltipItem('${rod.toY.toInt()}', TextStyle(color: tooltipColor, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true, leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)), topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)), rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) {
                          final idx = v.toInt();
                          if (idx >= bars.length) return const SizedBox();
                          return Padding(padding: const EdgeInsets.only(top: 8), child: Text(bars[idx].label, style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp, fontWeight: FontWeight.w600, color: context.textSecondaryColor)));
                        })),
                      ),
                      gridData: FlGridData(show: true, getDrawingHorizontalLine: (_) => FlLine(color: context.dividerColor, strokeWidth: 1, dashArray: [5, 5]), drawVerticalLine: false),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(bars.length, (i) => BarChartGroupData(x: i, barRods: [
                        BarChartRodData(
                          toY: bars[i].value, color: bars[i].color, width: 28.w, borderRadius: BorderRadius.circular(6.r),
                          backDrawRodData: BackgroundBarChartRodData(show: true, toY: maxY * 1.3, color: bars[i].color.withOpacity(0.1)),
                        ),
                      ])),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatNum(dynamic n) {
    final num v = n is num ? n : 0;
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
    return v.toStringAsFixed(0);
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  const _LegendItem({required this.color, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 14.w, height: 14.w, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4.r))),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor), maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(value, style: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatData {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const _StatData(this.title, this.value, this.icon, this.color, this.onTap);
}

class _BarData {
  final String label;
  final double value;
  final Color color;
  const _BarData(this.label, this.value, this.color);
}
