import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String title;

  const Tag({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
