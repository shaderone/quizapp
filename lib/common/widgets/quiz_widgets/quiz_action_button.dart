import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_paper/questions_controller.dart';

class QuizActionButton extends GetView<QuestionsController> {
  const QuizActionButton({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(elevation: MaterialStatePropertyAll(0)),
      onPressed: onPressed,
      child: Text(controller.isLastQuestion ? "Complete" : "Next"),
    );
  }
}
