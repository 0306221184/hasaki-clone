import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/abstracts/auth_service.dart';
import 'package:frontend/core/services/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService.local();
  UserType? _currentUser;

  UserType? get currentUser => _currentUser;
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    if (accessToken != null) {
      final decodedToken = JWT.decode(accessToken);
      final userId = decodedToken.payload['id'] as int;
      _currentUser = UserType(
          id: userId,
          roleId: decodedToken.payload['roleId'] as int,
          email: decodedToken.payload['email'] as String,
          isEmailVerified: false,
          isDisabled: false,
          isDeleted: false,
          username: "username",
          avatar: "avatar",
          fullName: "fullName",
          phoneNumber: "phoneNumber",
          provider: "provider",
          providerId: "providerId");
    }
    notifyListeners();
  }

  Future<void> fetchCurrentUser() async {
    _currentUser = _authService.currentUser;
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    try {
      _currentUser =
          await _authService.createUser(email: email, password: password);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'access_token', _currentUser!.accessToken as String);
    } catch (e) {
      throw Exception('Đăng ký thất bại: $e');
    }
  }

  Future<void> login(String email, String password) async {
    _currentUser = await _authService.login(email: email, password: password);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', _currentUser!.accessToken as String);
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    notifyListeners();
  }
}
