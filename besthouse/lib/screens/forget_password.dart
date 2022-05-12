import 'package:besthouse/services/api/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
//widget
import 'package:besthouse/widgets/common/button.dart';

//screen
import 'package:besthouse/screens/sign_in.dart';
//dio
import 'package:dio/dio.dart';
import 'package:besthouse/widgets/common/alert.dart';
import 'package:besthouse/models/response/info_response.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);
  static const routeName = "/forget-password";

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _resetHandler() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var result = await UserApi.resetPass(emailController.text);
        if (result is InfoResponse) {
          Future.delayed(const Duration(seconds: 1), (() {
            setState(() {
              isLoading = false;
            });
            Alert.successAlert(
              result,
              'Reset pass',
              () => Navigator.of(context).pushNamed(SignIn.routeName),
              context,
            );
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
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email can't be empty";
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return "Please enter a valid email";
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
                    ),
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
                                text: "Get new password",
                                isLoading: isLoading,
                                clickHandler: _resetHandler),
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
