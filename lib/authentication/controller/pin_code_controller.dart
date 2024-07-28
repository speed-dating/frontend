// controllers/pin_code_controller.dart

import 'package:speed_dating_front/authentication/services/auth_service.dart';

class PinCodeController {
  final AuthService _authService = AuthService();

  Future<bool> verifyPinCode(
      String phoneNumber, String verificationCode) async {
    try {
      final response =
          await _authService.verifyPinCode(phoneNumber, verificationCode);
      return response.isSuccess;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
