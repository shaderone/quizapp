import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/bindings/initial_bindings.dart';
import 'package:quiz_app/controllers/theme_controller/theme_controller.dart';
import 'package:quiz_app/firebase_options.dart';
import 'package:quiz_app/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // inject controllers into the app
  InitialBindings().dependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await FirebaseAppCheck.instance.activate(
  //  // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
  //  // argument for `webProvider`
  //  webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //  // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
  //  // your preferred provider. Choose from:
  //  // 1. Debug provider
  //  // 2. Safety Net provider
  //  // 3. Play Integrity provider
  //  androidProvider: AndroidProvider.debug,
  //  // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
  //  // your preferred provider. Choose from:
  //  // 1. Debug provider
  //  // 2. Device Check provider
  //  // 3. App Attest provider
  //  // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
  //  //appleProvider: AppleProvider.appAttest,
  //);
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: Get.find<ThemeController>().darkTheme,
      debugShowCheckedModeBanner: false,
      //home: DataUploaderScreen(),
      getPages: AppRoutes.routes,
    );
  }
}
