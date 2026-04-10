import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/features/customer/games/achievements/presentation/screens/achievements_screen.dart';
import 'package:Resilio/features/customer/games/affirmation_builder/presentation/screens/affirmation_builder_screen.dart';
import 'package:Resilio/features/customer/games/breathing_game/presentation/screens/breathing_game_screen.dart';
import 'package:Resilio/features/customer/games/mood_tracker/presentation/screens/mood_calendar_screen.dart';
import 'package:Resilio/features/customer/games/mood_tracker/presentation/widgets/mood_tracker_widget.dart';
import 'package:Resilio/features/customer/games/wellness_trivia/presentation/screens/wellness_quiz_screen.dart';
import 'package:Resilio/features/customer/games/game_hub/data/models/game_model.dart';
import 'package:Resilio/features/customer/games/game_hub/presentation/bloc/games_hub_cubit.dart';

class GamesHubScreen extends StatefulWidget {
  final String userId;

  const GamesHubScreen({Key? key, required this.userId}) : super(key: key);

  @override
  GamesHubScreenState createState() => GamesHubScreenState();
}

class GamesHubScreenState extends State<GamesHubScreen> {
  // ... rest of the state ...
  final List<GameModel> _games = [
    GameModel(
      id: 'breathing_game',
      title: 'Mindful Breathing',
      description: 'Sync your breath with the animation to earn points and find calm',
      animationPath: 'assets/animations/meditation.json',
      type: 'breathing',
      config: {
        'inhaleDuration': 4,
        'holdDuration': 2,
        'exhaleDuration': 4,
        'defaultSessionLength': 60,
      },
      sortOrder: 1,
    ),
    GameModel(
      id: 'affirmation_builder',
      title: 'Affirmation Builder',
      description: 'Drag and drop words to form positive affirmations',
      animationPath: 'assets/animations/abc_blocks.json',
      type: 'word_puzzle',
      config: {
        'wordsPerPuzzle': 5,
        'maxAttempts': 3,
        'defaultSessionLength': 120,
      },
      sortOrder: 2,
    ),
    GameModel(
      id: 'wellness_quiz',
      title: 'Wellness Trivia',
      description: 'Test your knowledge and learn new wellness facts',
      animationPath: 'assets/animations/quiz.json',
      type: 'quiz',
      config: {
        'questionsPerSession': 5,
        'timePerQuestion': 15,
      },
      sortOrder: 3,
    ),
  ];

  int _currentGameIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    context.read<GamesHubCubit>().loadUserStats();
  }

  void _launchGame(GameModel game) {
    Widget? screen;
    switch (game.type) {
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

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen!),
    ).then((_) {
      if (mounted) {
        context.read<GamesHubCubit>().loadUserStats();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Wellness Hub',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        elevation: 0,
        backgroundColor: isDarkMode
            ? Theme.of(context).colorScheme.background.withOpacity(0.85)
            : Theme.of(context).colorScheme.background.withOpacity(0.85),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [Theme.of(context).colorScheme.background, Theme.of(context).colorScheme.surface]
                : [Theme.of(context).colorScheme.background, Theme.of(context).colorScheme.surface],
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await context.read<GamesHubCubit>().loadUserStats();
            },
            color: Theme.of(context).primaryColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  _buildStatsRow(isDarkMode),
                  SizedBox(height: 24.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'Current Mood',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: MoodTrackerWidget(userId: widget.userId),
                  ),
                  SizedBox(height: 24.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'Choose a Game',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  _buildGamesCarousel(isDarkMode),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(bool isDarkMode) {
    return BlocBuilder<GamesHubCubit, GamesHubState>(
      builder: (context, state) {
        if (state.isLoading) {
          return _buildStatsShimmer(isDarkMode);
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildStatCard(
                  title: 'Wellness Points',
                  value: state.points.toString(),
                  icon: Icons.stars_rounded,
                  color: Colors.amber,
                  isDarkMode: isDarkMode,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AchievementScreen(userId: widget.userId)),
                    // ).then((_) => context.read<GamesHubCubit>().loadUserStats());
                  },
                  child: _buildStatCard(
                    title: 'Achievements',
                    value: state.achievements.toString(),
                    icon: Icons.emoji_events_rounded,
                    color: Colors.deepPurpleAccent,
                    isDarkMode: isDarkMode,
                    isClickable: true,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 3,
                child: _buildStatCard(
                  title: 'Games Played',
                  value: state.gamesPlayed.toString(),
                  icon: Icons.sports_esports_rounded,
                  color: Colors.greenAccent,
                  isDarkMode: isDarkMode,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDarkMode,
    bool isClickable = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Theme.of(context).colorScheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: isClickable ? Border.all(color: color.withOpacity(0.3), width: 2.w) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22.sp, color: color),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              color: isDarkMode ? Theme.of(context).colorScheme.onSurfaceVariant : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          if (isClickable) ...[
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View All',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10.sp,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 8.sp, color: color),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsShimmer(bool isDarkMode) {
    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
      child: Row(
        children: List.generate(
          3,
          (index) => Expanded(
            flex: index == 1 ? 4 : 3,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGamesCarousel(bool isDarkMode) {
    return SizedBox(
      height: 450.h,
      child: Column(
        children: [
          SizedBox(
            height: 370.h,
            child: CarouselSlider.builder(
              itemCount: _games.length,
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 370.h,
                viewportFraction: 0.7,
                enlargeCenterPage: true,
                enableInfiniteScroll: _games.length > 1,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentGameIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final game = _games[index];
                final isActive = index == _currentGameIndex;

                return RepaintBoundary(
                  child: AnimatedScale(
                    scale: isActive ? 1.0 : 0.85,
                    duration: const Duration(milliseconds: 300),
                    child: _buildGameCard(game, isDarkMode, isActive),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8.h),
          if (_games.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _games.asMap().entries.map((entry) {
                return Container(
                  width: 8.w,
                  height: 8.w,
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentGameIndex == entry.key
                        ? Theme.of(context).primaryColor
                        : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildGameCard(GameModel game, bool isDarkMode, bool isActive) {
    Color gameColor;
    switch (game.type) {
      case 'breathing':
        gameColor = Colors.blue;
        break;
      case 'tap':
        gameColor = Colors.green;
        break;
      case 'quiz':
        gameColor = Colors.orange;
        break;
      default:
        gameColor = Colors.purple;
    }

    return GestureDetector(
      onTap: () => _launchGame(game),
      child: Hero(
        tag: 'game_${game.id}',
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Theme.of(context).colorScheme.surface : Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: gameColor.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            gameColor.withOpacity(0.05),
                            gameColor.withOpacity(0.15),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 200.w,
                            height: 200.w,
                            child: Lottie.asset(
                              game.animationPath,
                              frameRate: const FrameRate(30),
                              fit: BoxFit.contain,
                              animate: isActive,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.black.withOpacity(0.3)
                                : Colors.white.withOpacity(0.9),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                game.title,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                game.description,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
                                  color: isDarkMode ? Theme.of(context).colorScheme.onSurfaceVariant : Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => _launchGame(game),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: gameColor,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.play_arrow, size: 22.sp),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Play Now",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
