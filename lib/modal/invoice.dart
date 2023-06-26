// To parse this JSON data, do
//
//     final invoice = invoiceFromJson(jsonString);

import 'dart:convert';

Invoice invoiceFromJson(String str) => Invoice.fromJson(json.decode(str));

String invoiceToJson(Invoice data) => json.encode(data.toJson());

class Invoice {
  int? id;
  int? customer;

  double? grandtotal;
  String? date;

  Invoice({
    this.id,
    this.customer,
    this.grandtotal,
    this.date,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        customer: json["customer"],
        grandtotal: json["grandtotal"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer": customer,
        "grandtotal": grandtotal,
        "date": date,
      };

  Map<String, dynamic> toMap() => {
        "id": id,
        "customer": customer,
        "grandtotal": grandtotal,
        "date": date,
      };
}
