import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrowserActionSheet {
  static showActionSheet(BuildContext context) {
    if (Platform.isAndroid) {
      androidActionSheet(context);
    } else if (Platform.isIOS) {
      cupertinoActionSheet(context);
    }
  }

  static androidActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Copy URL'),
            Text('Cancel'),
          ],
        );
      },
    );
  }

  static cupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {},
              child: Text('Copy URL'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        );
      },
    );
  }
}
