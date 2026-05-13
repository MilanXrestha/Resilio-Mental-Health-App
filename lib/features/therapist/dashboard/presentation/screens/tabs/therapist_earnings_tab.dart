import '../../widgets/shimmer_therapist_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../bloc/therapist_cubit.dart';
import '../../bloc/therapist_state.dart';

class TherapistEarningsTab extends StatefulWidget {
  const TherapistEarningsTab({super.key});

  @override
  State<TherapistEarningsTab> createState() => _TherapistEarningsTabState();
}

class _TherapistEarningsTabState extends State<TherapistEarningsTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TherapistCubit>().loadEarnings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: BlocBuilder<TherapistCubit, TherapistState>(
          builder: (context, state) {
            if (state.isLoading && !state.hasEarnings) {
              return const TherapistEarningsShimmer();
            }
            if (state.errorMessage != null && !state.hasEarnings) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 48.sp,
                      color: context.errorColor,
                    ),
                    SizedBox(height: 12.h),
                    TextButton(
                      onPressed: () =>
                          context.read<TherapistCubit>().loadEarnings(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (!state.hasEarnings) {
              return const SizedBox.shrink();
            }

            final earnings = state.earningsData!;

            return RefreshIndicator(
              color: context.primaryColor,
              onRefresh: () => context.read<TherapistCubit>().loadEarnings(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 100.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Earnings',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _TotalEarningsHero(total: (earnings['totalEarnings'] as num?)?.toDouble() ?? 0.0),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: _EarningsCard(
                            label: 'This Week',
                            amount: (earnings['weekEarnings'] as num?)?.toDouble() ?? 0.0,
                            icon: Icons.date_range_rounded,
                            color: const Color(0xFF6366F1),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _EarningsCard(
                            label: 'This Month',
                            amount: (earnings['monthEarnings'] as num?)?.toDouble() ?? 0.0,
                            icon: Icons.calendar_month_rounded,
                            color: const Color(0xFF0D9488),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28.h),
                    _WeeklyEarningsChart(chart: (earnings['weeklyChart'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>()),
                    SizedBox(height: 28.h),
                    _TransactionList(transactions: (earnings['transactions'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TotalEarningsHero extends StatelessWidget {
  final double total;
  const _TotalEarningsHero({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
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
            color: context.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Earnings',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Rs.${total.toStringAsFixed(2)}',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 36.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'All time revenue',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}

class _EarningsCard extends StatelessWidget {
  final String label;
  final double amount;
  final IconData icon;
  final Color color;

  const _EarningsCard({
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
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
            color: color.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 18.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            'Rs.${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: context.textPrimaryColor,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyEarningsChart extends StatelessWidget {
  final List<Map<String, dynamic>> chart;
  const _WeeklyEarningsChart({required this.chart});

  @override
  Widget build(BuildContext context) {
    if (chart.isEmpty) return const SizedBox.shrink();

    final max = chart
        .map((e) => (e['amount'] as num?)?.toDouble() ?? 0.0)
        .fold(0.0, (a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Revenue',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: context.textPrimaryColor,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          height: 180.h,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: context.borderColor, width: 0.5),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
            ],
          ),
          child: BarChart(
            BarChartData(
              maxY: (max * 1.2).clamp(10.0, double.infinity),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (_) =>
                    FlLine(color: context.borderColor, strokeWidth: 0.5),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40.w,
                    interval: (max / 3).clamp(1.0, double.infinity),
                    getTitlesWidget: (val, _) => Text(
                      'Rs.${val.toInt()}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9.sp,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ),
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
                    reservedSize: 24,
                    getTitlesWidget: (val, _) {
                      final i = val.toInt();
                      if (i < 0 || i >= chart.length)
                        return const SizedBox.shrink();
                      return Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          chart[i]['label'] as String? ?? '',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.sp,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(chart.length, (i) {
                final amount = (chart[i]['amount'] as num?)?.toDouble() ?? 0.0;
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: amount,
                      gradient: LinearGradient(
                        colors: [const Color(0xFF14B8A6), context.primaryColor],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      width: 18.w,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(6.r),
                      ),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: (max * 1.2).clamp(10.0, double.infinity),
                        color: context.primaryColor.withOpacity(0.06),
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

class _TransactionList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;
  const _TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Transactions',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: context.textPrimaryColor,
          ),
        ),
        SizedBox(height: 12.h),
        ...transactions.take(20).map((t) {
          final name = t['patientName'] as String? ?? 'Patient';
          final amount = (t['amount'] as num?)?.toDouble() ?? 0.0;
          final dateStr = t['date'] as String?;
          DateTime? date;
          if (dateStr != null) date = DateTime.tryParse(dateStr);
          final dateFormatted = date != null
              ? DateFormat('MMM d, yyyy').format(date.toLocal())
              : '';
          final status = t['status'] as String? ?? '';

          return Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: context.borderColor, width: 0.5),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: context.primaryColor.withOpacity(0.1),
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : 'P',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: context.primaryColor,
                      fontSize: 13.sp,
                    ),
                  ),
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
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      Text(
                        dateFormatted,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.sp,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Rs.${amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: context.successColor,
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10.sp,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
