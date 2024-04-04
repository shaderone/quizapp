import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
import 'package:quiz_app/config/Themes/ui_parameters.dart';

import '../controllers/theme_controller/theme_controller.dart';

// ** this widget is for the background
class ContentArea extends StatelessWidget {
  const ContentArea({super.key, this.addPadding = true, required this.child});

  final bool addPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Obx(() {
        return Ink(
          decoration: BoxDecoration(
            color: Get.find<ThemeController>().isDarkModeEnabled.value ? customScaffodColor() : customScaffodColor(),
          ),
          //padding: addPadding ? EdgeInsets.only(top: mobileScreenPadding, left: mobileScreenPadding, right: mobileScreenPadding) : EdgeInsets.zero,
          padding: addPadding ? EdgeInsets.all(mobileScreenPadding) : EdgeInsets.zero,
          child: child,
        );
      }),
    );
  }
}
