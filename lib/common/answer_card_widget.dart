import 'package:flutter/material.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
import 'package:quiz_app/config/Themes/ui_parameters.dart';

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
