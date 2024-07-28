import 'package:speed_dating_front/authentication/services/auth_service.dart';

class PhoneNumberController {
  final AuthService _authService = AuthService();

  bool isValidPhoneNumber(String phoneNumber) {
    return phoneNumber.startsWith("010") && phoneNumber.length == 11;
  }

  Future<bool> sendPhoneNumber(String phoneNumber) async {
    try {
      final response =
          await _authService.requestSmsVerification(phoneNumber, '+82');

      return response.isSuccess;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
