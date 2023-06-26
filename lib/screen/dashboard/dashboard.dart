import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nesscale_test/components/dropDownItem.dart';
import 'package:nesscale_test/modal/invoice.dart';
import 'package:nesscale_test/screen/dashboard/dashboardcontroller.dart';
import 'package:nesscale_test/utils/extenstion.dart';

import '../../components/app_colors.dart';
import '../../components/c_text_field.dart';
import '../../components/drawer.dart';
import '../../modal/invoice_item.dart';
import '../../utils/app_text_theme.dart';

class Dashboard extends StatelessWidget {
  static String route = '/dashboard';
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Dashboard'),
      ),
      body: Container(
        child: Obx(
          () => Visibility(
            visible: _dashboardController.invoiceList.isNotEmpty,
            replacement: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('List is Empty!'),
                ],
              ),
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                Invoice? invoice = _dashboardController.invoiceList[index];
                String? customer = _dashboardController.customerList
                    .firstWhere((element) => element.id == invoice.customer)
                    .name;
                RxList<InvoiceItem> invoiceItem = RxList<InvoiceItem>([]);
                for (var element in _dashboardController.invoiceItemList) {
                  if (element.invoiceId == invoice.id) {
                    invoiceItem.add(element);
                  }
                }

                return Obx(
                  () => Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Date:'),
                            Text(DateFormat('EEEE, d MMM')
                                .format(DateTime.parse(invoice.date.toString()))
                                .toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Customer:'),
                            Text(customer.toString()),
                          ],
                        ),
                        const Divider(),
                        Text('Product Detail:', style: TextThemeX.text14),
                        Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.03 * (invoiceItem.length),
                              child: ListView.builder(
                                itemCount: invoiceItem.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text(invoiceItem[index]
                                              .item
                                              .toString())),
                                      Text(invoiceItem[index].qty.toString()),
                                      Text(invoiceItem[index].rate.toString()),
                                      Text(((invoiceItem[index].qty)! *
                                              (invoiceItem[index].rate!))
                                          .toString()),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                    width: 100, child: Text('Grand Total:')),
                                Text(invoice.grandtotal.toString()),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _dashboardController.invoiceList.length,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _dashboardController.tablerow.clear();
          DashboardController.rate.clear();
          _dashboardController.qty.clear();
          _dashboardController.grandtotal.clear();
          _dashboardController.tableItem.clear();
          _dashboardController.gtotal.value = 0;
          await _dashboardController.getItem();
          await _dashboardController.getCustomer();

          InvoiceBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      drawer: CustomeDrawer(),
    );
  }

  Future<dynamic> InvoiceBottomSheet(BuildContext context) {
    return Get.bottomSheet(
      isScrollControlled: true,
      Container(
        decoration: const BoxDecoration(
          color: lLinearGradientColor1,
          gradient: LinearGradient(
              colors: [lLinearGradientColor1, whiteColor1],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "add Invoice",
                    style: TextThemeX.text24.copyWith(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () => _dashboardController.chooseDatePicker(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 16,
                        ),
                        Obx(() => Text(
                              DateFormat('EEEE, d MMM')
                                  .format(
                                      _dashboardController.selectedDate.value)
                                  .toString(),
                              style: TextThemeX.text14
                                  .copyWith(fontWeight: FontWeight.w300),
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomerDropDownItems(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    defualtValue: _dashboardController.selectedCustomer,
                    itemList:
                        _dashboardController.dropdowncustomerList.toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Obx(() => ItemDropDownItems(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        defualtValue: _dashboardController.selectedItem,
                        itemList:
                            _dashboardController.dropdownitemList.toList(),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CTextField(
                          labelText: 'Enter Rate',
                          keyboardType: TextInputType.number,
                          maxLength: 5,
                          controller: DashboardController.rate,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: CTextField(
                          labelText: 'Enter Qty',
                          keyboardType: TextInputType.number,
                          maxLength: 5,
                          controller: _dashboardController.qty,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            if (DashboardController.rate.text.isEmpty ||
                                _dashboardController.qty.text.isEmpty) {
                              return "fill proper data!".errorSnackbar;
                            }
                            _dashboardController.addTableItem(
                                DashboardController.rate.text.trim(),
                                _dashboardController.selectedItem!.value.name
                                    .toString(),
                                _dashboardController.qty.text.trim());
                          },
                          iconSize: 40,
                          icon: const Icon(Icons.arrow_circle_right),
                        ),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: _dashboardController.tablerow.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Table(
                        border: TableBorder.all(width: 1),
                        children: _dashboardController.tablerow,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CTextField(
                    maxLine: 1,
                    labelText: 'Grand Total...',
                    readOnly: true,
                    maxLength: 20,
                    controller: _dashboardController.grandtotal,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      debugPrint('submit');
                      Get.back();
                      _dashboardController.insertInvoice();
                    },
                    child: Text(
                      'Submit',
                      style:
                          TextThemeX.text16.copyWith(color: lPrimaryTextColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isDismissible: true,
    );
  }
}
