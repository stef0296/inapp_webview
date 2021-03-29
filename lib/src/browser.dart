import 'package:flutter/material.dart';
import 'package:inapp_browser/src/navbar.dart';
import 'package:inapp_browser/src/tabbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {
  final Uri? url;

  const Browser({@required this.url});

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> with SingleTickerProviderStateMixin {
  List<Uri> urls = [];
  String title = '';
  bool isSecure = false;
  int currentIndex = 0;
  double loadingStatus = 0.0;
  WebViewController? _webViewController;
  late AnimationController animationController;

  NavigationDecision navigationDelegate(NavigationRequest request) {
    print('URL: ${request.url}');

    /**
     * if currentIndex != lastIndex,
     * the user has navigated back and is now going to some other page.
     * so any url after the current index is now useless and needs to be removed
     */
    int filteredURI =
        urls.indexWhere((element) => element.toString() == request.url);

    if (filteredURI != -1) {
      currentIndex = filteredURI;
      title = '';
      isSecure = false;
      setState(() {});
      return NavigationDecision.navigate;
    }
    if (currentIndex != (urls.length - 1) && filteredURI == -1)
      urls.removeRange(currentIndex + 1, urls.length);

    // if ((urls.length > 1) && urls[0].toString() == widget.url.toString()) {
    //   urls.removeAt(0);
    //   currentIndex--;
    // }

    Uri uri = Uri.parse(request.url);
    urls.add(uri);
    currentIndex++;
    title = '';
    isSecure = false;
    setState(() {});
    return NavigationDecision.navigate;
  }

  void goBack(_) async {
    // get current url
    String currentUrl = (await _webViewController!.currentUrl())!;

    /**
     * if current url matches the url at the current index,
     * decrement current index.
     */
    if (currentUrl == urls[currentIndex].toString()) {
      currentIndex--;
      setState(() {});
    }

    // if it's possible to navigate back, navigate
    // if (await _webViewController!.canGoBack()) {
    _webViewController!.loadUrl(urls[currentIndex].toString());
    // }
  }

  void goForward(_) async {
    /**
     * if the current index is less than the array length,
     * go ahead
     */
    if (currentIndex < (urls.length - 1)) {
      currentIndex++;
      setState(() {});
    }
    // if (await _webViewController!.canGoForward())
    //   _webViewController!.goForward();
    _webViewController!.loadUrl(urls[currentIndex].toString());
  }

  void reloadPage(_) {
    _webViewController!.reload();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    urls.add(widget.url!);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: WillPopScope(
        onWillPop: () async {
          if (currentIndex > 0) {
            goBack(null);
            return false;
          }
          return true;
        },
        child: SafeArea(
          child: Column(
            children: [
              Navbar(
                title: title,
                url: urls[currentIndex].host,
                isSecure: isSecure,
                reloadCallback: reloadPage,
              ),
              Visibility(
                visible: animationController.value != 0.0,
                child: LinearProgressIndicator(
                  value: animationController.value,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: size.height,
                  child: WebView(
                    initialUrl: urls[currentIndex].toString(),
                    javascriptMode: JavascriptMode.unrestricted,
                    navigationDelegate: navigationDelegate,
                    onWebViewCreated: (WebViewController controller) {
                      _webViewController = controller;
                    },
                    onPageFinished: (url) async {
                      title = (await _webViewController!.getTitle())!;
                      isSecure = urls[currentIndex].isScheme('https');
                      setState(() {});
                    },
                    onProgress: (int status) {
                      print('Status $status');
                      animationController.value = status / 1.0;
                      if (status == 100) animationController.value = 0.0;
                      setState(() {});
                    },
                  ),
                ),
              ),
              Tabbar(
                urls: urls,
                currentIndex: currentIndex,
                goBack: goBack,
                goForward: goForward,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
