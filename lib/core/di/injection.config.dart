// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
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
import 'package:Resilio/core/network/network_info.dart' as _i759;
import 'package:Resilio/core/network/network_module.dart' as _i266;
import 'package:Resilio/core/routing/navigation_service.dart' as _i39;
import 'package:Resilio/core/services/auth_token_service.dart' as _i80;
import 'package:Resilio/core/theme/cubit/theme_cubit.dart' as _i4;
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
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => externalModule.connectionChecker,
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i39.NavigationService>(() => _i39.NavigationService());
    gh.lazySingleton<_i80.AuthTokenService>(() => _i80.AuthTokenService());
    gh.lazySingleton<_i376.AuthRemoteDataSource>(
      () => _i376.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i852.BackendAuthDataSource>(
      () => _i852.BackendAuthDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i667.SuperTokensDataSource>(
      () => _i667.SuperTokensDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i726.PreferenceRemoteDataSource>(
      () => _i726.PreferenceRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i882.AuthLocalDataSource>(
      () => _i882.AuthLocalDataSourceImpl(gh<_i865.DatabaseHelper>()),
    );
    gh.lazySingleton<_i759.NetworkInfo>(
      () => _i759.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()),
    );
    gh.lazySingleton<_i4.ThemeCubit>(
      () => _i4.ThemeCubit(gh<_i460.SharedPreferences>()),
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
    gh.lazySingleton<_i103.OnboardingLocalDataSource>(
      () => _i103.OnboardingLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i1033.SyncUserUseCase>(
      () => _i1033.SyncUserUseCase(gh<_i852.BackendAuthDataSource>()),
    );
    gh.lazySingleton<_i337.PreferenceRepository>(
      () => _i449.PreferenceRepositoryImpl(
        gh<_i726.PreferenceRemoteDataSource>(),
        gh<_i189.PreferenceLocalDataSource>(),
        gh<_i759.NetworkInfo>(),
        gh<_i80.AuthTokenService>(),
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
    gh.lazySingleton<_i687.OnboardingRepository>(
      () =>
          _i318.OnboardingRepositoryImpl(gh<_i103.OnboardingLocalDataSource>()),
    );
    gh.lazySingleton<_i184.AuthRepository>(
      () => _i474.AuthRepositoryImpl(
        gh<_i519.FirebaseAuthDataSource>(),
        gh<_i852.BackendAuthDataSource>(),
        gh<_i337.PreferenceRepository>(),
        gh<_i667.SuperTokensDataSource>(),
        gh<_i80.AuthTokenService>(),
      ),
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
    gh.factory<_i811.PreferencesBloc>(
      () => _i811.PreferencesBloc(
        gh<_i441.GetPreferencesUseCase>(),
        gh<_i226.GetUserPreferencesUseCase>(),
        gh<_i599.SaveUserPreferencesUseCase>(),
        gh<_i420.CheckPreferencesCompletionUseCase>(),
      ),
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
    gh.lazySingleton<_i64.FacebookSignInUseCase>(
      () => _i64.FacebookSignInUseCase(gh<_i184.AuthRepository>()),
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
    return this;
  }
}

class _$RegisterModule extends _i306.RegisterModule {}

class _$ExternalModule extends _i759.ExternalModule {}

class _$NetworkModule extends _i266.NetworkModule {}
