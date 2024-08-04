import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:speed_dating_front/authentication/model/user.dart';

class AuthService {
  Future<HttpResponse> requestSmsVerification(
      String phoneNumber, String countryCode) async {
    final url =
        Uri.parse('http://localhost:8080/api/v1/auth/sms-verification/request');
    final headers = {'Content-Type': 'application/json'};
    final body =
        '{"phoneNumber": "$phoneNumber", "countryCode": "$countryCode"}';

    final response = await http.post(url, body: body, headers: headers);

    if (response.statusCode == HttpStatus.created) {
      return HttpResponse(isSuccess: true);
    } else {
      return HttpResponse(isSuccess: false);
    }
  }

  Future<HttpResponse> verifyPinCode(
      String phoneNumber, String verificationCode) async {
    final url =
        Uri.parse('http://localhost:8080/api/v1/auth/sms-verification/verify');
    final headers = {'Content-Type': 'application/json'};
    final body =
        '{"phoneNumber": "$phoneNumber", "verifyCode": "$verificationCode"}';

    final response = await http.post(url, body: body, headers: headers);
    print(response.body);
    if (response.statusCode == 201) {
      return HttpResponse(isSuccess: true);
    } else {
      return HttpResponse(isSuccess: false);
    }
  }

  Future<HttpResponse> requestUserCreation(UserModel userModel) async {
    final url = Uri.parse('http://localhost:8080/api/v1/user/signup');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(userModel.toJson());

    final response = await http.post(url, body: body, headers: headers);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      return HttpResponse(isSuccess: true);
    } else {
      return HttpResponse(isSuccess: false);
    }
  }
}

class HttpResponse {
  final bool isSuccess;

  HttpResponse({required this.isSuccess});
}
