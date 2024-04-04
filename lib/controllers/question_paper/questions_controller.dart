import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quiz_app/firebase_ref/loading_status.dart';
import 'package:quiz_app/firebase_ref/references.dart';
import 'package:quiz_app/models/question_paper_model.dart';
import 'package:quiz_app/screens/home/home_screen.dart';
import 'package:quiz_app/screens/question/result/result_screen.dart';

import 'question_paper_controller.dart';

class QuestionsController extends GetxController {
  late QuestionPaperModel questionPaperModel;
  //variable to hold all question for a paper
  late List<QuestionsModal> questionsListforUI = <QuestionsModal>[].obs;

  final questionsCounter = 0.obs;

  bool get isFirstQuestion => questionsCounter.value > 0;
  bool get isLastQuestion => questionsCounter.value == questionsListforUI.length - 1;

  //  WTF is currentQuestion, why questionsListForUi is not used?
  // ? CurrentQuestion hold the current Question. As the name suggests.
  Rxn<QuestionsModal> currentQuestion = Rxn<QuestionsModal>();

  final loadingStatus = LoadingStatus.loading.obs;

  Timer? _timer;
  late int remainingSeconds;
  final RxString time = "ETA...".obs;

  @override
  void onReady() {
    // ** Get the arguments passed while routing
    final modal = Get.arguments as QuestionPaperModel;
    //we fetch the data for the selected paper from firestore
    loadQuizData(modal);
    super.onReady();
  }

  Future<void> loadQuizData(QuestionPaperModel data) async {
    questionPaperModel = data;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionsQuery = await questionPaperCRF.doc(questionPaperModel.id).collection("questions").get();

      //convert the fetched documents - (the questions) from json or Map to list using a modal class
      final questionsList = questionsQuery.docs.map((snapshot) => QuestionsModal.fromSnapshot(snapshot)).toList();

      //we then add the questionsList to the questions field in the questionPaperModal
      // ? the questions List is first created using the questions modal,
      // ? then this list is assigned to the 'questions' field in the 'QuestionPaperModal' thus accessible to the UI.
      // ? Only QuestionPaperModal is used to access all data, sub modal just assist in fetching data.
      questionPaperModel.questions = questionsList;
      // in questionPaperModel.questions
      for (QuestionsModal questionsModal in questionPaperModel.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answerQuery = await questionPaperCRF.doc(questionPaperModel.id).collection("questions").doc(questionsModal.id).collection("answers").get();

        final List<AnswersModal> answersList = answerQuery.docs.map((snapshot) => AnswersModal.fromSnapshot(snapshot)).toList();

        questionsModal.answers = answersList;

        //ie; if the questions from the firestore hasn't reached the questions list in questionpaperModal
        if (questionPaperModel.questions != null && questionPaperModel.questions!.isNotEmpty) {
          currentQuestion.value = questionPaperModel.questions![0]; //! WHY 0?
          questionsListforUI.assignAll(questionPaperModel.questions!);

          loadingStatus.value = LoadingStatus.completed;
        } else {
          loadingStatus.value = LoadingStatus.error;
        }
      }
    } catch (e) {
      if (kDebugMode) print("error: $e");
    }

    if (loadingStatus.value == LoadingStatus.completed) startTimer(questionPaperModel.timeSeconds);
  }

  String get getQuizOverview {
    //Get how may answers are selected in the quiz
    int selectedAnswersCount = questionsListforUI.where((quiz) => quiz.selectedAnswer != null).toList().length;
    return "$selectedAnswersCount out of ${questionsListforUI.length} answered";
  }

  void selectedAnswer(String? selectedAnswer) {
    currentQuestion.value!.selectedAnswer = selectedAnswer;
    //Rebuilds any getBuilder for RXN type variables
    update(['answers_list', 'answers_review_list']);
  }

  void nextQuestion() {
    if (questionsCounter.value >= questionsListforUI.length - 1) {
      return;
    } else {
      questionsCounter.value++;
      //send the new index to the cuurent questions stack
      currentQuestion.value = questionsListforUI[questionsCounter.value];
    }
  }

  void previousQuestion() {
    if (questionsCounter.value <= 0) {
      return;
    } else {
      questionsCounter.value--;
      //send the new index to the cuurent questions stack
      currentQuestion.value = questionsListforUI[questionsCounter.value];
    }
  }

  void jumpToQuestion(int index, {bool shouldGoBack = true}) {
    // This index is the index of the overview card item.
    questionsCounter.value = index;
    //set this as the current question
    currentQuestion.value = questionsListforUI[index];
    if (shouldGoBack) Get.back();
  }

  void startTimer(int quizTimeInSeconds) {
    //get quiz time from database
    // divide it by 60 to get minutes
    //decrement by 1 second until it reaches 00:00
    const Duration decreaseInterval = Duration(seconds: 1);
    remainingSeconds = quizTimeInSeconds;
    _timer = Timer.periodic(decreaseInterval, (timer) {
      if (remainingSeconds == 0) {
        time.value = "~END~";
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;

        time.value = "${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}";
        remainingSeconds--;
      }
    });
  }

  //on quiz completion
  void completeQuiz() {
    _timer!.cancel();
    questionsCounter.value = 0;
    Get.offAndToNamed(ResultScreen.resultScreenRouteName);
  }

  void tryAgain() {
    print("in try again");
    Get.find<QuestionPaperController>().navigateToQuestions(
      questionPaperModel: questionPaperModel,
      context: Get.context!,
      tryAgain: true,
    );
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.homeScreenRouteName, (route) => false);
  }
}
