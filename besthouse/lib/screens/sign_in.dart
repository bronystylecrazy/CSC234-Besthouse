import 'package:besthouse/main.dart';
import 'package:besthouse/models/response/info_response.dart';
import 'package:besthouse/services/api/user.dart';
import 'package:besthouse/services/dio.dart';
import 'package:besthouse/services/share_preference.dart';
import 'package:besthouse/widgets/common/alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//widget
import 'package:besthouse/widgets/common/custom_textfield.dart';
import 'package:besthouse/widgets/common/button.dart';

//screen
import 'package:besthouse/screens/forget_password.dart';
import 'package:besthouse/screens/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const routeName = "/sign-in";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _loginHandler() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var result = await UserApi.login(
            _usernameController.text, _passwordController.text);

        if (result is InfoResponse) {
          SharePreference.prefs.setString("token", result.data);
          DioInstance.dio.options.headers["Authorization"] =
              "Bearer ${result.data}";
          Future.delayed(const Duration(seconds: 1), (() {
            setState(() {
              isLoading = false;
            });
            Navigator.pushNamed(context, MyHomePage.routeName);
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
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 24, left: 24, top: 112),
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
                      Form(
                        key: _formKey,
                        child: Column(
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
                          ],
                        ),
                      ),
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
                                  Navigator.pushNamed(
                                      context, ForgetPassword.routeName);
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
                                  isLoading: isLoading,
                                  clickHandler: _loginHandler),
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
                                      Navigator.pushNamed(
                                          context, SignUp.routeName);
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
      ),
    );
  }
}
