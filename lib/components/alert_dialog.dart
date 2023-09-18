import 'package:flutter/material.dart';

class CustomDialog {
  static void show(BuildContext context, String title) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
              title: Text(title));
        });
  }
}
