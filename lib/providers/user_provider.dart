import 'package:flutter/material.dart';
import 'package:health_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  setUserFeromJson(Map<String, dynamic> map) {
    UserModel data = UserModel.fromJSON(map);
    _user = data;
    notifyListeners();
  }

  setUserFromUser(UserModel data) {
    _user = data;
    notifyListeners();
  }

  
}
