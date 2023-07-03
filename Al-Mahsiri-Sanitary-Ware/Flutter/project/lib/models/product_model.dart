class ProductModel {
  int? id;
  String name;
  double price;
  int quantityInStock;
  String image;
  String? description;
  int categoryId;
  int? discountId;
  int selectedQty = 1;
  double tax = 16;
  ProductModel(
      {this.id,
      required this.name,
      required this.price,
      required this.quantityInStock,
      required this.image,
      this.description,
      required this.categoryId,
      this.discountId});

  double get finalPrice {
    return price * (1 + (tax / 100));
  }

  double get subTotal {
    return price * selectedQty;
  }

  double get taxAmount {
    return (price * (tax / 100)) * selectedQty;
  }

  double get total {
    return (price * (1 + (tax / 100))) * selectedQty;
  }

  double get total2 => price * selectedQty;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      price: double.parse(json["price"].toString()),
      quantityInStock: int.parse(json["quantity_in_stock"].toString()),
      image: json["image"],
      description: json["description"],
      categoryId: int.parse(json["category_id"].toString()),
      discountId: json["discount_id"],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": id,
        "qty": selectedQty,
        "price": price,
        "total": total,
      };

  Map<String, dynamic> toJsonC() => {
        "name": name,
        "price": price.toString(),
        "quantity_in_stock": quantityInStock.toString(),
        "image": image,
        "category_id": categoryId.toString(),
      };
  Map<String, dynamic> toJsonU() => {
        "id": id.toString(),
        "name": name,
        "price": price.toString(),
        "quantity_in_stock": quantityInStock.toString(),
        "image": image,
        "category_id": categoryId.toString(),
      };
}
