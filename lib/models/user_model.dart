import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String gender;
  final String nationality;
  final String? maritalStatus;
  final String? bloodGroup;
  final String dob;
  final String? emergencyContactName;
  final String? emergencyContactNumber;
  final String addressLine1;
  final String? addressLine2;
  final String country;
  final String state;
  final String city;
  final String pincode;
  final String? profilePicURL;
  final int currentProfle;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.gender,
    required this.nationality,
    this.maritalStatus,
    this.bloodGroup,
    required this.dob,
    this.emergencyContactName,
    this.emergencyContactNumber,
    required this.addressLine1,
    this.addressLine2,
    required this.country,
    required this.state,
    required this.city,
    required this.pincode,
    this.profilePicURL,
    this.currentProfle = 0,
  });

  static Map<String, dynamic> toJson(UserModel user) {
    Map<String, dynamic> map = {
      'id': user.id,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'phoneNumber': user.phoneNumber,
      'email': user.email,
      'gender': user.gender,
      'nationality': user.nationality,
      'maritalStatus': user.maritalStatus,
      'bloodGroup': user.bloodGroup,
      'dob': user.dob,
      'emergencyContactName': user.emergencyContactName,
      'emergencyContactNumber': user.emergencyContactNumber,
      'addressLine1': user.addressLine1,
      'addressLine2': user.addressLine2,
      'country': user.country,
      'state': user.state,
      'city': user.city,
      'pincode': user.pincode,
      'profilePicURL': user.profilePicURL,
      'currentProfile': user.currentProfle,
      'createdAt': FieldValue.serverTimestamp(),
    };
    return map;
  }

  factory UserModel.fromJSON(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      gender: map['gender'],
      nationality: map['nationality'],
      maritalStatus: map['maritalStatus'],
      bloodGroup: map['bloodGroup'],
      dob: map['dob'],
      emergencyContactName: map['emergencyContactName'],
      emergencyContactNumber: map['emergencyContactNumber'],
      addressLine1: map['addressLine1'],
      addressLine2: map['addressLine2'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
      pincode: map['pincode'],
      profilePicURL: map['profilePicURL'],
      currentProfle: map['currentProfile'],
    );
  }
}
