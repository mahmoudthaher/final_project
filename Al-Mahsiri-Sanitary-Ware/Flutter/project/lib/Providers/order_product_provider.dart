import 'package:flutter/material.dart';
import 'package:project/controllers/order_product_controller.dart';
import 'package:project/models/order_product_model.dart';

class OrderProductProvider with ChangeNotifier {
  List<OrderProductModel> orderProducts = [];
  int orderId = 0;

  getAllOrderdetail() async {
    OrderProdutsController().getAllOrders(orderId).then((result) {
      orderProducts = result;
      notifyListeners();
    }).catchError((ex) {});
  }
}
