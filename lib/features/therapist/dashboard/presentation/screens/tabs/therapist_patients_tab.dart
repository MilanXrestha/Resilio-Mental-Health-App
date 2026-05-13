import '../../widgets/shimmer_therapist_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../bloc/therapist_cubit.dart';
import '../../bloc/therapist_state.dart';

class TherapistPatientsTab extends StatefulWidget {
  const TherapistPatientsTab({super.key});

  @override
  State<TherapistPatientsTab> createState() => _TherapistPatientsTabState();
}

class _TherapistPatientsTabState extends State<TherapistPatientsTab> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TherapistCubit>().loadPatients();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
              child: Text(
                'My Patients',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Search bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: context.borderColor, width: 0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (q) =>
                      context.read<TherapistCubit>().filterPatients(q),
                  decoration: InputDecoration(
                    hintText: 'Search patients…',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      color: context.textHintColor,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: context.textSecondaryColor,
                      size: 20.sp,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.close_rounded,
                              size: 18.sp,
                              color: context.textSecondaryColor,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              context.read<TherapistCubit>().filterPatients('');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // List
            Expanded(
              child: BlocBuilder<TherapistCubit, TherapistState>(
                builder: (context, state) {
                  if (state.isLoading && !state.hasPatients) {
                    return const TherapistListShimmer();
                  }
                  if (state.errorMessage != null && !state.hasPatients) {
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
                                context.read<TherapistCubit>().loadPatients(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (!state.hasPatients) {
                    return const SizedBox.shrink();
                  }
                  if (state.filteredPatients!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.people_outline_rounded,
                            size: 64.sp,
                            color: context.textSecondaryColor.withOpacity(0.4),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            state.patientQuery.isEmpty
                                ? 'No patients yet'
                                : 'No results for "${state.patientQuery}"',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15.sp,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    color: context.primaryColor,
                    onRefresh: () =>
                        context.read<TherapistCubit>().loadPatients(),
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: state.filteredPatients!.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, i) =>
                          _PatientCard(patient: state.filteredPatients![i]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientCard extends StatelessWidget {
  final Map<String, dynamic> patient;
  const _PatientCard({required this.patient});

  @override
  Widget build(BuildContext context) {
    final name = patient['displayName'] as String? ?? 'Unknown';
    final email = patient['email'] as String? ?? '';
    final sessions = (patient['sessionCount'] as num?)?.toInt() ?? 0;
    final lastStr = patient['lastSessionDate'] as String?;
    DateTime? lastDate;
    if (lastStr != null) lastDate = DateTime.tryParse(lastStr);
    final lastFormatted = lastDate != null
        ? DateFormat('MMM d, yyyy').format(lastDate.toLocal())
        : 'No sessions';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.borderColor, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: context.primaryColor.withOpacity(0.1),
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : 'P',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                color: context.primaryColor,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                if (email.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    email,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      color: context.textSecondaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                SizedBox(height: 6.h),
                Row(
                  children: [
                    _PillBadge(
                      label: '$sessions session${sessions != 1 ? 's' : ''}',
                      color: context.primaryColor,
                    ),
                    SizedBox(width: 8.w),
                    _PillBadge(
                      label: 'Last: $lastFormatted',
                      color: context.textSecondaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: context.textSecondaryColor,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}

class _PillBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _PillBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
