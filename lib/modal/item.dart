// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  int? id;
  String? name;
  String? code;
  double? rate;
  int? isDeleted;

  Item({
    this.id,
    this.name,
    this.code,
    this.rate,
    this.isDeleted,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        rate: json["rate"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "rate": rate,
        "isDeleted": isDeleted,
      };

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        rate: json["rate"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "code": code,
        "rate": rate,
        "isDeleted": isDeleted,
      };
}
