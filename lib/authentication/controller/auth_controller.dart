import 'package:speed_dating_front/authentication/model/user.dart';
import 'package:speed_dating_front/authentication/services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<bool> sendUserCreation(UserModel userModel) async {
    try {
      final response = await _authService.requestUserCreation(userModel);

      return response.isSuccess;
    } catch (e) {
      return false;
    }
  }

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
