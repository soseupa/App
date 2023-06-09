import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Login.dart';

class MapPage extends StatefulWidget {
  final int id;
  final String title;

  MapPage({required this.id, required this.title});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Token? inputData = InputData.inputData;
  late WebViewController controller;

  @override
  void initState() {
    String token = inputData?.token ?? "";
    print('token : $token');
    print('ID : ${widget.id}');
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(),
      )
      ..loadRequest(Uri.parse(
          'http://34.64.108.196/map?id=${widget.id}&token=$token'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          '${widget.title}',
          style: TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w600
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
