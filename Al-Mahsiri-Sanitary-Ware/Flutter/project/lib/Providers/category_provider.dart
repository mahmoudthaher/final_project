import 'package:flutter/material.dart';
import 'package:project/controllers/category_controller.dart';
import 'package:project/models/category_model.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> categories = [];
  List<CategoryModel> categoriesAdmin = [];
  String name = "";
  getAllCategory() async {
    CategoryController().getAllCategories().then((result) {
      categories = result;
      notifyListeners();
    }).catchError((ex) {
      print(ex);
    });
  }

  getAllCategoryAdmin() async {
    CategoryController().getAllCategoriesAdmin().then((result) {
      categoriesAdmin = result;
      notifyListeners();
    }).catchError((ex) {
      print(ex);
    });
  }
}
