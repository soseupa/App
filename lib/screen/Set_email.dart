import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaori/screen/Signup.dart';
import 'package:http/http.dart' as http;

import 'Start_page.dart';

class SetEmailPage extends StatefulWidget {
  const SetEmailPage({Key? key}) : super(key: key);

  @override
  State<SetEmailPage> createState() => SetEmailPageState();
}

class SetEmailPageState extends State<SetEmailPage> {
  User? inputData = InputData.inputData;

  bool isButtonActive = false;
  bool _isButtonEnabled = false; // 버튼 유효성
  late TextEditingController controller;
  late String receivedCode;

  final emailController = TextEditingController();
  final verificationCodeController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    verificationCodeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    verificationCodeController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    // 버튼이 활성화
    setState(() {
      _isButtonEnabled = emailController.text.isNotEmpty &&
          verificationCodeController.text.isNotEmpty &&
          receivedCode == verificationCodeController.text;
    });
  }

  Future<void> Signup(String nickname, String password, String email) async {
    final String url = 'http://34.64.137.179:8080/user/signup';
    final Map<String, String> requestData = {
      'nickname': nickname,
      'password': password,
      'email': email,
    };

    var body = jsonEncode(
        {'nickname': nickname, 'password': password, 'email': email});
    // API 호출
    var response = await http.post(Uri.parse(url),
        body: body, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      // 회원가입 성공
      print('회원가입이 성공적으로 완료되었습니다!');
    } else {
      // 회원가입 실패
      print('회원가입에 실패하였습니다. 다시 시도해주세요.');
    }
  }

  void _signUp() {
    String nickname = inputData?.nickname ?? "";
    String password = inputData?.password ?? "";
    String email = emailController.text;

    print(nickname);
    print(password);

    Signup(nickname, password, email);
  }

  Future<void> sendEmail() async {
    var url = Uri.parse('http://34.64.137.179:8080/auth/email/check');
    var email = emailController.text;

    var body = jsonEncode({'email': email});

    var response = await http
        .post(url, body: body, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      print("이메일 전송 성공 ");
      print(response.body);
      receivedCode = response.body;
    } else {
      print("이메일 전송 실패");
    }
  }

  @override
  Widget build(BuildContext context) {
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
              MaterialPageRoute(builder: (context) => SignupPage()),
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
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  '이메일 설정',
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
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: '이메일을 입력해주세요.',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          filled: true,
                          fillColor: Color(0xffF5F5F5),
                          suffixIcon: TextButton(
                            onPressed: sendEmail,
                            child: Text(
                              '보내기',
                              style: TextStyle(
                                color: Color(0xffFF419C),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 12),
                child: Text(
                  '이메일 인증',
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
                        decoration: InputDecoration(
                          hintText: '이메일 인증코드를 입력해주세요.',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          filled: true,
                          fillColor: Color(0xffF5F5F5),
                        ),
                        controller: verificationCodeController,
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
                onPressed: () {
                  print(_isButtonEnabled);
                  _isButtonEnabled;
                  _signUp();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StartPage()),
                  );
                  setState(() => isButtonActive = false);
                },
                child: Text(
                  "완료",
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
