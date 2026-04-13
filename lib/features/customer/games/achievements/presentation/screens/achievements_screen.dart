import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/features/customer/games/game_hub/data/services/game_service.dart';

class AchievementScreen extends StatefulWidget {
  final String userId;

  const AchievementScreen({super.key, required this.userId});

  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen>
    with TickerProviderStateMixin {
  final GameService _gameService = GameService();
  bool _isLoading = true;
  List<Map<String, dynamic>> _unlockedAchievements = [];
  List<Map<String, dynamic>> _allAchievements = [];
  late AnimationController _headerAnim;
  late AnimationController _listAnim;

  @override
  void initState() {
    super.initState();
    _headerAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _listAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _loadAchievements();
  }

  @override
  void dispose() {
    _headerAnim.dispose();
    _listAnim.dispose();
    super.dispose();
  }

  Future<void> _loadAchievements() async {
    setState(() => _isLoading = true);
    try {
      final unlocked = await _gameService.getUserAchievements(widget.userId);
      final all = await _gameService.getAllAchievements();

      final unlockedIds = unlocked.map((a) => a['achievementId'] as String).toSet();
      for (var a in all) {
        a['unlocked'] = unlockedIds.contains(a['id']);
      }
      // Sort: unlocked first
      all.sort((a, b) {
        final aU = a['unlocked'] == true ? 0 : 1;
        final bU = b['unlocked'] == true ? 0 : 1;
        return aU.compareTo(bU);
      });

      if (mounted) {
        setState(() {
          _unlockedAchievements = unlocked;
          _allAchievements = all;
          _isLoading = false;
        });
        _headerAnim.forward();
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) _listAnim.forward();
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Map achievement game categories
  static const _gameInfo = {
    'breathing_game': {'label': 'Mindful Breathing', 'emoji': '🫁', 'color': Color(0xFF60A5FA)},
    'affirmation_builder': {'label': 'Affirmation Builder', 'emoji': '✨', 'color': Color(0xFFA78BFA)},
    'wellness_quiz': {'label': 'Wellness Trivia', 'emoji': '🧠', 'color': Color(0xFFFBBF24)},
    'global': {'label': 'General Wellness', 'emoji': '🌟', 'color': Color(0xFF34D399)},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          if (_isLoading)
            const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
          else ...[
            SliverToBoxAdapter(child: _buildHeroCard()),
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
            if (_allAchievements.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('🏆', style: TextStyle(fontSize: 64.sp)),
                      SizedBox(height: 16.h),
                      Text(
                        'No achievements yet',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Play games to start earning badges!',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final achievement = _allAchievements[i];
                      final delay = i * 50;
                      return FadeTransition(
                        opacity: CurvedAnimation(
                          parent: _listAnim,
                          curve: Interval(
                            (delay / 1000).clamp(0.0, 1.0),
                            1.0,
                            curve: Curves.easeOut,
                          ),
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _listAnim,
                            curve: Interval(
                              (delay / 1000).clamp(0.0, 1.0),
                              1.0,
                              curve: Curves.easeOut,
                            ),
                          )),
                          child: _buildAchievementCard(achievement),
                        ),
                      );
                    },
                    childCount: _allAchievements.length,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      backgroundColor: context.backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      leading: IconButton(
        icon: Icon(CupertinoIcons.back, color: context.textPrimaryColor),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Achievements',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: context.textPrimaryColor,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh_rounded, color: context.textSecondaryColor),
          onPressed: _loadAchievements,
        ),
      ],
    );
  }

  Widget _buildHeroCard() {
    final total = _allAchievements.length;
    final unlocked = _unlockedAchievements.length;
    final pct = total > 0 ? unlocked / total : 0.0;

    final levelName = _levelName(unlocked);
    final levelColor = _levelColor(unlocked);

    return FadeTransition(
      opacity: _headerAnim,
      child: SlideTransition(
        position: Tween<Offset>(
                begin: const Offset(0, -0.2), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: _headerAnim, curve: Curves.easeOut)),
        child: Container(
          margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [levelColor.withValues(alpha: 0.9), levelColor.withValues(alpha: 0.6)],
            ),
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: levelColor.withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Big trophy emoji
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _levelEmoji(unlocked),
                        style: TextStyle(fontSize: 32.sp),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          levelName,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$unlocked of $total unlocked',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Circular progress
                  SizedBox(
                    width: 52.w,
                    height: 52.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: pct,
                          strokeWidth: 5,
                          backgroundColor: Colors.white.withValues(alpha: 0.25),
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        Text(
                          '${(pct * 100).round()}%',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: LinearProgressIndicator(
                  value: pct,
                  backgroundColor: Colors.white.withValues(alpha: 0.25),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 6.h,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${unlocked * 50} pts from badges',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.sp,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  Text(
                    _nextLevelLabel(unlocked),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.sp,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
    final isUnlocked = achievement['unlocked'] == true;
    final gameId = achievement['gameId'] as String? ?? 'global';
    final info = _gameInfo[gameId] ?? _gameInfo['global']!;
    final color = info['color'] as Color;
    final emoji = info['emoji'] as String;
    final title = achievement['title'] as String? ?? 'Achievement';
    final desc = achievement['description'] as String? ?? '';
    final pts = achievement['pointsAwarded'] as int? ?? 50;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isUnlocked ? color.withValues(alpha: 0.3) : context.borderColor,
          width: isUnlocked ? 1.5 : 1,
        ),
        boxShadow: isUnlocked
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ]
            : [],
      ),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Row(
          children: [
            // Badge icon
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isUnlocked
                    ? color.withValues(alpha: 0.15)
                    : context.backgroundColor,
              ),
              child: Center(
                child: isUnlocked
                    ? Text(emoji, style: TextStyle(fontSize: 26.sp))
                    : Icon(Icons.lock_rounded,
                        color: context.textSecondaryColor.withValues(alpha: 0.4),
                        size: 22.sp),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: isUnlocked
                          ? context.textPrimaryColor
                          : context.textSecondaryColor,
                    ),
                  ),
                  if (desc.isNotEmpty)
                    Text(
                      desc,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        color: context.textSecondaryColor,
                        height: 1.4,
                      ),
                    ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: isUnlocked ? 0.12 : 0.06),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          '${info['label']}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.sp,
                            color: isUnlocked ? color : context.textSecondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (isUnlocked) ...[
                        Icon(Icons.auto_awesome_rounded,
                            size: 12.sp, color: const Color(0xFFFBBF24)),
                        SizedBox(width: 3.w),
                        Text(
                          '+$pts pts',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFFBBF24),
                          ),
                        ),
                      ] else
                        Text(
                          'Locked',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.sp,
                            color: context.textSecondaryColor.withValues(alpha: 0.5),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _levelName(int count) {
    if (count == 0) return 'Newcomer';
    if (count < 3) return 'Explorer';
    if (count < 7) return 'Practitioner';
    if (count < 15) return 'Achiever';
    return 'Master';
  }

  String _levelEmoji(int count) {
    if (count == 0) return '🌱';
    if (count < 3) return '🌿';
    if (count < 7) return '⭐';
    if (count < 15) return '🏆';
    return '👑';
  }

  Color _levelColor(int count) {
    if (count == 0) return const Color(0xFF94A3B8);
    if (count < 3) return const Color(0xFF34D399);
    if (count < 7) return const Color(0xFF60A5FA);
    if (count < 15) return const Color(0xFFA78BFA);
    return const Color(0xFFFBBF24);
  }

  String _nextLevelLabel(int count) {
    if (count == 0) return 'Unlock 1 to become Explorer';
    if (count < 3) return '${3 - count} more to Practitioner';
    if (count < 7) return '${7 - count} more to Achiever';
    if (count < 15) return '${15 - count} more to Master';
    return 'Max rank reached! 🎉';
  }
}
