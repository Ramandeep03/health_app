import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_app/constants/keys.dart';
import 'package:health_app/models/appointment_model.dart';
import 'package:health_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';

class AppointmentProvider extends ChangeNotifier {
  List<AppointmentModel> _appointments = [];

  List<AppointmentModel> get appointments => _appointments;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  fetchData(BuildContext context) async {
    _appointments = [];
    _isLoading = true;
    String mainUserId = AuthServices.getUser()!.uid;
    String currentUserId =
        Provider.of<UserProvider>(context, listen: false).user!.id;

    List<AppointmentModel> fetchedDate = [];
    if (currentUserId == mainUserId) {
      var data = await FirebaseFirestore.instance
          .collection(Keys.users)
          .doc(mainUserId)
          .collection(Keys.appointments)
          .get();
      for (var i in data.docs) {
        fetchedDate.add(AppointmentModel.fromJSON(i.data()));
      }
    } else {
      var data = await FirebaseFirestore.instance
          .collection(Keys.users)
          .doc(mainUserId)
          .collection(Keys.profiles)
          .doc(currentUserId)
          .collection(Keys.appointments)
          .get();
      for (var i in data.docs) {
        fetchedDate.add(AppointmentModel.fromJSON(i.data()));
      }
    }
    _appointments = fetchedDate;
    _isLoading = false;
    notifyListeners();
  }
}
