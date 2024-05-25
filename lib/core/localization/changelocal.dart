import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/services.dart';

class LocaleController extends GetxController {
  Locale? language;

  MyServices myServices = Get.find();

  changeLang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreferences.setString("lang", langcode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      myServices.sharedPreferences.setString("step", "1");
      // appTheme = themeArabic;
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      myServices.sharedPreferences.setString("step", "1");
      // appTheme = themeEnglish;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      // appTheme = themeEnglish;
    }
    super.onInit();
  }
}
