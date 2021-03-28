import 'package:flutter/material.dart';
import 'package:inapp_browser/inapp_browser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Test(),
      ),
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              InappBrowser.showPopUpBrowser(
                context,
                Uri.parse('https://google.com'),
              );
            },
            child: Text('google.com'),
          ),
          ElevatedButton(
            onPressed: () {
              InappBrowser.showPopUpBrowser(
                context,
                Uri.parse('https://pub.dev'),
              );
            },
            child: Text('pub.dev'),
          ),
        ],
      ),
    );
  }
}
