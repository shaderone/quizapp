import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common/answer_overview_card_widget.dart';
import 'package:quiz_app/common/background_decoration_widget.dart';
import 'package:quiz_app/common/common_widgets.dart';
import 'package:quiz_app/common/content_area_widget.dart';
import 'package:quiz_app/common/custom_appbar_widget.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
import 'package:quiz_app/controllers/question_paper/questions_controller.dart';
import 'package:quiz_app/controllers/question_paper/questions_controller_extension.dart';
import 'package:quiz_app/screens/home/home_screen.dart';
import 'package:quiz_app/screens/question/test_overview_screen.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({super.key});

  static const String resultScreenRouteName = "/result-screen";

  @override
  Widget build(BuildContext context) {
    final textColor = Get.isDarkMode ? ksurfaceTextColor : Theme.of(context).primaryColorLight;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbarWidget(
        leadingWidget: null,
        titleWidget: Title(color: Colors.black, child: Text(controller.correctAnswerdQuestions)),
      ),
      body: BackgroundDecorationWidget(
        child: SafeArea(
          child: ContentArea(
            child: Column(
              children: [
                SvgPicture.asset("assets/images/bulb.svg"),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                  child: Text(
                    "Quiz Over",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "You have 10 points",
                  style: TextStyle(color: textColor),
                ),
                Gap.vertical(10),
                const Text(
                  "Tap the below question numbers to view the correct answers",
                  textAlign: TextAlign.center,
                ),
                Gap.vertical(10),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: controller.questionsListforUI.length,
                  itemBuilder: (BuildContext context, int index) {
                    final question = controller.questionsListforUI[index];
                    final selectedAnswer = question.selectedAnswer;
                    final correctAnswer = question.correctAnswer;
                    AnswerStatus answerStatus = AnswerStatus.unAnswered; // Default value

                    if (selectedAnswer == correctAnswer) {
                      answerStatus = AnswerStatus.correct;
                    } else if (question.selectedAnswer == null) {
                      answerStatus = AnswerStatus.wrong;
                    } else {
                      answerStatus = AnswerStatus.wrong;
                    }
                    return AnswerOverviewCardWidget(
                      index: index + 1,
                      answerStatus: answerStatus,
                      onTap: () => controller.jumpToQuestion(index, shouldGoBack: false),
                    );
                    //return AnswerOverviewCardWidget(
                    //  index: index + 1,
                    //  answerStatus: answerStatus ? AnswerStatus.answered : AnswerStatus.unAnswered,
                    //  onTap: () => controller.jumpToQuestion(index),
                    //);
                  },
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).cardColor.withOpacity(0.1),
                          ),
                        ),
                        onPressed: () => Get.offAndToNamed(HomeScreen.homeScreenRouteName),
                        child: const Text("Try Again"),
                      ),
                    ),
                    Gap.horizontal(10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.offAndToNamed(HomeScreen.homeScreenRouteName),
                        child: const Text("GO HOME"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
