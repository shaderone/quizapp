import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/common/Answer_card_widget.dart';
import 'package:quiz_app/common/background_decoration_widget.dart';
import 'package:quiz_app/common/common_widgets.dart';
import 'package:quiz_app/common/content_area_widget.dart';
import 'package:quiz_app/common/custom_appbar_widget.dart';
import 'package:quiz_app/common/question_place_holder.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
import 'package:quiz_app/controllers/question_paper/questions_controller.dart';
import 'package:quiz_app/firebase_ref/loading_status.dart';
import 'package:quiz_app/screens/question/test_overview_screen.dart';

class QuestionScreen extends GetView<QuestionsController> {
  const QuestionScreen({super.key});

  static const String questionScreenRouteName = "/start_quiz";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbarWidget(
        leadingWidget: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: ksurfaceTextColor),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.timer, color: ksurfaceTextColor),
                  Gap.horizontal(10),
                  Expanded(child: Text(controller.time.value, style: questionTextStyleUtil())),
                ],
              );
            }),
          ),
        ),
        title: "Qn. 1",
        showActonIcon: true,
        titleWidget: Obx(() {
          return Text(
            "Q. ${(controller.questionsCounter.value + 1).toString().padLeft(2, "0")}",
            style: questionTextStyleUtil(),
          );
        }),
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
                                          controller.isLastQuestion ? Get.toNamed(TestOverviewScreen.testOverviewScreenRouteName) : controller.nextQuestion();
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
              );
            },
          ),
        ),
      ),
    );
  }
}
