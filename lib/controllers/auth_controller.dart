import 'package:get/get.dart';

// ? All controllers need to be injected in order to work.

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  //@override
  //void onInit() {
  //  navigateToOnboardingScreen();
  //  super.onInit();
  //}

  void initAuth() {
    Future.delayed(
      const Duration(seconds: 2),
      () => navigateToOnboardingScreen(),
    );
  }

  void navigateToOnboardingScreen() {
    Get.offAllNamed("/onboarding");
  }
}
