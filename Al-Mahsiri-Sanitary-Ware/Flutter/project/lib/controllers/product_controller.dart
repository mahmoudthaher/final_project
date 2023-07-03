import 'package:project/controllers/api_helper.dart';
import 'package:project/models/category_model.dart';
import 'package:project/models/product_model.dart';

class ProductController {
  Future<List<ProductModel>> getProducts() async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest2("api/Products");
      List<ProductModel> products = [];
      jsonObject["data"]
          .forEach((v) => {products.add(ProductModel.fromJson(v))});
      return products;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<ProductModel>> getProductByCategoryId(int categoryId) async {
    try {
      dynamic jsonObject =
          await ApiHelper().getRequest2("api/Products/$categoryId");
      List<ProductModel> products = [];
      jsonObject.forEach((v) => {products.add(ProductModel.fromJson(v))});
      return products;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<List<ProductModel>> fliterProduct(String name) async {
    try {
      dynamic jsonObject =
          await ApiHelper().getRequest2("api/Products/fliterProduct/$name");
      List<ProductModel> products = [];
      jsonObject.forEach((v) => {products.add(ProductModel.fromJson(v))});
      return products;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<ProductModel> create(ProductModel product) async {
    try {
      dynamic jsonObject =
          await ApiHelper().postRequest("api/Products", product.toJsonC());
      return ProductModel.fromJson(jsonObject);
    } catch (ex) {
      rethrow;
    }
  }

  void delete(int id) async {
    try {
      await ApiHelper().deleteRequest(
        "api/Products/$id",
      );
    } catch (ex) {
      rethrow;
    }
  }

  Future<ProductModel> getProductsById(int id) async {
    try {
      dynamic jsonObject =
          await ApiHelper().getRequest2("api/Products/productID/$id");

      return ProductModel.fromJson(jsonObject);
    } catch (ex) {
      rethrow;
    }
  }

  void update(ProductModel product) async {
    try {
      await ApiHelper().putRequest("api/Products", product.toJsonU());
    } catch (ex) {
      rethrow;
    }
  }
}
