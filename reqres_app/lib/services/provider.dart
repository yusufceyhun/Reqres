import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<void> checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    print(token.toString() + " get provider");

    notifyListeners();
  }

  Future<void> setToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = token;
    await prefs.setString('token', token ?? '');
    print(token.toString() + " set provider");

    notifyListeners();
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _token = null;
    print('Token removed from SharedPreferences');
    notifyListeners();
  }
}
