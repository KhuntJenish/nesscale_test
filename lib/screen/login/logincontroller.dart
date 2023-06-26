import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nesscale_test/screen/dashboard/dashboard.dart';
import 'package:nesscale_test/service/gs_services.dart';
import 'package:nesscale_test/utils/extenstion.dart';

import '../../modal/user_credential.dart';
import '../../service/sqlite.dart';

class LoginController extends GetxController {
  List<UserCred> data = [];
  RxBool isPwdVisible = false.obs;
  late TextEditingController username;
  late TextEditingController password;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    username = TextEditingController();
    password = TextEditingController();
  }

  Future<void> login(String username, String password) async {
    data = await SqlService.getUser();
    if (data.isEmpty) {
      debugPrint("---add new user----");
      UserCred user = UserCred(id: 0, username: username, password: password);
      await SqlService.insertUser(user);
    } else {
      if (username == data.toList().first.username &&
          password == data.toList().first.password) {
        print(data.toList().first.username);
        print(data.toList().first.password);
        UserCred user = UserCred(
            id: data.toList().first.id,
            username: data.toList().first.username,
            password: data.toList().first.password);
        GSServices.setUser(user: user);
        Get.offAllNamed(Dashboard.route);
      } else {
        'invalid user credential!'.infoSnackbar;
      }
    }
  }

  void passVisibleToggle() {
    isPwdVisible.value = !isPwdVisible.value;
  }
}
