import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/question_paper/question_paper_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuestionPaperController questionPaperController = Get.find<QuestionPaperController>();
    //print(questionPaperController.questionPapersList.length);
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => ListView.separated(
            itemCount: questionPaperController.questionPapersList.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CachedNetworkImage(
                    imageUrl: questionPaperController.questionPapersList[index].imageUrl,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (context, url, error) => Image.asset("assets/images/app_splash_logo.png"),
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
