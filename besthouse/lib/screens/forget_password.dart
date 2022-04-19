import 'package:besthouse/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:besthouse/widgets/common/custom_textfield.dart';
import 'package:besthouse/widgets/common/button.dart';
import 'package:flutter/gestures.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);
  static const routeName = "/forget-password";

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Image.asset("assets/logo.png", scale: 0.8),
            top: 50,
            left: 18,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      "Change password",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      "BestHouse",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                        context: context,
                        controller: _usernameController,
                        label: "Username",
                        isObscure: false),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        context: context,
                        controller: _passwordController,
                        label: "Enter new password",
                        isObscure: true),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        context: context,
                        controller: _passwordController,
                        label: "Enter new password",
                        isObscure: true),
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
                            child: Button(text: "Comfirm", clickHandler: () {}),
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
