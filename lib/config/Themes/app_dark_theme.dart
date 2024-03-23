import 'package:flutter/material.dart';
import 'package:quiz_app/config/Themes/app_light_theme.dart';
import 'sub_theme_data_mixin.dart';

const Color primaryColorDark = Color(0xFF2e3c62);
const Color primaryColorDarkSub = Color(0xFF99ace1);
//const Color primaryTextColorDark = Color.fromARGB(255, 228, 228, 228);

class DarkThemeData with SubThemeData {
  //This method will create the lightTheme
  ThemeData buildDarkTheme() {
    ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      primaryColor: primaryColorDark,
      primaryColorDark: primaryColorDarkSub,
      iconTheme: getIconTheme(),
      textTheme: getTextTheme().apply(
        displayColor: primaryTextColorLight,
        bodyColor: primaryTextColorLight,
      ),
    );
  }
}
