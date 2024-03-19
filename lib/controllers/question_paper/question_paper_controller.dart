// ? controller to get images from the firebase_storage
import 'package:get/get.dart';
import 'package:quiz_app/services/firebase_storage_services.dart';

class QuestionPaperController extends GetxController {
  // This list will have all the imageUrls from the firebase to use in the app
  List<String> imageDownloadUrls = <String>[].obs;
  final directoryPath = 'assets/images';

  @override
  Future<void> onReady() async {
    //will sent image file names as argument to retrieve the downloadUrls of image from the firebase Storage.
    getPaperImages();
    super.onReady();
  }

  Future<void> getPaperImages() async {
    // ** This list is created to fetch the correct image based on their file name. The file names are the string values in the list
    // ? There should be another way to do this.
    List<String> imageNamesList = ["biology", "Chemistry", "Maths", "Physics"];
    try {
      for (var imageName in imageNamesList) {
        // ? the Get.find<> is used when accessing a controller or service
        final String? imageDownloadUrl = await Get.find<FirebaseStorageService>().getImage(imageName);
        // ** How can we be sure 'imageDownloadUrl` is not null?
        imageDownloadUrls.add(imageDownloadUrl!);
      }
    } catch (e) {
      print(e);
    }
  }
}
