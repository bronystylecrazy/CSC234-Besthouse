import 'package:besthouse/widgets/common/step_identifyer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomActions extends StatelessWidget {
  const BottomActions(
      {Key? key,
      required this.stepIndex,
      required this.next,
      required this.registerHandler,
      required this.isLoading})
      : super(key: key);
  final int stepIndex;
  final Function() next;
  final Function() registerHandler;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepIdentifyer(
          stepIndex: stepIndex,
          amount: 2,
        ),
        ElevatedButton(
          onPressed: stepIndex == 1 ? registerHandler : next,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          child: Ink(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF245679),
                  Color(0xFF173651),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.6,
              child: isLoading
                  ? const SpinKitRing(
                      lineWidth: 2,
                      color: Colors.white,
                      size: 20.0,
                    )
                  : Text(
                      stepIndex == 1 ? "Sign up" : "Next",
                      style: GoogleFonts.poppins(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ),
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
                    Navigator.pop(context);
                  }),
          ),
        ),
      ],
    );
  }
}
