import 'package:flutter/material.dart';
import 'package:quiz_app/config/Themes/sub_theme_data_mixin.dart';

const Color primaryColorLight = Color(0xFF3ac3cb);
const Color primaryColorLightSub = Color(0xFFf85187);
const Color primaryTextColorLight = Color.fromRGBO(40, 40, 40, 1);
const Color cardColor = Colors.white;

class LightThemeData with SubThemeData {
  //This method will create the lightTheme
  ThemeData buildLightTheme() {
    ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      primaryColor: primaryColorLight,
      primaryColorLight: primaryColorLightSub,
      cardColor: cardColor,
      iconTheme: getIconTheme(),
      textTheme: getTextTheme().apply(
        displayColor: primaryTextColorLight,
        bodyColor: primaryTextColorLight,
      ),
    );
  }
}
