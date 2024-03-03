import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/bindings/initial_bindings.dart';
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
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //textTheme: const TextTheme(
        //  bodyMedium: TextStyle(color: Colors.white),
        //),
        //scaffoldBackgroundColor: const Color.fromARGB(255, 30, 31, 45),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      //home: DataUploaderScreen(),
      getPages: AppRoutes.routes,
    );
  }
}
