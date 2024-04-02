import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_paper/questions_controller.dart';

import '../screens/question/test_overview_screen.dart';

class QuizActionButton extends GetView<QuestionsController> {
  const QuizActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(elevation: MaterialStatePropertyAll(0)),
      onPressed: () {
        controller.isLastQuestion ? Get.toNamed(TestOverviewScreen.testOverviewScreenRouteName) : controller.nextQuestion();
      },
      child: Text(controller.isLastQuestion ? "Complete" : "Next"),
    );
  }
}
