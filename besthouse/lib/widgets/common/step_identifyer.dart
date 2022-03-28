import 'package:flutter/material.dart';

class StepIdentifyer extends StatelessWidget {
  const StepIdentifyer({Key? key, required this.stepIndex}) : super(key: key);
  final int stepIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 5,
            backgroundColor: stepIndex == 0 ? const Color(0xFF24577A) : const Color(0xFFC4C4C4),
          ),
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 5,
            backgroundColor: stepIndex == 1 ? const Color(0xFF24577A) : const Color(0xFFC4C4C4),
          )
        ],
      ),
    );
  }
}
