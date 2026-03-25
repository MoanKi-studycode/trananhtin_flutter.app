import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageViewRss65Httts4 extends StatefulWidget {PageViewRss65Httts4({super.key, required this.link, required this.resourceName});
  String link, resourceName;

  @override
  State<PageViewRss65Httts4> createState() => _PageViewRss65Httts4State();
}

class _PageViewRss65Httts4State extends State<PageViewRss65Httts4> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.resourceName),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.link));
  }
}

