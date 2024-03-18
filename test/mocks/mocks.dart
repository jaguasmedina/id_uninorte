import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info/package_info.dart';

import 'package:identidaddigital/core/data/analytics/analytics.dart';
import 'package:identidaddigital/core/data/api/client/api_client.dart';
import 'package:identidaddigital/core/data/api/services/auth_service/auth_service.dart';
import 'package:identidaddigital/core/data/api/services/device_service/device_service.dart';
import 'package:identidaddigital/core/data/api/services/profile_service/profile_service.dart';
import 'package:identidaddigital/core/data/data_sources/biometrics_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/device_info_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/network_info_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart';
import 'package:identidaddigital/core/data/data_sources/secure_storage_data_source.dart';
import 'package:identidaddigital/features/settings/data/data_sources/package_info_data_source.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockApiClient extends Mock implements ApiClient {}

class MockAuthService extends Mock implements AuthService {}

class MockDeviceService extends Mock implements DeviceService {}

class MockProfileService extends Mock implements ProfileService {}

class MockBiometricsDataSource extends Mock implements BiometricsDataSource {}

class MockSecureStorageDataSource extends Mock
    implements SecureStorageDataSource {}

class MockPreferencesDataSource extends Mock implements PreferencesDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfoDataSource {}

class MockDeviceInfo extends Mock implements DeviceInfoDataSource {}

class MockPackageInfo extends Mock implements PackageInfo {}

class MockPackageInfoDataSource extends Mock implements PackageInfoDataSource {}

class MockAnalyticsLogger extends Mock implements AnalyticsLogger {}
