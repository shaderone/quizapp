import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_paper/data_uploader.dart';

//The getxcontroller - 'DataUploader' should be called here.
//for that we have to inject the controller
class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({super.key});
  // ** - what is dependency and package injection?
  final DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Data Uploader Screen"),
      ),
    );
  }
}
