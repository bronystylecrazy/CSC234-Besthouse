import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
//widget
import 'package:besthouse/widgets/common/custom_textfield.dart';
import 'package:besthouse/widgets/common/button.dart';

//screen
import 'package:besthouse/screens/sign_in.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);
  static const routeName = "/forget-password";

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Image.asset("assets/logo.png", scale: 14),
            top: 50,
            left: 18,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(right: 24, left: 24, top: 112),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "BestHouse",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      "Update password",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(height: 60),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "We will send you new password\n     via your registered email",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some detail about your property';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          fillColor: Theme.of(context).colorScheme.tertiary,
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            child: Button(
                                text: "Get new password", clickHandler: () {}),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: RichText(
                              text: TextSpan(
                                  text: 'Back to sign-in page',
                                  style: const TextStyle(
                                    color: Color(0xFF022B3A),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, SignIn.routeName);
                                    }),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
