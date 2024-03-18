abstract class ApiRoutes {
  static const _api = '/app/api';
  static const String login = '$_api/login';
  static const String loginPortal = '$_api/loginPortal';
  static const String unlinkDevice = '$_api/auth/unlinkDevice';
  static const String uploadPhoto = '$_api/auth/uploadPhoto';
  static const String getUserPermission = '$_api/auth/getUserPermission';
  static const String photoStates = '$_api/auth/photoStates';
  static const String sendRequestCard = '$_api/auth/sendRequestCard';
  static const String changePasswordForExternalUser =
      '$_api/auth/changePassword';
  static const String getFaqs = '$_api/getFaqs';
  static const String getExternalFaqs = '$_api/getFaqse';
  static const String encodeQR = '$_api/auth/encodeQR';
  static const String getRemoteConfig = '$_api/getRemoteConfig';
}
