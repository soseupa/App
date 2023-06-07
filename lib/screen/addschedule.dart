import 'package:flutter/material.dart';

import '../class/friendListUserInfo.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({Key? key}) : super(key: key);

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final List<friendListUserInfoModel> friendsList = <friendListUserInfoModel>[];

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 200, bottom: 10.0),
            child: Image.asset("assets/image/juhomin.png",
                width: 160, height: 120, fit: BoxFit.fill),
          ),
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
            onPressed: () {},
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
