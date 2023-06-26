import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nesscale_test/modal/customer.dart';

import '../../components/app_colors.dart';
import '../../components/c_text_field.dart';
import '../../utils/app_text_theme.dart';
import 'customercontroller.dart';

class Customers extends StatelessWidget {
  static String route = '/customers';

  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  final CustomerController _customerController = Get.put(CustomerController());

  Customers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Customers'),
      ),
      body: Container(
        child: Obx(
          () => Visibility(
            visible: _customerController.customerlist.isNotEmpty,
            replacement: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Cutomers is Empty!')
                ],
              ),
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                Customer? customer = _customerController.customerlist[index];
                print(customer?.isDeleted);
                return Visibility(
                  visible: customer?.isDeleted == 0,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text((index + 1).toString()),
                    ),
                    title: Text(customer!.name.toString()),
                    trailing: GestureDetector(
                      child: const Icon(Icons.delete),
                      onTap: () async =>
                          await _customerController.deleteCustomer(customer),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.mobile.toString(),
                          style: TextThemeX.text12.copyWith(color: greyColor1),
                        ),
                        Text(
                          customer.email.toString(),
                          style: TextThemeX.text12.copyWith(color: greyColor1),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _customerController.customerlist.length,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "add Items",
                          style: TextThemeX.text24.copyWith(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CTextField(
                          labelText: 'Enter Name',
                          keyboardType: TextInputType.text,
                          maxLength: 20,
                          controller: name,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CTextField(
                          labelText: 'Enter mobile no.',
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          controller: mobile,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CTextField(
                          maxLine: 1,
                          labelText: 'Enter Email...',
                          keyboardType: TextInputType.text,
                          maxLength: 30,
                          controller: email,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            print('submit');
                            Get.back();

                            await _customerController.insertCustomer(
                                name.text, mobile.text, email.text);
                            mobile.clear();
                            name.clear();
                            email.clear();
                          },
                          child: Text(
                            'Submit',
                            style: TextThemeX.text16
                                .copyWith(color: lPrimaryTextColor),
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
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
