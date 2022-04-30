import 'package:flutter/material.dart';

class DropdownMenu extends StatelessWidget {
  const DropdownMenu({
    required this.list,
    required this.typeValue,
    required this.changeHandler,
    this.iconList,
    Key? key,
  }) : super(key: key);

  final List<String> list;
  final String typeValue;
  final ValueChanged changeHandler;
  final List<IconData>? iconList;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: typeValue,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.tertiary,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Theme.of(context).colorScheme.secondary,
      ),
      elevation: 16,
      onChanged: changeHandler,
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (iconList!.isNotEmpty)
                Icon(
                  iconList![list.indexOf(value)],
                  color: Theme.of(context).colorScheme.primary,
                ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(value),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
