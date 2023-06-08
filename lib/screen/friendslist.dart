import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gaori/class/friendListUserInfo.dart';
import 'package:http/http.dart' as http;

import 'Login.dart';

class FriendsListPage extends StatefulWidget {
  final List<friendListUserInfoModel> friendsList;

  const FriendsListPage({Key? key, required this.friendsList})
      : super(key: key);

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  Token? inputData = InputData.inputData;
  String searchedNickname = '';
  String searchedEmail = '';
  bool showContainer = false;
  bool _isfriend = false;
  List<dynamic> friendlist = [];
  int length = 0;
  String email = '';
  String nickname = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: buildAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Search(),
              if (showContainer == false)
                for (var friend in friendlist)
                  alreadyFriend(friend['email'], friend['nickname']),
              if (showContainer) NotFriend(),
              //for(var request in requestList) Notice(request['email'], request['nickname'], request['id'])
              // HavenoFriend(),
            ],
          ),
        ),
      ),
    );
  }

  Padding HavenoFriend() {
    return Padding(
      padding: const EdgeInsets.only(top: 250.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Image.asset(
                'assets/image/noFriend.png',
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text('친구가 없어요...',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'NotoSansKR',
                      color: Colors.black,
                      fontWeight: FontWeight.w200)),
            ),
            Text('친구를 추가해 볼까요?',
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'NotoSansKR',
                    color: Colors.black,
                    fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
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

  @override
  void initState() {
    super.initState();
    friendList();
  }

  SingleChildScrollView alreadyFriend(String email, String nickname) {
    return SingleChildScrollView(
      child: Column(children: [
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
                  onTap: () => alreadyFriends('$nickname'),
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
                              Text('$email',
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
      ]),
    );
  }

  Future<void> _searchEmail(final email) async {
    String token = inputData?.token ?? "";
    String useremail = inputData?.email ?? "";
    print(token);

    final url = Uri.parse('http://34.64.137.179:8080/auth/email/' + email);
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> decodeResponseBody = json.decode(responseBody);
    // 응답 처리 로직 작성
    if (response.statusCode == 200 &&
        useremail != decodeResponseBody['email']) {
      // 요청이 성공했을 경우
      print('요청이 성공했습니다.');
      print('응답 본문: $responseBody');
      final nickname = decodeResponseBody['nickname'];
      final email = decodeResponseBody['email'];
      _isfriend = decodeResponseBody['friend'];
      print('닉네임: $nickname');
      print('이메일: $email');
      setState(() {
        showContainer = true;
        searchedNickname = nickname;
      });
    } else {
      // 요청이 실패했을 경우
      print('요청이 실패했습니다.');
      print('응답 상태 코드: ${response.statusCode}');
    }
  }

  Future<void> sendFriendRequest(String friendEmail) async {
    String token = inputData?.token ?? "";
    var url = 'http://34.64.137.179:8080/friend/request';
    Map<String, dynamic> requestData = {
      'email': friendEmail,
    };

    // 데이터를 JSON 형태로 변환
    String requestBody = jsonEncode(requestData);

    // POST 요청 생성
    var response = await http.post(
      Uri.parse(url),
      body: requestBody,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      // 요청이 성공적으로 보내졌을 경우
      print("친구요쳥 성공");
      print(response.body);
    } else if (response.statusCode == 403) {
      _isfriend = true;
      print("이미 친구신청 보냄");
    } else {
      // 요청이 실패했을 경우
      print("친구요청 실패");
      print('응답 상태 코드: ${response.statusCode}');
    }
  }

  Padding NotFriend() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: InkWell(
        onTap: () {},
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
                    child: Text('$searchedNickname',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'NotoSansKR',
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text('$searchedEmail',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'NotoSansKR',
                              color: Colors.black,
                              fontWeight: FontWeight.w300)),
                    ),
                    InkWell(
                        onTap: () => _rotateDialog(
                            '$searchedNickname', '$searchedEmail'),
                        child: Icon(Icons.add))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Padding UserList(int i) {
  //   return
  // }

  SizedBox Search() {
    final emailController = TextEditingController();
    return SizedBox(
      width: 360,
      child: TextFormField(
        controller: emailController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            hintText: '친구의 이메일을 검색해 보세요.',
            hintStyle: TextStyle(
              color: Color(0xffDEDEDE),
              fontSize: 15,
              fontFamily: 'NotoSansKR',
            ),
            border: InputBorder.none,
            suffixIcon: InkWell(
              onTap: () {
                _searchEmail(emailController.text);
                setState(() {
                  searchedEmail = emailController.text;
                  searchedNickname;
                });
              },
              child: Icon(
                Icons.search_rounded,
                color: Color(0xffFF00A8),
                size: 30,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Color(0xffFCD8E9),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Color(0xffFCD8E9),
              ),
            ),
            filled: true,
            fillColor: Color(0xffFDF7FA)),
        // style: ,
      ),
    );
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

  void _rotateDialog(String name, String friendEmail) {
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
                Image.asset(
                  'assets/image/friendrequeset.png',
                  height: 70,
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                    text: TextSpan(
                        text: name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w600),
                        children: const [
                      TextSpan(
                          text: '님께 친구 요청을 보내시겠어요?\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'NotoSansKR',
                            fontSize: 17,
                          )),
                    ])),
                const Center(
                  child: Text('한 번 건 친구 요청은 취소가 불가능합니다.',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'NotoSansKR',
                        fontSize: 13,
                      )),
                )
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffFF3F9B),
                          elevation: 0,
                          fixedSize: Size(130, 30)),
                      onPressed: () {
                        sendFriendRequest(friendEmail);
                        Navigator.pop(context);
                      },
                      child: const Text("확인"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFFFFFF),
                        elevation: 0,
                        fixedSize: Size(130, 30),
                      ),
                      child: const Text(
                        "취소",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  void alreadyFriends(String name) {
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
                Image.asset(
                  'assets/image/friendsGaori.png',
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
                            text: '님과 친구입니다!',
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffFF3F9B),
                          elevation: 0,
                          fixedSize: Size(130, 30)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("확인"),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
