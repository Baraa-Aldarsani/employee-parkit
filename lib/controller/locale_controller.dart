import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class LocaleController extends GetxController {
  Locale initlang =
  sharedpref!.getString("lang") == "ar" ? Locale("ar") : Locale("en");

  void changeLanguage(String codelang) {
    Locale currentlang = Locale(codelang);
    sharedpref!.setString("lang", codelang);
    Get.updateLocale(currentlang);
  }
}
