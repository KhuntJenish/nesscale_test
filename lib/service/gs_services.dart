import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nesscale_test/modal/user_credential.dart';

class GSServices {
  GSServices._();

  static final GetStorage _userGS = GetStorage('user');

  static Future<void> initialize() async {
    await GetStorage.init('user');
  }

  static Future<void> setUser({required UserCred user}) async {
    await _userGS.write('user', user.toJson());
    debugPrint("<--- Local User Updated => ${getUser?.toString()} --->");
  }

  static UserCred? get getUser => isNullEmptyOrFalse(_userGS.read('user'))
      ? null
      : UserCred.fromJson(_userGS.read('user'));

  static Future<void> clearLocalStorage() async {
    await _userGS.erase();
  }

  static String defaultStringAssertion = "-";
  static int defaultIntAssertion = -1;
  static double defaultDoubleAssertion = -1.0;
  static bool isNullEmptyOrFalse(dynamic o) {
    if (o is Map<String, dynamic> || o is List<dynamic>) {
      return o == null || o.length == 0;
    }
    return o == null ||
        o == false ||
        o == "" ||
        o == defaultIntAssertion ||
        o == defaultStringAssertion ||
        o == defaultDoubleAssertion;
  }
}
