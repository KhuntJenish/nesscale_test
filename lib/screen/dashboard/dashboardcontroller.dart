import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nesscale_test/modal/customer.dart';
import 'package:nesscale_test/modal/invoice.dart';
import 'package:nesscale_test/modal/invoice_item.dart';
import 'package:nesscale_test/modal/item.dart';
import 'package:nesscale_test/utils/extenstion.dart';

import '../../service/sqlite.dart';

class DashboardController extends GetxController {
  RxList<Customer> customerList = RxList<Customer>([]);
  RxList<Customer> dropdowncustomerList = RxList<Customer>([]);
  RxList<Invoice> invoiceList = RxList<Invoice>([]);
  RxList<InvoiceItem> invoiceItemList = RxList<InvoiceItem>([]);
  RxList<Item> itemList = RxList<Item>([]);
  RxList<Item> dropdownitemList = RxList<Item>([]);
  Rx<Customer>? selectedCustomer = Customer().obs;
  Rx<Item>? selectedItem = Item().obs;
  RxList<TableRow> tablerow = RxList<TableRow>([]);
  RxList<InvoiceItem> tableItem = RxList<InvoiceItem>([]);
  RxDouble gtotal = 0.0.obs;
  static late TextEditingController rate;
  late TextEditingController qty;
  late TextEditingController grandtotal;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    rate = TextEditingController();
    qty = TextEditingController();
    grandtotal = TextEditingController();
    getInvoice();
    getInvoiceItem();
    getItem();
    getCustomer();
  }

  getItem() async {
    debugPrint("---on Init Item Start---");
    itemList.value = [];
    dropdownitemList.value = [];
    itemList.value = await SqlService.getItems();
    if (itemList.isNotEmpty) {
      for (var i in itemList) {
        if (i.isDeleted == 0) {
          dropdownitemList.add(i);
        }
      }
    }

    if (dropdownitemList.isNotEmpty) {
      selectedItem?.value = dropdownitemList.first;
      rate.text = selectedItem!.value.rate.toString();
    }
    print(rate.text);
  }

  getCustomer() async {
    debugPrint("---on Init Customer Start---");
    customerList.value = [];
    dropdowncustomerList.value = [];
    customerList.value = await SqlService.getCustomers();
    // print(customerList);
    if (customerList.isNotEmpty) {
      for (var c in customerList) {
        if (c.isDeleted == 0) {
          dropdowncustomerList.add(c);
        }
      }
    }

    if (dropdowncustomerList.isNotEmpty) {
      selectedCustomer?.value = dropdowncustomerList.first;
    }
  }

  getInvoice() async {
    debugPrint("---on Init Invoice Start---");
    invoiceList.value = [];
    invoiceList.value = await SqlService.getInvoice();
    // print(invoiceList);
  }

  getInvoiceItem() async {
    debugPrint("---on Init InvoiceItem Start---");
    invoiceItemList.value = [];
    invoiceItemList.value = await SqlService.getInvoiceItem();
    print(invoiceItemList);
  }

  addTableItem(String rate, String item, String qty) {
    var amount = double.parse(rate) * int.parse(qty);
    gtotal.value += amount;
    grandtotal.text = gtotal.toString();
    var tr = TableRow(children: [
      Text(item, textAlign: TextAlign.center),
      Text(rate, textAlign: TextAlign.center),
      Text(qty, textAlign: TextAlign.center),
      Text(
        (double.parse(rate) * int.parse(qty)).toString(),
        textAlign: TextAlign.center,
      ),
    ]);
    var ftr = const TableRow(children: [
      Text('Item', textAlign: TextAlign.center),
      Text('Rate', textAlign: TextAlign.center),
      Text('qty', textAlign: TextAlign.center),
      Text('amount', textAlign: TextAlign.center),
    ]);
    tablerow.isEmpty ? tablerow.add(ftr) : tablerow[0] = ftr;
    tablerow.add(tr);
    tableItem.add(
        InvoiceItem(item: item, qty: int.parse(qty), rate: double.parse(rate)));
  }

  insertInvoice() async {
    if (selectedCustomer != null ||
        DashboardController.rate.text.isNotEmpty ||
        qty.text.isNotEmpty) {
      double gtotal = double.parse(grandtotal.text.trim());
      int? cid = selectedCustomer?.value.id;

      Invoice invoice = Invoice(
          customer: cid, grandtotal: gtotal, date: selectedDate.toString());
      int invoiceID = await SqlService.insertInvoice(invoice);
      for (var raw in tableItem) {
        InvoiceItem invoiceItem = InvoiceItem(
            invoiceId: invoiceID, item: raw.item, qty: raw.qty, rate: raw.rate);
        int invoiceItemID = await SqlService.insertInvoiceItem(invoiceItem);
      }

      await getInvoice();
      await getInvoiceItem();
    } else {
      "Fill Data Properly!".errorSnackbar;
    }
  }

  chooseDatePicker(BuildContext context) async {
    selectedDate.value = await showDatePicker(
            context: context,
            initialDate: DateTime.now(), //get today's date
            firstDate: DateTime(DateTime.now().year -
                2), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(DateTime.now().year + 2)) ??
        selectedDate.value;
  }
}
