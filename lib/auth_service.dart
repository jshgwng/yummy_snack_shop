import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yummy_snack_shop/user.dart';

class AuthService extends ChangeNotifier {
  SharedPreferences? _prefs;
  User? _currentUser;

  AuthService() {
    _loadCurrentUser();
  }

  Future<void> _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  void _loadCurrentUser() {
    final savedUsername = _prefs?.getString('username');
    final savedPassword = _prefs?.getString('password');

    if (savedUsername != null && savedPassword != null) {
      _currentUser = User(username: savedUsername, password: savedPassword);
    }
  }

  User? get currentUser => _currentUser;

  Future<bool> signUp(String username, String password) async {
    await _initPrefs();
    await _prefs?.setString('username', username);
    await _prefs?.setString('password', password);
    _currentUser = User(username: username, password: password);
    notifyListeners();
    return true; // Simulate success
  }

  Future<bool> login(String username, String password) async {
    await _initPrefs();
    final savedUsername = _prefs?.getString('username');
    final savedPassword = _prefs?.getString('password');

    if (savedUsername == username && savedPassword == password) {
      _currentUser = User(username: username, password: password);
      notifyListeners();
      return true; // Login successful
    } else {
      return false; // Login failed
    }
  }

  void logout() async {
    await _initPrefs();
    await _prefs?.remove('username');
    await _prefs?.remove('password');
    _currentUser = null;
    notifyListeners();
  }
}
