// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:identidaddigital/core/data/analytics/analytics.dart' as _i741;
import 'package:identidaddigital/core/data/api/client/api_client.dart' as _i8;
import 'package:identidaddigital/core/data/api/client/api_client_impl.dart'
    as _i1019;
import 'package:identidaddigital/core/data/api/services/auth_service/auth_service.dart'
    as _i278;
import 'package:identidaddigital/core/data/api/services/auth_service/auth_service_impl.dart'
    as _i548;
import 'package:identidaddigital/core/data/api/services/auth_service/dev_auth_service_impl.dart'
    as _i1025;
import 'package:identidaddigital/core/data/api/services/device_service/dev_device_service_impl.dart'
    as _i279;
import 'package:identidaddigital/core/data/api/services/device_service/device_service.dart'
    as _i415;
import 'package:identidaddigital/core/data/api/services/device_service/device_service_impl.dart'
    as _i593;
import 'package:identidaddigital/core/data/api/services/faqs_service/dev_faqs_service_impl.dart'
    as _i399;
import 'package:identidaddigital/core/data/api/services/faqs_service/faqs_service.dart'
    as _i659;
import 'package:identidaddigital/core/data/api/services/faqs_service/faqs_service_impl.dart'
    as _i948;
import 'package:identidaddigital/core/data/api/services/profile_service/dev_profile_service_impl.dart'
    as _i279;
import 'package:identidaddigital/core/data/api/services/profile_service/profile_service.dart'
    as _i899;
import 'package:identidaddigital/core/data/api/services/profile_service/profile_service_impl.dart'
    as _i928;
import 'package:identidaddigital/core/data/api/services/remote_config_service/dev_remote_config_service_impl.dart'
    as _i104;
import 'package:identidaddigital/core/data/api/services/remote_config_service/remote_config_service.dart'
    as _i760;
import 'package:identidaddigital/core/data/api/services/remote_config_service/remote_config_service_impl.dart'
    as _i169;
import 'package:identidaddigital/core/data/data_sources/biometrics_data_source.dart'
    as _i664;
import 'package:identidaddigital/core/data/data_sources/device_info_data_source.dart'
    as _i229;
import 'package:identidaddigital/core/data/data_sources/network_info_data_source.dart'
    as _i764;
import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart'
    as _i600;
import 'package:identidaddigital/core/data/data_sources/secure_storage_data_source.dart'
    as _i795;
import 'package:identidaddigital/core/data/repositories/app_update_repository_impl.dart'
    as _i25;
import 'package:identidaddigital/core/data/repositories/destination_repository_impl.dart'
    as _i986;
import 'package:identidaddigital/core/data/repositories/remote_config_repository_impl.dart'
    as _i8;
import 'package:identidaddigital/core/data/repositories/user_permission_repository_impl.dart'
    as _i1063;
import 'package:identidaddigital/core/data/repositories/user_repository_impl.dart'
    as _i875;
import 'package:identidaddigital/core/domain/repositories/app_update_repository.dart'
    as _i442;
import 'package:identidaddigital/core/domain/repositories/destination_repository.dart'
    as _i997;
import 'package:identidaddigital/core/domain/repositories/remote_config_repository.dart'
    as _i79;
import 'package:identidaddigital/core/domain/repositories/user_permission_repository.dart'
    as _i910;
import 'package:identidaddigital/core/domain/repositories/user_repository.dart'
    as _i490;
import 'package:identidaddigital/di/injection.dart' as _i46;
import 'package:identidaddigital/features/auth/data/repositories/login_repository_impl.dart'
    as _i432;
import 'package:identidaddigital/features/auth/domain/repositories/login_repository.dart'
    as _i681;
import 'package:identidaddigital/features/auth/presentation/bloc/change_external_password_bloc.dart'
    as _i572;
import 'package:identidaddigital/features/auth/presentation/bloc/login_bloc.dart'
    as _i572;
import 'package:identidaddigital/features/digital_card/data/repositories/digital_card_repository_impl.dart'
    as _i925;
import 'package:identidaddigital/features/digital_card/domain/repositories/digital_card_repository.dart'
    as _i723;
import 'package:identidaddigital/features/digital_card/presentation/bloc/digital_card_bloc.dart'
    as _i216;
import 'package:identidaddigital/features/faqs/data/repositories/faqs_repository_impl.dart'
    as _i859;
import 'package:identidaddigital/features/faqs/domain/repositories/faqs_repository.dart'
    as _i251;
import 'package:identidaddigital/features/faqs/presentation/bloc/faqs_bloc.dart'
    as _i179;
import 'package:identidaddigital/features/onboarding/presentation/bloc/onboarding_bloc.dart'
    as _i339;
import 'package:identidaddigital/features/profile_picture/data/data_sources/image_picker_data_source.dart'
    as _i281;
import 'package:identidaddigital/features/profile_picture/data/repositories/file_manager_repository_impl.dart'
    as _i2;
import 'package:identidaddigital/features/profile_picture/data/repositories/picture_repository_impl.dart'
    as _i389;
import 'package:identidaddigital/features/profile_picture/domain/repositories/file_manager_repository.dart'
    as _i850;
import 'package:identidaddigital/features/profile_picture/domain/repositories/picture_repository.dart'
    as _i1038;
import 'package:identidaddigital/features/profile_picture/presentation/bloc/picture_not_found_bloc.dart'
    as _i532;
import 'package:identidaddigital/features/profile_picture/presentation/bloc/profile_picture_bloc.dart'
    as _i771;
import 'package:identidaddigital/features/profile_picture/presentation/bloc/upload_picture_bloc.dart'
    as _i583;
import 'package:identidaddigital/features/settings/data/data_sources/package_info_data_source.dart'
    as _i787;
import 'package:identidaddigital/features/settings/data/repositories/settings_repository_impl.dart'
    as _i118;
import 'package:identidaddigital/features/settings/domain/repositories/settings_repository.dart'
    as _i567;
import 'package:identidaddigital/features/settings/presentation/bloc/send_message_bloc.dart'
    as _i228;
import 'package:identidaddigital/features/settings/presentation/bloc/settings_bloc.dart'
    as _i4;
import 'package:identidaddigital/features/splash/presentation/bloc/splash_bloc.dart'
    as _i426;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:local_auth/local_auth.dart' as _i152;
import 'package:package_info_plus/package_info_plus.dart' as _i655;
import 'package:screen_brightness/screen_brightness.dart' as _i108;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i655.PackageInfo>(
      () => appModule.packageInfo,
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => appModule.secureStorage);
    gh.lazySingleton<_i895.Connectivity>(() => appModule.connectivity);
    gh.lazySingleton<_i152.LocalAuthentication>(
        () => appModule.localAuthentication);
    gh.lazySingleton<_i833.DeviceInfoPlugin>(() => appModule.deviceInfoPlugin);
    gh.lazySingleton<_i183.ImagePicker>(() => appModule.imagePicker);
    gh.lazySingleton<_i108.ScreenBrightness>(() => appModule.screenBrightness);
    gh.lazySingleton<_i659.FaqsService>(
      () => _i399.DevFaqsServiceImpl(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i415.DeviceService>(
      () => _i279.DevDeviceServiceImpl(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i281.ImagePickerDataSource>(
        () => _i281.ImagePickerDataSourceImpl(gh<_i183.ImagePicker>()));
    gh.lazySingleton<_i741.AnalyticsLogger>(() => _i741.AnalyticsLoggerImpl());
    gh.lazySingleton<_i278.AuthService>(
      () => _i1025.DevAuthServiceImpl(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i664.BiometricsDataSource>(() =>
        _i664.BiometricsDataSourceImpl(
            localAuthentication: gh<_i152.LocalAuthentication>()));
    gh.lazySingleton<_i899.ProfileService>(
      () => _i279.DevProfileServiceImpl(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i760.RemoteConfigService>(
      () => _i104.DevRemoteConfigServiceImpl(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i795.SecureStorageDataSource>(() =>
        _i795.SecureStorageDataSourceImpl(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i600.PreferencesDataSource>(() =>
        _i600.PreferencesDataSourceImpl(
            preferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i764.NetworkInfoDataSource>(() =>
        _i764.NetworkInfoDataSourceImpl(
            connectivity: gh<_i895.Connectivity>()));
    gh.lazySingleton<_i850.FileManagerRepository>(
        () => _i2.FileManagerRepositoryImpl(gh<_i281.ImagePickerDataSource>()));
    gh.lazySingleton<_i787.PackageInfoDataSource>(
        () => _i787.PackageInfoDataSourceImpl(gh<_i655.PackageInfo>()));
    gh.lazySingleton<_i229.DeviceInfoDataSource>(
        () => _i229.DeviceInfoDataSourceImpl(gh<_i833.DeviceInfoPlugin>()));
    gh.lazySingleton<_i997.DestinationRepository>(() =>
        _i986.DestinationRepositoryImpl(gh<_i600.PreferencesDataSource>()));
    gh.lazySingleton<_i490.UserRepository>(
        () => _i875.UserRepositoryImpl(gh<_i600.PreferencesDataSource>()));
    gh.lazySingleton<_i442.AppUpdateRepository>(
        () => _i25.AppUpdateRepositoryImpl(
              gh<_i600.PreferencesDataSource>(),
              gh<_i655.PackageInfo>(),
            ));
    gh.lazySingleton<_i8.ApiClient>(
        () => _i1019.ApiClientImpl(gh<_i600.PreferencesDataSource>()));
    gh.factory<_i339.OnboardingBloc>(
        () => _i339.OnboardingBloc(gh<_i997.DestinationRepository>()));
    gh.lazySingleton<_i415.DeviceService>(
      () => _i593.DeviceServiceImpl(gh<_i8.ApiClient>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i278.AuthService>(
      () => _i548.AuthServiceImpl(
        gh<_i8.ApiClient>(),
        gh<_i600.PreferencesDataSource>(),
      ),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i659.FaqsService>(
      () => _i948.FaqsServiceImpl(gh<_i8.ApiClient>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i251.FaqsRepository>(
        () => _i859.FaqsRepositoryImpl(faqsService: gh<_i659.FaqsService>()));
    gh.lazySingleton<_i899.ProfileService>(
      () => _i928.ProfileServiceImpl(gh<_i8.ApiClient>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i760.RemoteConfigService>(
      () => _i169.RemoteConfigServiceImpl(gh<_i8.ApiClient>()),
      registerFor: {_prod},
    );
    gh.factory<_i179.FaqsBloc>(
        () => _i179.FaqsBloc(gh<_i251.FaqsRepository>()));
    gh.lazySingleton<_i1038.PictureRepository>(
        () => _i389.PictureRepositoryImpl(
              gh<_i899.ProfileService>(),
              gh<_i600.PreferencesDataSource>(),
              gh<_i764.NetworkInfoDataSource>(),
            ));
    gh.lazySingleton<_i681.LoginRepository>(() => _i432.LoginRepositoryImpl(
          authService: gh<_i278.AuthService>(),
          profileService: gh<_i899.ProfileService>(),
          secureStorage: gh<_i795.SecureStorageDataSource>(),
          biometrics: gh<_i664.BiometricsDataSource>(),
          preferences: gh<_i600.PreferencesDataSource>(),
          networkInfo: gh<_i764.NetworkInfoDataSource>(),
          deviceInfo: gh<_i229.DeviceInfoDataSource>(),
          analyticsLogger: gh<_i741.AnalyticsLogger>(),
        ));
    gh.lazySingleton<_i910.UserPermissionRepository>(
        () => _i1063.UserPermissionRepositoryImpl(
              gh<_i899.ProfileService>(),
              gh<_i600.PreferencesDataSource>(),
              gh<_i764.NetworkInfoDataSource>(),
            ));
    gh.factory<_i572.LoginBloc>(
        () => _i572.LoginBloc(loginRepository: gh<_i681.LoginRepository>()));
    gh.lazySingleton<_i79.RemoteConfigRepository>(
        () => _i8.RemoteConfigRepositoryImpl(
              gh<_i760.RemoteConfigService>(),
              gh<_i764.NetworkInfoDataSource>(),
              gh<_i600.PreferencesDataSource>(),
            ));
    gh.factory<_i426.SplashBloc>(() => _i426.SplashBloc(
          gh<_i997.DestinationRepository>(),
          gh<_i79.RemoteConfigRepository>(),
          gh<_i442.AppUpdateRepository>(),
        ));
    gh.factory<_i771.ProfilePictureBloc>(() => _i771.ProfilePictureBloc(
          gh<_i850.FileManagerRepository>(),
          gh<_i1038.PictureRepository>(),
        ));
    gh.factory<_i532.PictureNotFoundBloc>(() => _i532.PictureNotFoundBloc(
          gh<_i850.FileManagerRepository>(),
          gh<_i1038.PictureRepository>(),
        ));
    gh.lazySingleton<_i723.DigitalCardRepository>(
        () => _i925.DigitalCardRepositoryImpl(
              deviceInfo: gh<_i229.DeviceInfoDataSource>(),
              preferences: gh<_i600.PreferencesDataSource>(),
              profileService: gh<_i899.ProfileService>(),
            ));
    gh.factory<_i572.ChangeExternalPasswordBloc>(
        () => _i572.ChangeExternalPasswordBloc(gh<_i681.LoginRepository>()));
    gh.factory<_i583.UploadPictureBloc>(
        () => _i583.UploadPictureBloc(gh<_i1038.PictureRepository>()));
    gh.lazySingleton<_i567.SettingsRepository>(
        () => _i118.SettingsRepositoryImpl(
              packageInfo: gh<_i787.PackageInfoDataSource>(),
              preferences: gh<_i600.PreferencesDataSource>(),
              biometrics: gh<_i664.BiometricsDataSource>(),
              deviceService: gh<_i415.DeviceService>(),
              profileService: gh<_i899.ProfileService>(),
              networkInfo: gh<_i764.NetworkInfoDataSource>(),
              secureStorage: gh<_i795.SecureStorageDataSource>(),
            ));
    gh.factory<_i216.DigitalCardBloc>(() => _i216.DigitalCardBloc(
          gh<_i723.DigitalCardRepository>(),
          gh<_i910.UserPermissionRepository>(),
          gh<_i79.RemoteConfigRepository>(),
          gh<_i108.ScreenBrightness>(),
        ));
    gh.factory<_i4.SettingsBloc>(
        () => _i4.SettingsBloc(gh<_i567.SettingsRepository>()));
    gh.factory<_i228.SendMessageBloc>(
        () => _i228.SendMessageBloc(gh<_i567.SettingsRepository>()));
    return this;
  }
}

class _$AppModule extends _i46.AppModule {}
