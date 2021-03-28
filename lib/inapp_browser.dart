library inapp_browser;

// export 'src/browser.dart';
import 'package:flutter/material.dart';
import 'package:inapp_browser/src/browser.dart';

class InappBrowser {
  static showPopUpBrowser(BuildContext context, Uri uri) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Browser(url: uri),
      ),
    );
    // Size size = MediaQuery.of(context).size;
    // showBottomSheet(
    //   context: context,
    //   builder: (context) => Container(
    //     height: size.height * 0.9,
    //     child: Browser(url: uri),
    //   ),
    // );
  }

  // static showBrowser(BuildContext context, String url) {
  //   Overlay.of(context)!.insert(createBrowserOverlay());
  // }

  // static OverlayEntry createBrowserOverlay() {
  //   return OverlayEntry(builder: (ctx) {
  //     return Container();
  //   });
  // }
}
