import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'Login.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  Token? inputData = InputData.inputData;
  String nickname = '';
  String email = '';
  int id = 0;
  int length = 0;
  List<dynamic> requestList = [];

  Future<void> requestFriendlist() async {
    String token = inputData?.token ?? "";

    final url = Uri.parse('http://34.64.137.179:8080/friend/request');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    final values = json.decode(responseBody);
    requestList = values['findFriendRequestResponseList'];
    length = requestList.length;

    if (response.statusCode == 200) {
      // 응답 데이터 디코딩
      for (var request in requestList) {
        email = request['email'];
        nickname = request['nickname'];
        id = request['id'];

        setState(() {
          email = request['email'];
          nickname = request['nickname'];
          id = request['id'];
        });

        print(email);
        print(nickname);
        Notice(email, nickname, id);
      }
    } else {
      // 요청 실패 처리
      print("실패");
    }
  }

  @override
  void initState() {
    super.initState();
    requestFriendlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: buildAppBar(),
      body: ListView(children: [
        Center(
          child: Column(
            children: [for(var request in requestList) Notice(request['email'], request['nickname'], request['id'])],
          ),
        ),
      ]),
    );
  }

  Future<void> acceptFriendRequest(int senderId) async {
    String token = inputData?.token ?? "";

    final url = Uri.parse('http://34.64.137.179:8080/friend/request/accept?senderId=$senderId');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(url, headers: headers);

    print(senderId);
    if (response.statusCode == 200) {
      print("수락 완료");
    }
    else {
      print("수락 실패");
    }
  }

  Padding Notice(String email, String nickname, int id) {
    return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Slidable(
          //key: ValueKey(i),
          endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: '삭제',
              ),
            ],
          ),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$nickname',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '$email',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      acceptFriendRequest(id);
                      print(id);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(10, 15),
                      elevation: 0,
                      backgroundColor: Color(0xffFFE0EF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      '수락',
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFF3F9B)),
                    ))
              ],
            ),
          ),
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xffFFFFFF),
        elevation: 0,
        title: const Text('알람',
            style: TextStyle(
                fontSize: 23,
                fontFamily: 'NotoSansKR',
                color: Colors.black,
                fontWeight: FontWeight.w500)));
  }
}
