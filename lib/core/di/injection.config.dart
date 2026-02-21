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
import 'package:Resilio/core/theme/cubit/theme_cubit.dart' as _i4;
import 'package:Resilio/features/customer/auth/data/datasources/local/auth_local_data_source.dart'
    as _i882;
import 'package:Resilio/features/customer/auth/data/datasources/remote/auth_remote_data_source.dart'
    as _i376;
import 'package:Resilio/features/customer/auth/data/datasources/remote/firebase_auth_data_source.dart'
    as _i519;
import 'package:Resilio/features/customer/auth/data/repositories/auth_repository_impl.dart'
    as _i474;
import 'package:Resilio/features/customer/auth/domain/repositories/auth_repository.dart'
    as _i184;
import 'package:Resilio/features/customer/auth/domain/services/email_link_handler.dart'
    as _i154;
import 'package:Resilio/features/customer/auth/domain/usecases/facebook_signin_usecase.dart'
    as _i64;
import 'package:Resilio/features/customer/auth/domain/usecases/google_signin_usecase.dart'
    as _i671;
import 'package:Resilio/features/customer/auth/domain/usecases/login_usecase.dart'
    as _i269;
import 'package:Resilio/features/customer/auth/domain/usecases/send_signin_link_usecase.dart'
    as _i438;
import 'package:Resilio/features/customer/auth/domain/usecases/signin_with_email_link_usecase.dart'
    as _i1038;
import 'package:Resilio/features/customer/auth/domain/usecases/signup_usecase.dart'
    as _i81;
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_bloc.dart'
    as _i829;
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
    gh.lazySingleton<_i865.DatabaseHelper>(() => _i865.DatabaseHelper());
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.lazySingleton<_i806.FacebookAuth>(() => registerModule.facebookAuth);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => externalModule.connectionChecker,
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i39.NavigationService>(() => _i39.NavigationService());
    gh.lazySingleton<_i519.FirebaseAuthDataSource>(
      () => _i519.FirebaseAuthDataSource(
        gh<_i59.FirebaseAuth>(),
        gh<_i116.GoogleSignIn>(),
        gh<_i806.FacebookAuth>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i376.AuthRemoteDataSource>(
      () => _i376.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
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
    gh.lazySingleton<_i154.EmailLinkHandler>(
      () => _i154.EmailLinkHandler(
        gh<_i59.FirebaseAuth>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i184.AuthRepository>(
      () => _i474.AuthRepositoryImpl(gh<_i519.FirebaseAuthDataSource>()),
    );
    gh.lazySingleton<_i103.OnboardingLocalDataSource>(
      () => _i103.OnboardingLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i671.GoogleSignInUseCase>(
      () => _i671.GoogleSignInUseCase(gh<_i184.AuthRepository>()),
    );
    gh.factory<_i269.LoginUseCase>(
      () => _i269.LoginUseCase(gh<_i184.AuthRepository>()),
    );
    gh.factory<_i81.SignUpUseCase>(
      () => _i81.SignUpUseCase(gh<_i184.AuthRepository>()),
    );
    gh.lazySingleton<_i687.OnboardingRepository>(
      () =>
          _i318.OnboardingRepositoryImpl(gh<_i103.OnboardingLocalDataSource>()),
    );
    gh.lazySingleton<_i64.FacebookSignInUseCase>(
      () => _i64.FacebookSignInUseCase(gh<_i184.AuthRepository>()),
    );
    gh.lazySingleton<_i438.SendSignInLinkUseCase>(
      () => _i438.SendSignInLinkUseCase(gh<_i184.AuthRepository>()),
    );
    gh.lazySingleton<_i1038.SignInWithEmailLinkUseCase>(
      () => _i1038.SignInWithEmailLinkUseCase(gh<_i184.AuthRepository>()),
    );
    gh.factory<_i829.AuthBloc>(
      () => _i829.AuthBloc(
        gh<_i269.LoginUseCase>(),
        gh<_i81.SignUpUseCase>(),
        gh<_i671.GoogleSignInUseCase>(),
        gh<_i64.FacebookSignInUseCase>(),
        gh<_i438.SendSignInLinkUseCase>(),
        gh<_i1038.SignInWithEmailLinkUseCase>(),
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
    gh.factory<_i858.OnboardingBloc>(
      () => _i858.OnboardingBloc(
        gh<_i1034.GetOnboardingPagesUseCase>(),
        gh<_i155.CompleteOnboardingUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i306.RegisterModule {}

class _$ExternalModule extends _i759.ExternalModule {}

class _$NetworkModule extends _i266.NetworkModule {}
