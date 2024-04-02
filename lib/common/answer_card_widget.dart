import 'package:flutter/material.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
import 'package:quiz_app/config/Themes/ui_parameters.dart';
import 'package:quiz_app/screens/question/test_overview_screen.dart';

class AnswerCardWidget extends StatelessWidget {
  const AnswerCardWidget({super.key, required this.answer, required this.onTap, this.isSelected = false, required this.identifier});

  final String answer;
  final String identifier;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox.fromSize(
        size: const Size.fromHeight(60),
        child: Card(
          elevation: 0,
          color: isSelected ? selectedAnswerColor() : Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardBorderRadius),
            side: BorderSide(
              color: isSelected ? selectedAnswerColor() : selectedAnswerBorderColor(),
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "$identifier.",
                    style: TextStyle(
                      color: isSelected ? ksurfaceTextColor : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    answer,
                    style: TextStyle(color: isSelected ? ksurfaceTextColor : Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Cards for AnswerTypes

class AnswerCardTypeWidget extends StatelessWidget {
  const AnswerCardTypeWidget({super.key, required this.answer, required this.answerStatus});

  final String answer;
  final AnswerStatus answerStatus;

  @override
  Widget build(BuildContext context) {
    late Color color;
    if (answerStatus == AnswerStatus.correct) {
      color = correctAnswerColor;
    } else if (answerStatus == AnswerStatus.wrong) {
      color = wrongAnswerColor;
    } else if (answerStatus == AnswerStatus.unAnswered) {
      color = unAnswerColor;
    }

    return Ink(
      child: SizedBox.fromSize(
        size: const Size.fromHeight(60),
        child: Card(
          elevation: 0,
          color: color.withOpacity(0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cardBorderRadius)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                answer,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
