import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nesscale_test/screen/login/logincontroller.dart';

import '../../components/app_colors.dart';
import '../../components/c_text_field.dart';

class LoginScreen extends StatelessWidget {
  static String route = '/loginscreen';
  final LoginController _loginController = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [lPrimaryColor, lLinearGradientColor1],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                maxRadius: Get.height * 0.09,
                child: CircleAvatar(
                  maxRadius: Get.height * 0.088,
                  backgroundImage: const AssetImage('assets/images/h1.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CTextField(
              labelText: 'Username',
              controller: _loginController.username,
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => CTextField(
                labelText: 'password',
                controller: _loginController.password,
                obscureText: !_loginController.isPwdVisible.value,
                maxLine: 1,
                suffixIcon: IconButton(
                  icon: Icon(
                    _loginController.isPwdVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    _loginController.passVisibleToggle();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await _loginController.login(_loginController.username.text,
                      _loginController.password.text);
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
