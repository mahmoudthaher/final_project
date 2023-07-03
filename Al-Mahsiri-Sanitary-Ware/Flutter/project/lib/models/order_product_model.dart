import 'package:project/models/product_model.dart';

class OrderProductModel {
  int id;
  int orderId;
  int productId;
  int qty;
  double price;
  ProductModel products;

  OrderProductModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.qty,
    required this.price,
    required this.products,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
        id: json["id"],
        orderId: int.parse(json["order_id"].toString()),
        productId: int.parse(json["product_id"].toString()),
        qty: int.parse(json["qty"].toString()),
        price: double.parse(json["price"].toString()),
        products: ProductModel.fromJson(json['product']));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": orderId,
        "sub_total": productId,
        "qty": qty,
        "price": price,
        "product": products.toJson()
      };
}
