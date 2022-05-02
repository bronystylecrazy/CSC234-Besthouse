import 'package:besthouse/models/response/info_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Alert {
  static Future<dynamic> successAlert(
      InfoResponse result, String title, String? route, BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('$title Success!'),
        content: Text(result.message),
        actions: <Widget>[
          TextButton(
            onPressed: () => route == null
                ? null
                : Navigator.popAndPushNamed(context, route),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static Future<dynamic> errorAlert(DioError e, BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Something went wrong!'),
        content: Text(e.response?.data["message"] ?? e.message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
