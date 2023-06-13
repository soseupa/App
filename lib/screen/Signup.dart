import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:gaori/screen/Set_email.dart';
import 'package:gaori/screen/Start_page.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class InputData {
  static User? inputData;
}

class _SignupPageState extends State<SignupPage> {
  InputData inputData = InputData();

  bool isButtonActive = false;
  bool _checknickname = true;
  late TextEditingController controller = TextEditingController();
  final TextEditingController nicknameController =
      TextEditingController(); // 닉네임 넣기
  final TextEditingController passwordController =
      TextEditingController(); // 비밀번호 넣기
  final TextEditingController passwordCheckController =
      TextEditingController(); // 비밀번호 유효성 검사 위함
  final myController = TextEditingController();
  final _confirmPasswordFocusNode = FocusNode();
  bool _isButtonEnabled = false;

  @override
  void dispose() {
    passwordController.dispose();
    passwordCheckController.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    nicknameController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
    passwordCheckController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    // 버튼이 활성화
    setState(() {
      _isButtonEnabled = _checknickname &&
          nicknameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          passwordCheckController.text.isNotEmpty &&
          passwordController.text == passwordCheckController.text;
    });
  }

  bool _passwordmatch = true;

  void CheckPasswordMatch() {
    String password = passwordController.text;
    String confirmpassword = passwordCheckController.text;

    setState(() {
      _passwordmatch = password == confirmpassword;
    });
  }

  Future<void> checkNicknameDulication() async {
    final String nickname = nicknameController.text;
    final String url = 'http://34.64.137.179:8080/user/check/' + nickname;

    final response = await http.get(
      Uri.parse(url),
    );
    print(nickname);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data && nickname.length <= 0) {
        print(nickname.length);
        _checknickname = false;
        print('사용 가능하지않음');
      } else {
        _checknickname = true;
        print('닉네임 중복 아님');
      }
    } else {
      print(nickname.length);
      _checknickname = false;
      print('닉네임 중복임');
    }
  }

  @override
  Widget build(BuildContext context) {
    String nickname = nicknameController.text;
    String password = passwordController.text;
    User user = User(nickname: nickname, password: password);
    InputData.inputData = user;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '회원가입',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // TODO : 아이콘 피그마에 나와 있는 걸로 바꾸기
          color: Colors.black,
          onPressed: () {
            // 아이콘 버튼 실행
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StartPage()),
            );
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 42.0),
            child: Center(
              child: Image.asset('assets/image/main_logo.png',
                  width: 109, height: 117),
            ),
          ),
          Padding(
            // progress bar
            padding: const EdgeInsets.only(top: 22.0, bottom: 23.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffFF67B0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  height: 39,
                  width: 39,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(400),
                    border: Border.all(
                      width: 4,
                      color: Color(0xffFF67B0),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xfFF00A8).withOpacity(.30),
                        spreadRadius: 3,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 4,
                  width: 68,
                  color: Color(0xffFF67B0),
                ),
                Container(
                  child: Center(
                    child: Text(
                      '2',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  height: 39,
                  width: 39,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(400),
                    color: Color(0xffFF67B0),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  '닉네임 설정',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: 360,
                      child: TextField(
                        controller: nicknameController, // 닉네임 저장
                        onChanged: (value) {
                          // 입력 값이 변경될 때마다 유효성 검사를 실행합니다.
                          checkNicknameDulication();
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12.0),
                          hintText: '닉네임을 입력해주세요.',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          errorText: !_checknickname ? '닉네임이 중복되었어요.' : null,
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          filled: true,
                          fillColor: Color(0xffF5F5F5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 12),
                child: Text(
                  '비밀번호 설정',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 360,
                      height: 48,
                      child: TextField(
                        controller: passwordController, // 비밀번호 저장
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '비밀번호를 입력해주세요.',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          filled: true,
                          fillColor: Color(0xffF5F5F5),
                        ),
                        onChanged: (value) {
                          CheckPasswordMatch();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 12),
                child: Text(
                  '비밀번호 확인',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: 360,
                      child: TextField(
                        controller: passwordCheckController,
                        focusNode: _confirmPasswordFocusNode,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12.0),
                          hintText: '비밀번호를 입력해주세요.',
                          errorStyle: TextStyle(
                            fontSize: 11,
                          ),
                          errorText: !_passwordmatch ? '비밀번호가 일치하지않아요.' : null,
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          filled: true,
                          fillColor: Color(0xffF5F5F5),
                        ),
                        onChanged: (value) {
                          CheckPasswordMatch();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 54.0),
              child: ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetEmailPage()),
                        );
                      }
                    : null,
                child: Text(
                  "다음",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  onSurface: Color(0xffFF419C),
                  backgroundColor: Color(0xffFF419C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0)),
                  minimumSize: Size(360, 48),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class User {
  final String nickname;
  final String password;

  User({required this.nickname, required this.password});
}
