import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:nesscale_test/modal/user_credential.dart';
import 'package:nesscale_test/screen/customer/customer.dart';
import 'package:nesscale_test/screen/profile/profile.dart';

import '../screen/item/items.dart';
import '../screen/login/loginscreen.dart';
import '../service/gs_services.dart';
import 'app_colors.dart';

class CustomeDrawer extends StatelessWidget {
  var userEmail = "info@nesscale.com";
  var userName = "Anonymous";

  CustomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          AnimationLimiter(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: Get.height * 0.28,
                  child: UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: lPrimaryColor,
                    ),
                    accountName: Text(userName.toString()),
                    accountEmail: Text(userEmail.toString()),
                    currentAccountPicture: Hero(
                      tag: "userphoto",
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [whiteColor1, whiteColor1],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          maxRadius: Get.height * 0.08,
                          child: CircleAvatar(
                            maxRadius: Get.height * 0.078,
                            backgroundImage:
                                const AssetImage('assets/images/h1.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedItem(
                  icon: const Icon(Icons.home),
                  itemName: "home",
                  onTap: () => Get.back(),
                ),
                AnimatedItem(
                  icon: const Icon(Icons.poll_rounded),
                  itemName: "products",
                  onTap: () => Get.toNamed(Items.route),
                ),
                AnimatedItem(
                  icon: const Icon(Icons.person),
                  itemName: "customer",
                  onTap: () => Get.toNamed(Customers.route),
                ),
                AnimatedItem(
                  icon: const Icon(Icons.settings),
                  itemName: "settings",
                  // onTap: () => Get.toNamed(SettingPage.routeName),
                ),
                AnimatedItem(
                  icon: const Icon(Icons.contacts),
                  itemName: "contact_us".tr,
                  onTap: () => Get.back(),
                ),
                AnimatedItem(
                  icon: const Icon(Icons.logout),
                  itemName: "logout".tr,
                  onTap: () => {
                    Get.back(),
                    GSServices.setUser(
                        user: UserCred(id: 1, username: "", password: "")),
                    Get.offAllNamed(LoginScreen.route),
                  },
                ),
              ],
            ),
          ),
          Positioned(
            height: Get.height * 0.40,
            left: Get.width * 0.65,
            child: IconButton(
              onPressed: () => Get.toNamed(Profile.route),
              icon: const Icon(
                Icons.edit,
                color: whiteColor1,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class AnimatedItem extends StatelessWidget {
  AnimatedItem({
    super.key,
    this.icon,
    required this.itemName,
    this.onTap,
  });
  Icon? icon;
  String? itemName;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: ListTile(
            leading: icon, //const Icon(Icons.home),
            title: Text(itemName.toString()),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
