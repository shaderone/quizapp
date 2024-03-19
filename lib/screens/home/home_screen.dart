import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/question_paper/question_paper_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestionPaperController questionPaperController = Get.find<QuestionPaperController>();
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => ListView.separated(
            itemCount: questionPaperController.imageDownloadUrls.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: FadeInImage(
                    placeholder: const AssetImage("assets/images/app_splash_logo.png"),
                    image: NetworkImage(questionPaperController.imageDownloadUrls[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
