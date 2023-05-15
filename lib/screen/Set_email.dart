import 'package:flutter/material.dart';
import 'package:gaori/screen/Signup.dart';

import 'Start_page.dart';

class SetEmailPage extends StatefulWidget {
  const SetEmailPage({Key? key}) : super(key: key);

  @override
  State<SetEmailPage> createState() => SetEmailPageState();
}

class SetEmailPageState extends State<SetEmailPage> {
  bool isButtonActive = false;
  bool _isButtonEnabled = false; // 버튼 유효성
  late TextEditingController controller;

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

  void _updateButtonState() { // 버튼이 활성화
    setState(() {
      _isButtonEnabled = emailController.text.isNotEmpty &&
          verificationCodeController.text.isNotEmpty;
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
              MaterialPageRoute(builder: (context) => SignupPage()),
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
                    child: Text( '2',
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
                          suffixIcon:
                            TextButton(
                              onPressed: () {  },
                                child: Text('보내기', style: TextStyle(color: Color(0xffFF419C),),
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
                        controller: verificationCodeController
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
                        setState(() => isButtonActive = false);
                      }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StartPage()),
                  );
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
