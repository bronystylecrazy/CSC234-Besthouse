import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../common/step_identifyer.dart';
import '../common/button.dart';

class BottomActions extends StatelessWidget {
  const BottomActions({Key? key, required this.stepIndex, required this.next}) : super(key: key);
  final int stepIndex;
  final Function() next;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepIdentifyer(
          stepIndex: stepIndex,
        ),
        Button(clickHandler: next, text: stepIndex == 1 ? "sign up" : "next"),
        Padding(
          padding: const EdgeInsets.all(16),
          child: RichText(
            text: TextSpan(
              text: 'Already have account ?',
              style: const TextStyle(
                color: Color(0xFF022B3A),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Login Text Clicked');
                },
            ),
          ),
        ),
      ],
    );
  }
}
