import 'package:besthouse/models/response/info_response.dart';
import 'package:besthouse/screens/sign_in.dart';
import 'package:besthouse/services/api/user.dart';
import 'package:besthouse/widgets/common/alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//widget
import 'package:besthouse/widgets/common/custom_textfield.dart';
import 'package:besthouse/widgets/sign_up/bottom_actions.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const routeName = "/sign-up";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumController = TextEditingController();
  int _stepIndex = 0;
  bool isLoading = false;

  void registerHandler() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var result = await UserApi.resgister(
            _usernameController.text,
            _passwordController.text,
            _emailController.text,
            _firstnameController.text,
            _lastnameController.text,
            _phoneNumController.text);
        if (result is InfoResponse) {
          Future.delayed(const Duration(seconds: 1), (() {
            setState(() {
              isLoading = false;
            });

            Alert.successAlert(result, "register", SignIn.routeName, context);
          }));
        }
      } on DioError catch (e) {
        setState(() {
          isLoading = false;
        });
        Alert.errorAlert(e, context);
      }
    }
  }

  void next() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _stepIndex = _stepIndex + 1;
      });
    }
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Username can't be empty";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    } else if (value.length <= 4) {
      return "Password must have at least 4 character";
    } else if (value != _passwordController.text) {
      return "Password is not match";
    }
    return null;
  }

  String? firstnameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Firstname can't be empty";
    }
    return null;
  }

  String? lastnameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Lastname can't be empty";
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number can't be empty";
    } else if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
        .hasMatch(value)) {
      return "Please enter a valid phone number";
    }
    return null;
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
              validator: usernameValidator,
              isObscure: false),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
              context: context,
              controller: _passwordController,
              label: "Password",
              validator: passwordValidator,
              isObscure: true),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
              context: context,
              controller: _confirmPassController,
              label: "Confirm Password",
              validator: passwordValidator,
              isObscure: true),
        ],
      ),
      Column(
        children: [
          CustomTextField(
            context: context,
            controller: _firstnameController,
            label: "Firstname",
            validator: firstnameValidator,
            isObscure: false,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            context: context,
            controller: _lastnameController,
            label: "Lastname",
            validator: lastnameValidator,
            isObscure: false,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            context: context,
            controller: _emailController,
            label: "Email",
            validator: emailValidator,
            isObscure: false,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            context: context,
            controller: _phoneNumController,
            label: "Phone",
            validator: phoneNumberValidator,
            isObscure: false,
          )
        ],
      )
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Image.asset("assets/logo.png", scale: 14),
              top: 50,
              left: 18,
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 112),
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
                    child: Form(
                        key: _formKey,
                        child: stepScreen.elementAt(_stepIndex))),
                BottomActions(
                  stepIndex: _stepIndex,
                  next: next,
                  registerHandler: registerHandler,
                  isLoading: isLoading,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
