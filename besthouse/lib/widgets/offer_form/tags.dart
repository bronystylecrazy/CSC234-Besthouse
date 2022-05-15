import 'package:flutter/material.dart';
// widgets
import '../common/tag.dart';
import 'tag_sheet.dart';

class Tags extends StatelessWidget {
  const Tags({
    required this.tags,
    required this.deleteHandler,
    required this.addHandler,
    Key? key,
  }) : super(key: key);

  final List<String> tags;
  final Function(String) deleteHandler;
  final Function(String) addHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      padding: const EdgeInsets.only(top: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              "Tags",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          if (tags.isNotEmpty)
            ...tags.map((value) {
              return Tag(
                title: value,
                deleteHandler: deleteHandler,
                isCanDelete: true,
              );
            }).toList(),
          IconButton(
            padding: EdgeInsets.only(bottom: 8),
            splashRadius: 16,
            iconSize: 24,
            icon: const Icon(Icons.add),
            onPressed: () => _buildModalOfTags(context),
          ),
        ],
      ),
    );
  }

  void _buildModalOfTags(BuildContext ctx) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: ctx,
        builder: (_) {
          return TagSheet(
            addTagHandler: addHandler,
          );
        });
  }
}
