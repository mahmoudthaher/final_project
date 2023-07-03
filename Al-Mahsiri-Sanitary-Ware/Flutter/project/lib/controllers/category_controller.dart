import 'package:project/controllers/api_helper.dart';
import 'package:project/models/category_model.dart';

class CategoryController {
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest2("api/Categories");
      List<CategoryModel> category = [];
      jsonObject.forEach((v) => {category.add(CategoryModel.fromJson(v))});
      return category;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> getAllCategoriesAdmin() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest2("api/Categories");
      List<CategoryModel> categoryAdmin = [];
      jsonObject.forEach((v) => {categoryAdmin.add(CategoryModel.fromJson(v))});
      return categoryAdmin;
    } catch (ex) {
      rethrow;
    }
  }

  void create(CategoryModel category) async {
    try {
      await ApiHelper().postRequest("api/Categories", category.toJson());
    } catch (ex) {
      rethrow;
    }
  }

  void delete(int id) async {
    try {
      await ApiHelper().deleteRequest(
        "api/Categories/$id",
      );
    } catch (ex) {
      rethrow;
    }
  }

  void update(CategoryModel category) async {
    try {
      await ApiHelper().putRequest("api/Categories", category.toJsonU());
    } catch (ex) {
      rethrow;
    }
  }
}
