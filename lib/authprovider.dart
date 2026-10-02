import 'package:flutter/material.dart';

class AuthProviders extends ChangeNotifier {
  bool _isPasswordVisible = false;
  bool _isconfirmpassword = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isconfirmpassword => _isconfirmpassword;

  void toggleconfirmpassword() {
    _isconfirmpassword = !_isconfirmpassword;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }
}
