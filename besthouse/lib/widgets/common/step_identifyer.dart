import 'package:flutter/material.dart';

class StepIdentifyer extends StatelessWidget {
  final int stepIndex;
  final int amount;

  const StepIdentifyer({
    Key? key,
    required this.stepIndex,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < amount; i++)
            if (i == stepIndex)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: CircleAvatar(radius: 5, backgroundColor: Color(0xFF24577A)),
              )
            else
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: CircleAvatar(radius: 5, backgroundColor: Color(0xFFC4C4C4)),
              )
        ],
      ),
    );
  }
}
