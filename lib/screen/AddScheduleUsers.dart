import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import 'Login.dart';

class AddScheduleUsers extends StatefulWidget {
  final int id;

  AddScheduleUsers({required this.id});

  @override
  State<AddScheduleUsers> createState() => _AddScheduleUsersState();
}

class _AddScheduleUsersState extends State<AddScheduleUsers> {
  Token? inputData = InputData.inputData;
  bool showContainer = false;
  List<dynamic> friendlist = [];
  int length = 0;
  String email = '';
  String nickname = '';

  @override
  void initState() {
    super.initState();
    friendList();
  }

  // @override
  // void dispose() {
  //   setState(() {
  //     showContainer = false;
  //   });
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var friend in friendlist)
                alreadyFriend(friend['email'], friend['nickname']),
            ]),
          ),
        ));
  }

  Future<void> addFriendToSchedule(String selectedEmail) async {
    String token = inputData?.token ?? "";

    final url = Uri.parse(
        'http://34.64.137.179:8080/schedule/user/add?id=${widget.id}&email=$selectedEmail');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      // 응답 데이터 디코딩
      print("성공");
      // showAboutDialog(context: context)
    } else {
      // 요청 실패 처리
      print("실패");
      final responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = json.decode(responseBody);
      final String message = responseData['message'];
      print(message);
      if (message == "이미 존재하는 사용자입니다.") {
        showAnimatedDialog(
            context: context,
            barrierDismissible: true,
            animationType: DialogTransitionType.fadeScale,
            duration: const Duration(milliseconds: 350),
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: const Color(0xffECECEC),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                //Dialog Main Title
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.cancel_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/image/ggamnol.png',
                      height: 100,
                    ),
                  ],
                ),
                content: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text('이미 추가된 친구예요!',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'NotoSansKR',
                              fontSize: 18,
                            )),
                      ),
                      const Center(
                        child: Text('한 번 추가한 친구 다시 추가할 수 없어요.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'NotoSansKR',
                              fontSize: 13,
                            )),
                      )
                    ],
                  ),
                ),
              );
            });
      }
    }
  }

  Future<void> friendList() async {
    String token = inputData?.token ?? "";

    final url = Uri.parse('http://34.64.137.179:8080/friend/list');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    final values = json.decode(responseBody);
    friendlist = values['friendList'];
    length = friendlist.length;

    if (response.statusCode == 200) {
      // 응답 데이터 디코딩
      for (var request in friendlist) {
        email = request['email'];
        nickname = request['nickname'];

        setState(() {
          email = request['email'];
          nickname = request['nickname'];
        });

        alreadyFriend(email, nickname);
      }
    } else {
      // 요청 실패 처리
      print("실패");
    }
  }

  Column alreadyFriend(String Email, String nickname) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.25,
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: '친구 삭제',
                ),
              ],
            ),
            child: Center(
              child: InkWell(
                onTap: () => alreadyFriends('$nickname', '$Email'),
                child: Container(
                  width: 360,
                  height: 66,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF9F7F7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 18.0),
                            child: Text('$nickname',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'NotoSansKR',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 23),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('$Email',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'NotoSansKR',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    ]);
  }

  void alreadyFriends(String name, String Email) {
    showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.fadeScale,
        duration: const Duration(milliseconds: 350),
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xffECECEC),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/friendrequeset.png',
                  height: 130,
                  width: 130,
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: RichText(
                      text: TextSpan(
                          text: name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600),
                          children: const [
                        TextSpan(
                            text: '님을 추가하시겠습니까?',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'NotoSansKR',
                              fontSize: 17,
                            )),
                      ])),
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFF3F9B),
                        elevation: 0,
                        fixedSize: Size(120, 30)),
                    onPressed: () {
                      addFriendToSchedule(Email);
                      Navigator.pop(context);
                    },
                    child: const Text("확인"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffCAC9C9),
                        elevation: 0,
                        fixedSize: Size(120, 30)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("취소"),
                  )
                ],
              ),
            ],
          );
        });
  }

  AppBar buildAppBar() {
    return AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xffFFFFFF),
        elevation: 0,
        title: const Text('친구목록',
            style: TextStyle(
                fontSize: 23,
                fontFamily: 'NotoSansKR',
                color: Colors.black,
                fontWeight: FontWeight.w500)));
  }
}
