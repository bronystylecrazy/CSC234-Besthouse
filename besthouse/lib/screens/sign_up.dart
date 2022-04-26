import 'package:flutter/material.dart';

import '../widgets/sign_up/bottom_actions.dart';
import '../widgets/common/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const routeName = "/sign-up";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumController = TextEditingController();

  int _stepIndex = 0;
  void next() {
    setState(() {
      _stepIndex = _stepIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stepScreen = <Widget>[
      Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
              context: context,
              controller: _confirmPassController,
              label: "Confirm Password",
              isObscure: true),
        ],
      ),
      const Text("Form second step"), //TODOS here!
    ];

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
                  ],
                ),
              ),
              Padding(
                  // height: MediaQuery.of(context).size.height * 0.4,
                  padding: const EdgeInsets.all(24),
                  child: stepScreen.elementAt(_stepIndex)),
              BottomActions(
                stepIndex: _stepIndex,
                next: next,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
