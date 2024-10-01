import 'package:tasky_app/feature/auth/login/model/auth_model.dart';

class RegisterResponse extends AuthResponse {
  final String displayName;

  RegisterResponse({
    required super.id,
    required super.accessToken,
    required super.refreshToken,
    required this.displayName,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      id: json['_id'] ?? '',
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      displayName: json['displayName'] ?? '',
    );
  }
}
