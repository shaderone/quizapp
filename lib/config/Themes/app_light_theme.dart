import 'package:flutter/material.dart';
import 'package:quiz_app/config/Themes/sub_theme_data_mixin.dart';

const Color primaryColorLight = Color(0xFF3ac3cb);
const Color primaryColorLightSub = Color(0xFFf85187);
const Color primaryTextColorLight = Color.fromARGB(255, 40, 40, 40);

class LightThemeData with SubThemeData {
  //This method will create the lightTheme
  ThemeData buildLightTheme() {
    ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      iconTheme: getIconTheme(),
      textTheme: getTextTheme().apply(
        displayColor: primaryTextColorLight,
        bodyColor: primaryTextColorLight,
      ),
    );
  }
}
