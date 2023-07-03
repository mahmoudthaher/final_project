import 'package:project/controllers/api_helper.dart';
import 'package:project/models/order_product_model.dart';

class OrderProdutsController {
  Future<List<OrderProductModel>> getAllOrders(int orderId) async {
    try {
      dynamic jsonObject =
          await ApiHelper().getRequest2("api/OrderProduts/$orderId");
      List<OrderProductModel> orderProducts = [];
      jsonObject
          .forEach((v) => {orderProducts.add(OrderProductModel.fromJson(v))});
      return orderProducts;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
}
