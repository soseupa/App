import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Login.dart';

class searchPlacePage extends StatefulWidget {
  final int id;
  final String title;

  searchPlacePage({required this.id, required this.title});

  @override
  State<searchPlacePage> createState() => _searchPlacePageState();
}

class _searchPlacePageState extends State<searchPlacePage> {
  Token? inputData = InputData.inputData;
  String searchedNickname = '';
  String searchedEmail = '';
  bool showContainer = false;
  List<dynamic> friendlist = [];
  int length = 0;
  String email = '';
  String nickname = '';
  late WebViewController controller;

  @override
  void initState() {
    String token = inputData?.token ?? "";
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(),
      )
      ..loadRequest(Uri.parse(
          'http://34.64.108.196/search?id=${widget.id}&title=${widget.title}&token=$token'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: buildAppBar(),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: const Color(0xffFFFFFF),
      elevation: 0,
      title: const Text('일정추가',
          style: TextStyle(
              fontSize: 23,
              fontFamily: 'NotoSansKR',
              color: Colors.black,
              fontWeight: FontWeight.w500)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                '완료',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFF7CBB),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
