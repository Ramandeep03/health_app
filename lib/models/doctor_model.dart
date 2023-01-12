class DoctorModel {
  String id;
  final String name;
  final String picURL;

  DoctorModel({
    required this.name,
    required this.picURL,
    required this.id
  });

  factory DoctorModel.fromJSON(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'],
      name: map['name'],
      picURL: map['profilePic'],
    );
  }
}
