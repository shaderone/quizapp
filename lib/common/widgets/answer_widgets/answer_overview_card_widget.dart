import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
import 'package:quiz_app/config/Themes/ui_parameters.dart';
import 'package:quiz_app/screens/question/test_overview_screen.dart';

class AnswerOverviewCardWidget extends StatelessWidget {
  const AnswerOverviewCardWidget({super.key, required this.index, required this.answerStatus, required this.onTap});

  final int index;
  final AnswerStatus answerStatus;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColorLight;

    //To give custom Background color as per Answer Status
    switch (answerStatus) {
      case AnswerStatus.answered:
        backgroundColor = Get.isDarkMode ? const Color.fromARGB(255, 97, 137, 248) : Theme.of(context).primaryColorLight;
        break;
      case AnswerStatus.correct:
        backgroundColor = correctAnswerColor;
        break;
      case AnswerStatus.wrong:
        backgroundColor = wrongAnswerColor;
        break;
      case AnswerStatus.unAnswered:
        backgroundColor = Get.isDarkMode ? const Color.fromARGB(255, 237, 61, 61).withOpacity(0.8) : Theme.of(context).primaryColorLight.withOpacity(0.1);
        break;
      default:
        backgroundColor = Theme.of(context).primaryColorLight.withOpacity(0.1);
    }

    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: UiParameters.cardBorderRadius,
        ),
        child: Center(
          child: Text(
            index.toString(),
            style: const TextStyle(
              color: ksurfaceTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
