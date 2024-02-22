import 'package:get/get.dart';

//This controller is for the admin
class DataUploader extends GetxController {
  @override
  // This function is called only once.(in the app lifetime or when it restores)
  // This 'controller' should be called from the UI

  void onReady() {
    uploadData();
    super.onReady();
  }

  void uploadData() {
    print("Data Uploading...");
  }
}
