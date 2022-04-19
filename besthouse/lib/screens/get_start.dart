import 'package:flutter/material.dart';

// screen
import './sign_in.dart';

// widgets
import '../widgets/common/button.dart';
import '../widgets/common/step_identifyer.dart';
import '../widgets/get_start/content.dart';

class GetStart extends StatefulWidget {
  const GetStart({Key? key}) : super(key: key);
  static const routeName = "/get-start";

  @override
  State<GetStart> createState() => _GetStartState();
}

class _GetStartState extends State<GetStart> {
  int stepIndex = 0;

  final List<Content> steps = const [
    Content(
      header: "Best House",
      subHeader: "Welcome to",
      image: "assets/get_start_1.png",
      text: "Best house help you find your “Best house” that will fit your style the most",
    ),
    Content(
      header: "Information",
      subHeader: "Accurate",
      image: "assets/get_start_2.png",
      text:
          "Browse more efficiently with our policy, to ensure user best experience using our application",
    ),
  ];

  void _onNextStep() {
    if (stepIndex == 1) {
      Navigator.pushNamed(context, SignIn.routeName);
    } else {
      setState(() {
        stepIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: mediaQuery.size.width * 0.7,
              height: isLandscape ? mediaQuery.size.height * 1.3 : mediaQuery.size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  steps[stepIndex],
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StepIdentifyer(stepIndex: stepIndex),
                      Button(
                        clickHandler: _onNextStep,
                        text: stepIndex == 0 ? "Get started" : "Okay, got it!",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
