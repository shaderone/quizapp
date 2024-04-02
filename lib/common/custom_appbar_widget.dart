import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
import 'package:quiz_app/config/app_icons.dart';
import 'package:quiz_app/screens/question/test_overview_screen.dart';

class CustomAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbarWidget({
    super.key,
    this.title = "",
    this.showActonIcon = false,
    this.titleWidget,
    this.leadingWidget,
    this.onMenuTap,
    required this.automaticallyImplyLeading,
  });

  final String title;
  final Widget? titleWidget;
  final bool showActonIcon;
  final Widget? leadingWidget;
  final VoidCallback? onMenuTap;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: titleWidget ?? Text(title),
        centerTitle: leadingWidget == const SizedBox() ? false : true,
        leading: leadingWidget,
        toolbarHeight: 80,
        leadingWidth: leadingWidget != null ? 120 : 50,
        actions: [
          showActonIcon
              ? IconButton(
                  onPressed: onMenuTap ?? () => Get.toNamed(TestOverviewScreen.testOverviewScreenRouteName),
                  icon: const Icon(AppIcons.quizMenuIcon, color: ksurfaceTextColor),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}
