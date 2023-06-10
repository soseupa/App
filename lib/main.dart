import 'package:flutter/material.dart';
import 'package:gaori/screen/Start_page.dart';
import 'package:gaori/screen/calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(MyPage());
}
// Future main() async {
//   //Splash 화면 나타나게 하는 코드!!
//   WidgetsFlutterBinding.ensureInitialized(); // 초기화 보장
//   await Future.delayed(const Duration(seconds: 10)); // 3초 지연
//   initializeDateFormatting().then((_) => runApp(MaterialApp(
//     home: MyPage(),
//   )));
class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: '가오리',
          debugShowCheckedModeBanner: false,
          home: StartPage()
    );
  }
}
