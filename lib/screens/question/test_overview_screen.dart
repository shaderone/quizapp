import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common/answer_overview_card_widget.dart';
import 'package:quiz_app/common/background_decoration_widget.dart';
import 'package:quiz_app/common/common_widgets.dart';
import 'package:quiz_app/common/content_area_widget.dart';
import 'package:quiz_app/common/countdown_timer_widget.dart';
import 'package:quiz_app/common/custom_appbar_widget.dart';
import 'package:quiz_app/common/quiz_action_button.dart';
import 'package:quiz_app/config/Themes/ui_parameters.dart';
import 'package:quiz_app/controllers/question_paper/questions_controller.dart';

enum AnswerStatus {
  correct,
  wrong,
  answered,
  unAnswered,
}

class TestOverviewScreen extends GetView<QuestionsController> {
  const TestOverviewScreen({super.key});

  static const String testOverviewScreenRouteName = "/test-overview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbarWidget(
        title: controller.getQuizOverview,
        leadingWidget: null,
      ),
      body: BackgroundDecorationWidget(
        child: SafeArea(
          child: ContentArea(
            child: Column(
              children: [
                Column(
                  children: [
                    CountdownTimerWidget(
                      color: UiParameters.isDarkMode() ? Theme.of(context).textTheme.bodyLarge!.color : Theme.of(context).primaryColorLight,
                    ),
                    Gap.vertical(20),
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
                        final answerStatus = controller.questionsListforUI[index].selectedAnswer != null;
                        return AnswerOverviewCardWidget(
                          index: index + 1,
                          answerStatus: answerStatus ? AnswerStatus.answered : AnswerStatus.unAnswered,
                          onTap: () => controller.jumpToQuestion(index),
                        );
                      },
                    ),
                  ],
                ),
                const Spacer(),
                const Row(
                  children: [
                    Expanded(child: QuizActionButton()),
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
