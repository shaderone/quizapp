import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common/widgets/ui_widgets/content_area_widget.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
import 'package:quiz_app/config/Themes/ui_parameters.dart';
import 'package:quiz_app/config/app_icons.dart';
import 'package:quiz_app/controllers/auth_controller.dart';
import 'package:quiz_app/controllers/theme_controller/theme_controller.dart';
import 'package:quiz_app/screens/home/menu_screen.dart';
import 'package:quiz_app/screens/home/question_card.dart';
import '../../controllers/question_paper/question_paper_controller.dart';
import '../../controllers/drawer_menu_controller.dart';

enum PopupValue { toggleTheme, logout }

class HomeScreen extends GetView<DrawerMenuController> {
  const HomeScreen({super.key});

  static const String homeScreenRouteName = "/home";

  @override
  Widget build(BuildContext context) {
    final QuestionPaperController questionPaperController = Get.find<QuestionPaperController>();

    return Scaffold(
      body: GetBuilder<DrawerMenuController>(
        builder: (controller) {
          return ZoomDrawer(
            controller: controller.drawerMenuController,
            borderRadius: 50.0,
            angle: 0.0,
            slideWidth: MediaQuery.of(context).size.width * 0.7,
            mainScreenScale: .2,
            mainScreenTapClose: true,
            menuScreen: const MenuScreen(),
            mainScreen: Obx(() {
              return Container(
                decoration: BoxDecoration(
                  gradient: Get.find<ThemeController>().isDarkModeEnabled.value == true ? gradientDarkTheme : gradientLightTheme,
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(mobileScreenPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: controller.toggleDrawer,
                              icon: const Icon(
                                AppIcons.menuLeft,
                              ),
                            ),
                            GetBuilder<AuthController>(
                              builder: (authController) {
                                String profileUrl;
                                final user = authController.currentUser;
                                if (user == null || user.photoURL == null || user.photoURL!.isEmpty) {
                                  profileUrl = "https://i.stack.imgur.com/frlIf.png";
                                } else {
                                  profileUrl = user.photoURL!;
                                }
                                return !authController.isUserLoggedIn()
                                    ? const Text(
                                        "Quiz App",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : GetBuilder<ThemeController>(
                                        builder: (themeController) {
                                          return PopupMenuButton(
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundImage: NetworkImage(profileUrl),
                                            ),
                                            onSelected: (value) {
                                              if (value == PopupValue.toggleTheme) {
                                                themeController.isDarkModeEnabled.value = !themeController.isDarkModeEnabled.value;
                                              } else if (value == PopupValue.logout) {
                                                controller.signOut();
                                              }
                                            },
                                            itemBuilder: (context) {
                                              return [
                                                const PopupMenuItem(
                                                  value: PopupValue.toggleTheme,
                                                  child: Text("Change Theme"),
                                                ),
                                                const PopupMenuItem(
                                                  value: PopupValue.logout,
                                                  child: Text("Logout"),
                                                )
                                              ];
                                            },
                                          );
                                        },
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ContentArea(
                            addPadding: false,
                            child: Obx(
                              () => ListView.separated(
                                padding: UiParameters.mobileScreenPadding,
                                itemCount: questionPaperController.questionPapersList.length,
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(height: 20);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: QuestionCard(
                                      paperData: questionPaperController.questionPapersList[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
