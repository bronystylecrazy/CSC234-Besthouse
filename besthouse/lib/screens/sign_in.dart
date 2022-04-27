import 'package:besthouse/screens/forget_password.dart';
import 'package:besthouse/screens/home.dart';
import 'package:flutter/gestures.dart';
import 'package:besthouse/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:besthouse/widgets/common/custom_textfield.dart';
import 'package:besthouse/widgets/common/button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const routeName = "/sign-in";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      "Best house",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(height: 50),
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
                        label: "Password",
                        isObscure: true),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: RichText(
                          text: TextSpan(
                            text: 'Forget password ?',
                            style: Theme.of(context).textTheme.caption,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, ForgetPassword.routeName);
                              },
                          ),
                        ),
                      ),
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
                                text: "Start your journey",
                                clickHandler: () {
                                  Navigator.pushNamed(context, Home.routeName);
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: RichText(
                              text: TextSpan(
                                text: 'or Sign Up here',
                                style: const TextStyle(
                                  color: Color(0xFF022B3A),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, SignUp.routeName);
                                  },
                              ),
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
