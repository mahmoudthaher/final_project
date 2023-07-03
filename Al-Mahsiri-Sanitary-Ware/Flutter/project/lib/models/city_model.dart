class CityModel {
  int id;
  String city;

  CityModel({
    required this.id,
    required this.city,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json["id"],
      city: json["city"],
    );
  }
}
