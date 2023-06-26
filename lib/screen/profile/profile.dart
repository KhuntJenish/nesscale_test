import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nesscale_test/screen/login/logincontroller.dart';

import '../../components/app_colors.dart';
import '../../components/c_text_field.dart';

class Profile extends StatelessWidget {
  static String route = '/profile';

  final LoginController _loginController = Get.put(LoginController());

  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("profile".tr),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.04, horizontal: Get.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Hero(
                tag: "userphoto",
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [lPrimaryColor, lLinearGradientColor1],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    maxRadius: Get.height * 0.08,
                    child: CircleAvatar(
                      maxRadius: Get.height * 0.078,
                      backgroundImage: const AssetImage('assets/images/h1.png'),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CTextField(
                labelText: 'Nesscale Solutions Private Limited',
                maxLength: 30,
                keyboardType: TextInputType.name,
                readOnly: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CTextField(
                labelText: 'info@nesscale.com',
                maxLength: 30,
                keyboardType: TextInputType.emailAddress,
                readOnly: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CTextField(
                labelText: '+91 6359985959',
                maxLength: 10,
                keyboardType: TextInputType.phone,
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
