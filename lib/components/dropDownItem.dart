// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mybusiness/core/models/product.dart';
// import 'package:mybusiness/design/utils/app_colors.dart';

// import '../../core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nesscale_test/modal/customer.dart';
import 'package:nesscale_test/modal/item.dart';
import 'package:nesscale_test/screen/dashboard/dashboardcontroller.dart';

import 'app_colors.dart';

// // ignore: must_be_immutable
class ItemDropDownItems extends StatelessWidget {
  ItemDropDownItems(
      {super.key, this.defualtValue, this.itemList, this.margin, this.padding});
  Rx<Item>? defualtValue;
  final List<Item>? itemList;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 50,
      width: Get.width * 0.9,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: whiteColor1,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Obx(() => DropdownButtonHideUnderline(
              child: DropdownButton(
                value: defualtValue?.value,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: itemList?.map((Item items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items.name.toString()),
                  );
                }).toList(),
                onChanged: (Item? newValue) {
                  defualtValue?.value = newValue!;
                  print(defualtValue);
                  DashboardController.rate.text =
                      defualtValue!.value.rate.toString();
                },
              ),
            )),
      ),
    );
  }
}

// // ignore: must_be_immutable

class CustomerDropDownItems extends StatelessWidget {
  CustomerDropDownItems(
      {super.key, this.defualtValue, this.itemList, this.margin, this.padding});
  Rx<Customer>? defualtValue;
  final List<Customer>? itemList;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 50,
      width: Get.width * 0.9,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: whiteColor1,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Obx(() => DropdownButtonHideUnderline(
              child: DropdownButton<Customer>(
                value: defualtValue?.value,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: itemList?.map((Customer items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items.name.toString()),
                  );
                }).toList(),
                onChanged: (Customer? newValue) {
                  defualtValue?.value = newValue!;
                },
              ),
            )),
      ),
    );
  }
}
