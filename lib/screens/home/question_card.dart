import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common/utils.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
import 'package:quiz_app/config/app_icons.dart';
import 'package:quiz_app/controllers/question_paper/question_paper_controller.dart';
import 'package:quiz_app/models/question_paper_model.dart';

import '../../config/Themes/ui_parameters.dart';

class QuestionCard extends GetView<QuestionPaperController> {
  const QuestionCard({super.key, required this.paperData});

  final QuestionPaperModel paperData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.navigateToQuestions(questionPaperModel: paperData, context: context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cardBorderRadius),
          color: Get.isDarkMode ? ksurfaceTextColor : Theme.of(context).cardColor,
        ),
        padding: const EdgeInsets.all(10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ColoredBox(
                    color: Get.isDarkMode ? const Color(0xFF2e3c62).withOpacity(0.5) : Theme.of(context).primaryColorLight.withOpacity(0.1),
                    child: SizedBox(
                      height: Get.width * 0.125,
                      width: Get.width * 0.125,
                      child: CachedNetworkImage(
                        imageUrl: paperData.imageUrl,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) => Image.asset("assets/images/app_splash_logo.png"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paperData.title,
                        style: cardTitleTextStyleUtil(context),
                      ),
                      Gap.vertical(10),
                      Text(
                        paperData.description,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Gap.vertical(10),
                      Row(
                        children: [
                          CardStatWidget(text: "${paperData.questionCount} questions", icon: Icons.help_outline_sharp),
                          Gap.horizontal(10),
                          CardStatWidget(text: paperData.timeInMinutes, icon: Icons.timer),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: -14,
              right: -10.5,
              child: IconButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  backgroundColor: MaterialStateProperty.all(
                    Get.isDarkMode ? const Color(0xFF2e3c62).withOpacity(0.5) : Theme.of(context).primaryColorLight,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(cardBorderRadius),
                        bottomRight: Radius.circular(cardBorderRadius),
                      ),
                    ),
                  ),
                ),
                icon: const Icon(AppIcons.trophyOutline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardStatWidget extends StatelessWidget {
  const CardStatWidget({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: UiParameters.isDarkMode() ? const Color(0xFF2e3c62) : Theme.of(context).primaryColorLight.withOpacity(0.7),
        ),
        Gap.horizontal(5),
        Text(
          text,
          style: cardStatTextStyleUtil(context),
        ),
      ],
    );
  }
}
