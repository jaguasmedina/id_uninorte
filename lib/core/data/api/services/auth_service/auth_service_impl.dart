import 'package:dartz/dartz.dart';
import 'package:identidaddigital/core/data/data_sources/preferences_data_source.dart';
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/client/api_client.dart';
import 'package:identidaddigital/core/data/api/constants/api_routes.dart';
import 'package:identidaddigital/core/data/api/request/login_request.dart';
import 'package:identidaddigital/core/data/api/response/api_response.dart';
import 'package:identidaddigital/core/data/api/services/auth_service/auth_service.dart';
import 'package:identidaddigital/core/data/models/user_model.dart';
import 'package:identidaddigital/core/enums/flavor.dart';
import 'package:identidaddigital/core/error/exceptions.dart';

@LazySingleton(as: AuthService)
@Environment(Env.prod)
class AuthServiceImpl implements AuthService {
  final ApiClient client;
  final PreferencesDataSource preferences;

  AuthServiceImpl(this.client, this.preferences,);

  @override
  Future<Tuple2<UserModel, String>> login(LoginRequest request) async {
    final ApiResponse<Map> response = await client.post(
      ApiRoutes.login,
      body: request.toMap(),
    );
    if (response.status.code == -1) {

      ///Get Token to Unlink Device
      final ApiResponse<Map> response = await client.post(
        ApiRoutes.loginPortal,
        body: request.toMap(),
      );

      ///Set Email for Unlink Device
      preferences.userEmail = request.credentials.username;
      preferences.authToken = response.data['access_token'];

      throw DeviceAlreadyInUseException();
    } else if (response.status.code == 401) {
      throw NotAuthorizedException();
    } else if (response.status.code == -2) {
      throw AuthRequestException();
    } else if (response.isSuccessful) {
      final String accessToken = response.data['access_token'];
      final userModel = UserModel.fromMap(response.data);
      return tuple2(userModel, accessToken);
    } else {
      throw ServerException();
    }
  }
}
