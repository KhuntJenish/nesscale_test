import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/app_colors.dart';
import '../../components/c_text_field.dart';
import '../../modal/item.dart';
import '../../utils/app_text_theme.dart';
import 'itemscontroller.dart';

class Items extends StatelessWidget {
  static String route = '/items';

  TextEditingController name = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController rate = TextEditingController();
  final ItemsController _itemsController = Get.put(ItemsController());

  Items({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Items'),
      ),
      body: Container(
        child: Obx(
          () => Visibility(
            visible: _itemsController.itemlist.isNotEmpty,
            replacement: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Items is Empty!')
                ],
              ),
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                Item? item = _itemsController.itemlist[index];
                return Visibility(
                  visible: item?.isDeleted == 0,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text((index + 1).toString()),
                    ),
                    title: Text(item!.name.toString()),
                    subtitle: Text(item.code.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(item.rate.toString()),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async =>
                              await _itemsController.deleteItem(item),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _itemsController.itemlist.length,
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
                          labelText: 'Enter Rate',
                          keyboardType: TextInputType.number,
                          maxLength: 5,
                          controller: rate,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CTextField(
                          maxLine: 1,
                          labelText: 'Enter Code...',
                          keyboardType: TextInputType.text,
                          maxLength: 20,
                          controller: code,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            print('submit');
                            Get.back();

                            await _itemsController.insertItem(
                                name.text, double.parse(rate.text), code.text);
                            code.clear();
                            name.clear();
                            rate.clear();
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
