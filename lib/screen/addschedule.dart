import 'package:flutter/material.dart';
import 'package:gaori/screen/AddScheduleUsers.dart';

import '../class/friendListUserInfo.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({Key? key}) : super(key: key);

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final List<friendListUserInfoModel> friendsList = <friendListUserInfoModel>[];
  var name = "조수현";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Center(
              child: InkWell(
                onTap: () {},
                child: const Text('완료',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'NotoSansKR',
                        color: Color(0xffFF3F9B),
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      width: 320,
                      child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            color: Colors.black,
                            fontSize: 25,
                          ),
                          decoration: InputDecoration(
                            hintText: '제목 입력',
                            hintStyle: TextStyle(
                              color: Color(0xffDEDEDE),
                              fontSize: 25,
                            ),
                            border: InputBorder.none,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: InkWell(
                      child: Text('저장',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'NotoSansKR',
                              color: Color(0xff8E8E8F),
                              fontWeight: FontWeight.w500)),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Color(0xffDEDEDE),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++) scheduleuser(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 8),
                  child: InkWell(
                    child: Icon(
                      Icons.add_circle,
                      color: Color(0xffFF3F9B),
                      size: 35,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddScheduleUsers(friendsList: friendsList,)));

                    },
                  ),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: 360,
                  height: 100,
                  decoration: BoxDecoration(
                    // color: Color(0xffF9F7F7),
                    // color: Color(0xffFF3F9B),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xffF9F7F7), width: 3),
                      color: Color(0xffF9F7F7)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 3),
                        child: Text("밥먹기",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'NotoSansKR',
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 3),
                        child: Text('맥도날드 김해삼정DT점',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'NotoSansKR',
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: 360,
                  height: 100,
                  decoration: BoxDecoration(
                    // color: Color(0xffF9F7F7),
                    // color: Color(0xffFF3F9B),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xffF9F7F7), width: 3),
                      color: Color(0xffF9F7F7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, bottom: 3),
                            child: Text("일정을 입력해 주세요",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'NotoSansKR',
                                    color: Color(0xffD9D9D9),
                                    fontWeight: FontWeight.w600)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 3),
                            child: Text('위치를 설정해 주세요',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'NotoSansKR',
                                    color: Color(0xffD9D9D9),
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: InkWell(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding scheduleuser() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 10),
      child: Container(
        width: 80,
        height: 35,
        decoration: BoxDecoration(
          // color: Color(0xffFF3F9B),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Color(0xffFF3F9B), width: 1),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Text('$name',
                // textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'NotoSansKR',
                    color: Color(0xffFF3F9B),
                    fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}
