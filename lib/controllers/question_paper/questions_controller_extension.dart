import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_paper/questions_controller.dart';

import '../../firebase_ref/references.dart';
import '../auth_controller.dart';

// ? Extension works similar to Inheritance
extension QuestionsControllerExtension on QuestionsController {
  int get correctQuestionCount => questionsListforUI.where((element) => element.selectedAnswer == element.correctAnswer).toList().length;

  String get correctAnswerdQuestions => "$correctQuestionCount out of ${questionsListforUI.length} are correct";

  String get quizPoints {
    var points = (correctQuestionCount / questionsListforUI.length) * 100 * (questionPaperModel.timeSeconds - remainingSeconds) / questionPaperModel.timeSeconds * 100;
    return points.toStringAsFixed(2);
  }

  Future<void> saveTestResult() async {
    var batch = fireStore.batch(); // * Get Batch instance
    // * Verify if user exists
    User? user = Get.find<AuthController>().getUser();
    if (user != null) {
      batch.set(
        userRFC.doc(user.email).collection("recent-quiz").doc(questionPaperModel.id),
        {
          "points": quizPoints,
          "correct_answer": correctQuestionCount / questionsListforUI.length,
          "question_id": questionPaperModel.id,
          "time_elasped": questionPaperModel.timeSeconds - remainingSeconds,
        },
      );
    } else {
      return;
    }
    await batch.commit();
    navigateToHome();
  }
}
