import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/Providers/user_provider.dart';
import 'package:project/controllers/api_helper.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';

class UserController {
  Future<bool> login(UserModel user) async {
    try {
      dynamic jsonObject =
          await ApiHelper().postRequest("api/Users/login", user.toJsonLogin());
      String type = jsonObject["type"];
      String token = jsonObject["token"];
      final storage = FlutterSecureStorage();
      await storage.write(key: "token", value: "$type $token");

      return true;
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> informationUser(String emailUser) async {
    try {
      dynamic jsonObject =
          await ApiHelper().getRequest2("api/Users/informationUser/$emailUser");
      int id = jsonObject[0]["id"];
      String fistName = jsonObject[0]["fist_name"];
      String lastName = jsonObject[0]["last_name"];
      String phoneNumber = jsonObject[0]["phone_number"];
      String email = jsonObject[0]["email"];
      String userName = jsonObject[0]["user_name"];
      String password = jsonObject[0]["password"];
      String address = jsonObject[0]["address"];
      int genderId = jsonObject[0]["gender_id"];
      int typeId = jsonObject[0]["type_id"];
      int cityId = jsonObject[0]["city_id"];
      final storage = FlutterSecureStorage();
      await storage.write(key: "id", value: "$id");
      await storage.write(key: "fistName", value: fistName);
      await storage.write(key: "lastName", value: lastName);
      await storage.write(key: "phoneNumber", value: phoneNumber);
      await storage.write(key: "email", value: email);
      await storage.write(key: "userName", value: userName);
      await storage.write(key: "password", value: password);
      await storage.write(key: "address", value: address);
      await storage.write(key: "genderId", value: "$genderId");
      await storage.write(key: "typeId", value: "$typeId");
      await storage.write(key: "cityId", value: "$cityId");

      return UserModel.fromJson(jsonObject[0]);
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> create(UserModel user) async {
    try {
      dynamic jsonObject =
          await ApiHelper().postRequest("api/Users", user.toJsonCreate());
      return UserModel.fromJson(jsonObject);
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<UserModel> update(UserModel user) async {
    try {
      dynamic jsonObject =
          await ApiHelper().putRequest("api/Users", user.toJson());
      return UserModel.fromJson(jsonObject);
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<UserModel> resetPassword(UserModel user) async {
    try {
      dynamic jsonObject = await ApiHelper()
          .putRequest("api/Users/updatePassword/", user.toJsonResetPsddword());
      return UserModel.fromJson(jsonObject);
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> getUser() async {
    dynamic jsonObject = await ApiHelper().getRequest("api/users");
    return UserModel.fromJson(jsonObject);
  }

  Future<List<UserModel>> getUserByTypeId1() async {
    dynamic jsonObject = await ApiHelper().getRequest("api/Users/SubAdmin");
    List<UserModel> users = [];
    jsonObject.forEach((v) => {users.add(UserModel.fromJson(v))});
    return users;
  }

  Future<List<UserModel>> getUserByTypeId2() async {
    dynamic jsonObject = await ApiHelper().getRequest("api/Users/BaseAdmin");
    List<UserModel> users = [];
    jsonObject.forEach((v) => {users.add(UserModel.fromJson(v))});
    return users;
  }

  void delete(int id) async {
    try {
      await ApiHelper().deleteRequest(
        "api/Users/$id",
      );
    } catch (ex) {
      rethrow;
    }
  }
}
