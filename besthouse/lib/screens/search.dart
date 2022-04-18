import 'package:besthouse/widgets/search/filter_sheet.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  static const routeName = "/search";

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("search"),
          ElevatedButton(
            child: Text("test modal"),
            onPressed: () {
              _buildModal(context);
            },
          ),
        ],
      ),
    );
  }

  void _buildModal(BuildContext ctx) {
    showModalBottomSheet<dynamic>(
        // isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: ctx,
        builder: (_) {
          return const FilterSheet();
        });
  }

  void _closeModalSheet(BuildContext context) {
    Navigator.pop(context);
  }
}
