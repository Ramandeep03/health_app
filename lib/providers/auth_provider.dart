import 'package:flutter/material.dart';

import 'package:health_app/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  String _phone = '';
  String get phone => _phone;

  String _otp = '';
  String get otp => _otp;

  bool _isValid = false;

  bool get isValid => _isValid;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void onChange(String value) {
    if (value.length < 10) {
      _isValid = false;
      _phone = value;
      notifyListeners();
    } else {
      _phone = value;
      _isValid = true;
      notifyListeners();
    }
  }

  setOTP(String value) {
    _otp = value;
    notifyListeners();
  }

  sendOtp(
    BuildContext context,
  ) async {
    _isLoading = true;
    notifyListeners();
    await AuthServices.sendOtp(context, '+91$_phone');

    _isLoading = false;
    notifyListeners();
  }

  login(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    await AuthServices.login(context, _otp);
    _isLoading = false;
    notifyListeners();
  }
}
