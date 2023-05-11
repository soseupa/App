import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaori/screen/Set_email.dart';
import 'package:gaori/screen/Start_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isButtonActive = true;
  late TextEditingController controller = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();

  final myController = TextEditingController();
  late String nicknameInput;
  late String passwordInput;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      final isButtonActive = true;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 54.0),
              child: ElevatedButton(
                onPressed: isButtonActive
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
