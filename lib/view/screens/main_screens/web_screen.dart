import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  final String url;

  const WebScreen({super.key, required this.url});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
     ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar
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
     ..loadRequest(Uri.parse(widget.url));  // Load the provided URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search ON YOUTUBE' , style: TextStyle(color: Colors.white38),),
        backgroundColor: Colors.black,
      ),
      body: WebViewWidget(controller: _controller),  // Display the WebView
    );
  }
}
