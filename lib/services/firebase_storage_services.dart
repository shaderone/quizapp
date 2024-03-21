// ? This config is used to load files from the firebase_storage.
// ** To use this Service, we need to use a controller.

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../firebase_ref/references.dart';

class FirebaseStorageService extends GetxService {
  // the imageName will match the image names in the firebase storage. They come from a local List.
  Future<String?> getImage(String? imageName) async {
    if (imageName == null) return null;
    try {
      // child() requires a path (folder name), each directory should be in child().
      // ? urlRef is a special type of url which acts as a reference link to the file path, this includes many features, like uploading feature, passing user data and so on. the getDownloadUrl is only one of the feature when creating a storage reference.
      // ** firebaseStorage is the reference variable to Firebase Storage
      Reference urlRef = firebaseStorageRF.child("question_paper_images").child("${imageName.toLowerCase()}.png");
      // actual image path (only for downloading no other functionalities)
      var imageUrl = await urlRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }
}
