class StateAndCityModel {
  final String name;
  final List city;

  StateAndCityModel({required this.name, required this.city});

  factory StateAndCityModel.fromJson(Map<String, dynamic> map) {
    return StateAndCityModel(
      name: map['state'],
      city: map['districts'],
    );
  }
}
