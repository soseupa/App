import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../class/friendListUserInfo.dart';
import 'Login.dart';

class AddScheduleUsers extends StatefulWidget {
  final List<friendListUserInfoModel> friendsList;

  const AddScheduleUsers({Key? key, required this.friendsList})
      : super(key: key);

  @override
  State<AddScheduleUsers> createState() => _AddScheduleUsersState();
}

class _AddScheduleUsersState extends State<AddScheduleUsers> {
  Token? inputData = InputData.inputData;
  late TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: buildAppBar(),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              Search(),
            ])));
  }

  SizedBox Search() {
    Future<void> _searchEmail(final email) async {
      String token = inputData?.token ?? "";
      print(token);

      final url = Uri.parse('http://34.64.137.179:8080/auth/email/' + email);
      final headers = {'Authorization': 'Bearer $token'};
      final response = await http.get(url, headers: headers);
      final responseBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> decodeResponseBody = json.decode(responseBody);
      // 응답 처리 로직 작성
      if (response.statusCode == 200) {
        // 요청이 성공했을 경우
        print('요청이 성공했습니다.');
        print('응답 본문: $responseBody');
        final nickname = decodeResponseBody['nickname'];
        final email = decodeResponseBody['email'];
        print('닉네임: $nickname');
        print('이메일: $email');
      } else {
        // 요청이 실패했을 경우
        print('요청이 실패했습니다.');
        print('응답 상태 코드: ${response.statusCode}');
      }
    }

    final emailController = TextEditingController();
    return SizedBox(
      width: 400,
      height: 50,
      child: TextFormField(
        controller: emailController,
        decoration: InputDecoration(
            hintText: '친구의 이메일을 검색해보세요.',
            hintStyle: TextStyle(
              color: Color(0xffDEDEDE),
            ),
            border: InputBorder.none,
            suffixIcon: InkWell(
              onTap: () {
                _searchEmail(emailController.text);
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
}
