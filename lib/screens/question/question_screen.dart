import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common/background_decoration_widget.dart';
import 'package:quiz_app/controllers/question_paper/questions_controller.dart';

class QuestionScreen extends GetView<QuestionsController> {
  const QuestionScreen({super.key});

  static const String questionScreenRouteName = "/start_quiz";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //appBar: AppBar(),
      body: BackgroundDecorationWidget(
        //showCustomGradient: false,
        child: Center(child: Text("hey")),
      ),
    );
    //return const BackgroundDecorationWidget(child: Center(child: Text("hey")));
  }
}
