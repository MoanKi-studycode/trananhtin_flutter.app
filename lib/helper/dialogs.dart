import 'package:flutter/material.dart';

Future<String?> showConfirmDialog(
  BuildContext context,
  String dispMessage,
) async {
  AlertDialog dialog = AlertDialog(
    title: Text("Verify"),
    content: Text(dispMessage),
    actions: [
      ElevatedButton(
        onPressed: () =>
            Navigator.of(context, rootNavigator: true).pop("cancel"),
        child: Text("Cancel"),
      ),
      ElevatedButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop("ok"),
        child: Text("OK"),
      ),
    ],
  );
  String? res = await showDialog<String?>(
    barrierDismissible: false,
    context: context,
    builder: (context) => dialog,
  );
  return res;
}
