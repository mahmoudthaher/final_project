import 'package:project/controllers/api_helper.dart';
import 'package:project/models/city_model.dart';

class CityController {
  Future<List<CityModel>> getAllCities() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest2("api/Cities");
      List<CityModel> cities = [];
      jsonObject.forEach((v) => {cities.add(CityModel.fromJson(v))});
      return cities;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
}
