import 'package:flutter/material.dart';
import 'package:health_app/constants/keys.dart';
import 'package:health_app/services/shared_pref_services.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  toggleTheme() async {
    bool result = await SharedPrefrencesServices.checkKey(key: Keys.isDarkMode);
    if (_isDark) {
      _isDark = false;
      if (result) {
        await SharedPrefrencesServices.changeBoolValue(
            key: Keys.isDarkMode, value: false);
      } else {
        await SharedPrefrencesServices.addBool(
            key: Keys.isDarkMode, value: false);
      }
    } else {
      _isDark = true;
      if (result) {
        await SharedPrefrencesServices.changeBoolValue(
            key: Keys.isDarkMode, value: true);
      } else {
        await SharedPrefrencesServices.addBool(
            key: Keys.isDarkMode, value: true);
      }
    }
    notifyListeners();
  }

  checkTheme() async {
    bool result = await SharedPrefrencesServices.checkKey(key: Keys.isDarkMode);
    if (result) {
      bool isDarkMode =
          await SharedPrefrencesServices.getBool(key: Keys.isDarkMode);
      _isDark = isDarkMode;
      notifyListeners();
    } else {
      _isDark = false;
      notifyListeners();
    }
  }
}
