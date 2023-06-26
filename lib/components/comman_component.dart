// import 'dart:developer';



// FadeIn googleSingInButton(AuthController authController) {
//   return FadeIn(
//     child: Obx(
//       () => InkWell(
//         onTap: () async {
//           // Get.back();
//           authController.isLoading.value = true;
//           try {
//             await authController.signInWithGoogle(
//                 role: authController.selectedRole.value.toShortString());
//           } catch (e) {
//             e.toString().errorSnackbar;
//           }
//           authController.isLoading.value = false;
//           // Get.offAllNamed(Dashboard.routeName);
//         },
//         child: Container(
//           alignment: Alignment.center,
//           margin: EdgeInsets.symmetric(
//             horizontal: Get.width * 0.1,
//             vertical: Get.height * 0.01,
//           ),
//           height: Get.height * 0.06,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.grey.withOpacity(.2),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Visibility(
//             visible: authController.isLoading.value,
//             replacement: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SvgPicture.asset('assets/icons/iconGoogle.svg'),
//                 SizedBox(width: Get.width * 0.05),
//                 Text(
//                   'Sign up with Google',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w700,
//                     fontSize: Get.width * 0.038,
//                   ),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: circularProgressIndicator(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// CircularProgressIndicator circularProgressIndicator() {
//   return const CircularProgressIndicator(
//     color: lPrimaryColor,
//   );
// }

// Container DashboardTile(UserModel data) {
//   var name = data.name;
//   var photo = data.photoUrl;
//   var email = data.email;
//   final FlipCardController controller = FlipCardController();

//   // var name = data?.get('name');
//   // var photo = data?.get('photoUrl');
//   // var email = data?.get('email');
//   return Container(
//     margin: const EdgeInsets.symmetric(
//       horizontal: 0,
//       vertical: 0,
//     ),
//     child: GestureDetector(
//       onLongPress: () async {
//         if (await Vibration.hasVibrator() ?? false) {
//           Vibration.vibrate(duration: 200, amplitude: 100);

//           log('vibrate');
//         }
//         await controller.toggleCard();
//       },
//       onTap: () async {
//         DashboardController dashboardController =
//             Get.put(DashboardController());

//         dashboardController.transactionRecord(
//             SelectedMonth: dashboardController.month.value + 1,
//             idList: [data.uid]);
//         print(dashboardController.transactionRecordList);

//         Get.toNamed(DashboardTransaction.routeName, arguments: data);
//       },
//       child: ListTile(
//         leading: FlipCard(
//           controller: controller,
//           back: CircleAvatar(
//               backgroundColor: lPrimaryColor.withOpacity(.2),
//               radius: 24,
//               child: const Icon(
//                 Icons.done,
//                 color: lPrimaryColor,
//               )),
//           front: CircleAvatar(
//             backgroundColor: lPrimaryColor.withOpacity(.2),
//             radius: 24,
//             backgroundImage: photo != null
//                 ? NetworkImage(
//                     photo,
//                   )
//                 : null,
//             child: photo == null
//                 ? Text(
//                     name != null
//                         ? name.substring(0, 1).toUpperCase()
//                         : 'No Name',
//                     style: TextThemeX.text16,
//                   )
//                 : null,
//           ),
//         ),
//         title: Text(
//           name ?? 'No Name',
//           style: TextThemeX.text14,
//         ),
//         subtitle: Text(
//           email ?? 'No Email',
//           style: TextThemeX.text12,
//         ),
//       ),
//     ),
//   );
// }
