// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:resilio/core/database/database_helper.dart' as _i951;
import 'package:resilio/core/di/injection.dart' as _i918;
import 'package:resilio/core/network/network_info.dart' as _i171;
import 'package:resilio/core/network/network_module.dart' as _i470;
import 'package:resilio/core/routing/navigation_service.dart' as _i957;
import 'package:resilio/features/customer/auth/data/datasources/local/auth_local_data_source.dart'
    as _i511;
import 'package:resilio/features/customer/auth/data/datasources/remote/auth_remote_data_source.dart'
    as _i563;
import 'package:resilio/features/customer/auth/data/repositories/auth_repository_impl.dart'
    as _i292;
import 'package:resilio/features/customer/auth/domain/repositories/auth_repository.dart'
    as _i826;
import 'package:resilio/features/customer/auth/domain/usecases/login_usecase.dart'
    as _i559;
import 'package:resilio/features/customer/auth/presentation/bloc/auth_bloc.dart'
    as _i993;
import 'package:resilio/features/customer/onboarding/data/datasources/onboarding_local_data_source.dart'
    as _i352;
import 'package:resilio/features/customer/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i739;
import 'package:resilio/features/customer/onboarding/domain/repositories/onboarding_repository.dart'
    as _i428;
import 'package:resilio/features/customer/onboarding/domain/usecases/check_onboarding_status_usecase.dart'
    as _i931;
import 'package:resilio/features/customer/onboarding/domain/usecases/complete_onboarding_usecase.dart'
    as _i936;
import 'package:resilio/features/customer/onboarding/domain/usecases/get_onboarding_pages_usecase.dart'
    as _i59;
import 'package:resilio/features/customer/onboarding/presentation/bloc/onboarding_bloc.dart'
    as _i1017;
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
    gh.lazySingleton<_i951.DatabaseHelper>(() => _i951.DatabaseHelper());
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => externalModule.connectionChecker,
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i957.NavigationService>(() => _i957.NavigationService());
    gh.lazySingleton<_i563.AuthRemoteDataSource>(
      () => _i563.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i352.OnboardingLocalDataSource>(
      () => _i352.OnboardingLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i428.OnboardingRepository>(
      () =>
          _i739.OnboardingRepositoryImpl(gh<_i352.OnboardingLocalDataSource>()),
    );
    gh.factory<_i931.CheckOnboardingStatusUseCase>(
      () =>
          _i931.CheckOnboardingStatusUseCase(gh<_i428.OnboardingRepository>()),
    );
    gh.factory<_i936.CompleteOnboardingUseCase>(
      () => _i936.CompleteOnboardingUseCase(gh<_i428.OnboardingRepository>()),
    );
    gh.factory<_i59.GetOnboardingPagesUseCase>(
      () => _i59.GetOnboardingPagesUseCase(gh<_i428.OnboardingRepository>()),
    );
    gh.factory<_i1017.OnboardingBloc>(
      () => _i1017.OnboardingBloc(
        gh<_i59.GetOnboardingPagesUseCase>(),
        gh<_i936.CompleteOnboardingUseCase>(),
      ),
    );
    gh.lazySingleton<_i171.NetworkInfo>(
      () => _i171.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()),
    );
    gh.lazySingleton<_i511.AuthLocalDataSource>(
      () => _i511.AuthLocalDataSourceImpl(gh<_i951.DatabaseHelper>()),
    );
    gh.lazySingleton<_i826.AuthRepository>(
      () => _i292.AuthRepositoryImpl(
        gh<_i563.AuthRemoteDataSource>(),
        gh<_i511.AuthLocalDataSource>(),
        gh<_i171.NetworkInfo>(),
      ),
    );
    gh.factory<_i559.LoginUseCase>(
      () => _i559.LoginUseCase(gh<_i826.AuthRepository>()),
    );
    gh.factory<_i993.AuthBloc>(() => _i993.AuthBloc(gh<_i559.LoginUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i918.RegisterModule {}

class _$ExternalModule extends _i171.ExternalModule {}

class _$NetworkModule extends _i470.NetworkModule {}
