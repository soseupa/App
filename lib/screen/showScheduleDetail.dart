import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowScheduleDetail extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String title;
  ShowScheduleDetail({required this.latitude, required this.longitude, required this.title});

  @override
  State<ShowScheduleDetail> createState() => _ShowScheduleDetailState();
}

class _ShowScheduleDetailState extends State<ShowScheduleDetail> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(),
      )
      ..loadRequest(Uri.parse(
          'http://34.64.108.196/location?lat=${widget.latitude}&lon=${widget.longitude}'));
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
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
