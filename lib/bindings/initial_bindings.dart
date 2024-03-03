import 'package:get/get.dart';
import 'package:quiz_app/controllers/auth_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    // ** here we inject the controllers in the app
    Get.put(AuthController(), permanent: true);
  }
}
