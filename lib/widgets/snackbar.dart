import 'package:flutter/material.dart';
import 'package:message_buddy/widgets/constants.dart';

void showSnackBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color,
    duration: Duration(seconds: 5),
    action:
        SnackBarAction(label: 'Ok', textColor: Colors.black, onPressed: () {}),
  ));
}
