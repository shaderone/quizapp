import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common/widgets/answer_widgets/answer_overview_card_widget.dart';
import 'package:quiz_app/common/widgets/ui_widgets/background_decoration_widget.dart';
import 'package:quiz_app/common/utils.dart';
import 'package:quiz_app/common/widgets/ui_widgets/content_area_widget.dart';
import 'package:quiz_app/common/widgets/quiz_widgets/countdown_timer_widget.dart';
import 'package:quiz_app/common/widgets/ui_widgets/custom_appbar_widget.dart';
import 'package:quiz_app/common/widgets/quiz_widgets/quiz_action_button.dart';
import 'package:quiz_app/config/Themes/app_colors.dart';
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
        automaticallyImplyLeading: true,
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
                      color: UiParameters.isDarkMode() ? ksurfaceTextColor : Theme.of(context).primaryColorLight,
                    ),
                    Gap.vertical(20),
                    const OverViewCardWidgetWrapper(),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: QuizActionButton(
                        onPressed: () {
                          controller.completeQuiz();
                        },
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

class OverViewCardWidgetWrapper extends GetView<QuestionsController> {
  const OverViewCardWidgetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
    );
  }
}
