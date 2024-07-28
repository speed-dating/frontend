import 'dart:io';

import 'package:http/http.dart' as http;

class AuthService {
  Future<HttpResponse> requestSmsVerification(
      String phoneNumber, String countryCode) async {
    final url =
        Uri.parse('http://localhost:8080/api/v1/auth/sms-verification/request');
    final headers = {'Content-Type': 'application/json'};
    final body =
        '{"phoneNumber": "$phoneNumber", "countryCode": "$countryCode"}';

    final response = await http.post(url, body: body, headers: headers);

    return HttpResponse(isSuccess: false);

    if (response.statusCode == HttpStatus.created) {
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
