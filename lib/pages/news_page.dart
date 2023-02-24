import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  InAppWebViewController _appWebViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tin tức dịch bệnh COVID-19"),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (_appWebViewController != null) {
                _appWebViewController.goBack();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              if (_appWebViewController != null) {
                _appWebViewController.goForward();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              if (_appWebViewController != null) {
                _appWebViewController.reload();
              }
            },
          )
        ],
      ),
      body: Container(
        // padding: EdgeInsets.only(bottom: 50),
        child: InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.https("covid19.gov.vn", "/ban-tin-covid-19.htm")),
          onWebViewCreated: (controller) {
            _appWebViewController = controller;
          },
          onLoadStop: (controller, url) {
            _appWebViewController.evaluateJavascript(
                source:
                    "document.getElementsByClassName('header')[0].style.display= 'none'");
          },
        ),
      ),
    );
  }
}
