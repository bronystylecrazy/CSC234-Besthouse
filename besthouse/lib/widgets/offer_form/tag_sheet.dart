import 'package:flutter/material.dart';
// widgets
import '../common/button.dart';

class TagSheet extends StatefulWidget {
  const TagSheet({required this.addTagHandler, Key? key}) : super(key: key);

  final Function(String) addTagHandler;

  @override
  State<TagSheet> createState() => _TagSheetState();
}

class _TagSheetState extends State<TagSheet> {
  final _tagsController = TextEditingController();

  @override
  void dispose() {
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tags",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                    controller: _tagsController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                      fillColor: Theme.of(context).colorScheme.tertiary,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Button(
                      clickHandler: () {
                        if (_tagsController.text.isNotEmpty) {
                          widget.addTagHandler(_tagsController.text);
                          Navigator.of(context).pop();
                        }
                      },
                      text: "Add tag",
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
