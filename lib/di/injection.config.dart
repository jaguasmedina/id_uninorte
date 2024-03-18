// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:data_connection_checker/data_connection_checker.dart' as _i6;
import 'package:device_info/device_info.dart' as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:identidaddigital/core/data/analytics/analytics.dart' as _i3;
import 'package:identidaddigital/core/data/api/client/api_client.dart' as _i41;
import 'package:identidaddigital/core/data/api/client/api_client_impl.dart'
    as _i42;
import 'package:identidaddigital/core/data/api/services/auth_service/auth_service.dart'
    as _i4;
import 'package:identidaddigital/core/data/api/services/auth_service/auth_service_impl.dart'
    as _i45;
import 'package:identidaddigital/core/data/api/services/auth_service/dev_auth_service_impl.dart'
    as _i5;
import 'package:identidaddigital/core/data/api/services/device_service/dev_device_service_impl.dart'
    as _i9;
import 'package:identidaddigital/core/data/api/services/device_service/device_service.dart'
    as _i8;
import 'package:identidaddigital/core/data/api/services/device_service/device_service_impl.dart'
    as _i48;
import 'package:identidaddigital/core/data/api/services/faqs_service/dev_faqs_service_impl.dart'
    as _i11;
import 'package:identidaddigital/core/data/api/services/faqs_service/faqs_service.dart'
    as _i10;
import 'package:identidaddigital/core/data/api/services/faqs_service/faqs_service_impl.dart'
    as _i52;
import 'package:identidaddigital/core/data/api/services/profile_service/dev_profile_service_impl.dart'
    as _i20;
import 'package:identidaddigital/core/data/api/services/profile_service/profile_service.dart'
    as _i19;
import 'package:identidaddigital/core/data/api/services/profile_service/profile_service_impl.dart'
    as _i59;
import 'package:identidaddigital/core/data/api/services/remote_config_service/dev_remote_config_service_impl.dart'
    as _i22;
import 'package:identidaddigital/core/data/api/services/remote_config_service/remote_config_service.dart'
    as _i21;
import 'package:identidaddigital/core/data/api/services/remote_config_service/remote_config_service_impl.dart'
    as _i60;
import 'package:identidaddigital/core/data/data_sources/biometrics_data_source.dart'
    as _i26;
import 'package:identidaddigital/core/data/data_sources/device_info_data_source.dart'
    as _i27;
import 'package:identidaddigital/core/data/data_sources/network_info_data_source.dart'
    as _i16;
import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart'
    as _i32;
import 'package:identidaddigital/core/data/data_sources/secure_storage_data_source.dart'
    as _i24;
import 'package:identidaddigital/core/data/repositories/app_update_repository_impl.dart'
    as _i44;
import 'package:identidaddigital/core/data/repositories/destination_repository_impl.dart'
    as _i47;
import 'package:identidaddigital/core/data/repositories/remote_config_repository_impl.dart'
    as _i34;
import 'package:identidaddigital/core/data/repositories/user_permission_repository_impl.dart'
    as _i38;
import 'package:identidaddigital/core/data/repositories/user_repository_impl.dart'
    as _i40;
import 'package:identidaddigital/core/domain/repositories/app_update_repository.dart'
    as _i43;
import 'package:identidaddigital/core/domain/repositories/destination_repository.dart'
    as _i46;
import 'package:identidaddigital/core/domain/repositories/remote_config_repository.dart'
    as _i33;
import 'package:identidaddigital/core/domain/repositories/user_permission_repository.dart'
    as _i37;
import 'package:identidaddigital/core/domain/repositories/user_repository.dart'
    as _i39;
import 'package:identidaddigital/di/injection.dart' as _i69;
import 'package:identidaddigital/features/auth/data/repositories/login_repository_impl.dart'
    as _i54;
import 'package:identidaddigital/features/auth/domain/repositories/login_repository.dart'
    as _i53;
import 'package:identidaddigital/features/auth/presentation/bloc/change_external_password_bloc.dart'
    as _i65;
import 'package:identidaddigital/features/auth/presentation/bloc/login_bloc.dart'
    as _i67;
import 'package:identidaddigital/features/digital_card/data/repositories/digital_card_repository_impl.dart'
    as _i50;
import 'package:identidaddigital/features/digital_card/domain/repositories/digital_card_repository.dart'
    as _i49;
import 'package:identidaddigital/features/digital_card/presentation/bloc/digital_card_bloc.dart'
    as _i66;
import 'package:identidaddigital/features/faqs/data/repositories/faqs_repository_impl.dart'
    as _i29;
import 'package:identidaddigital/features/faqs/domain/repositories/faqs_repository.dart'
    as _i28;
import 'package:identidaddigital/features/faqs/presentation/bloc/faqs_bloc.dart'
    as _i51;
import 'package:identidaddigital/features/onboarding/presentation/bloc/onboarding_bloc.dart'
    as _i55;
import 'package:identidaddigital/features/profile_picture/data/data_sources/image_picker_data_source.dart'
    as _i14;
import 'package:identidaddigital/features/profile_picture/data/repositories/file_manager_repository_impl.dart'
    as _i31;
import 'package:identidaddigital/features/profile_picture/data/repositories/picture_repository_impl.dart'
    as _i57;
import 'package:identidaddigital/features/profile_picture/domain/repositories/file_manager_repository.dart'
    as _i30;
import 'package:identidaddigital/features/profile_picture/domain/repositories/picture_repository.dart'
    as _i56;
import 'package:identidaddigital/features/profile_picture/presentation/bloc/picture_not_found_bloc.dart'
    as _i68;
import 'package:identidaddigital/features/profile_picture/presentation/bloc/profile_picture_bloc.dart'
    as _i58;
import 'package:identidaddigital/features/profile_picture/presentation/bloc/upload_picture_bloc.dart'
    as _i64;
import 'package:identidaddigital/features/settings/data/data_sources/package_info_data_source.dart'
    as _i18;
import 'package:identidaddigital/features/settings/data/repositories/settings_repository_impl.dart'
    as _i36;
import 'package:identidaddigital/features/settings/domain/repositories/settings_repository.dart'
    as _i35;
import 'package:identidaddigital/features/settings/presentation/bloc/send_message_bloc.dart'
    as _i61;
import 'package:identidaddigital/features/settings/presentation/bloc/settings_bloc.dart'
    as _i62;
import 'package:identidaddigital/features/splash/presentation/bloc/splash_bloc.dart'
    as _i63;
import 'package:image_picker/image_picker.dart' as _i13;
import 'package:injectable/injectable.dart' as _i2;
import 'package:local_auth/local_auth.dart' as _i15;
import 'package:package_info/package_info.dart' as _i17;
import 'package:screen_brightness/screen_brightness.dart' as _i23;
import 'package:shared_preferences/shared_preferences.dart' as _i25;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.lazySingleton<_i3.AnalyticsLogger>(() => _i3.AnalyticsLoggerImpl());
  gh.lazySingleton<_i4.AuthService>(() => _i5.DevAuthServiceImpl(),
      registerFor: {_dev});
  gh.lazySingleton<_i6.DataConnectionChecker>(
      () => appModule.dataConnectionChecker);
  gh.lazySingleton<_i7.DeviceInfoPlugin>(() => appModule.deviceInfoPlugin);
  gh.lazySingleton<_i8.DeviceService>(() => _i9.DevDeviceServiceImpl(),
      registerFor: {_dev});
  gh.lazySingleton<_i10.FaqsService>(() => _i11.DevFaqsServiceImpl(),
      registerFor: {_dev});
  gh.lazySingleton<_i12.FlutterSecureStorage>(() => appModule.secureStorage);
  gh.lazySingleton<_i13.ImagePicker>(() => appModule.imagePicker);
  gh.lazySingleton<_i14.ImagePickerDataSource>(
      () => _i14.ImagePickerDataSourceImpl(get<_i13.ImagePicker>()));
  gh.lazySingleton<_i15.LocalAuthentication>(
      () => appModule.localAuthentication);
  gh.lazySingleton<_i16.NetworkInfoDataSource>(() =>
      _i16.NetworkInfoDataSourceImpl(
          connectionChecker: get<_i6.DataConnectionChecker>()));
  await gh.lazySingletonAsync<_i17.PackageInfo>(() => appModule.packageInfo,
      preResolve: true);
  gh.lazySingleton<_i18.PackageInfoDataSource>(
      () => _i18.PackageInfoDataSourceImpl(get<_i17.PackageInfo>()));
  gh.lazySingleton<_i19.ProfileService>(() => _i20.DevProfileServiceImpl(),
      registerFor: {_dev});
  gh.lazySingleton<_i21.RemoteConfigService>(
      () => _i22.DevRemoteConfigServiceImpl(),
      registerFor: {_dev});
  gh.lazySingleton<_i23.ScreenBrightness>(() => appModule.screenBrightness);
  gh.lazySingleton<_i24.SecureStorageDataSource>(
      () => _i24.SecureStorageDataSourceImpl(get<_i12.FlutterSecureStorage>()));
  await gh.lazySingletonAsync<_i25.SharedPreferences>(() => appModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i26.BiometricsDataSource>(() =>
      _i26.BiometricsDataSourceImpl(
          localAuthentication: get<_i15.LocalAuthentication>()));
  gh.lazySingleton<_i27.DeviceInfoDataSource>(
      () => _i27.DeviceInfoDataSourceImpl(get<_i7.DeviceInfoPlugin>()));
  gh.lazySingleton<_i28.FaqsRepository>(
      () => _i29.FaqsRepositoryImpl(faqsService: get<_i10.FaqsService>()));
  gh.lazySingleton<_i30.FileManagerRepository>(
      () => _i31.FileManagerRepositoryImpl(get<_i14.ImagePickerDataSource>()));
  gh.lazySingleton<_i32.PreferencesDataSource>(() =>
      _i32.PreferencesDataSourceImpl(
          preferences: get<_i25.SharedPreferences>()));
  gh.lazySingleton<_i33.RemoteConfigRepository>(() =>
      _i34.RemoteConfigRepositoryImpl(
          get<_i21.RemoteConfigService>(),
          get<_i16.NetworkInfoDataSource>(),
          get<_i32.PreferencesDataSource>()));
  gh.lazySingleton<_i35.SettingsRepository>(() => _i36.SettingsRepositoryImpl(
      packageInfo: get<_i18.PackageInfoDataSource>(),
      preferences: get<_i32.PreferencesDataSource>(),
      biometrics: get<_i26.BiometricsDataSource>(),
      deviceService: get<_i8.DeviceService>(),
      profileService: get<_i19.ProfileService>(),
      networkInfo: get<_i16.NetworkInfoDataSource>(),
      secureStorage: get<_i24.SecureStorageDataSource>()));
  gh.lazySingleton<_i37.UserPermissionRepository>(() =>
      _i38.UserPermissionRepositoryImpl(
          get<_i19.ProfileService>(),
          get<_i32.PreferencesDataSource>(),
          get<_i16.NetworkInfoDataSource>()));
  gh.lazySingleton<_i39.UserRepository>(
      () => _i40.UserRepositoryImpl(get<_i32.PreferencesDataSource>()));
  gh.lazySingleton<_i41.ApiClient>(
      () => _i42.ApiClientImpl(get<_i32.PreferencesDataSource>()));
  gh.lazySingleton<_i43.AppUpdateRepository>(() => _i44.AppUpdateRepositoryImpl(
      get<_i32.PreferencesDataSource>(), get<_i17.PackageInfo>()));
  gh.lazySingleton<_i4.AuthService>(
      () => _i45.AuthServiceImpl(
          get<_i41.ApiClient>(), get<_i32.PreferencesDataSource>()),
      registerFor: {_prod});
  gh.lazySingleton<_i46.DestinationRepository>(
      () => _i47.DestinationRepositoryImpl(get<_i32.PreferencesDataSource>()));
  gh.lazySingleton<_i8.DeviceService>(
      () => _i48.DeviceServiceImpl(get<_i41.ApiClient>()),
      registerFor: {_prod});
  gh.lazySingleton<_i49.DigitalCardRepository>(() =>
      _i50.DigitalCardRepositoryImpl(
          deviceInfo: get<_i27.DeviceInfoDataSource>(),
          preferences: get<_i32.PreferencesDataSource>(),
          profileService: get<_i19.ProfileService>()));
  gh.factory<_i51.FaqsBloc>(() => _i51.FaqsBloc(get<_i28.FaqsRepository>()));
  gh.lazySingleton<_i10.FaqsService>(
      () => _i52.FaqsServiceImpl(get<_i41.ApiClient>()),
      registerFor: {_prod});
  gh.lazySingleton<_i53.LoginRepository>(() => _i54.LoginRepositoryImpl(
      authService: get<_i4.AuthService>(),
      profileService: get<_i19.ProfileService>(),
      secureStorage: get<_i24.SecureStorageDataSource>(),
      biometrics: get<_i26.BiometricsDataSource>(),
      preferences: get<_i32.PreferencesDataSource>(),
      networkInfo: get<_i16.NetworkInfoDataSource>(),
      deviceInfo: get<_i27.DeviceInfoDataSource>(),
      analyticsLogger: get<_i3.AnalyticsLogger>()));
  gh.factory<_i55.OnboardingBloc>(
      () => _i55.OnboardingBloc(get<_i46.DestinationRepository>()));
  gh.lazySingleton<_i56.PictureRepository>(() => _i57.PictureRepositoryImpl(
      get<_i19.ProfileService>(),
      get<_i32.PreferencesDataSource>(),
      get<_i16.NetworkInfoDataSource>()));
  gh.factory<_i58.ProfilePictureBloc>(() => _i58.ProfilePictureBloc(
      get<_i30.FileManagerRepository>(), get<_i56.PictureRepository>()));
  gh.lazySingleton<_i19.ProfileService>(
      () => _i59.ProfileServiceImpl(get<_i41.ApiClient>()),
      registerFor: {_prod});
  gh.lazySingleton<_i21.RemoteConfigService>(
      () => _i60.RemoteConfigServiceImpl(get<_i41.ApiClient>()),
      registerFor: {_prod});
  gh.factory<_i61.SendMessageBloc>(
      () => _i61.SendMessageBloc(get<_i35.SettingsRepository>()));
  gh.factory<_i62.SettingsBloc>(
      () => _i62.SettingsBloc(get<_i35.SettingsRepository>()));
  gh.factory<_i63.SplashBloc>(() => _i63.SplashBloc(
      get<_i46.DestinationRepository>(),
      get<_i33.RemoteConfigRepository>(),
      get<_i43.AppUpdateRepository>()));
  gh.factory<_i64.UploadPictureBloc>(
      () => _i64.UploadPictureBloc(get<_i56.PictureRepository>()));
  gh.factory<_i65.ChangeExternalPasswordBloc>(
      () => _i65.ChangeExternalPasswordBloc(get<_i53.LoginRepository>()));
  gh.factory<_i66.DigitalCardBloc>(() => _i66.DigitalCardBloc(
      get<_i49.DigitalCardRepository>(),
      get<_i37.UserPermissionRepository>(),
      get<_i33.RemoteConfigRepository>(),
      get<_i23.ScreenBrightness>()));
  gh.factory<_i67.LoginBloc>(
      () => _i67.LoginBloc(loginRepository: get<_i53.LoginRepository>()));
  gh.factory<_i68.PictureNotFoundBloc>(() => _i68.PictureNotFoundBloc(
      get<_i30.FileManagerRepository>(), get<_i56.PictureRepository>()));
  return get;
}

class _$AppModule extends _i69.AppModule {}
