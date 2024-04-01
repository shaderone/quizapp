import 'package:flutter/material.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
import 'package:quiz_app/config/app_icons.dart';

class CustomAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbarWidget({
    super.key,
    this.title = "",
    this.showActonIcon = false,
    this.titleWidget,
    this.leadingWidget,
    this.onMenuTap,
  });

  final String title;
  final Widget? titleWidget;
  final bool showActonIcon;
  final Widget? leadingWidget;
  final VoidCallback? onMenuTap;
  //final Widget? timer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppBar(
        automaticallyImplyLeading: leadingWidget == null ? false : true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: titleWidget ?? Text(title),
        centerTitle: true,
        leading: leadingWidget,
        toolbarHeight: 80,
        leadingWidth: 120,
        actions: [
          IconButton(
            onPressed: onMenuTap,
            icon: const Icon(AppIcons.quizMenuIcon, color: ksurfaceTextColor),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}
