import 'package:flutter/material.dart';
import 'package:gaori/screen/Set_email.dart';
import 'package:gaori/screen/Start_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class InputData {
  String nickname='';
  String password='';
  String email='';
}

/*Future<bool> signUp(String name, String email, String password) async {
  var url = Uri.parse('');

  var body = jsonEncode({
    'name' : name,
    'password' : password,
    'email' : email,
  });

  //회원가입 요청 보내기
  var response = await http.post(
    url,
    headers : {'Content-type' : 'application/json'},
    body : body,
  );
} */

class _SignupPageState extends State<SignupPage> {
  InputData inputData = InputData();

  bool isButtonActive = false;
  late TextEditingController controller = TextEditingController();
  final nicknameController = TextEditingController(); // 닉네임 넣기
  final TextEditingController passwordController = TextEditingController(); // 비밀번호 넣기
  final TextEditingController passwordCheckController = TextEditingController(); // 비밀번호 유효성 검사 위함
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

  void _updateButtonState() { // 버튼이 활성화
    setState(() {
      _isButtonEnabled = nicknameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty && passwordCheckController.text.isNotEmpty && passwordController.text == passwordCheckController.text;
    });
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
              MaterialPageRoute(builder: (context) => StartPage()),
            );
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:42.0),
            child: Center(
              child: Image.asset('assets/image/main_logo.png',
                  width: 109, height: 117),
            ),
          ),
          Padding( // progress bar
              padding: const EdgeInsets.only(top: 22.0, bottom: 23.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                      child: Text( '1',
                        style: TextStyle(
                          fontSize:16,
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
                      child: Text( '2',
                        style: TextStyle(
                          fontSize:16,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 360,
                      height: 48,
                      child: TextField(
                        controller: nicknameController, // 닉네임 저장
                        decoration: InputDecoration(
                          hintText: '닉네임을 입력해주세요.',
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
                        controller: passwordController,// 비밀번호 저장
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 360,
                      height: 48,
                      child: TextField(
                        controller : passwordCheckController,
                        focusNode: _confirmPasswordFocusNode,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '비밀번호를 입력해주세요.',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
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
                        setState(() {
                          inputData.nickname = nicknameController.text;
                          inputData.password = passwordController.text;
                        });
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
