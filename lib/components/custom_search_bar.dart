// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:mybusiness/core/models/user_model.dart';
// import 'package:mybusiness/design/utils/extensions.dart';
// import 'package:vibration/vibration.dart';

// import '../../core/models/transaction.dart';
// import '../screens/home/dashboardController.dart';
// import '../utils/app_colors.dart';
// import '../utils/app_text_theme.dart';
// import '../utils/enums.dart';

// class CustomSearchDelegate extends SearchDelegate {
//   CustomSearchDelegate({required this.userModel});
//   UserModel userModel;
//   DashboardController dashboardController = Get.put(DashboardController());
//   RxList<TransactionRecord> searchTransactionRecord =
//       RxList<TransactionRecord>([]);

// // Demo list to show querying
//   List<String> searchTerms = [
//     "Apple",
//     "Banana",
//     "Mango",
//     "Pear",
//     "Watermelons",
//     "Blueberries",
//     "Pineapples",
//     "Strawberries"
//   ];

// // first overwrite to
// // clear the search text
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }

// // second overwrite to pop out of search menu
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }

// // third overwrite to show query result
//   @override
//   Widget buildResults(BuildContext context) {
//     searchTransactionRecord = RxList<TransactionRecord>([]);
//     for (TransactionRecord tr in dashboardController.transactionRecordList) {
//       if (tr.note.toLowerCase().contains(query.toLowerCase())) {
//         searchTransactionRecord.add(tr);
//       }
//     }
//     return transactionList(searchTransactionRecord);
//   }

// // last overwrite to show the
// // querying process at the runtime
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // return transactionList(searchTransactionRecord);

//     searchTransactionRecord = RxList<TransactionRecord>([]);
//     for (TransactionRecord tr in dashboardController.transactionRecordList) {
//       if (tr.note.toLowerCase().contains(query.toLowerCase())) {
//         searchTransactionRecord.add(tr);
//       }
//     }
//     return transactionList(searchTransactionRecord);
//   }

//   Padding transactionList(RxList<TransactionRecord> tList) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: Get.height * 0.72,
//               width: Get.width,
//               child: Obx(
//                 () => Visibility(
//                   visible: tList.isNotEmpty,
//                   replacement: Center(
//                     child: Lottie.asset('assets/loties/empty.json'),
//                   ),
//                   child: ListView.builder(
//                     reverse: true,
//                     itemCount: tList.length,
//                     // itemCount:  snap.data?.docs.length,
//                     itemBuilder: (context, index) {
//                       TransactionRecord transactionRecord = tList[index];
//                       // var tid = transactionList[index].id;
//                       var product = dashboardController.productList
//                           .firstWhereOrNull((element) =>
//                               element.pid == transactionRecord.productId)
//                           ?.pname;

//                       bool isOwnMsg =
//                           transactionRecord.updatedBy == dashboardController.uid
//                               ? true
//                               : false;

//                       bool? condition = DashboardController.currentUserRole ==
//                               Roles.admin.name
//                           ? (((transactionRecord.createdBy == userModel.uid) &&
//                                   transactionRecord.isDeleted == false)
//                               ? true
//                               : false)
//                           : (((userModel.uid == transactionRecord.parentID) &&
//                                   transactionRecord.isDeleted == false)
//                               ? true
//                               : false);

//                       Rx<bool> isNoteVisible = false.obs;

//                       return GestureDetector(
//                         onDoubleTap: () async {
//                           // print(await Vibration.hasCustomVibrationsSupport());
//                           // print(await Vibration.hasVibrator());
//                           isNoteVisible.value = true;
//                           Timer(const Duration(seconds: 3), () {
//                             // print('done');
//                             isNoteVisible.value = false;
//                           });

//                           // Timer.periodic(const Duration(seconds: 5), (timer) {
//                           // });

//                           if (await Vibration.hasVibrator() ?? false) {
//                             Vibration.vibrate();
//                           }
//                         },
//                         child: Slidable(
//                           endActionPane: ActionPane(
//                             extentRatio: 0.3,
//                             // A motion is a widget used to control how the pane animates.
//                             motion: const ScrollMotion(),

//                             // A pane can dismiss the Slidable.
//                             dismissible: DismissiblePane(onDismissed: () {}),

//                             // All actions are defined in the children parameter.
//                             children: [
//                               // A SlidableAction can have an icon and/or a label.
//                               SlidableAction(
//                                 flex: 1,
//                                 borderRadius: BorderRadius.circular(5),
//                                 onPressed: (context) async {
//                                   transactionRecord.deletedAt = Timestamp.now();
//                                   transactionRecord.deletedBy =
//                                       dashboardController.uid;
//                                   transactionRecord.isDeleted = true;
//                                   // await dashboardController.changeTransactionState(
//                                   //     tid, transactionRecord);

//                                   "transaction deleted successfull."
//                                       .errorSnackbar;
//                                 },
//                                 backgroundColor: lPrimaryColor,
//                                 foregroundColor: Colors.white,
//                                 icon: Icons.delete,
//                                 label: 'Delete',
//                               ),
//                             ],
//                           ),
//                           child: Visibility(
//                             visible: (DateTime.fromMillisecondsSinceEpoch(
//                                             transactionRecord.date.seconds *
//                                                 1000)
//                                         .month ==
//                                     (dashboardController.month.value + 1) &&
//                                 condition),
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                   right: isOwnMsg ? 0 : Get.width * 0.2,
//                                   left: isOwnMsg ? Get.width * 0.2 : 0,
//                                   top: 3,
//                                   bottom: 3),
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: isOwnMsg
//                                     ? lPrimaryColor.withOpacity(.2)
//                                     : greyColor1.withOpacity(.2),
//                               ),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(child: Text(product.toString())),
//                                       SizedBox(
//                                         child: Text(
//                                           transactionRecord.qty.toString(),
//                                           style: TextThemeX.text12.copyWith(),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         child: Text(
//                                           transactionRecord.price
//                                               .toStringAsFixed(2),
//                                           style: TextThemeX.text12.copyWith(),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         child: Text(
//                                           (transactionRecord.qty *
//                                                   transactionRecord.price)
//                                               .toStringAsFixed(2),
//                                           style: TextThemeX.text12.copyWith(),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         DateFormat("dd MMM,yyyy hh:mm a")
//                                             .format(DateTime
//                                                 .fromMillisecondsSinceEpoch(
//                                                     transactionRecord
//                                                             .date.seconds *
//                                                         1000)),
//                                         style: TextThemeX.text12.copyWith(
//                                             color: blackColor3.withOpacity(.3)),
//                                       ),
//                                     ],
//                                   ),
//                                   Obx(
//                                     () => Visibility(
//                                       visible: isNoteVisible.value,
//                                       child: SizedBox(
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'NOTE: ',
//                                               style: TextThemeX.text12.copyWith(
//                                                   color: blackColor3
//                                                       .withOpacity(.5)),
//                                             ),
//                                             Flexible(
//                                               child: Text(
//                                                 transactionRecord.note,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 maxLines: 2,
//                                                 style:
//                                                     TextThemeX.text12.copyWith(
//                                                   color: blackColor3
//                                                       .withOpacity(.3),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(right: Get.width * 0.18),
//               width: Get.width * 0.75,
//               decoration: BoxDecoration(
//                 // color: Colors.grey,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Divider(color: greyColor10),
//                   Text(
//                     'Total Transaction:',
//                     style:
//                         TextThemeX.text14.copyWith(fontWeight: FontWeight.w600),
//                   ),
//                   Obx(() => Text(
//                         '₹${dashboardController.total.value}',
//                         style: TextThemeX.text16
//                             .copyWith(fontWeight: FontWeight.w600),
//                       )),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
