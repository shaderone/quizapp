import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common/Answer_card_widget.dart';
import 'package:quiz_app/common/background_decoration_widget.dart';
import 'package:quiz_app/common/common_widgets.dart';
import 'package:quiz_app/common/content_area_widget.dart';
import 'package:quiz_app/common/question_place_holder.dart';
import 'package:quiz_app/config/Themes/ui_parameters.dart';
import 'package:quiz_app/controllers/question_paper/questions_controller.dart';
import 'package:quiz_app/firebase_ref/loading_status.dart';

class QuestionScreen extends GetView<QuestionsController> {
  const QuestionScreen({super.key});

  static const String questionScreenRouteName = "/start_quiz";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDecorationWidget(
        child: SafeArea(
          child: Obx(
            () {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(mobileScreenPadding),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("TIMER"),
                        Text("QN."),
                        Text("MENU"),
                      ],
                    ),
                  ),
                  Gap.vertical(20),
                  Expanded(
                    child: Padding(
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
                                          style: questionTextStyleUtil(context),
                                        ),
                                        Gap.vertical(30),
                                        GetBuilder<QuestionsController>(
                                          id: 'answers_list', // ? this id can be use to call update only to this builder<QuestionsController>
                                          builder: (context) {
                                            final answer = controller.currentQuestion.value!.answers;
                                            return ListView.separated(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: controller.currentQuestion.value!.answers.length,
                                              separatorBuilder: (BuildContext context, int index) {
                                                return Gap.vertical(10);
                                              },
                                              itemBuilder: (BuildContext context, int index) {
                                                return AnswerCardWidget(
                                                  identifier: "${answer[index].identifier}.",
                                                  answer: " ${answer[index].answer}",
                                                  onTap: () {
                                                    controller.selectedAnswer(answer[index].identifier);
                                                  },
                                                  isSelected: answer[index].identifier == controller.currentQuestion.value!.selectedAnswer,
                                                );
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
                                            child: ElevatedButton(
                                              style: const ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                                              onPressed: () {
                                                controller.isLastQuestion
                                                    ? const Scaffold(
                                                        body: Center(
                                                          child: Text("Answer Review Page"),
                                                        ),
                                                      )
                                                    : controller.nextQuestion();
                                              },
                                              child: Text(controller.isLastQuestion ? "Complete" : "Next"),
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
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
