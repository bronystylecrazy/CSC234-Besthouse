import 'package:besthouse/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Guide extends StatelessWidget {
  const Guide({Key? key}) : super(key: key);
  static const routeName = "/guide";

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String? guideType = routeArgs['type'];
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                "Back",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          elevation: 0,
          backgroundColor: Color(0xffF5F5F5)),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              guideType == "customer" ? "Customer Guide" : "Seller Guide",
              style: Theme.of(context).textTheme.headline3,
            )
          ],
        ),
      ),
    );
  }
}
