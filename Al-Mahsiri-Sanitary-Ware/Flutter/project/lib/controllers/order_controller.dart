import 'package:project/controllers/api_helper.dart';
import 'package:project/models/order.dart';
import 'package:project/models/order_mpdel.dart';

class OrderController {
  Future<dynamic> create(Order order) async {
    try {
      var result = await ApiHelper().postDio("/api/Orders", order.toJson());
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> getAllOrders(String userId) async {
    try {
      dynamic jsonObject = await ApiHelper().getRequest2("api/Orders/$userId");
      List<OrderModel> orders = [];
      jsonObject.forEach((v) => {orders.add(OrderModel.fromJson(v))});
      return orders;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<List<OrderModel>> callOrder() async {
    try {
      dynamic jsonObject =
          await ApiHelper().getRequest2("api/Orders/callOrder");
      List<OrderModel> orders = [];
      jsonObject.forEach((v) => {orders.add(OrderModel.fromJson(v))});
      return orders;
    } catch (ex) {
      rethrow;
    }
  }

  void modifyStatusOrder(OrderModel order) async {
    try {
      await ApiHelper()
          .putRequest("api/Orders/modifyStatusOrder", order.toJsonU());
    } catch (ex) {
      rethrow;
    }
  }

  void delete(int id) async {
    try {
      await ApiHelper().deleteRequest(
        "api/Orders/$id",
      );
    } catch (ex) {
      rethrow;
    }
  }
}
