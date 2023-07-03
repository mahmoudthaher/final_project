import 'package:project/models/address_model.dart';
import 'package:project/models/product_model.dart';

class Order {
  List<ProductModel> products;
  AddressModel address;
  int paymentMethodId;
  double total;
  double taxAmount;
  double subTotal;

  Order({
    required this.products,
    required this.address,
    required this.paymentMethodId,
    required this.total,
    required this.taxAmount,
    required this.subTotal,
  });

  Map<String, dynamic> toJson() => {
        "sub_total": subTotal,
        "tax_amount": taxAmount,
        "total": total,
        "payment_method_id": paymentMethodId,
        "products": products.map((e) => e.toJson()).toList(),
        "address": address.toJson(),
      };
}
