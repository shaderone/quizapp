// ** This is where we'll identify the current thememode.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double _mobileScreenPadding = 25.0;
const double _cardBorderRadius = 10.0;

double get mobileScreenPadding => _mobileScreenPadding;
double get cardBorderRadius => _cardBorderRadius;

class UiParameters {
  //These Get variables are the above get identifiers
  static BorderRadius get cardBorderRadius => BorderRadius.circular(_cardBorderRadius);
  static EdgeInsets get mobileScreenPadding => const EdgeInsets.all(_mobileScreenPadding);

  static bool isDarkMode() {
    // use Get to replace without
    //return Theme.of(context).brightness == Brightness.dark;
    return Get.isDarkMode ? true : false;
  }
}
