import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'Login.dart';

class AddSchedulePage extends StatefulWidget {
  DateTime date;

  AddSchedulePage({required this.date});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  String inputValue = '';
  Token? inputData = InputData.inputData;
  final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');

  String formattedDate = '';

  String format() {
    DateTime newDate = widget.date.add(Duration(minutes: 1));
    formattedDate = formatter.format(newDate);
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    format();
  }

  void _handleSubmit() {
    print('전달할 값: $inputValue');
  }

  Future<void> _makeSchedule() async {
    String token = inputData?.token ?? "";
    final url = Uri.parse('http://34.64.137.179:8080/schedule');
    Map<String, dynamic> requestBody = {
      'title': '${inputValue}',
      'time': '${formattedDate}',
    };
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode == 200) {
      print('SCHEDULE 생성 완료');
      //TODO : 일정 추가 완료 알림창
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('일정 추가 완료'),
                content: Text('일정이 추가되었습니다.'),
                actions: [
                  InkWell(
                    child: Text('확인'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
    } else {
      print('SCHEDULE 생성 실패');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '일정추가',
          style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Color(0xffFF67B0),
              ),
              child: Center(
                child: Text('일정 제목을 입력해 볼까요?',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'NotoSansKR',
                        color: Color(0xffFF67B0),
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    width: 320,
                    height: 60,
                    child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            inputValue = value; // TextField의 값이 변경될 때마다 변수에 저장
                          });
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Color(0xffFCD8E9),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Color(0xffFCD8E9),
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xffFDF7FA),
                          hintText: '제목을 입력해주세요',
                          hintStyle: TextStyle(
                            fontFamily: 'NotoSansKR',
                            color: Color(0xffDEDEDE),
                            fontSize: 18,
                          ),
                          border: InputBorder.none,
                        )),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _makeSchedule();
            },
            child: Text(
              '일정 추가하기',
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xffFF67B0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              minimumSize: Size(320, 40),
            ),
          )
        ],
      ),
    );
  }
}
