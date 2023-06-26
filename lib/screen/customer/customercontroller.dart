import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nesscale_test/modal/customer.dart';
import 'package:nesscale_test/service/sqlite.dart';
import 'package:nesscale_test/utils/extenstion.dart';

class CustomerController extends GetxController {
  RxList customerlist = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCustomer();
  }

  Future<void> insertCustomer(String name, String mobile, String email) async {
    Customer customer =
        Customer(name: name, mobile: mobile, email: email, isDeleted: 0);
    await SqlService.insertCustomer(customer);
    await getCustomer();
  }

  getCustomer() async {
    debugPrint("---on Init Start---");
    customerlist.value = await SqlService.getCustomers();
    print(customerlist);
  }

  deleteCustomer(Customer customer) async {
    debugPrint("---on Init Start---");
    customer.isDeleted = 1;
    var val = await SqlService.updateCustomer(customer);
    print(val);
    if (val > 0) {
      "customer delete successfull!".successSnackbar;
      await getCustomer();
    }
  }
}
