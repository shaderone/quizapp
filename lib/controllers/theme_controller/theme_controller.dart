import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/config/Themes/app_dark_theme.dart';
import 'package:quiz_app/config/Themes/app_light_theme.dart';

class ThemeController extends GetxController {
  late ThemeData _lightTheme;
  late ThemeData _darkTheme;

  @override
  void onInit() {
    initializeTheme();
    super.onInit();
  }

  void initializeTheme() {
    _lightTheme = LightThemeData().buildLightTheme();
    _darkTheme = DarkThemeData().buildDarkTheme();
  }

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;
}
