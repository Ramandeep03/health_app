// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:health_app/constants/assets.dart';
import 'package:health_app/constants/keys.dart';
import 'package:health_app/models/state_and_city_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:health_app/models/user_model.dart';
import 'package:health_app/providers/bottom_navigation_provider.dart';
import 'package:health_app/providers/user_provider.dart';
import 'package:health_app/routes/routes_constants.dart';
import 'package:health_app/services/auth_services.dart';
import 'package:health_app/services/message_service.dart';
import 'package:health_app/services/overlay_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class RegisterProvider extends ChangeNotifier {
  File _image = File('');
  File get image => _image;
  List<StateAndCityModel> _list = [];

  List<StateAndCityModel> get list => _list;

  List<String> _states = [];

  List<String> get states => _states;

  List<String> _city = [];

  List<String> get city => _city;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _firstName = '';
  String get firstName => _firstName;
  String _lastName = '';
  String get lastName => _lastName;
  String _phone = '';
  String get phone => _phone;
  String _email = '';
  String get email => _email;
  String _dob = '';
  String get dob => _dob;
  String _emergencyName = '';
  String get emergencyName => _emergencyName;
  String _emergencyNumber = '';
  String get emergencyNumber => _emergencyNumber;
  String _address1 = '';
  String get address1 => _address1;
  String _address2 = '';
  String get address2 => _address2;
  String _pinCode = '';
  String get pinCode => _pinCode;

  String _gender = '';
  String get gender => _gender;

  String _nationality = 'Indian';
  String get nationality => _nationality;

  String _maritalStatus = '';
  String get maritalStatus => _maritalStatus;

  String _bloodGroup = '';
  String get bloodGroup => _bloodGroup;

  String _country = 'India';
  String get country => _country;

  String _selectedCity = '';

  String get selectedCity => _selectedCity;

  String _selectedState = '';

  String get selectedState => _selectedState;

  String? _imageURL = '';

  bool _uploading = false;
  bool get uploading => _uploading;
  firstNameChange(String text) {
    _firstName = text;
  }

  lastNameChange(String text) {
    _lastName = text;
  }

  phoneChange(String text) {
    _phone = text;
  }

  emailChange(String text) {
    _email = text;
  }

  emergencyNameChange(String text) {
    _emergencyName = text;
  }

  emergencyNumberChange(String text) {
    _emergencyNumber = text;
  }

  address1Change(String text) {
    _address1 = text;
  }

  address2Change(String text) {
    _address2 = text;
  }

  pinCodeChange(String text) {
    _pinCode = text;
  }

  genderTap(String value) {
    _gender = value;
    notifyListeners();
  }

  maritalStatusTap(String value) {
    _maritalStatus = value;
    notifyListeners();
  }

  nationalityTap(String value) {
    _nationality = value;
    notifyListeners();
  }

  bloodGroupTap(String value) {
    _bloodGroup = value;
    notifyListeners();
  }

  countryTap(String value) {
    _country = value;
    notifyListeners();
  }

  fetchStateAndCity(TextEditingController controller) async {
    String data = await rootBundle.loadString(AssetPaths.stateJson);
    var decodedData = json.decode(data);
    for (Map<String, dynamic> map in decodedData['states']) {
      StateAndCityModel model = StateAndCityModel.fromJson(map);
      _list.add(model);
      states.add(model.name);
    }

    _phone = AuthServices.getPhone().toString();
    controller.text = AuthServices.getPhone().toString();
    notifyListeners();
  }

  stateChange(String value) {
    _city = [];
    _selectedCity = '';
    for (StateAndCityModel model in _list) {
      if (model.name == value) {
        for (var i in model.city) {
          city.add(i.toString());
        }
        notifyListeners();
      }
    }
    _selectedState = value;
    notifyListeners();
  }

  cityChange(var value) {
    _selectedCity = value.toString();
    notifyListeners();
  }

  pickChange(BuildContext context, TextEditingController controller) {
    OverlayServices.datePicker(context, controller);
  }

  dateChange(DateTime time, TextEditingController controller) {
    _dob = '${time.day}/${time.month}/${time.year}';
    controller.text = '${time.day}/${time.month}/${time.year}';
    notifyListeners();
  }

  pickImageFromGallery() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file!.path.isNotEmpty) {
      _image = File(file.path);
      notifyListeners();
    }
  }

  imageFromCamera() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    if (file!.path.isNotEmpty) {
      _image = File(file.path);
      notifyListeners();
    }
  }

  imageOverlay(BuildContext context) {
    OverlayServices.imagePicker(context);
  }

  uploadImage() async {
    String userId = AuthServices.getUser()!.uid;
    String ref = '$userId/${DateTime.now()}';
    await FirebaseStorage.instance
        .ref(ref)
        .putFile(File(image.path))
        .then((p0) async {
      String url = await FirebaseStorage.instance.ref(ref).getDownloadURL();
      _imageURL = url;
    });
  }

  uploadUser() async {
    _uploading = true;
    String id = AuthServices.getUser()!.uid;
    Map<String, dynamic> userData = UserModel.toJson(getUser());

    await FirebaseFirestore.instance
        .collection(Keys.users)
        .doc(id)
        .set(userData);
    _uploading = false;
    notifyListeners();
  }

  uploadProfile(String id) async {
    _uploading = true;
    String userId = AuthServices.getUser()!.uid;
    Map<String, dynamic> userData = UserModel.toJson(getUser(
      customId: id,
    ));

    await FirebaseFirestore.instance
        .collection(Keys.users)
        .doc(userId)
        .collection(Keys.profiles)
        .doc(id)
        .set(userData);
    _uploading = false;
    notifyListeners();
  }

  UserModel getUser({String? customId}) {
    String id = customId ?? AuthServices.getUser()!.uid;
    return UserModel(
      id: id,
      firstName: _firstName,
      lastName: _lastName,
      phoneNumber: _phone,
      email: _email,
      gender: gender,
      nationality: nationality,
      dob: _dob,
      addressLine1: _address1,
      country: country,
      state: selectedState,
      city: selectedCity,
      pincode: _pinCode,
      addressLine2: _address2,
      emergencyContactName: _emergencyName,
      emergencyContactNumber: _emergencyNumber,
      profilePicURL: _imageURL,
      maritalStatus: maritalStatus,
      bloodGroup: bloodGroup,
    );
  }

  uploadData(BuildContext context, bool isRegister) async {
    if (_firstName.isEmpty ||
        _lastName.isEmpty ||
        _phone.isEmpty ||
        _email.isEmpty ||
        _gender.isEmpty ||
        _nationality.isEmpty ||
        _dob.isEmpty ||
        _address1.isEmpty ||
        _country.isEmpty ||
        _selectedCity.isEmpty ||
        _selectedState.isEmpty ||
        _pinCode.isEmpty) {
      MessageService.showMessage(
          context, 'Please fill all the necessaary Fields', true);
    } else {
      if (isRegister) {
        _isLoading = true;
        UserModel user = getUser();
        if (image.path.isNotEmpty) {
          await uploadImage();
        }
        await uploadUser();
        dispose();
        Provider.of<UserProvider>(context, listen: false).setUserFromUser(user);
        context.replaceNamed(RoutesConstants.homeScreen);
        _isLoading = false;
        notifyListeners();
      } else {
        String id = const Uuid().v4();
        _isLoading = true;
        if (image.path.isNotEmpty) {
          await uploadImage();
        }
        await uploadProfile(id);
        dispose();

        context.replaceNamed(
          RoutesConstants.homeScreen,
        );
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  dispose() {
    _firstName == '';
    _lastName == '';
    _phone == '';
    _email == '';
    _gender = '';
    _maritalStatus = '';
    _bloodGroup = '';
    _dob == '';
    _emergencyName == '';
    _emergencyNumber == '';
    _address1 == '';
    _address2 == '';
    _selectedCity = '';
    _selectedState = '';
    _pinCode == '';
    _image = File('');
    _imageURL = '';
    notifyListeners();
  }
}
