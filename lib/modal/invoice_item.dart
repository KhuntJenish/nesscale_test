// To parse this JSON data, do
//
//     final invoiceItem = invoiceItemFromJson(jsonString);

import 'dart:convert';

InvoiceItem invoiceItemFromJson(String str) =>
    InvoiceItem.fromJson(json.decode(str));

String invoiceItemToJson(InvoiceItem data) => json.encode(data.toJson());

class InvoiceItem {
  int? id;
  int? invoiceId;
  String? item;
  int? qty;
  double? rate;

  InvoiceItem({
    this.id,
    this.invoiceId,
    this.item,
    this.qty,
    this.rate,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) => InvoiceItem(
        id: json["id"],
        invoiceId: json["invoiceid"],
        item: json["item"],
        qty: json["qty"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoiceid": invoiceId,
        "item": item,
        "qty": qty,
        "rate": rate,
      };

  factory InvoiceItem.fromMap(Map<String, dynamic> json) => InvoiceItem(
        id: json["id"],
        invoiceId: json["invoiceid"],
        item: json["item"],
        qty: json["qty"],
        rate: json["rate"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "invoiceid": invoiceId,
        "item": item,
        "qty": qty,
        "rate": rate,
      };
}
