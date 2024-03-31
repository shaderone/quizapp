import 'package:flutter/material.dart';
import 'package:quiz_app/common/common_widgets.dart';
import 'package:shimmer/shimmer.dart';

class QuestionPlaceholder extends StatelessWidget {
  const QuestionPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final questionShimmer = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      width: double.infinity,
      height: 15.0,
    );

    final answerShimmer = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      width: double.infinity,
      height: 50.0,
    );

    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1200),
      baseColor: Colors.white,
      highlightColor: const Color.fromARGB(255, 199, 192, 211).withOpacity(0.1),
      child: Column(
        children: [
          ListView.separated(
            //padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (BuildContext context, int index) {
              return Gap.vertical(15);
            },
            itemBuilder: (BuildContext context, int index) {
              return questionShimmer;
            },
          ),
          Gap.vertical(30),
          ListView.separated(
            //padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) {
              return Gap.vertical(15);
            },
            itemBuilder: (BuildContext context, int index) {
              return answerShimmer;
            },
          ),
        ],
      ),
    );
  }
}
