import 'package:speed_dating_front/authentication/model/user.dart';

class UserVerificationResponse {
  final TokenInfo? token;
  final UserModel? user;

  UserVerificationResponse({this.token, this.user});

  factory UserVerificationResponse.fromJson(Map<String, dynamic> json) {
    return UserVerificationResponse(
      token: json['token'] != null ? TokenInfo.fromJson(json['token']) : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token?.toJson(),
      'user': user?.toJson(),
    };
  }
}

class TokenInfo {
  final String grantType;
  final String accessToken;

  TokenInfo({required this.grantType, required this.accessToken});

  factory TokenInfo.fromJson(Map<String, dynamic> json) {
    return TokenInfo(
      grantType: json['grantType'],
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'grantType': grantType,
      'accessToken': accessToken,
    };
  }
}
