// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  int? id;
  String? name;
  String? mobile;
  String? email;
  int? isDeleted;

  // Customer({
  //   this.id,
  //   required this.name,
  //   required this.mobile,
  //   required this.email,
  //   required this.isDeleted,
  // });

  Customer({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.isDeleted,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        "isDeleted": isDeleted,
      };

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        "isDeleted": isDeleted,
      };
}
