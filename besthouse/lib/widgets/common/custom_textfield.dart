import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.context,
    required this.controller,
    required this.label,
    required this.isObscure,
  }) : super(key: key);

  final BuildContext context;
  final TextEditingController controller;
  final String label;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          decoration: const InputDecoration(
            fillColor: Color(0xFFE9E9E9),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
