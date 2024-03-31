import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quiz_app/firebase_ref/loading_status.dart';
import 'package:quiz_app/firebase_ref/references.dart';
import 'package:quiz_app/models/question_paper_model.dart';

class QuestionsController extends GetxController {
  late QuestionPaperModel questionPaperModel;
  //variable to hold all question for a paper
  late List<QuestionsModal> questionsListforUI = <QuestionsModal>[].obs;

  // ! WTF is currentQuestion, why questionsListForUi is not used?
  Rxn<QuestionsModal> currentQuestion = Rxn<QuestionsModal>();

  final loadingStatus = LoadingStatus.loading.obs;

  @override
  void onReady() {
    // ** Get the arguments passed while routing
    final modal = Get.arguments as QuestionPaperModel;
    //we fetch the data for the selected paper from firestore
    loadQuizData(modal);
    super.onReady();
  }

  Future<void> loadQuizData(QuestionPaperModel questionPaperModel) async {
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
          currentQuestion.value = questionPaperModel.questions![0];
          questionsListforUI.assignAll(questionPaperModel.questions!);
          //print(questionPaperModel.questions!);
          loadingStatus.value = LoadingStatus.completed;
        } else {
          loadingStatus.value = LoadingStatus.error;
        }
      }
    } catch (e) {
      if (kDebugMode) print("error: $e");
    }
  }

  void selectedAnswer(String? selectedAnswer) {
    currentQuestion.value!.selectedAnswer = selectedAnswer;
    //Rebuilds any getBuilder for RXN type variables
    update(['answers_list']);
  }
}
