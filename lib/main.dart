import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetBuilder<ThemeController>(
      builder: (_) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: _.lightTheme,
          debugShowCheckedModeBanner: false,
          //home: DataUploaderScreen(),
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
