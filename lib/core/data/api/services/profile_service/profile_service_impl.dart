import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/data/api/client/api_client.dart';
import 'package:identidaddigital/core/data/api/constants/api_routes.dart';
import 'package:identidaddigital/core/data/api/services/profile_service/profile_service.dart';
import 'package:identidaddigital/core/data/models/models.dart';
import 'package:identidaddigital/core/enums/flavor.dart';
import 'package:identidaddigital/core/error/exceptions.dart';
import 'package:identidaddigital/core/extensions/file_extension.dart';

@LazySingleton(as: ProfileService)
@Environment(Env.prod)
class ProfileServiceImpl implements ProfileService {
  final ApiClient client;

  ProfileServiceImpl(this.client);

  @override
  Future<PictureStatusModel> requestPictureStatus(String document) async {
    final response = await client.post<Map>(
      ApiRoutes.photoStates,
      body: <String, String>{'code': document},
    );
    if (response.isSuccessful) {
      return PictureStatusModel.fromMap(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserPermissionModel> requestUserPermission(
    String id,
    String email,
  ) async {
    final response = await client.getUrl<Map>(
      ApiRoutes.getUserPermission,
      queryParameters: {
        'code': id,
        'email': email,
      },
    );
    if (response.isSuccessful) {
      return UserPermissionModel.fromMap(response.data);
    } else {
      throw PermissionNotFoundException();
    }
  }

  @override
  Future<void> uploadPicture(String userId, File image) async {
    final uri = Uri.parse(client.joinBaseUrl(ApiRoutes.uploadPhoto));
    final request = http.MultipartRequest('POST', uri);
    final multipartFile = await image.toMultipartFile('image');
    request.fields['code'] = userId;
    request.files.add(multipartFile);
    final response = await client.send<Map>(request);
    if (response.isSuccessful) {
      return;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> changePasswordForExternalUser(
    AuthCredentialsModel credentials,
  ) async {
    final response = await client.post<Map>(
      ApiRoutes.changePasswordForExternalUser,
      body: credentials.toMap(),
    );
    if (response.isUnsuccessful) {
      throw ServerException();
    }
  }

  @override
  Future<void> sendMessageToContactCenter(MessageModel message) async {
    final response = await client.post<Map>(
      ApiRoutes.sendRequestCard,
      body: message.toMap(),
    );
    if (response.status.code == -1) {
      throw EmailNotFoundException();
    }
    if (response.isUnsuccessful) {
      throw ServerException();
    }
  }

  @override
  Future<String> encodeAccessInfo(String id, int timestamp) async {
    final response = await client.post<String>(
      ApiRoutes.encodeQR,
      body: <String, Object>{
        'code': id,
        'timestamp': timestamp,
      },
    );

    if (response.isSuccessful) {
      return response.data;
    } else {
      throw ServerException(response.status.message);
    }
  }
}
