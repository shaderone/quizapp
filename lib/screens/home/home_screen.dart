import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common/content_area.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
import 'package:quiz_app/config/Themes/ui_parameters.dart';
import 'package:quiz_app/config/app_icons.dart';
import 'package:quiz_app/screens/home/menu_screen.dart';
import 'package:quiz_app/screens/home/question_card.dart';
import '../../controllers/question_paper/question_paper_controller.dart';
import '../../controllers/drawer_menu_controller.dart';

class HomeScreen extends GetView<DrawerMenuController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestionPaperController questionPaperController = Get.find<QuestionPaperController>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: getGradient()),
        child: GetBuilder<DrawerMenuController>(
          builder: (controller) {
            return ZoomDrawer(
              controller: controller.drawerMenuController,
              //showShadow: true,
              //menuBackgroundColor: Colors.transparent,
              borderRadius: 50.0,
              angle: 0.0,
              slideWidth: MediaQuery.of(context).size.width * 0.7,
              mainScreenScale: .2,
              mainScreenTapClose: true,
              menuScreen: const MenuScreen(),
              mainScreen: Container(
                decoration: BoxDecoration(gradient: getGradient()),
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
                            const Text(
                              "Quiz App",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
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
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
