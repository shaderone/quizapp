import 'package:quiz_app/controllers/question_paper/questions_controller.dart';

// ? Extension works similar to Inheritance
extension QuestionsControllerExtension on QuestionsController {
  int get correctQuestionCount => questionsListforUI.where((element) => element.selectedAnswer == element.correctAnswer).toList().length;

  String get correctAnswerdQuestions => "$correctQuestionCount out of ${questionsListforUI.length} are correct";

  String get quizPoints {
    var points = (correctQuestionCount / questionsListforUI.length) * 100 * (questionPaperModel.timeSeconds - remainingSeconds) / questionPaperModel.timeSeconds * 100;
    return points.toStringAsFixed(2);
  }
}
