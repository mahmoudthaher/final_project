class UserModel {
  String? id, gender, city, type;

  String? firstName, lastName, phoneNumber, email, username, address, password;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.username,
      this.address,
      this.city,
      this.gender,
      this.type,
      this.password});
  Map<String, dynamic> toJson() => {
        "id": id,
        "fist_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "email": email,
        "user_name": username,
        "address": address,
        "city_id": city,
        "gender_id": gender,
        "type_id": type,
        "password": password,
      };

  Map<String, dynamic> toJsonCreate() => {
        "fist_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "email": email,
        "user_name": username,
        "address": address,
        "city_id": city,
        "gender_id": gender,
        "type_id": type,
        "password": password,
      };

  Map<String, dynamic> toJsonLogin() => {
        "email": email,
        "password": password,
      };
  Map<String, dynamic> toJsonResetPsddword() => {
        "id": id,
        "password": password,
      };
  Map<String, dynamic> toJsoncheckUserAndPhone() => {
        "email": email,
        "phone_number": phoneNumber,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"].toString(),
      firstName: json["fist_name"],
      lastName: json["last_name"],
      phoneNumber: json["phone_number"],
      email: json["email"],
      username: json["user_name"],
      address: json["address"],
      city: json["city_id"].toString(),
      gender: json["gender_id"].toString(),
      type: json["type_id"].toString(),
      password: json["password"],
    );
  }
}
