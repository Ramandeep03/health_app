import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_app/constants/keys.dart';
import 'package:health_app/models/user_model.dart';
import 'package:health_app/providers/user_provider.dart';
import 'package:health_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class ManageProfileProvider extends ChangeNotifier {
  int _selectedProfileIndex = 0;

  int get selectedProfileIndex => _selectedProfileIndex;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  changeProfile(int newProfileIndex, BuildContext context) async {
    _isLoading = true;
    String currentUser = AuthServices.getUser()!.uid;
    await FirebaseFirestore.instance
        .collection(Keys.users)
        .doc(currentUser)
        .update({
      'currentProfile': newProfileIndex,
    });

    _selectedProfileIndex = newProfileIndex;
    // ignore: use_build_context_synchronously
    Provider.of<UserProvider>(context, listen: false)
        .setUserFromUser(users[newProfileIndex]);
    _isLoading = false;
    notifyListeners();
  }

  fetchData(BuildContext context) async {
    _isLoading = true;
    _users = [];
    List<UserModel> data = [];
    String id = AuthServices.getUser()!.uid;
    var currentUser =
        await FirebaseFirestore.instance.collection(Keys.users).doc(id).get();
    var getData = await FirebaseFirestore.instance
        .collection(Keys.users)
        .doc(id)
        .collection(Keys.profiles)
        .get();
    UserModel userModel = UserModel.fromJSON(currentUser.data()!);
    data.add(userModel);
    for (var item in getData.docs) {
      UserModel model = UserModel.fromJSON(item.data());
      data.add(model);
    }
    // ignore: use_build_context_synchronously
    changeProfile(userModel.currentProfle, context);
    _users = data;
    _isLoading = false;
    notifyListeners();
  }
}
