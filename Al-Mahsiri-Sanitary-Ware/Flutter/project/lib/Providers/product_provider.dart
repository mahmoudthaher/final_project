import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:project/models/address_model.dart';
import 'package:project/models/category_model.dart';
import 'package:project/models/product_model.dart';
import 'package:project/controllers/product_controller.dart';

class ProductProvider with ChangeNotifier {
  bool checkFliter = false;
  bool hideAppBar = false;
  bool hideNavigationBar = false;
  List<ProductModel> products = [];
  List<ProductModel> productsAll = [];

  List<ProductModel> productsFilter = [];
  // ProductModel? products2;

  //ProductModel? products2;
  int id = 1;
  int? udpateIDAdimn;
  late String name;
  CategoryModel? categories;
  List<ProductModel> selectedProducts = [];
  double total = 0;
  double taxAmount = 0;
  double subTotal = 0;
  AddressModel address = AddressModel();

  final keyForm = GlobalKey<FormState>();
  int paymentMethod = 1;

  addToCart(ProductModel product) {
    selectedProducts.add(product);
    generateTotal();
    notifyListeners();
  }

  updateAddress(AddressModel newAddress) {
    address = newAddress;
  }

  updatePaymentMethod(int newId) {
    paymentMethod = newId;
    notifyListeners();
  }

  removeProduct(int index) {
    selectedProducts.removeAt(index);
    generateTotal();
    notifyListeners();
  }

  updateQty(ProductModel product, int newQty) {
    product.selectedQty = newQty;
    generateTotal();
    notifyListeners();
  }

  generateTotal() {
    total = 0;
    subTotal = 0;
    taxAmount = 0;
    for (ProductModel product in selectedProducts) {
      subTotal += product.subTotal;
      taxAmount += product.taxAmount;
      total += product.total;
    }
  }

  getAllProducts() async {
    ProductController().getProducts().then((result) {
      productsAll = result;
      notifyListeners();
    }).catchError((ex) {
      print(ex);
    });
  }

  getAllProductsByCategoryID() async {
    ProductController().getProductByCategoryId(id).then((result) {
      products = result;
      notifyListeners();
    }).catchError((ex) {
      print(ex);
    });
  }

  filterProduct() async {
    ProductController().fliterProduct(name).then((result) {
      productsFilter = result;
      notifyListeners();
    }).catchError((ex) {
      print(ex);
    });
  }
}
