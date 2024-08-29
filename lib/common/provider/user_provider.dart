import 'package:flutter/material.dart';
import 'package:speed_dating_front/authentication/model/user.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners(); // UI 업데이트를 위해 호출
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
