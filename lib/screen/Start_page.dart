import 'package:flutter/material.dart';
import 'package:gaori/screen/Signup.dart';

import 'Login.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/image/main_logo.png'),
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 52),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: Text("회원가입"),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Color(0xffFF419C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0)),
                        minimumSize: Size(150, 50),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 52),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text("로그인"),
                      style: TextButton.styleFrom(
                        primary: Color(0xffFF419C),
                        backgroundColor: Color(0xffFFF8FB),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0)),
                        minimumSize: Size(150, 50),
                        shadowColor: Color(0xffFF419C),
                        //TODO : Shadow Blur 처리 넣기
                      ),
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
