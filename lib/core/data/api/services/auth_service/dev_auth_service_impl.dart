import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/enums/flavor.dart';
import 'package:identidaddigital/core/data/api/request/login_request.dart';
import 'package:identidaddigital/core/data/api/response/api_response.dart';
import 'package:identidaddigital/core/data/api/services/auth_service/auth_service.dart';
import 'package:identidaddigital/core/data/models/user_model.dart';

@LazySingleton(as: AuthService)
@Environment(Env.dev)
class DevAuthServiceImpl implements AuthService {
  @override
  Future<Tuple2<UserModel, String>> login(LoginRequest request) async {
    final response = ApiResponse(
      status: ResponseStatus(code: 1, message: 'message'),
      data: {
        "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9",
        "expires_in": 1604292321,
        "registerPhone": {
          "status": {"code": 1, "message": "Registro de dispositivo"},
          "data": {
            "user_id": 3,
            "user_email_un": null,
            "user_email_ext": "test@mail.com",
            "user_uid": "123456",
            "user_phone_model": "test",
            "user_phone_brand": "AOSP on IA Emulator",
            "user_last_access": "hola",
            "updated_at": "2020-05-06 04:09:20.840",
            "created_at": "2020-05-06 04:09:20.840"
          }
        },
        "permission": {
          "status": {"code": 1, "message": "Permisos Obtenidos"},
          "data": {
            "id": "2000101010",
            "documento": "1010101010",
            "nombre": "Vladimir Stegantsov",
            "foto":
                "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",
            "perfilesnew": [
              {
                "name": "ES",
                "titulo": "Estudiante",
                "color": "650E81",
              },
              {
                "name": "EG",
                "titulo": "Egresado",
                "color": "E0AF28",
              },
              {
                "name": "DO",
                "titulo": "Docente",
                "color": "C41615",
              },
              {
                "name": "VT",
                "titulo": "Visitante",
                "color": "5DAF5E",
              },
              {
                "name": "CD",
                "titulo": "Consejo Directivo",
                "color": "00015C",
              },
              {
                "name": "CO",
                "titulo": "Contratista",
                "color": "E60485",
              },
              {
                "name": "FH",
                "titulo": "Colaborador HUN",
                "color": "00C2E7",
              },
            ]
          }
        }
      },
    );
    final String accessToken = response.data['access_token'];
    final userModel = UserModel.fromMap(response.data);
    return tuple2(userModel, accessToken);
  }
}
