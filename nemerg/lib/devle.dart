import 'package:flutter/material.dart';

import 'package:nemerg/Geribildirme.dart';
import 'package:http/http.dart' as http;
import 'package:nemerg/devlethastane.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Dev extends StatelessWidget {
   Dev({Key? key}) : super(key: key);
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Devlet Hastaneler"),
      ),
      body: WebView(
        initialUrl:
            "https://www.istanbulhastaneleri.net/devlet-hastaneleri.html",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
      ),
    );
  }
}
