import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog({
  @required BuildContext context,
  @required String title,
  @required String content,
  @required String defaultActionText,
}) async {
  if (Platform.isIOS) {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(defaultActionText))
        ],
      ),
    );
  }
}
