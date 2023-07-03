import 'package:flutter/material.dart';
import 'package:project/models/user_model.dart';

class UserProvider with ChangeNotifier {
  //List<UserModel> user = [];
  int forgetId = 0;
  UserModel? user;
  profileUser(
      String id,
      String firstName,
      String lastName,
      String phoneNumber,
      String email,
      String username,
      String address,
      String city,
      String gender,
      String type,
      String password) {
    user = UserModel(
        id: id,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        email: email,
        username: username,
        address: address,
        city: city,
        gender: gender,
        type: type,
        password: password);
    notifyListeners();
    return user;
  }

  login(String email, String password) {
    user = UserModel(email: email, password: password);
    notifyListeners();
    return user;
  }
}
