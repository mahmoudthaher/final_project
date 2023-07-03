import 'package:project/models/status_model.dart';
import 'package:project/models/user_model.dart';

class OrderModel {
  int id;
  UserModel? user;

  int paymentMethodId;
  double total;
  double taxAmount;
  double subTotal;
  StatusModel? status;
  String? createdAt;

  OrderModel(
      {required this.id,
      this.user,
      required this.paymentMethodId,
      required this.total,
      required this.taxAmount,
      required this.subTotal,
      this.status,
      this.createdAt});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      user: UserModel.fromJson(json["user"]),
      paymentMethodId: json["payment_method_id"],
      total: double.parse(json["total"].toString()),
      taxAmount: double.parse(json["tax_amount"].toString()),
      subTotal: double.parse(json["sub_total"].toString()),
      status: StatusModel.fromJson(json['status']),
      createdAt: json["created_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "sub_total": subTotal,
        "tax_amount": taxAmount,
        "total": total,
        "payment_method_id": paymentMethodId,
        "status": status?.toJson(),
        "created_at": createdAt
      };

  Map<String, dynamic> toJsonU() => {
        "id": id.toString(),
      };
}
