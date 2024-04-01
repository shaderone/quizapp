import 'package:flutter/material.dart';
import 'package:quiz_app/common/background_decoration_widget.dart';
import 'package:quiz_app/common/custom_appbar_widget.dart';

class TestOverviewScreen extends StatelessWidget {
  const TestOverviewScreen({super.key});

  static const String testOverviewScreenRouteName = "/test-overview";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbarWidget(
        title: "Test Over.",
        leadingWidget: null,
      ),
      body: BackgroundDecorationWidget(
          child: Center(
        child: Text("hey"),
      )),
    );
  }
}
