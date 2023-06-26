import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nesscale_test/components/app_colors.dart';

extension BuildContextExtension on String {
  dynamic get errorSnackbar => Get
    ..closeAllSnackbars()
    ..rawSnackbar(
      message: this,
      backgroundColor: Colors.red,
    );

  dynamic get successSnackbar => Get
    ..closeAllSnackbars()
    ..rawSnackbar(
      message: this,
      backgroundColor: Colors.green,
    );

  dynamic get infoSnackbar => Get
    ..closeAllSnackbars()
    ..rawSnackbar(
      message: this,
      backgroundColor: lPrimaryColor,
    );
}
