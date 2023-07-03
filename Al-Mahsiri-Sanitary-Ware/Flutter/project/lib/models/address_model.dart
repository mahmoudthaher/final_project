class AddressModel {
  double latitude = 0;
  double longitude = 0;
  String country = "الاردن";
  String city = "";
  String area = "";
  String street = "";
  String buildingNo = "";

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "country": country,
        "city": city,
        "area": area,
        "street": street,
        "building_no": buildingNo,
      };
}
