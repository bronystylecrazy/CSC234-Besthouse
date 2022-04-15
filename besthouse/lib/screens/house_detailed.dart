import 'package:flutter/material.dart';

class HouseDetailed extends StatelessWidget {
  const HouseDetailed({Key? key}) : super(key: key);
  static const routeName = "/house";

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final houseId = routeArgs['id'];
    return Scaffold();
  }
}
