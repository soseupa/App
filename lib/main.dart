import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future main() async { //Splash 화면 나타나게 하는 코드!!
  WidgetsFlutterBinding.ensureInitialized(); // 초기화 보장
  await Future.delayed(const Duration(seconds: 3)); // 3초 지연
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '가오리',
      home: Scaffold(
        appBar: AppBar(
          title: Text('가오리'),
        ),
        body: Center(
          child: Text('Splash 화면 아이콘이 너무 옹졸해!!'),
        ),
      ),
    );
  }
}

