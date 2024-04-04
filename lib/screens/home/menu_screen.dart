import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/common/utils.dart';
import 'package:quiz_app/config/Themes/ui_parameters.dart';
import 'package:quiz_app/controllers/drawer_menu_controller.dart';

class MenuScreen extends GetView<DrawerMenuController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.maxFinite,
        child: Theme(
          data: ThemeData(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.black54),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(mobileScreenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () {
                    if (controller.user.value != null) {
                      return Column(
                        children: [
                          controller.user.value!.photoURL != null
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(controller.user.value!.photoURL!),
                                )
                              : CircleAvatar(
                                  child: Text(controller.user.value!.displayName![0]),
                                ),
                          Gap.vertical(10),
                          Text(
                            controller.user.value?.displayName ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi There,",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          Text(
                            "Please login to Continue",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                Gap.vertical(20),
                _DrawerButtonWidget(onTap: () => controller.openWebsite(), icon: Icons.web, label: "Website"),
                _DrawerButtonWidget(onTap: () => controller.sendMail(), icon: Icons.email, label: "Email"),
                const Spacer(flex: 1),
                Obx(() {
                  if (controller.user.value == null) {
                    return _DrawerButtonWidget(onTap: () => controller.signIn(), icon: Icons.login, label: "Sign In");
                  } else {
                    return _DrawerButtonWidget(onTap: () => controller.signOut(), icon: Icons.logout, label: "Sign out");
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerButtonWidget extends StatelessWidget {
  const _DrawerButtonWidget({required this.onTap, required this.icon, required this.label});

  final void Function() onTap;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
