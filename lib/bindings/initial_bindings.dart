import 'package:get/get.dart';
import 'package:quiz_app/controllers/auth_controller.dart';
import 'package:quiz_app/controllers/theme_controller/theme_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    // ** here we inject the controllers in the app
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
  }
}
