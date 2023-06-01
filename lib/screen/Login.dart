import 'package:flutter/material.dart';
import 'package:gaori/screen/calendar.dart';
import 'Start_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class InputData {
  static Token? inputData;
}

class _LoginPageState extends State<LoginPage> {
  InputData inputData = InputData();
  late TextEditingController controller;
  bool isButtonActive = false;
  bool _isButtonEnabled = false;
  bool logincheck = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> Login(String email, String password) async{
    email = emailController.text;
    password = passwordController.text;
    var url = Uri.parse('http://localhost:8080/login'); // Todo url 얻기
    var body = jsonEncode({'email': email, 'password':password});

    try {
      // HTTP POST 요청 보내기
      var response = await http.post(url, body: body, headers : {'Content-Type': 'application/json'});
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String accessToken = responseData['accessToken'];
      Token token = Token(token: accessToken);
      InputData.inputData = token;
      print(accessToken);

      // 서버로부터 받은 응답 처리
      if (response.statusCode == 200 && password.length>0) {
        logincheck = true;
        print("로그인성공");
        final responseData = jsonDecode(response.body);
      } else {
        logincheck = false;
        print("로그인실패");
      }
    } catch (error) {
      print('로그인 요청 실패: $error');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
  }

  void _updateButtonState() { // 버튼이 활성화
    setState(() {
      _isButtonEnabled = emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '로그인',
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
            padding: const EdgeInsets.all(42.0),
            child: Center(
              child: Image.asset('assets/image/main_logo.png',
                  width: 109, height: 117),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  '이메일 입력',
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 12),
                child: Text(
                  '비밀번호 입력',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 360,
                      child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                            hintText: '비밀번호를 입력해주세요.',
                            errorText: ! logincheck ? '비밀번호가 틀렸습니다.' : null,
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            filled: true,
                            fillColor: Color(0xffF5F5F5),
                          ),
                          controller: passwordController,
                          onChanged: (value) {
                            Login(emailController.text, passwordController.text);
                            _updateButtonState();
                          }
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
                  Login(emailController.text, passwordController.text);
                  if(logincheck) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage()),
                    );
                  }
                  setState(() => isButtonActive = false);
                }
                    : null,
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

class Token {
  final String token;
  Token({required this.token});
}
