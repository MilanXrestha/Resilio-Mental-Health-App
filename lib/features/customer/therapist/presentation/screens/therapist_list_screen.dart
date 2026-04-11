import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/theme/app_colors.dart';

class TherapistListScreen extends StatefulWidget {
  /// When provided, results are fetched from the weighted match endpoint.
  final Map<String, dynamic>? matchParams;

  const TherapistListScreen({super.key, this.matchParams});

  @override
  State<TherapistListScreen> createState() => _TherapistListScreenState();
}

class _TherapistListScreenState extends State<TherapistListScreen> {
  final _dio = getIt<Dio>();
  final _searchCtrl = TextEditingController();

  List<Map<String, dynamic>> _therapists = [];
  bool _loading = true;
  String? _error;
  String _searchQuery = '';

  bool get _isMatched => widget.matchParams != null && widget.matchParams!.isNotEmpty;

  @override
  void initState() {
    super.initState();
    if (_isMatched) {
      _loadMatches();
    } else {
      _loadTherapists();
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadMatches() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await _dio.post('/therapists/match', data: widget.matchParams);
      final list = res.data['therapists'] as List<dynamic>? ?? [];
      if (mounted) {
        setState(() {
          _therapists = list.cast<Map<String, dynamic>>();
          _loading = false;
        });
      }
    } catch (e) {
      // Fall back to browsing all therapists
      _loadTherapists();
    }
  }

  Future<void> _loadTherapists({String? specialty}) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await _dio.get('/therapists', queryParameters: {
        if (specialty != null && specialty.isNotEmpty) 'specialty_tag': specialty,
        'limit': 50,
      });
      final list = res.data['therapists'] as List<dynamic>? ?? [];
      if (mounted) {
        setState(() {
          _therapists = list.cast<Map<String, dynamic>>();
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load therapists';
          _loading = false;
        });
      }
    }
  }

  List<Map<String, dynamic>> get _filtered {
    if (_searchQuery.isEmpty) return _therapists;
    final q = _searchQuery.toLowerCase();
    return _therapists.where((t) {
      final name = (t['displayName'] ?? t['display_name'] ?? '').toString().toLowerCase();
      final spec = (t['specialty'] ?? '').toString().toLowerCase();
      return name.contains(q) || spec.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: [
          SliverAppBar(
            backgroundColor: context.backgroundColor,
            surfaceTintColor: Colors.transparent,
            floating: true,
            snap: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  size: 20.sp, color: context.textPrimaryColor),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Find a Therapist',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: context.textPrimaryColor,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(64.h),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.surfaceColor,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: context.borderColor, width: 0.5),
                  ),
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        color: context.textPrimaryColor),
                    decoration: InputDecoration(
                      hintText: 'Search by name or specialty…',
                      hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          color: context.textSecondaryColor),
                      prefixIcon: Icon(Icons.search_rounded,
                          color: context.textSecondaryColor, size: 20.sp),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear_rounded,
                                  color: context.textSecondaryColor,
                                  size: 18.sp),
                              onPressed: () {
                                _searchCtrl.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_isMatched && !_loading)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: context.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: context.primaryColor.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.auto_awesome_rounded, color: context.primaryColor, size: 18.sp),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'Showing therapists matched to your responses',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.primaryColor, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (_loading)
            const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()))
          else if (_error != null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline_rounded,
                        size: 48.sp, color: context.errorColor),
                    SizedBox(height: 12.h),
                    Text(_error!,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            color: context.textSecondaryColor)),
                    SizedBox(height: 12.h),
                    ElevatedButton(
                        onPressed: _loadTherapists,
                        child: const Text('Retry')),
                  ],
                ),
              ),
            )
          else if (_filtered.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_search_rounded,
                        size: 64.sp,
                        color: context.textSecondaryColor.withOpacity(0.4)),
                    SizedBox(height: 16.h),
                    Text('No therapists found',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimaryColor)),
                    SizedBox(height: 6.h),
                    Text('Try a different search',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            color: context.textSecondaryColor)),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 100.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _TherapistCard(
                    therapist: _filtered[i],
                    onTap: () => context
                        .push('/therapist/${_filtered[i]['userId'] ?? _filtered[i]['id']}'),
                  ),
                  childCount: _filtered.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Therapist Card ─────────────────────────────────────────────────────────────
class _TherapistCard extends StatelessWidget {
  final Map<String, dynamic> therapist;
  final VoidCallback onTap;

  const _TherapistCard({required this.therapist, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final name = therapist['displayName'] ??
        therapist['display_name'] ??
        'Therapist';
    final specialty = therapist['specialty'] ?? '';
    final bio = therapist['bio'] ?? '';
    final rating = (therapist['rating'] as num?)?.toDouble() ?? 0.0;
    final reviews = therapist['totalReviews'] ?? therapist['total_reviews'] ?? 0;
    final fee = therapist['consultationFee'] ?? therapist['consultation_fee'] ?? 0;
    final yearsExp = therapist['yearsOfExperience'] ??
        therapist['years_of_experience'] ??
        0;
    final isVerified = therapist['isVerified'] ?? therapist['is_verified'] ?? false;
    final pic = therapist['profileImageUrl'] ?? therapist['profile_image_url'];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: context.borderColor, width: 0.5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Row(
                children: [
                  // Avatar
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage:
                            pic != null ? NetworkImage(pic) : null,
                        backgroundColor:
                            context.primaryColor.withOpacity(0.1),
                        child: pic == null
                            ? Text(
                                name.isNotEmpty
                                    ? name[0].toUpperCase()
                                    : 'T',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: context.primaryColor,
                                ),
                              )
                            : null,
                      ),
                      if (isVerified == true)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              color: context.surfaceColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.verified_rounded,
                                size: 16.sp,
                                color: const Color(0xFF6366F1)),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. $name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        if (specialty.isNotEmpty) ...[
                          SizedBox(height: 2.h),
                          Text(
                            specialty,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                color: context.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(Icons.star_rounded,
                                color: const Color(0xFFF59E0B),
                                size: 14.sp),
                            SizedBox(width: 3.w),
                            Text(
                              rating.toStringAsFixed(1),
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: context.textPrimaryColor),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '($reviews)',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.sp,
                                  color: context.textSecondaryColor),
                            ),
                            SizedBox(width: 12.w),
                            Icon(Icons.work_outline_rounded,
                                size: 12.sp,
                                color: context.textSecondaryColor),
                            SizedBox(width: 3.w),
                            Text(
                              '$yearsExp yrs',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11.sp,
                                  color: context.textSecondaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'NPR ${(fee as num).toStringAsFixed(0)}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: context.primaryColor,
                        ),
                      ),
                      Text(
                        'per session',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.sp,
                            color: context.textSecondaryColor),
                      ),
                    ],
                  ),
                ],
              ),
              if (bio.isNotEmpty) ...[
                SizedBox(height: 12.h),
                Text(
                  bio,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      color: context.textSecondaryColor,
                      height: 1.5),
                ),
              ],
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    elevation: 0,
                    textStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  child: const Text('View & Book'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
