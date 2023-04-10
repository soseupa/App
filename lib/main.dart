import 'package:flutter/material.dart';
import 'package:gaori/screen/map.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future main() async { //Splash 화면 나타나게 하는 코드!!
  WidgetsFlutterBinding.ensureInitialized(); // 초기화 보장
  await Future.delayed(const Duration(seconds: 3)); // 3초 지연
  initializeDateFormatting().then((_) => runApp(MaterialApp(
      home: MapPage(),
    )
  ));
}