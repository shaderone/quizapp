// ** This is where we'll identify the current thememode.

import 'package:flutter/material.dart';

class UiParameters {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
