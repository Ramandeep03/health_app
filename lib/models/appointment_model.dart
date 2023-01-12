import 'package:cloud_firestore/cloud_firestore.dart';


class AppointmentModel {
  final String title;
  final String doctor;
  final String doctorId;
  final String time;
  final String day;

  AppointmentModel({
    required this.title,
    required this.doctor,
    required this.doctorId,
    required this.time,
    required this.day,
  });

  factory AppointmentModel.fromJSON(Map<String, dynamic> map) {
    return AppointmentModel(
      title: map['title'],
      doctor: map['doctor'],
      doctorId: map['doctorId'],
      time: map['time'],
      day: map['day'],
    );
  }

  static Map<String, dynamic> toJSON(AppointmentModel model) {
    Map<String, dynamic> map = {
      'title': model.title,
      'time': model.time,
      'day': model.day,
      'doctor': model.doctor,
      'doctorId': model.doctorId,
      'createdAt': FieldValue.serverTimestamp(),
    };
    return map;
  }
}
