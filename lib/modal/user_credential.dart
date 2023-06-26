// To parse this JSON data, do
//
//     final userCred = userCredFromJson(jsonString);

import 'dart:convert';

UserCred userCredFromJson(String str) => UserCred.fromJson(json.decode(str));

String userCredToJson(UserCred data) => json.encode(data.toJson());

class UserCred {
  int id;
  String username;
  String password;

  UserCred({
    required this.id,
    required this.username,
    required this.password,
  });

  factory UserCred.fromJson(Map<String, dynamic> json) => UserCred(
        id: json["id"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
      };

  factory UserCred.fromMap(Map<String, dynamic> json) => UserCred(
        id: json["id"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "password": password,
      };
}
