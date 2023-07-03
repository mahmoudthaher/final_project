class CategoryModel {
  int? id;
  String category;

  CategoryModel({
    this.id,
    required this.category,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      category: json["category"],
    );
  }

  Map<String, dynamic> toJson() => {
        "category": category,
      };
  Map<String, dynamic> toJsonU() => {
        "id": id.toString(),
        "category": category,
      };
}
