import 'package:flutter/material.dart';

class ScheduleDetailPage extends StatefulWidget {
  final int id;
  final String title;

  ScheduleDetailPage({required this.id, required this.title});

  @override
  State<ScheduleDetailPage> createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState extends State<ScheduleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Text(
            '${widget.title}',
            style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Center(
              child: InkWell(
                onTap: () {},
                child: const Text('저장',
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text('${widget.title}',
                  //   style: TextStyle(
                  //       fontSize: 20,
                  //       fontFamily: 'NotoSansKR',
                  //       color: Color(0xff000000),
                  //       fontWeight: FontWeight.w500
                  //   ),
                  // ),
                ],
              ),
            ),
            // Divider(
            //   thickness: 0.5,
            //   color: Color(0xffDEDEDE),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21.0),
                ),
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
                      // Navigator.push(context,
                      // MaterialPageRoute(builder: (context) => AddScheduleUsers(friendsList: friendsList,)));
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
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xffF9F7F7), width: 3),
                      color: Color(0xffF9F7F7)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: Text("밥먹기",
                            style: TextStyle(
                                fontSize: 16,
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
                  height: 85,
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
            child: Text('김지원',
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
