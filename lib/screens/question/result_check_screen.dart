import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/common/question_place_holder.dart';
import 'package:quiz_app/controllers/question_paper/questions_controller.dart';
import 'package:quiz_app/screens/question/result/result_screen.dart';
import 'package:quiz_app/screens/question/test_overview_screen.dart';

import '../../common/Answer_card_widget.dart';
import '../../common/background_decoration_widget.dart';
import '../../common/common_widgets.dart';
import '../../common/content_area_widget.dart';
import '../../common/custom_appbar_widget.dart';
import '../../common/quiz_action_button.dart';
import '../../firebase_ref/loading_status.dart';

class ResultCheckScreen extends GetView<QuestionsController> {
  const ResultCheckScreen({super.key});

  static const String resultCheckScreenRouteName = "/result-check-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbarWidget(
        automaticallyImplyLeading: true,
        showActonIcon: true,
        onMenuTap: () => Get.toNamed(ResultScreen.resultScreenRouteName),
        titleWidget: Obx(
          () {
            return Text(
              "Q. ${(controller.questionsCounter.value + 1).toString().padLeft(2, "0")}",
              style: questionTextStyleUtil(),
            );
          },
        ),
      ),
      body: BackgroundDecorationWidget(
        child: SafeArea(
          child: Obx(
            () {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ContentArea(
                  child: Column(
                    children: [
                      if (controller.loadingStatus.value == LoadingStatus.loading)
                        const QuestionPlaceholder()
                      else
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    controller.currentQuestion.value!.question,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Gap.vertical(30),
                                  GetBuilder<QuestionsController>(
                                    id: 'answers_review_list', // ? this id can be use to call update only to this builder<QuestionsController>
                                    builder: (context) {
                                      final answer = controller.currentQuestion.value!.answers;
                                      final selectedAnswer = controller.currentQuestion.value!.selectedAnswer;
                                      final correctAnswer = controller.currentQuestion.value!.correctAnswer;
                                      return ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: controller.currentQuestion.value!.answers.length,
                                        separatorBuilder: (BuildContext context, int index) {
                                          return Gap.vertical(10);
                                        },
                                        itemBuilder: (BuildContext context, int index) {
                                          final String answerText = "${answer[index].identifier} ${answer[index].answer}";
                                          if (correctAnswer == selectedAnswer && answer[index].identifier == selectedAnswer) {
                                            //selectedAnswer is also an identifier that the user has selected
                                            //correct answer
                                            return AnswerCardTypeWidget(answer: answerText, answerStatus: AnswerStatus.correct);
                                          } else if (selectedAnswer == null) {
                                            //not answered
                                            return AnswerCardTypeWidget(answer: answerText, answerStatus: AnswerStatus.unAnswered);
                                          } else if (correctAnswer != selectedAnswer && answer[index].identifier == selectedAnswer) {
                                            //wrong answer
                                            return AnswerCardTypeWidget(answer: answerText, answerStatus: AnswerStatus.wrong);
                                          } else if (correctAnswer == answer[index].identifier) {
                                            //correct answer
                                            return AnswerCardTypeWidget(answer: answerText, answerStatus: AnswerStatus.correct);
                                          } else {
                                            return AnswerCardWidget(
                                              identifier: "${answer[index].identifier}.",
                                              answer: " ${answer[index].answer}",
                                              onTap: () {},
                                              isSelected: false,
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: controller.loadingStatus.value == LoadingStatus.completed,
                                child: Row(
                                  children: [
                                    Visibility(
                                      visible: controller.isFirstQuestion,
                                      child: IconButton.filled(
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                        onPressed: () {
                                          controller.previousQuestion();
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: QuizActionButton(
                                        onPressed: () {
                                          controller.nextQuestion();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
