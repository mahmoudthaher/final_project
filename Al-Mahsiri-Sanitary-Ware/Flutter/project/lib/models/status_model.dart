class StatusModel {
  late int id;
  late String status;

  StatusModel({
    required this.id,
    required this.status,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(id: json["id"], status: json["status"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}
