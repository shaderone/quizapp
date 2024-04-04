import 'package:get/get.dart';
import 'package:quiz_app/controllers/auth_controller.dart';
import 'package:quiz_app/controllers/question_paper/data_uploader_controller.dart';
import 'package:quiz_app/controllers/theme_controller/theme_controller.dart';
import 'package:quiz_app/services/firebase_storage_services.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    // ** here we inject the controllers in the app
    Get.put(DataUploaderController());
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => FirebaseStorageService());
  }
}
