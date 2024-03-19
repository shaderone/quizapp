import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiz_app/firebase_ref/loading_status.dart';
import 'package:quiz_app/firebase_ref/references.dart';
import 'package:quiz_app/models/question_paper_model.dart';

//This controller is for the admin
class DataUploaderController extends GetxController {
  @override
  // This function is called only once.(in the app lifetime or when it restores)
  // This 'controller' should be called from the UI

  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  Future<void> uploadData() async {
    // get firestore (firebse database name) instance
    final firestore = FirebaseFirestore.instance;

    //print("Data Uploading...");
    // to upload files :
    // ** how 'context' is accessible here, - through getX, but how?
    // the loadString() will load the 'assets' key from pubspec.yaml (which includes every directory mentioned under assets:)
    final manifestContent = await DefaultAssetBundle.of(Get.context!).loadString("AssetManifest.json");
    //now the whole data is loaded into 'manifestContent', and next we need to decode the json data to read its content, (it will return a MAP)
    final Map<String, dynamic> manifestContentMap = json.decode(manifestContent);
    //log(manifestContentMap.toString());
    //now to filter out the specific data that's requried (in this case we only need the json files stored in under assets/DB/paper, however the result has all data under 'assets:'), we need to get the keys
    // ** what is the difference between 'Iterable' and 'List'
    final manifestContentFilteredIterable = manifestContentMap.keys.where((path) => path.startsWith("assets/DB/paper") && path.contains(".json"));
    // ? this data is what admin manages
    final jsonPathsInAssets = manifestContentFilteredIterable.toList();
    //print(jsonPathsInAssets);

    // ? NEXT : loop through the filtered data.
    List<QuestionPaperModel> questionPaperList = [];
    for (var paper in jsonPathsInAssets) {
      //rootbundle.loadString() -> load each of the json file content
      final paperContent = await rootBundle.loadString(paper);
      //log(paperContent);
      //Passing Data to model and adding the model to the list
      questionPaperList.add(QuestionPaperModel.fromJson(json.decode(paperContent)));
      // ? -- this data will be converted from JSON - MODEL - OBJECT - LIST and to firebase backend
      //has the list of json files
      //log(questionPaperList[0].questions[0].answers[3].answer);
      //print("question paper list length - ${questionPaperList.length}");

      //We need to send this data to the firestore, for that we upload the data as a whole in batch (multiple steps), for that we create and instance of firebase with batch() constructor
      var batch = firestore.batch();

      //now we loop through the questionPaper list (which contains the decoded data) and sent them to firestore
      for (QuestionPaperModel paper in questionPaperList) {
        //set() requies a document - (the collection to point to, also pass an id, which can be retrived from paper variable))
        // ? collection.document(id) - this 'document(id)' returns the document that maches the id (if it exists, else it just creates it.)
        batch.set(questionPaperCRF.doc(paper.id), {
          //The data will mock the fields to be created in the cloudfirestore
          "id": paper.id,
          "title": paper.title,
          "description": paper.description,
          "image_url": paper.imageUrl,
          "time_seconds": paper.timeSeconds,
          "questions_count": paper.questions == null ? 0 : paper.questions!.length
        });
        //log(paper.toString());

        //questions list
        for (QuestionsModal questions in paper.questions!) {
          //this method will create a collection on call and will return a document reference (means path name) (ie; questionCRF)
          final questionscollectionPath = questionsCRF(paperId: paper.id, questionId: questions.id);
          batch.set(questionscollectionPath, {
            "id": questions.id,
            "question": questions.question,
            "correct_answer": questions.correctAnswer,
          });

          //answers list
          for (AnswersModal answer in questions.answers) {
            batch.set(questionscollectionPath.collection("answers").doc(answer.identifier), {
              "identifier": answer.identifier,
              "answer": answer.answer,
            });
          }
        }
      }

      // commit() methods - sent the finished data (using set()) to cloud firestore
      await batch.commit();

      loadingStatus.value = LoadingStatus.completed;
    }
  }
}


/* Things did :
-> get data from assetBundle
-> get all json paths
-> get content from each json file
-> send data to firestore backend
! How Errors are handled?
 */
