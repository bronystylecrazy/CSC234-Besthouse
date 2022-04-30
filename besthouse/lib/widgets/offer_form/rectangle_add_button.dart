import 'package:flutter/material.dart';

class RectangleAddButton extends StatelessWidget {
  const RectangleAddButton({
    required this.clickHandler,
    Key? key,
  }) : super(key: key);

  final VoidCallback clickHandler;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: IconButton(
        splashRadius: 1,
        iconSize: 30,
        icon: const Icon(Icons.add),
        color: Theme.of(context).colorScheme.secondary,
        onPressed: clickHandler,
      ),
      //dont forget to add function
    );
  }
}
