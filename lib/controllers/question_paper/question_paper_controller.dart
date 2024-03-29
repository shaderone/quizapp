// ? controller to get images from the firebase_storage
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quiz_app/firebase_ref/references.dart';
import 'package:quiz_app/models/question_paper_model.dart';
import 'package:quiz_app/services/firebase_storage_services.dart';

class QuestionPaperController extends GetxController {
  // This list will have all the imageUrls from the firebase to use in the app
  //List<String> imageDownloadUrls = <String>[].obs;
  final directoryPath = 'assets/images';

  final questionPapersList = <QuestionPaperModel>[].obs;

  @override
  Future<void> onReady() async {
    //will sent image file names as argument to retrieve the downloadUrls of image from the firebase Storage.
    getPaperImages();
    super.onReady();
  }

  Future<void> getPaperImages() async {
    // ** This list is created to fetch the correct image based on their file name. The file names are the string values in the list
    // ? There should be another way to do this.
    //List<String> imageNamesList = ["biology", "Chemistry", "Maths", "Physics"];
    try {
      //Getting question papers
      // The get() will get all the data from the collection pointed by the `questionPaperCRF`
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperCRF.get();
      final questionPapers = data.docs.map((questionPapers) => QuestionPaperModel.fromSnapshot(questionPapers)).toList();
      questionPapersList.assignAll(questionPapers);

      for (var questionPaper in questionPapersList) {
        // ? the Get.find<> is used when accessing a controller or service
        final String? imageDownloadUrl = await Get.find<FirebaseStorageService>().getImage(questionPaper.title);
        // ** How can we be sure 'imageDownloadUrl` is not null?
        //imageDownloadUrls.add(imageDownloadUrl!);
        questionPaper.imageUrl = imageDownloadUrl!;
      }
      // ** latest questionPaper model with updated image path
      questionPapersList.assignAll(questionPapers);
      print("list - ${questionPapersList.length}");
    } catch (e) {
      print(e);
    }
  }
}
