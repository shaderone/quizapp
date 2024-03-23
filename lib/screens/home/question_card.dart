import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common/widgets.dart';
import 'package:quiz_app/models/question_paper_model.dart';

import '../../config/Themes/ui_parameters.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.paperData});

  final QuestionPaperModel paperData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ColoredBox(
                color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                child: SizedBox(
                  height: Get.width * 0.15,
                  width: Get.width * 0.15,
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
                  Text(paperData.description),
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
      ],
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
          color: UiParameters.isDarkMode() ? Colors.white : Theme.of(context).primaryColorLight,
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
