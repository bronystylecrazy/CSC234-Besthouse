import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String title;
  final Function(String)? deleteHandler;
  final bool isCanDelete;

  const Tag({
    Key? key,
    required this.title,
    this.deleteHandler,
    this.isCanDelete = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
              textAlign: TextAlign.center,
            ),
            if (isCanDelete)
              Container(
                margin: const EdgeInsets.only(left: 4),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.grey,
                    size: 15,
                  ),
                  onTap: () => deleteHandler!(title),
                ),
              ),
          ],
        ));
  }
}
