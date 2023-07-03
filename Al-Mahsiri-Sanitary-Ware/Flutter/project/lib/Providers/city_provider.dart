import 'package:flutter/material.dart';
import 'package:project/controllers/city_controller.dart';
import 'package:project/models/city_model.dart';

class CityProvider with ChangeNotifier {
  List<CityModel> cities = [];

  getAllCities() async {
    CityController().getAllCities().then((result) {
      cities = result;
      notifyListeners();
    }).catchError((ex) {});
  }
}
