import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/config/Themes/ui_parameters.dart';
import 'package:quiz_app/screens/home/question_card.dart';
import '../../controllers/question_paper/question_paper_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestionPaperController questionPaperController = Get.find<QuestionPaperController>();
    //print(questionPaperController.questionPapersList.length);
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => ListView.separated(
            padding: UiParameters.mobileScreenPadding,
            shrinkWrap: true,
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
    );
  }
}
