import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/features/customer/games/achievements/presentation/screens/achievements_screen.dart';
import 'package:Resilio/features/customer/games/affirmation_builder/presentation/screens/affirmation_builder_screen.dart';
import 'package:Resilio/features/customer/games/breathing_game/presentation/screens/breathing_game_screen.dart';
import 'package:Resilio/features/customer/games/mood_tracker/presentation/widgets/mood_tracker_widget.dart';
import 'package:Resilio/features/customer/games/story_game/presentation/screens/story_game_screen.dart';
import 'package:Resilio/features/customer/games/wellness_trivia/presentation/screens/wellness_quiz_screen.dart';
import 'package:Resilio/features/customer/games/game_hub/presentation/bloc/games_hub_cubit.dart';
import 'package:Resilio/l10n/app_localizations.dart';

// ─── Game definitions ─────────────────────────────────────────────────────────

class _GameDef {
  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final String? animation;
  final String type;
  final List<Color> gradientColors;
  final Map<String, dynamic> config;
  final String xpLabel;
  final String tag;

  const _GameDef({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    this.animation,
    required this.type,
    required this.gradientColors,
    required this.config,
    required this.xpLabel,
    required this.tag,
  });
}

const _games = [
  _GameDef(
    id: 'story_game',
    title: 'The Healing Journey',
    subtitle: 'Walk Alex through trauma to triumph',
    emoji: '🌅',
    animation: 'assets/animations/welcome.json',
    type: 'story',
    gradientColors: [Color(0xFF1B2F4E), Color(0xFF0D3025)],
    config: {},
    xpLabel: '150 XP',
    tag: 'NEW',
  ),
  _GameDef(
    id: 'breathing_game',
    title: 'Mindful Breathing',
    subtitle: '4 patterns · voice guide · calm your mind',
    emoji: '🫁',
    animation: 'assets/animations/meditation.json',
    type: 'breathing',
    gradientColors: [Color(0xFF1E3A5F), Color(0xFF1D4ED8)],
    config: {'inhaleDuration': 4, 'holdDuration': 2, 'exhaleDuration': 4},
    xpLabel: '50 XP / session',
    tag: 'CALM',
  ),
  _GameDef(
    id: 'affirmation_builder',
    title: 'Affirmation Builder',
    subtitle: 'Drag & drop words · rewire your thinking',
    emoji: '✨',
    animation: 'assets/animations/abc_blocks.json',
    type: 'word_puzzle',
    gradientColors: [Color(0xFF3B0764), Color(0xFF6D28D9)],
    config: {'wordsPerPuzzle': 5, 'maxAttempts': 3},
    xpLabel: '30 XP / round',
    tag: 'FOCUS',
  ),
  _GameDef(
    id: 'wellness_quiz',
    title: 'Wellness Trivia',
    subtitle: '5 questions · learn · earn · level up',
    emoji: '🧠',
    animation: 'assets/animations/quiz.json',
    type: 'quiz',
    gradientColors: [Color(0xFF78350F), Color(0xFFD97706)],
    config: {'questionsPerSession': 5, 'timePerQuestion': 15},
    xpLabel: '20 XP / correct',
    tag: 'LEARN',
  ),
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class GamesHubScreen extends StatefulWidget {
  final String userId;

  const GamesHubScreen({super.key, required this.userId});

  @override
  GamesHubScreenState createState() => GamesHubScreenState();
}

class GamesHubScreenState extends State<GamesHubScreen>
    with TickerProviderStateMixin {
  int _pageIndex = 0;
  late PageController _pageCtrl;
  late AnimationController _headerAnim;
  late AnimationController _cardsAnim;

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController(viewportFraction: 0.92);
    _headerAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _cardsAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GamesHubCubit>().loadUserStats();
      _headerAnim.forward();
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) _cardsAnim.forward();
      });
    });
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    _headerAnim.dispose();
    _cardsAnim.dispose();
    super.dispose();
  }

  void _launchGame(_GameDef game) {
    HapticFeedback.mediumImpact();
    Widget screen;
    switch (game.type) {
      case 'story':
        screen = StoryGameScreen(
          userId: widget.userId,
          gameId: game.id,
          gameConfig: game.config,
        );
        break;
      case 'breathing':
        screen = BreathingGameScreen(
          userId: widget.userId,
          gameId: game.id,
          gameConfig: game.config,
        );
        break;
      case 'word_puzzle':
        screen = AffirmationBuilderScreen(
          userId: widget.userId,
          gameId: game.id,
          gameConfig: game.config,
        );
        break;
      case 'quiz':
        screen = WellnessQuizScreen(
          userId: widget.userId,
          gameId: game.id,
          gameConfig: game.config,
        );
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen)).then((
      _,
    ) {
      if (mounted) context.read<GamesHubCubit>().loadUserStats();
    });
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async => context.read<GamesHubCubit>().loadUserStats(),
        color: context.primaryColor,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),
                  _buildPlayerCard(),
                  SizedBox(height: 20.h),
                  _buildQuickActions(),
                  SizedBox(height: 24.h),
                  _buildSectionHeader(
                    AppLocalizations.of(context)!.gmGames,
                    '${_pageIndex + 1}/${_games.length}',
                  ),
                  SizedBox(height: 12.h),
                  _buildGamePager(),
                  SizedBox(height: 10.h),
                  _buildPageDots(),
                  SizedBox(height: 28.h),
                  _buildDailyChallenge(),
                  SizedBox(height: 24.h),
                  _buildSectionHeader(
                    AppLocalizations.of(context)!.gmTodaysMood,
                    null,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: MoodTrackerWidget(userId: widget.userId),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      backgroundColor: context.backgroundColor,
      surfaceTintColor: Colors.transparent,
      floating: true,
      snap: true,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: context.textPrimaryColor,
          size: 20.sp,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        AppLocalizations.of(context)!.gmWellnessHub,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20.sp,
          fontWeight: FontWeight.w800,
          color: context.textPrimaryColor,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AchievementScreen(userId: widget.userId),
                ),
              ).then((_) {
                if (mounted) context.read<GamesHubCubit>().loadUserStats();
              }),
          child: Container(
            margin: EdgeInsets.only(right: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFBBF24).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: const Color(0xFFFBBF24).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🏆', style: TextStyle(fontSize: 13.sp)),
                SizedBox(width: 4.w),
                BlocBuilder<GamesHubCubit, GamesHubState>(
                  builder: (_, s) => Text(
                    s.isLoading ? '—' : '${s.achievements}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFBBF24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Player Card (XP + Level) ───────────────────────────────────────────────

  Widget _buildPlayerCard() {
    return BlocBuilder<GamesHubCubit, GamesHubState>(
      builder: (_, state) {
        final pts = state.points;
        final level = _levelFor(pts);
        final progress =
            ((pts - level.min) / (level.max - level.min).clamp(1, 99999)).clamp(
              0.0,
              1.0,
            );

        return FadeTransition(
          opacity: _headerAnim,
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, -0.15),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: _headerAnim, curve: Curves.easeOut),
                ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [level.color, level.color.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: level.color.withValues(alpha: 0.4),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Avatar circle
                      Container(
                        width: 56.w,
                        height: 56.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            level.emoji,
                            style: TextStyle(fontSize: 28.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              level.name,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              level.nextLabel(pts),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11.sp,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Stats chips
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _MiniStat('⭐', '$pts XP'),
                          SizedBox(height: 4.h),
                          _MiniStat('🎮', '${state.gamesPlayed} sessions'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  // XP Progress bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.gmLevelProgress,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.sp,
                              color: Colors.white.withValues(alpha: 0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${pts - level.min} / ${level.max - level.min} XP',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.sp,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Stack(
                        children: [
                          Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: progress,
                            child: Container(
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Quick Actions ──────────────────────────────────────────────────────────

  Widget _buildQuickActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _QuickAction(
            emoji: '🫁',
            label: 'Breathe',
            color: const Color(0xFF3B82F6),
            onTap: () => _launchGame(_games[1]),
          ),
          SizedBox(width: 10.w),
          _QuickAction(
            emoji: '🌅',
            label: 'Story',
            color: const Color(0xFF0D9488),
            onTap: () => _launchGame(_games[0]),
          ),
          SizedBox(width: 10.w),
          _QuickAction(
            emoji: '🧠',
            label: 'Trivia',
            color: const Color(0xFFF59E0B),
            onTap: () => _launchGame(_games[3]),
          ),
          SizedBox(width: 10.w),
          _QuickAction(
            emoji: '🏆',
            label: 'Badges',
            color: const Color(0xFFA78BFA),
            onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AchievementScreen(userId: widget.userId),
                  ),
                ).then((_) {
                  if (mounted) context.read<GamesHubCubit>().loadUserStats();
                }),
          ),
        ],
      ),
    );
  }

  // ── Section Header ─────────────────────────────────────────────────────────

  Widget _buildSectionHeader(String title, String? trailing) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: context.textPrimaryColor,
            ),
          ),
          const Spacer(),
          if (trailing != null)
            Text(
              trailing,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                color: context.textSecondaryColor,
              ),
            ),
        ],
      ),
    );
  }

  // ── Game Pager ─────────────────────────────────────────────────────────────

  Widget _buildGamePager() {
    return SizedBox(
      height: 380.h,
      child: PageView.builder(
        controller: _pageCtrl,
        itemCount: _games.length,
        onPageChanged: (i) {
          HapticFeedback.selectionClick();
          setState(() => _pageIndex = i);
        },
        itemBuilder: (_, i) {
          return AnimatedBuilder(
            animation: _pageCtrl,
            builder: (_, child) {
              double page = i.toDouble();
              if (_pageCtrl.hasClients && _pageCtrl.page != null) {
                page = _pageCtrl.page!;
              }
              final diff = (i - page).abs().clamp(0.0, 1.0);
              final scale = 1.0 - diff * 0.05;
              final opacity = 1.0 - diff * 0.4;
              return Transform.scale(
                scale: scale,
                child: Opacity(opacity: opacity, child: child),
              );
            },
            child: _buildGameCard(_games[i], i == _pageIndex),
          );
        },
      ),
    );
  }

  Widget _buildGameCard(_GameDef game, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (isActive) {
          _launchGame(game);
        } else {
          _pageCtrl.animateToPage(
            _games.indexOf(game),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: game.gradientColors,
          ),
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: game.gradientColors.last.withValues(alpha: 0.5),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 18.h,
              left: 20.w,
              right: 20.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 9.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      game.tag,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        size: 12.sp,
                        color: const Color(0xFFFBBF24),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        game.xpLabel,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFBBF24),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(0, -0.22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 172.w,
                    height: 172.w,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(28.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.16),
                      ),
                    ),
                    child: game.animation != null
                        ? Lottie.asset(
                            game.animation!,
                            fit: BoxFit.contain,
                            animate: isActive,
                            frameRate: const FrameRate(24),
                          )
                        : Center(
                            child: Text(
                              game.emoji,
                              style: TextStyle(fontSize: 62.sp),
                            ),
                          ),
                  ),
                  SizedBox(height: 14.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: Text(
                      game.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 22.w,
              right: 22.w,
              bottom: 22.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    game.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      height: 1.3,
                      color: Colors.white.withValues(alpha: 0.78),
                    ),
                  ),
                  if (isActive) ...[
                    SizedBox(height: 14.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _launchGame(game),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: game.gradientColors.last,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_circle_filled_rounded, size: 18.sp),
                            SizedBox(width: 6.w),
                            Text(
                              'Play Now',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_games.length, (i) {
        final active = i == _pageIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          width: active ? 22.w : 6.w,
          height: 6.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.r),
            color: active
                ? _games[_pageIndex].gradientColors.first
                : context.textSecondaryColor.withValues(alpha: 0.25),
          ),
        );
      }),
    );
  }

  // ── Daily Challenge ────────────────────────────────────────────────────────

  Widget _buildDailyChallenge() {
    final today = DateTime.now();
    final challenges = [
      ('🫁', 'Complete one breathing session', 'breathing'),
      ('📖', 'Play one chapter of The Healing Journey', 'story'),
      ('🧠', 'Score 4/5 in Wellness Trivia', 'quiz'),
      ('✨', 'Build an affirmation', 'word_puzzle'),
    ];
    final challenge = challenges[today.weekday % challenges.length];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: context.primaryColor.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: context.primaryColor.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: context.primaryColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Text(challenge.$1, style: TextStyle(fontSize: 24.sp)),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.primaryColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      'DAILY QUEST',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w800,
                        color: context.primaryColor,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    challenge.$2,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  Text(
                    '+50 bonus XP',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.sp,
                      color: const Color(0xFFFBBF24),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                final game = _games.firstWhere(
                  (g) => g.type == challenge.$3,
                  orElse: () => _games[0],
                );
                _launchGame(game);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Go',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Level system ───────────────────────────────────────────────────────────

  _Level _levelFor(int pts) {
    if (pts < 100) {
      return _Level('Newcomer', '🌱', const Color(0xFF64748B), 0, 100);
    }
    if (pts < 300) {
      return _Level('Explorer', '🌿', const Color(0xFF059669), 100, 300);
    }
    if (pts < 600) {
      return _Level('Practitioner', '⭐', const Color(0xFF2563EB), 300, 600);
    }
    if (pts < 1000) {
      return _Level('Achiever', '🏆', const Color(0xFF7C3AED), 600, 1000);
    }
    return _Level('Master', '👑', const Color(0xFFD97706), 1000, 9999);
  }
}

// ─── Helper widgets ───────────────────────────────────────────────────────────

class _Level {
  final String name;
  final String emoji;
  final Color color;
  final int min;
  final int max;

  const _Level(this.name, this.emoji, this.color, this.min, this.max);

  String nextLabel(int pts) {
    if (max == 9999) return 'Maximum rank achieved 🎉';
    return '${max - pts} XP to next rank';
  }
}

class _MiniStat extends StatelessWidget {
  final String emoji;
  final String label;

  const _MiniStat(this.emoji, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: TextStyle(fontSize: 11.sp)),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String emoji;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.emoji,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: color.withValues(alpha: 0.25), width: 1),
          ),
          child: Column(
            children: [
              Text(emoji, style: TextStyle(fontSize: 20.sp)),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
