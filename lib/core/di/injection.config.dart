// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i806;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:Resilio/core/database/database_helper.dart' as _i865;
import 'package:Resilio/core/di/injection.dart' as _i306;
import 'package:Resilio/core/network/auth_interceptor.dart' as _i251;
import 'package:Resilio/core/network/network_info.dart' as _i759;
import 'package:Resilio/core/network/network_module.dart' as _i266;
import 'package:Resilio/core/routing/navigation_service.dart' as _i39;
import 'package:Resilio/core/services/auth_token_service.dart' as _i80;
import 'package:Resilio/core/services/cloudinary_service.dart' as _i399;
import 'package:Resilio/core/services/connectivity_monitor.dart' as _i360;
import 'package:Resilio/core/services/offline_sync_manager.dart' as _i758;
import 'package:Resilio/core/theme/cubit/theme_cubit.dart' as _i4;
import 'package:Resilio/features/admin/dashboard/data/repositories/admin_repository_impl.dart'
    as _i624;
import 'package:Resilio/features/admin/dashboard/domain/repositories/admin_repository.dart'
    as _i22;
import 'package:Resilio/features/admin/dashboard/presentation/bloc/admin_content_cubit.dart'
    as _i1073;
import 'package:Resilio/features/admin/dashboard/presentation/bloc/admin_cubit.dart'
    as _i846;
import 'package:Resilio/features/admin/dashboard/presentation/bloc/admin_notification_cubit.dart'
    as _i968;
import 'package:Resilio/features/admin/dashboard/presentation/bloc/admin_preference_cubit.dart'
    as _i5;
import 'package:Resilio/features/admin/dashboard/presentation/bloc/admin_revenue_cubit.dart'
    as _i926;
import 'package:Resilio/features/customer/audio/data/datasources/audio_local_datasource.dart'
    as _i80;
import 'package:Resilio/features/customer/audio/data/datasources/audio_remote_datasource.dart'
    as _i343;
import 'package:Resilio/features/customer/audio/data/repositories/audio_repository_impl.dart'
    as _i591;
import 'package:Resilio/features/customer/audio/domain/repositories/audio_repository.dart'
    as _i164;
import 'package:Resilio/features/customer/audio/presentation/bloc/audio_bloc.dart'
    as _i171;
import 'package:Resilio/features/customer/auth/data/datasources/local/auth_local_data_source.dart'
    as _i882;
import 'package:Resilio/features/customer/auth/data/datasources/remote/auth_remote_data_source.dart'
    as _i376;
import 'package:Resilio/features/customer/auth/data/datasources/remote/backend_auth_data_source.dart'
    as _i852;
import 'package:Resilio/features/customer/auth/data/datasources/remote/firebase_auth_data_source.dart'
    as _i519;
import 'package:Resilio/features/customer/auth/data/datasources/remote/supertokens_data_source.dart'
    as _i667;
import 'package:Resilio/features/customer/auth/data/repositories/auth_repository_impl.dart'
    as _i474;
import 'package:Resilio/features/customer/auth/domain/repositories/auth_repository.dart'
    as _i184;
import 'package:Resilio/features/customer/auth/domain/usecases/facebook_signin_usecase.dart'
    as _i64;
import 'package:Resilio/features/customer/auth/domain/usecases/google_signin_usecase.dart'
    as _i671;
import 'package:Resilio/features/customer/auth/domain/usecases/login_usecase.dart'
    as _i269;
import 'package:Resilio/features/customer/auth/domain/usecases/logout_usecase.dart'
    as _i104;
import 'package:Resilio/features/customer/auth/domain/usecases/send_otp_usecase.dart'
    as _i99;
import 'package:Resilio/features/customer/auth/domain/usecases/signup_usecase.dart'
    as _i81;
import 'package:Resilio/features/customer/auth/domain/usecases/sync_user_usecase.dart'
    as _i1033;
import 'package:Resilio/features/customer/auth/domain/usecases/verify_otp_usecase.dart'
    as _i613;
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_bloc.dart'
    as _i829;
import 'package:Resilio/features/customer/categories/data/datasources/local/category_local_data_source.dart'
    as _i742;
import 'package:Resilio/features/customer/categories/data/datasources/remote/category_remote_data_source.dart'
    as _i748;
import 'package:Resilio/features/customer/categories/data/repositories/category_repository_impl.dart'
    as _i626;
import 'package:Resilio/features/customer/categories/domain/repositories/category_repository.dart'
    as _i429;
import 'package:Resilio/features/customer/categories/domain/usecases/get_categories_usecase.dart'
    as _i1053;
import 'package:Resilio/features/customer/categories/presentation/bloc/category_bloc.dart'
    as _i542;
import 'package:Resilio/features/customer/dashboard/data/datasources/local/dashboard_local_data_source.dart'
    as _i198;
import 'package:Resilio/features/customer/dashboard/data/datasources/local/quote_local_data_source.dart'
    as _i237;
import 'package:Resilio/features/customer/dashboard/data/datasources/remote/dashboard_remote_data_source.dart'
    as _i774;
import 'package:Resilio/features/customer/dashboard/data/datasources/remote/quote_remote_data_source.dart'
    as _i927;
import 'package:Resilio/features/customer/dashboard/data/repositories/dashboard_repository_impl.dart'
    as _i920;
import 'package:Resilio/features/customer/dashboard/data/repositories/quote_repository_impl.dart'
    as _i1025;
import 'package:Resilio/features/customer/dashboard/domain/repositories/dashboard_repository.dart'
    as _i637;
import 'package:Resilio/features/customer/dashboard/domain/repositories/quote_repository.dart'
    as _i610;
import 'package:Resilio/features/customer/dashboard/domain/usecases/get_dashboard_user_profile_usecase.dart'
    as _i426;
import 'package:Resilio/features/customer/dashboard/domain/usecases/quote_usecases.dart'
    as _i970;
import 'package:Resilio/features/customer/dashboard/presentation/bloc/dashboard_bloc.dart'
    as _i32;
import 'package:Resilio/features/customer/dashboard/presentation/bloc/quote_bloc.dart'
    as _i505;
import 'package:Resilio/features/customer/explore/data/datasources/explore_local_data_source.dart'
    as _i223;
import 'package:Resilio/features/customer/explore/data/repositories/explore_repository_impl.dart'
    as _i923;
import 'package:Resilio/features/customer/explore/domain/repositories/explore_repository.dart'
    as _i694;
import 'package:Resilio/features/customer/explore/domain/usecases/explore_usecases.dart'
    as _i772;
import 'package:Resilio/features/customer/explore/presentation/bloc/explore_bloc.dart'
    as _i241;
import 'package:Resilio/features/customer/favorites/data/datasources/favorite_remote_datasource.dart'
    as _i267;
import 'package:Resilio/features/customer/favorites/data/repositories/favorite_repository_impl.dart'
    as _i1055;
import 'package:Resilio/features/customer/favorites/domain/repositories/favorite_repository.dart'
    as _i618;
import 'package:Resilio/features/customer/favorites/presentation/bloc/favorite_bloc.dart'
    as _i99;
import 'package:Resilio/features/customer/games/affirmation_builder/data/datasources/local/affirmation_local_data_source.dart'
    as _i671;
import 'package:Resilio/features/customer/games/game_hub/data/datasources/games_remote_data_source.dart'
    as _i118;
import 'package:Resilio/features/customer/games/game_hub/data/repositories/games_repository_impl.dart'
    as _i427;
import 'package:Resilio/features/customer/games/game_hub/domain/repositories/games_repository.dart'
    as _i185;
import 'package:Resilio/features/customer/games/game_hub/presentation/bloc/games_hub_cubit.dart'
    as _i514;
import 'package:Resilio/features/customer/images/data/datasources/local/image_local_data_source.dart'
    as _i864;
import 'package:Resilio/features/customer/images/data/datasources/remote/image_remote_data_source.dart'
    as _i739;
import 'package:Resilio/features/customer/images/data/repositories/image_repository_impl.dart'
    as _i76;
import 'package:Resilio/features/customer/images/domain/repositories/image_repository.dart'
    as _i674;
import 'package:Resilio/features/customer/images/presentation/bloc/image_bloc.dart'
    as _i277;
import 'package:Resilio/features/customer/main/presentation/cubit/main_screen_cubit.dart'
    as _i26;
import 'package:Resilio/features/customer/onboarding/data/datasources/onboarding_local_data_source.dart'
    as _i103;
import 'package:Resilio/features/customer/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i318;
import 'package:Resilio/features/customer/onboarding/domain/repositories/onboarding_repository.dart'
    as _i687;
import 'package:Resilio/features/customer/onboarding/domain/usecases/check_onboarding_status_usecase.dart'
    as _i723;
import 'package:Resilio/features/customer/onboarding/domain/usecases/complete_onboarding_usecase.dart'
    as _i155;
import 'package:Resilio/features/customer/onboarding/domain/usecases/get_onboarding_pages_usecase.dart'
    as _i1034;
import 'package:Resilio/features/customer/onboarding/presentation/bloc/onboarding_bloc.dart'
    as _i858;
import 'package:Resilio/features/customer/preferences/data/datasources/local/preference_local_data_source.dart'
    as _i189;
import 'package:Resilio/features/customer/preferences/data/datasources/remote/preference_remote_data_source.dart'
    as _i726;
import 'package:Resilio/features/customer/preferences/data/repositories/preference_repository_impl.dart'
    as _i449;
import 'package:Resilio/features/customer/preferences/domain/repositories/preference_repository.dart'
    as _i337;
import 'package:Resilio/features/customer/preferences/domain/usecases/check_preferences_completion_usecase.dart'
    as _i420;
import 'package:Resilio/features/customer/preferences/domain/usecases/get_preferences_usecase.dart'
    as _i441;
import 'package:Resilio/features/customer/preferences/domain/usecases/get_user_preferences_usecase.dart'
    as _i226;
import 'package:Resilio/features/customer/preferences/domain/usecases/save_user_preferences_usecase.dart'
    as _i599;
import 'package:Resilio/features/customer/preferences/presentation/bloc/preferences_bloc.dart'
    as _i811;
import 'package:Resilio/features/customer/profile/data/datasources/profile_remote_data_source.dart'
    as _i159;
import 'package:Resilio/features/customer/profile/data/repositories/profile_repository_impl.dart'
    as _i140;
import 'package:Resilio/features/customer/profile/domain/repositories/profile_repository.dart'
    as _i633;
import 'package:Resilio/features/customer/profile/presentation/bloc/profile_bloc.dart'
    as _i85;
import 'package:Resilio/features/customer/settings/data/datasources/settings_local_data_source.dart'
    as _i786;
import 'package:Resilio/features/customer/settings/data/repositories/settings_repository_impl.dart'
    as _i736;
import 'package:Resilio/features/customer/settings/domain/repositories/settings_repository.dart'
    as _i648;
import 'package:Resilio/features/customer/settings/presentation/bloc/settings_bloc.dart'
    as _i733;
import 'package:Resilio/features/customer/subscription/data/datasources/subscription_remote_data_source.dart'
    as _i122;
import 'package:Resilio/features/customer/subscription/data/repositories/subscription_repository_impl.dart'
    as _i407;
import 'package:Resilio/features/customer/subscription/domain/repositories/subscription_repository.dart'
    as _i841;
import 'package:Resilio/features/customer/subscription/presentation/bloc/premium_cubit.dart'
    as _i348;
import 'package:Resilio/features/customer/subscription/presentation/bloc/subscription_bloc.dart'
    as _i738;
import 'package:Resilio/features/customer/tips/data/datasources/local/tips_local_data_source.dart'
    as _i812;
import 'package:Resilio/features/customer/tips/data/datasources/remote/tip_remote_data_source.dart'
    as _i482;
import 'package:Resilio/features/customer/tips/data/repositories/tip_repository_impl.dart'
    as _i543;
import 'package:Resilio/features/customer/tips/domain/repositories/tip_repository.dart'
    as _i871;
import 'package:Resilio/features/customer/tips/presentation/bloc/tip_bloc.dart'
    as _i1035;
import 'package:Resilio/features/customer/video/data/datasources/local/video_local_data_source.dart'
    as _i308;
import 'package:Resilio/features/customer/video/data/datasources/remote/video_remote_data_source.dart'
    as _i1067;
import 'package:Resilio/features/customer/video/data/repositories/video_repository_impl.dart'
    as _i503;
import 'package:Resilio/features/customer/video/domain/repositories/video_repository.dart'
    as _i81;
import 'package:Resilio/features/customer/video/presentation/bloc/long_video/long_video_bloc.dart'
    as _i599;
import 'package:Resilio/features/customer/video/presentation/bloc/short_video/short_video_bloc.dart'
    as _i329;
import 'package:Resilio/features/therapist/appointments/data/datasources/remote/appointments_remote_datasource.dart'
    as _i740;
import 'package:Resilio/features/therapist/appointments/data/repositories/appointments_repository_impl.dart'
    as _i453;
import 'package:Resilio/features/therapist/appointments/domain/repositories/appointments_repository.dart'
    as _i748;
import 'package:Resilio/features/therapist/content/data/datasources/remote/content_remote_datasource.dart'
    as _i48;
import 'package:Resilio/features/therapist/content/data/repositories/content_repository_impl.dart'
    as _i309;
import 'package:Resilio/features/therapist/content/domain/repositories/content_repository.dart'
    as _i1064;
import 'package:Resilio/features/therapist/dashboard/data/datasources/remote/dashboard_remote_datasource.dart'
    as _i518;
import 'package:Resilio/features/therapist/dashboard/data/repositories/dashboard_repository_impl.dart'
    as _i997;
import 'package:Resilio/features/therapist/dashboard/data/repositories/therapist_repository_impl.dart'
    as _i217;
import 'package:Resilio/features/therapist/dashboard/domain/repositories/dashboard_repository.dart'
    as _i451;
import 'package:Resilio/features/therapist/dashboard/domain/repositories/therapist_repository.dart'
    as _i120;
import 'package:Resilio/features/therapist/dashboard/presentation/bloc/therapist_content_cubit.dart'
    as _i499;
import 'package:Resilio/features/therapist/dashboard/presentation/bloc/therapist_cubit.dart'
    as _i196;
import 'package:Resilio/features/therapist/earnings/data/datasources/remote/earnings_remote_datasource.dart'
    as _i324;
import 'package:Resilio/features/therapist/earnings/data/repositories/earnings_repository_impl.dart'
    as _i423;
import 'package:Resilio/features/therapist/earnings/domain/repositories/earnings_repository.dart'
    as _i544;
import 'package:Resilio/features/therapist/patients/data/datasources/remote/patients_remote_datasource.dart'
    as _i1031;
import 'package:Resilio/features/therapist/patients/data/repositories/patients_repository_impl.dart'
    as _i122;
import 'package:Resilio/features/therapist/patients/domain/repositories/patients_repository.dart'
    as _i637;
import 'package:Resilio/features/therapist/profile/data/datasources/remote/profile_remote_datasource.dart'
    as _i316;
import 'package:Resilio/features/therapist/profile/data/repositories/profile_repository_impl.dart'
    as _i176;
import 'package:Resilio/features/therapist/profile/domain/repositories/profile_repository.dart'
    as _i696;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final externalModule = _$ExternalModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i26.MainScreenCubit>(() => _i26.MainScreenCubit());
    gh.lazySingleton<_i865.DatabaseHelper>(() => _i865.DatabaseHelper());
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.lazySingleton<_i806.FacebookAuth>(() => registerModule.facebookAuth);
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => externalModule.connectionChecker,
    );
    gh.lazySingleton<_i39.NavigationService>(() => _i39.NavigationService());
    gh.lazySingleton<_i80.AuthTokenService>(() => _i80.AuthTokenService());
    gh.lazySingleton<_i399.CloudinaryService>(() => _i399.CloudinaryService());
    gh.lazySingleton<_i772.SearchExploreItems>(
      () => _i772.SearchExploreItems(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i80.AuthTokenService>()),
    );
    gh.lazySingleton<_i742.CategoryLocalDataSource>(
      () => _i742.CategoryLocalDataSourceImpl(gh<_i865.DatabaseHelper>()),
    );
    gh.lazySingleton<_i159.ProfileRemoteDataSource>(
      () => _i159.ProfileRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i482.TipRemoteDataSource>(
      () => _i482.TipRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i118.GamesRemoteDataSource>(
      () => _i118.GamesRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i308.VideoLocalDataSource>(
      () => _i308.VideoLocalDataSourceImpl(gh<_i865.DatabaseHelper>()),
    );
    gh.lazySingleton<_i22.AdminRepository>(
      () => _i624.AdminRepositoryImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i671.AffirmationLocalDataSource>(
      () => _i671.AffirmationLocalDataSourceImpl(gh<_i865.DatabaseHelper>()),
    );
    gh.lazySingleton<_i518.TherapistDashboardRemoteDataSource>(
      () => _i518.TherapistDashboardRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i376.AuthRemoteDataSource>(
      () => _i376.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1031.PatientsRemoteDataSource>(
      () => _i1031.PatientsRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i786.SettingsLocalDataSource>(
      () => _i786.SettingsLocalDataSourceImpl(
        prefs: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i316.ProfileRemoteDataSource>(
      () => _i316.ProfileRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i812.TipsLocalDataSource>(
      () => _i812.TipsLocalDataSourceImpl(gh<_i865.DatabaseHelper>()),
    );
    gh.lazySingleton<_i748.CategoryRemoteDataSource>(
      () => _i748.CategoryRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1067.VideoRemoteDataSource>(
      () => _i1067.VideoRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i343.AudioRemoteDataSource>(
      () => _i343.AudioRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i852.BackendAuthDataSource>(
      () => _i852.BackendAuthDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i667.SuperTokensDataSource>(
      () => _i667.SuperTokensDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i267.FavoriteRemoteDataSource>(
      () => _i267.FavoriteRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i726.PreferenceRemoteDataSource>(
      () => _i726.PreferenceRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i648.SettingsRepository>(
      () => _i736.SettingsRepositoryImpl(
        localDataSource: gh<_i786.SettingsLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i120.TherapistRepository>(
      () => _i217.TherapistRepositoryImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i499.TherapistContentCubit>(
      () => _i499.TherapistContentCubit(gh<_i120.TherapistRepository>()),
    );
    gh.factory<_i196.TherapistCubit>(
      () => _i196.TherapistCubit(gh<_i120.TherapistRepository>()),
    );
    gh.lazySingleton<_i882.AuthLocalDataSource>(
      () => _i882.AuthLocalDataSourceImpl(gh<_i865.DatabaseHelper>()),
    );
    gh.factory<_i251.AuthInterceptor>(
      () => _i251.AuthInterceptor(gh<_i80.AuthTokenService>()),
    );
    gh.lazySingleton<_i759.NetworkInfo>(
      () => _i759.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()),
    );
    gh.lazySingleton<_i80.AudioLocalDataSource>(
      () => _i80.AudioLocalDataSourceImpl(gh<_i865.DatabaseHelper>()),
    );
    gh.lazySingleton<_i223.ExploreLocalDataSource>(
      () => _i223.ExploreLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i4.ThemeCubit>(
      () => _i4.ThemeCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i871.TipRepository>(
      () => _i543.TipRepositoryImpl(
        gh<_i482.TipRemoteDataSource>(),
        gh<_i812.TipsLocalDataSource>(),
        gh<_i759.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i519.FirebaseAuthDataSource>(
      () => _i519.FirebaseAuthDataSource(
        gh<_i59.FirebaseAuth>(),
        gh<_i116.GoogleSignIn>(),
        gh<_i806.FacebookAuth>(),
      ),
    );
    gh.lazySingleton<_i189.PreferenceLocalDataSource>(
      () => _i189.PreferenceLocalDataSourceImpl(gh<_i865.DatabaseHelper>()),
    );
    gh.lazySingleton<_i198.DashboardLocalDataSource>(
      () => _i198.DashboardLocalDataSourceImpl(gh<_i865.DatabaseHelper>()),
    );
    gh.lazySingleton<_i185.GamesRepository>(
      () => _i427.GamesRepositoryImpl(
        gh<_i118.GamesRemoteDataSource>(),
        gh<_i759.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i733.SettingsBloc>(
      () => _i733.SettingsBloc(repository: gh<_i648.SettingsRepository>()),
    );
    gh.factory<_i1035.TipBloc>(() => _i1035.TipBloc(gh<_i871.TipRepository>()));
    gh.lazySingleton<_i618.FavoriteRepository>(
      () => _i1055.FavoriteRepositoryImpl(gh<_i267.FavoriteRemoteDataSource>()),
    );
    gh.lazySingleton<_i696.TherapistProfileRepository>(
      () => _i176.ProfileRepositoryImpl(gh<_i316.ProfileRemoteDataSource>()),
    );
    gh.lazySingleton<_i237.QuoteLocalDataSource>(
      () => _i237.QuoteLocalDataSourceImpl(gh<_i865.DatabaseHelper>()),
    );
    gh.lazySingleton<_i429.CategoryRepository>(
      () => _i626.CategoryRepositoryImpl(
        gh<_i748.CategoryRemoteDataSource>(),
        gh<_i742.CategoryLocalDataSource>(),
        gh<_i759.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i1053.GetCategoriesUseCase>(
      () => _i1053.GetCategoriesUseCase(gh<_i429.CategoryRepository>()),
    );
    gh.lazySingleton<_i864.ImageLocalDataSource>(
      () => _i864.ImageLocalDataSourceImpl(gh<_i865.DatabaseHelper>()),
    );
    gh.lazySingleton<_i103.OnboardingLocalDataSource>(
      () => _i103.OnboardingLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i514.GamesHubCubit>(
      () => _i514.GamesHubCubit(gh<_i185.GamesRepository>()),
    );
    gh.lazySingleton<_i740.AppointmentsRemoteDataSource>(
      () => _i740.AppointmentsRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i774.DashboardRemoteDataSource>(
      () => _i774.DashboardRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i1073.AdminContentCubit>(
      () => _i1073.AdminContentCubit(gh<_i22.AdminRepository>()),
    );
    gh.factory<_i846.AdminCubit>(
      () => _i846.AdminCubit(gh<_i22.AdminRepository>()),
    );
    gh.factory<_i968.AdminNotificationCubit>(
      () => _i968.AdminNotificationCubit(gh<_i22.AdminRepository>()),
    );
    gh.factory<_i5.AdminPreferenceCubit>(
      () => _i5.AdminPreferenceCubit(gh<_i22.AdminRepository>()),
    );
    gh.factory<_i926.AdminRevenueCubit>(
      () => _i926.AdminRevenueCubit(gh<_i22.AdminRepository>()),
    );
    gh.lazySingleton<_i122.SubscriptionRemoteDataSource>(
      () => _i122.SubscriptionRemoteDataSourceImpl(
        gh<_i361.Dio>(),
        gh<_i80.AuthTokenService>(),
      ),
    );
    gh.lazySingleton<_i927.QuoteRemoteDataSource>(
      () => _i927.QuoteRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i48.ContentRemoteDataSource>(
      () => _i48.ContentRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i637.PatientsRepository>(
      () => _i122.PatientsRepositoryImpl(gh<_i1031.PatientsRemoteDataSource>()),
    );
    gh.lazySingleton<_i324.EarningsRemoteDataSource>(
      () => _i324.EarningsRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i739.ImageRemoteDataSource>(
      () => _i739.ImageRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i633.ProfileRepository>(
      () => _i140.ProfileRepositoryImpl(gh<_i159.ProfileRemoteDataSource>()),
    );
    gh.factory<_i1033.SyncUserUseCase>(
      () => _i1033.SyncUserUseCase(gh<_i852.BackendAuthDataSource>()),
    );
    gh.lazySingleton<_i451.DashboardRepository>(
      () => _i997.DashboardRepositoryImpl(
        gh<_i518.TherapistDashboardRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i748.AppointmentsRepository>(
      () => _i453.AppointmentsRepositoryImpl(
        gh<_i740.AppointmentsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i337.PreferenceRepository>(
      () => _i449.PreferenceRepositoryImpl(
        gh<_i726.PreferenceRemoteDataSource>(),
        gh<_i189.PreferenceLocalDataSource>(),
        gh<_i759.NetworkInfo>(),
        gh<_i80.AuthTokenService>(),
      ),
    );
    gh.factory<_i99.FavoriteBloc>(
      () => _i99.FavoriteBloc(gh<_i618.FavoriteRepository>()),
    );
    gh.lazySingleton<_i164.AudioRepository>(
      () => _i591.AudioRepositoryImpl(
        gh<_i343.AudioRemoteDataSource>(),
        gh<_i80.AudioLocalDataSource>(),
        gh<_i759.NetworkInfo>(),
      ),
    );
    gh.factory<_i420.CheckPreferencesCompletionUseCase>(
      () => _i420.CheckPreferencesCompletionUseCase(
        gh<_i337.PreferenceRepository>(),
      ),
    );
    gh.factory<_i441.GetPreferencesUseCase>(
      () => _i441.GetPreferencesUseCase(gh<_i337.PreferenceRepository>()),
    );
    gh.factory<_i226.GetUserPreferencesUseCase>(
      () => _i226.GetUserPreferencesUseCase(gh<_i337.PreferenceRepository>()),
    );
    gh.factory<_i599.SaveUserPreferencesUseCase>(
      () => _i599.SaveUserPreferencesUseCase(gh<_i337.PreferenceRepository>()),
    );
    gh.lazySingleton<_i674.ImageRepository>(
      () => _i76.ImageRepositoryImpl(
        gh<_i739.ImageRemoteDataSource>(),
        gh<_i864.ImageLocalDataSource>(),
        gh<_i759.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i687.OnboardingRepository>(
      () =>
          _i318.OnboardingRepositoryImpl(gh<_i103.OnboardingLocalDataSource>()),
    );
    gh.lazySingleton<_i81.VideoRepository>(
      () => _i503.VideoRepositoryImpl(
        gh<_i1067.VideoRemoteDataSource>(),
        gh<_i308.VideoLocalDataSource>(),
        gh<_i759.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i637.DashboardRepository>(
      () => _i920.DashboardRepositoryImpl(
        gh<_i774.DashboardRemoteDataSource>(),
        gh<_i198.DashboardLocalDataSource>(),
        gh<_i759.NetworkInfo>(),
      ),
    );
    gh.factory<_i542.CategoryBloc>(
      () => _i542.CategoryBloc(gh<_i1053.GetCategoriesUseCase>()),
    );
    gh.lazySingleton<_i544.EarningsRepository>(
      () => _i423.EarningsRepositoryImpl(gh<_i324.EarningsRemoteDataSource>()),
    );
    gh.lazySingleton<_i1064.ContentRepository>(
      () => _i309.ContentRepositoryImpl(gh<_i48.ContentRemoteDataSource>()),
    );
    gh.lazySingleton<_i610.QuoteRepository>(
      () => _i1025.QuoteRepositoryImpl(
        gh<_i927.QuoteRemoteDataSource>(),
        gh<_i237.QuoteLocalDataSource>(),
        gh<_i759.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i184.AuthRepository>(
      () => _i474.AuthRepositoryImpl(
        gh<_i519.FirebaseAuthDataSource>(),
        gh<_i852.BackendAuthDataSource>(),
        gh<_i337.PreferenceRepository>(),
        gh<_i667.SuperTokensDataSource>(),
        gh<_i80.AuthTokenService>(),
        gh<_i759.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i694.ExploreRepository>(
      () => _i923.ExploreRepositoryImpl(
        gh<_i361.Dio>(),
        gh<_i343.AudioRemoteDataSource>(),
        gh<_i1067.VideoRemoteDataSource>(),
        gh<_i927.QuoteRemoteDataSource>(),
        gh<_i482.TipRemoteDataSource>(),
        gh<_i739.ImageRemoteDataSource>(),
        gh<_i748.CategoryRemoteDataSource>(),
        gh<_i223.ExploreLocalDataSource>(),
      ),
    );
    gh.factory<_i85.ProfileBloc>(
      () => _i85.ProfileBloc(
        gh<_i633.ProfileRepository>(),
        gh<_i399.CloudinaryService>(),
      ),
    );
    gh.lazySingleton<_i841.SubscriptionRepository>(
      () => _i407.SubscriptionRepositoryImpl(
        gh<_i122.SubscriptionRemoteDataSource>(),
        gh<_i759.NetworkInfo>(),
      ),
    );
    gh.factory<_i171.AudioBloc>(
      () => _i171.AudioBloc(gh<_i164.AudioRepository>()),
    );
    gh.factory<_i723.CheckOnboardingStatusUseCase>(
      () =>
          _i723.CheckOnboardingStatusUseCase(gh<_i687.OnboardingRepository>()),
    );
    gh.factory<_i155.CompleteOnboardingUseCase>(
      () => _i155.CompleteOnboardingUseCase(gh<_i687.OnboardingRepository>()),
    );
    gh.factory<_i1034.GetOnboardingPagesUseCase>(
      () => _i1034.GetOnboardingPagesUseCase(gh<_i687.OnboardingRepository>()),
    );
    gh.factory<_i277.ImageBloc>(
      () => _i277.ImageBloc(gh<_i674.ImageRepository>()),
    );
    gh.lazySingleton<_i772.GetAllExploreItems>(
      () => _i772.GetAllExploreItems(gh<_i694.ExploreRepository>()),
    );
    gh.lazySingleton<_i772.ManageRecentSearches>(
      () => _i772.ManageRecentSearches(gh<_i694.ExploreRepository>()),
    );
    gh.factory<_i811.PreferencesBloc>(
      () => _i811.PreferencesBloc(
        gh<_i441.GetPreferencesUseCase>(),
        gh<_i226.GetUserPreferencesUseCase>(),
        gh<_i599.SaveUserPreferencesUseCase>(),
        gh<_i420.CheckPreferencesCompletionUseCase>(),
      ),
    );
    gh.lazySingleton<_i758.OfflineSyncManager>(
      () => _i758.OfflineSyncManager(
        gh<_i759.NetworkInfo>(),
        gh<_i429.CategoryRepository>(),
        gh<_i81.VideoRepository>(),
        gh<_i871.TipRepository>(),
      ),
    );
    gh.factory<_i738.SubscriptionBloc>(
      () => _i738.SubscriptionBloc(gh<_i841.SubscriptionRepository>()),
    );
    gh.factory<_i671.GoogleSignInUseCase>(
      () => _i671.GoogleSignInUseCase(gh<_i184.AuthRepository>()),
    );
    gh.factory<_i269.LoginUseCase>(
      () => _i269.LoginUseCase(gh<_i184.AuthRepository>()),
    );
    gh.factory<_i104.LogoutUseCase>(
      () => _i104.LogoutUseCase(gh<_i184.AuthRepository>()),
    );
    gh.factory<_i99.SendOtpUseCase>(
      () => _i99.SendOtpUseCase(gh<_i184.AuthRepository>()),
    );
    gh.factory<_i81.SignUpUseCase>(
      () => _i81.SignUpUseCase(gh<_i184.AuthRepository>()),
    );
    gh.factory<_i613.VerifyOtpUseCase>(
      () => _i613.VerifyOtpUseCase(gh<_i184.AuthRepository>()),
    );
    gh.factory<_i426.GetDashboardUserProfileUseCase>(
      () =>
          _i426.GetDashboardUserProfileUseCase(gh<_i637.DashboardRepository>()),
    );
    gh.factory<_i599.LongVideoBloc>(
      () => _i599.LongVideoBloc(gh<_i81.VideoRepository>()),
    );
    gh.factory<_i329.ShortVideoBloc>(
      () => _i329.ShortVideoBloc(gh<_i81.VideoRepository>()),
    );
    gh.factory<_i348.PremiumCubit>(
      () => _i348.PremiumCubit(gh<_i738.SubscriptionBloc>()),
    );
    gh.lazySingleton<_i970.GetFeaturedQuotes>(
      () => _i970.GetFeaturedQuotes(gh<_i610.QuoteRepository>()),
    );
    gh.lazySingleton<_i970.GetQuoteById>(
      () => _i970.GetQuoteById(gh<_i610.QuoteRepository>()),
    );
    gh.lazySingleton<_i970.ListQuotes>(
      () => _i970.ListQuotes(gh<_i610.QuoteRepository>()),
    );
    gh.lazySingleton<_i360.ConnectivityMonitor>(
      () => _i360.ConnectivityMonitor(
        gh<_i895.Connectivity>(),
        gh<_i758.OfflineSyncManager>(),
      ),
    );
    gh.lazySingleton<_i64.FacebookSignInUseCase>(
      () => _i64.FacebookSignInUseCase(gh<_i184.AuthRepository>()),
    );
    gh.factory<_i32.DashboardBloc>(
      () => _i32.DashboardBloc(
        gh<_i426.GetDashboardUserProfileUseCase>(),
        gh<_i80.AuthTokenService>(),
      ),
    );
    gh.factory<_i858.OnboardingBloc>(
      () => _i858.OnboardingBloc(
        gh<_i1034.GetOnboardingPagesUseCase>(),
        gh<_i155.CompleteOnboardingUseCase>(),
      ),
    );
    gh.factory<_i829.AuthBloc>(
      () => _i829.AuthBloc(
        gh<_i269.LoginUseCase>(),
        gh<_i81.SignUpUseCase>(),
        gh<_i671.GoogleSignInUseCase>(),
        gh<_i64.FacebookSignInUseCase>(),
        gh<_i99.SendOtpUseCase>(),
        gh<_i613.VerifyOtpUseCase>(),
        gh<_i104.LogoutUseCase>(),
      ),
    );
    gh.factory<_i241.ExploreBloc>(
      () => _i241.ExploreBloc(
        gh<_i772.GetAllExploreItems>(),
        gh<_i772.SearchExploreItems>(),
        gh<_i772.ManageRecentSearches>(),
        gh<_i694.ExploreRepository>(),
      ),
    );
    gh.factory<_i505.QuoteBloc>(
      () => _i505.QuoteBloc(gh<_i970.GetFeaturedQuotes>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i306.RegisterModule {}

class _$ExternalModule extends _i759.ExternalModule {}

class _$NetworkModule extends _i266.NetworkModule {}
