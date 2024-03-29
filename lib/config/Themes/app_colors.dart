// ** This is where we'll deal with the color related stuffs, like its configs and conditional checking

import 'package:flutter/material.dart';
import 'package:quiz_app/config/Themes/app_dark_theme.dart';
import 'package:quiz_app/config/Themes/app_light_theme.dart';
import 'package:quiz_app/config/Themes/ui_parameters.dart';

//colors
const Color ksurfaceTextColor = Colors.white;

// gradient for light theme
const gradientLightTheme = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    primaryColorLight,
    primaryColorLightSub,
  ],
);

// gradient for dark theme
const gradientDarkTheme = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    primaryColorDark,
    primaryColorDarkSub,
  ],
);

// choose the required theme programatically
LinearGradient getGradient() => UiParameters.isDarkMode() ? gradientDarkTheme : gradientLightTheme;

Color customScaffodColor() {
  return UiParameters.isDarkMode() ? const Color(0xFF2e3c62) : const Color.fromARGB(255, 240, 237, 255);
}
