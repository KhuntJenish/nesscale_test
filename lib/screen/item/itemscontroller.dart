import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nesscale_test/modal/item.dart';
import 'package:nesscale_test/service/sqlite.dart';
import 'package:nesscale_test/utils/extenstion.dart';

class ItemsController extends GetxController {
  RxList itemlist = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getItem();
  }

  Future<void> insertItem(String name, double rate, String code) async {
    Item item = Item(name: name, code: code, rate: rate, isDeleted: 0);
    await SqlService.insertItem(item);
    await getItem();
  }

  getItem() async {
    debugPrint("---on Init Start---");
    itemlist.value = await SqlService.getItems();
    print(itemlist);
  }

  deleteItem(Item item) async {
    debugPrint("---on Init Start---");
    item.isDeleted = 1;
    var val = await SqlService.updateItem(item);
    print(val);
    if (val > 0) {
      "item delete successfull!".successSnackbar;
      await getItem();
    }
  }
}
