import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:speed_dating_front/common/constant.dart';

class TokenProvider with ChangeNotifier {
  String? _token;
  final _storage = FlutterSecureStorage();
  bool _isLoading = false;

  String? get token => _token;
  bool get isLoading => _isLoading;

  TokenProvider() {
    loadToken();
  }

  Future<String?> getToken() async {
    final token = await _storage.read(key: TOKEN_KEY);
    return token;
  }

  Future<void> loadToken() async {
    _token = await _storage.read(key: TOKEN_KEY);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveToken(String token) async {
    _token = token;
    await _storage.write(key: TOKEN_KEY, value: token);
    notifyListeners();
  }

  Future<void> deleteToken() async {
    _token = null;
    await _storage.delete(key: TOKEN_KEY);
    notifyListeners();
  }
}
