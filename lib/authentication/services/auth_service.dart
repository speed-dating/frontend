import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:speed_dating_front/authentication/model/user.dart';
import 'package:speed_dating_front/authentication/model/user_verification.dart';
import 'package:speed_dating_front/common/models/api_response.dart';
import 'package:speed_dating_front/common/provider/token_provider.dart';
import 'package:speed_dating_front/common/provider/user_provider.dart';

class AuthService {
  Future<HttpResponse> requestSmsVerification(
      String phoneNumber, String countryCode) async {
    final url =
        Uri.parse('http://localhost:8080/api/v1/auth/sms-verification/request');
    final headers = {'Content-Type': 'application/json'};
    final body =
        '{"phoneNumber": "$phoneNumber", "countryCode": "$countryCode"}';

    final response = await http.post(url, body: body, headers: headers);
    print(response.statusCode);
    if (response.statusCode == HttpStatus.created) {
      return HttpResponse<void>(null, isSuccess: true);
    } else {
      return HttpResponse<void>(null, isSuccess: false);
    }
  }

  Future<HttpResponse<UserVerificationResponse>> verifyPinCode(
      String phoneNumber, String verificationCode) async {
    final url =
        Uri.parse('http://localhost:8080/api/v1/auth/sms-verification/verify');
    final headers = {'Content-Type': 'application/json'};
    final body =
        '{"phoneNumber": "$phoneNumber", "verifyCode": "$verificationCode"}';

    final response = await http.post(url, body: body, headers: headers);

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final apiResponse = ApiResponse.fromJson(
        responseData,
        (jsonData) =>
            UserVerificationResponse.fromJson(jsonData as Map<String, dynamic>),
      );
      TokenProvider().saveToken(apiResponse.data?.token?.accessToken ?? '');
      UserProvider().setUser(apiResponse.data?.user);

      return HttpResponse<UserVerificationResponse>(
        apiResponse.data,
        isSuccess: true,
      );
    } else {
      return HttpResponse<UserVerificationResponse>(
        null,
        isSuccess: false,
      );
    }
  }

  Future<HttpResponse> requestUserCreation(UserModel userModel) async {
    final url = Uri.parse('http://localhost:8080/api/v1/user/signup');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(userModel.toJson());

    final response = await http.post(url, body: body, headers: headers);

    if (response.statusCode == 201) {
      return HttpResponse<void>(null, isSuccess: true);
    } else {
      return HttpResponse<void>(null, isSuccess: false);
    }
  }
}

class HttpResponse<T> {
  final bool isSuccess;
  final T? data;

  HttpResponse(this.data, {required this.isSuccess});
}
