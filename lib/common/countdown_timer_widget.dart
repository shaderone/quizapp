import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/Themes/app_colors.dart';
import '../controllers/question_paper/questions_controller.dart';
import 'common_widgets.dart';

class CountdownTimerWidget extends GetView<QuestionsController> {
  const CountdownTimerWidget({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: color ?? ksurfaceTextColor),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Obx(
        () => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.timer, color: color ?? ksurfaceTextColor),
            Gap.horizontal(10),
            Text(controller.time.value, style: questionTextStyleUtil().copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
