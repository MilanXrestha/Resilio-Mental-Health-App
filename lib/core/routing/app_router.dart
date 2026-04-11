import 'package:Resilio/core/routing/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:Resilio/features/customer/audio/domain/entities/audio_entity.dart';
import '../../features/customer/auth/presentation/screens/login_screen.dart';
import '../../features/customer/auth/presentation/screens/passwordless_login_screen.dart';
import '../../features/customer/auth/presentation/screens/sign_up_screen.dart';
import '../../features/customer/audio/presentation/screens/media_player_screen.dart';
import '../../features/customer/categories/domain/entities/category_card_entity.dart';
import '../../features/customer/video/domain/entities/video_entity.dart';
import '../../features/customer/video/presentation/screens/shorts_player_screen.dart';
import '../../features/customer/video/presentation/screens/long_video_player_screen.dart';
import '../../features/customer/tips/presentation/screens/tips_screen.dart';
import '../../features/customer/tips/domain/entities/tip_entity.dart';
import '../../features/customer/dashboard/domain/entities/quote_entity.dart';
import '../../features/customer/tips/presentation/screens/content_viewer_screen.dart';
import '../../features/customer/images/presentation/screens/images_screen.dart';
import '../../features/customer/images/presentation/screens/image_viewer_screen.dart';
import '../../features/customer/categories/presentation/screens/category_detail_screen.dart';
import '../../features/customer/explore/presentation/screens/explore_screen.dart';
import '../../features/customer/main/presentation/screens/main_screen.dart';
import '../../features/customer/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/customer/preferences/presentation/screens/preferences_screen.dart';
import '../../features/customer/settings/presentation/screens/settings_screen.dart';
import '../../features/customer/splash/presentation/screens/splash_screen.dart';
import '../../features/customer/games/game_hub/presentation/screens/games_hub_screen.dart';
import '../../features/customer/games/mood_tracker/presentation/screens/mood_calendar_screen.dart';
import '../../features/customer/games/wellness_trivia/presentation/screens/wellness_quiz_screen.dart';
import '../../features/customer/games/breathing_game/presentation/screens/breathing_game_screen.dart';
import '../../features/customer/games/affirmation_builder/presentation/screens/affirmation_builder_screen.dart';
import '../../features/customer/games/achievements/presentation/screens/achievements_screen.dart';
import '../../features/customer/profile/domain/entities/profile_entity.dart';
import '../../features/customer/profile/presentation/screens/profile_screen.dart';
import '../../features/customer/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/customer/subscription/presentation/screens/subscription_screen.dart';
import '../../features/customer/subscription/presentation/screens/transaction_history_screen.dart';
import '../../features/therapist/dashboard/presentation/screens/therapist_dashboard_screen.dart';
import '../../features/admin/dashboard/presentation/screens/admin_dashboard_screen.dart';
import '../../features/customer/matching/presentation/screens/matching_questionnaire_screen.dart';
import '../../features/customer/booking/presentation/screens/session_booking_screen.dart';
import '../../features/customer/therapist/presentation/screens/therapist_list_screen.dart';
import '../../features/customer/therapist/presentation/screens/therapist_detail_screen.dart';
import '../../features/shared/video_call/presentation/screens/video_call_screen.dart';
import '../../features/customer/notifications/presentation/screens/notifications_screen.dart';
import '../../features/customer/appointments/presentation/screens/my_appointments_screen.dart';
import '../../features/customer/appointments/presentation/screens/appointment_chat_screen.dart';
import '../di/injection.dart';
import 'navigation_service.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: getIt<NavigationService>().navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: RouteNames.register,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/preferences',
        name: RouteNames.preferences,
        builder: (context, state) {
          final fromProfile =
              state.uri.queryParameters['fromProfile'] == 'true';
          return PreferencesScreen(fromProfile: fromProfile);
        },
      ),
      GoRoute(
        path: '/home',
        name: RouteNames.home,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/passwordless-login',
        name: RouteNames.passwordlessLogin,
        builder: (context, state) => const PasswordlessLoginScreen(),
      ),
      GoRoute(
        path: '/media-player',
        name: RouteNames.mediaPlayer,
        builder: (context, state) {
          final audioTrack = state.extra as AudioEntity?;
          if (audioTrack == null) {
            return const SizedBox.shrink();
          }
          return MediaPlayerScreen(audioTrack: audioTrack);
        },
      ),
      GoRoute(
        path: '/shorts-player',
        name: RouteNames.shortsPlayer,
        builder: (context, state) {
          final videos = state.extra as List?;
          final index = state.uri.queryParameters['index'] != null 
            ? int.parse(state.uri.queryParameters['index']!) 
            : 0;
          if (videos == null || videos.isEmpty) {
            return const SizedBox.shrink();
          }
          // Cast to List<VideoEntity>
          final videoEntities = videos.cast<VideoEntity>();
          return ShortsPlayerScreen(videos: videoEntities, initialIndex: index);
        },
      ),
      GoRoute(
        path: '/long-video-player',
        name: RouteNames.longVideoPlayer,
        builder: (context, state) {
          final video = state.extra;
          if (video == null) {
            return const SizedBox.shrink();
          }
          // Cast to VideoEntity
          final videoEntity = video as VideoEntity;
          return LongVideoPlayerScreen(video: videoEntity);
        },
      ),
      GoRoute(
        path: '/tips',
        name: 'tips',
        builder: (context, state) => const TipsScreen(),
      ),
      GoRoute(
        path: '/images',
        name: RouteNames.images,
        builder: (context, state) => const ImagesScreen(),
      ),
      GoRoute(
        path: '/explore',
        name: RouteNames.explore,
        builder: (context, state) => const ExploreScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/content-viewer',
        name: RouteNames.contentViewer,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return ContentViewerScreen(
            tips: (extra?['tips'] as List?)?.cast<TipEntity>(),
            quotes: (extra?['quotes'] as List?)?.cast<QuoteEntity>(),
            initialIndex: extra?['initialIndex'] as int? ?? 0,
            title: extra?['title'] as String? ?? 'Viewer',
          );
        },
      ),
      GoRoute(
        path: '/image-viewer',
        name: RouteNames.imageViewer,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final images = extra?['images'] as List?;
          
          return ImageViewerScreen(
            images: images ?? [],
            titles: (extra?['titles'] as List?)?.cast<String>(),
            subtitles: (extra?['subtitles'] as List?)?.cast<String>(),
            initialIndex: extra?['initialIndex'] as int? ?? 0,
            categoryName: extra?['categoryName'] as String?,
          );
        },
      ),
      GoRoute(
        path: '/category-detail',
        name: RouteNames.categoryDetail,
        builder: (context, state) {
          final category = state.extra as CategoryCardEntity;
          return CategoryDetailScreen(category: category);
        },
      ),
      GoRoute(
        path: '/games',
        name: RouteNames.gamesHub,
        builder: (context, state) {
          final userId = state.uri.queryParameters['userId'] ?? '';
          return GamesHubScreen(userId: userId);
        },
      ),
      GoRoute(
        path: '/mood-calendar',
        name: RouteNames.moodCalendar,
        builder: (context, state) {
          final userId = state.uri.queryParameters['userId'] ?? '';
          return MoodCalendarScreen(userId: userId);
        },
      ),
      GoRoute(
        path: '/wellness-quiz',
        name: RouteNames.wellnessQuiz,
        builder: (context, state) {
          final userId = state.uri.queryParameters['userId'] ?? '';
          final gameId = state.uri.queryParameters['gameId'] ?? '';
          final gameConfigStr = state.uri.queryParameters['gameConfig'];
          final gameConfig = gameConfigStr != null 
            ? jsonDecode(gameConfigStr) as Map<String, dynamic> 
            : <String, dynamic>{};
          return WellnessQuizScreen(
            userId: userId, 
            gameId: gameId, 
            gameConfig: gameConfig,
          );
        },
      ),
      GoRoute(
        path: '/breathing-game',
        name: RouteNames.breathingGame,
        builder: (context, state) {
          final userId = state.uri.queryParameters['userId'] ?? '';
          final gameId = state.uri.queryParameters['gameId'] ?? '';
          final gameConfigStr = state.uri.queryParameters['gameConfig'];
          final gameConfig = gameConfigStr != null 
            ? jsonDecode(gameConfigStr) as Map<String, dynamic> 
            : <String, dynamic>{};
          return BreathingGameScreen(
            userId: userId, 
            gameId: gameId, 
            gameConfig: gameConfig,
          );
        },
      ),
      GoRoute(
        path: '/affirmation-builder',
        name: RouteNames.affirmationBuilder,
        builder: (context, state) {
          final userId = state.uri.queryParameters['userId'] ?? '';
          final gameId = state.uri.queryParameters['gameId'] ?? '';
          final gameConfigStr = state.uri.queryParameters['gameConfig'];
          final gameConfig = gameConfigStr != null 
            ? jsonDecode(gameConfigStr) as Map<String, dynamic> 
            : <String, dynamic>{};
          return AffirmationBuilderScreen(
            userId: userId, 
            gameId: gameId, 
            gameConfig: gameConfig,
          );
        },
      ),
      GoRoute(
        path: '/achievements',
        name: RouteNames.achievements,
        builder: (context, state) {
          final userId = state.uri.queryParameters['userId'] ?? '';
          return AchievementScreen(userId: userId);
        },
      ),
      GoRoute(
        path: '/profile',
        name: RouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/profile/edit',
        name: RouteNames.editProfile,
        builder: (context, state) {
          final profile = state.extra as ProfileEntity;
          return EditProfileScreen(profile: profile);
        },
      ),
      GoRoute(
        path: '/subscription',
        name: RouteNames.subscription,
        builder: (context, state) => const SubscriptionScreen(),
      ),
      GoRoute(
        path: '/subscription/transactions',
        name: RouteNames.transactionHistory,
        builder: (context, state) => const TransactionHistoryScreen(),
      ),
      GoRoute(
        path: '/therapist-dashboard',
        name: RouteNames.therapistDashboard,
        builder: (context, state) => const TherapistDashboardScreen(),
      ),
      GoRoute(
        path: '/admin-dashboard',
        name: RouteNames.adminDashboard,
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/matching',
        name: RouteNames.matching,
        builder: (context, state) => const MatchingQuestionnaireScreen(),
      ),
      GoRoute(
        path: '/therapists',
        name: RouteNames.therapistList,
        builder: (context, state) {
          final matchParams = state.extra as Map<String, dynamic>?;
          return TherapistListScreen(matchParams: matchParams);
        },
      ),
      GoRoute(
        path: '/therapist/:therapistId',
        name: RouteNames.therapistDetail,
        builder: (context, state) {
          final id = state.pathParameters['therapistId'] ?? '';
          return TherapistDetailScreenWrapper(therapistId: id);
        },
      ),
      GoRoute(
        path: '/booking/:therapistId',
        name: RouteNames.booking,
        builder: (context, state) {
          final id = state.pathParameters['therapistId'] ?? '';
          return SessionBookingScreen(therapistId: id);
        },
      ),
      GoRoute(
        path: '/video-call/:appointmentId/:userId',
        name: RouteNames.videoCall,
        builder: (context, state) {
          final appointmentId = state.pathParameters['appointmentId'] ?? '';
          final userId = state.pathParameters['userId'] ?? '';
          return VideoCallScreen(
            appointmentId: appointmentId,
            currentUserId: userId,
          );
        },
      ),
      GoRoute(
        path: '/notifications',
        name: RouteNames.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/my-appointments',
        name: RouteNames.myAppointments,
        builder: (context, state) => const MyAppointmentsScreen(),
      ),
      GoRoute(
        path: '/appointments/:appointmentId/chat',
        name: RouteNames.appointmentChat,
        builder: (context, state) {
          final id = state.pathParameters['appointmentId'] ?? '';
          final appt = state.extra as Map<String, dynamic>?;
          return AppointmentChatScreen(
            appointmentId: id,
            appointment: appt,
          );
        },
      ),
    ],
  );
}
