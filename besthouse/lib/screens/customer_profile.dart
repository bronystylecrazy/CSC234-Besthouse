import 'package:besthouse/screens/offer_form.dart';
import 'package:flutter/material.dart';

class CustomerProfile extends StatelessWidget {
  const CustomerProfile({Key? key}) : super(key: key);
  static const routeName = "/customer_profile";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(OfferForm.routeName, arguments: OfferArguments());
        },
      ),
    );
  }
}
