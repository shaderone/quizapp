import 'package:flutter/material.dart';

import '../config/Themes/ui_parameters.dart';

class Gap {
  static Widget square(double size) {
    return SizedBox(width: size, height: size);
  }

  static Widget horizontal(double sizeH) {
    return SizedBox(width: sizeH, height: 0);
  }

  static Widget vertical(double sizeV) {
    return SizedBox(width: 0, height: sizeV);
  }
}

TextStyle cardTitleTextStyleUtil(context) => TextStyle(
      color: UiParameters.isDarkMode() ? Theme.of(context).textTheme.bodyLarge!.color : Theme.of(context).primaryColorLight,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

TextStyle cardStatTextStyleUtil(context) => TextStyle(
      color: UiParameters.isDarkMode() ? Theme.of(context).textTheme.bodyLarge!.color : Theme.of(context).primaryColorLight,
      fontSize: 13,
    );
