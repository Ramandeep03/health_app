import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_app/constants/keys.dart';
import 'package:health_app/models/appointment_model.dart';
import 'package:health_app/models/doctor_model.dart';
import 'package:health_app/providers/user_provider.dart';
import 'package:health_app/routes/routes_constants.dart';
import 'package:health_app/services/auth_services.dart';
import 'package:health_app/services/message_service.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class AddAppointmentProvider extends ChangeNotifier {
  String _search = '';

  String get search => _search;

  final List<String> _time = const [
    '8:00AM - 10:00AM',
    '10:00AM - 12:00PM',
    '12:00PM - 2:00PM',
    '2:00PM - 4:00PM',
  ];

  List<String> get times => _time;
  int _selectedTime = -1;
  int get selectedTime => _selectedTime;
  List<String> _allItems = [];

  List<String> get allItems => _allItems;

  List<String> _hints = [];

  List<String> get hints => _hints;

  bool _loading = false;

  bool get loading => _loading;

  List<DoctorModel> _doctors = [];

  List<DoctorModel> get doctors => _doctors;

  bool _doctorLoading = false;
  bool get doctorLoading => _doctorLoading;

  int _selectedDoctor = -1;

  int get selectedDoctor => _selectedDoctor;

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  bool _booking = false;
  bool get booking => _booking;

  setTime(int index) {
    _selectedTime = index;
    notifyListeners();
  }

  setDate(DateTime time) {
    _selectedDate = time;
    notifyListeners();
  }

  setDoctor(int index) {
    _selectedDoctor = index;
    notifyListeners();
  }

  fetchData() async {
    _loading = true;
    _allItems = [];
    _hints = [];
    List<String> fetchedData = [];
    var data =
        await FirebaseFirestore.instance.collection(Keys.speaclities).get();
    for (var item in data.docs) {
      fetchedData.add(item['name']);
    }
    _allItems = fetchedData;
    _loading = false;
    notifyListeners();
  }

  searchList(String query) {
    _hints = [];
    List<String> result = _allItems.where((element) {
      return element.toLowerCase().contains(query.toLowerCase());
    }).toList();
    _hints = result;
  }

  searchResult(String searchResult) {
    _search = searchResult;
    notifyListeners();
  }

  fetchDoctors() async {
    _doctorLoading = true;
    _doctors = [];
    _selectedDoctor = -1;
    _selectedTime = -1;
    _selectedDate = DateTime.now();
    List<DoctorModel> fetchedData = [];
    var data = await FirebaseFirestore.instance.collection(Keys.doctors).get();
    for (var item in data.docs) {
      fetchedData.add(DoctorModel.fromJSON(item.data()));
    }
    _doctors = fetchedData;
    _doctorLoading = false;
    notifyListeners();
  }

  bookAppointment(BuildContext context) async {
    String mainUserId = AuthServices.getUser()!.uid;
    String currentUserId =
        Provider.of<UserProvider>(context, listen: false).user!.id;
    if (selectedDoctor == -1 || selectedTime == -1) {
      MessageService.showMessage(
          context, 'Please select all information', true);
    } else {
      _booking = true;
      notifyListeners();
      AppointmentModel model = AppointmentModel(
        title: _search,
        doctor: _doctors[_selectedDoctor].name,
        doctorId: _doctors[_selectedDoctor].id,
        time: times[_selectedTime],
        day: '${_selectedDate.day}/${_selectedDate.month}/${selectedDate.year}',
      );
      if (currentUserId == mainUserId) {
        await FirebaseFirestore.instance
            .collection(Keys.users)
            .doc(mainUserId)
            .collection(Keys.appointments)
            .add(AppointmentModel.toJSON(model));
      } else {
        await FirebaseFirestore.instance
            .collection(Keys.users)
            .doc(mainUserId)
            .collection(Keys.profiles)
            .doc(currentUserId)
            .collection(Keys.appointments)
            .add(AppointmentModel.toJSON(model));
      }
      _booking = false;
      notifyListeners();
      context.replaceNamed(RoutesConstants.homeScreen);
    }
  }
}
