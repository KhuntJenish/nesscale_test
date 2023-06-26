import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nesscale_test/screen/customer/customer.dart';
import 'package:nesscale_test/screen/dashboard/dashboard.dart';
import 'package:nesscale_test/screen/profile/profile.dart';

import 'screen/item/items.dart';
import 'screen/login/loginscreen.dart';
import 'service/gs_services.dart';
import 'service/sqlite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SqlService.openDB();
  await GSServices.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      defaultTransition: Transition.cupertino,
      initialRoute: GSServices.getUser?.id == 1 || GSServices.getUser == null
          ? LoginScreen.route
          : Dashboard.route,
      getPages: [
        GetPage(name: LoginScreen.route, page: () => LoginScreen()),
        GetPage(name: Dashboard.route, page: () => Dashboard()),
        GetPage(name: Profile.route, page: () => Profile()),
        GetPage(name: Items.route, page: () => Items()),
        GetPage(name: Customers.route, page: () => Customers()),
      ],
    );
  }
}
