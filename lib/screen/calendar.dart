import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaori/class/friendListUserInfo.dart';
import 'package:gaori/screen/notice.dart';
import 'package:gaori/screen/webview.dart';
import 'package:table_calendar/table_calendar.dart';

import 'friendslist.dart';
import 'homepage.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  var nowYear = DateTime.now().year;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<friendListUserInfoModel> friendsList = <friendListUserInfoModel>[];
 var json_data;

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    json_data = await rootBundle.loadString('assets/json/information.json');
    var decode_data = json.decode(json_data);
    for (int i = 0; i < decode_data["length"]; i++) {
      friendsList.add(friendListUserInfoModel(
          decode_data["friend"][i]["name"], decode_data["friend"][i]["email"]));
    }
    setState(() {});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var month = DateTime.now().month;
    DateTime _now = DateTime.now();
    String user = "조수현";
    String scheduleName = "벚꽃데이트";

    return Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: buildAppBar(),
        body: Column(
          children: [
            buildCalendarHeader(month),
            buildCalendarBody(_now, selectedDay, focusedDay),
            PlusButton(user, selectedDay),
            SizedBox(
              height: 8,
            ),
            // TaskList()

            // Test()
          ],
        ));
  }

  Row PlusButton(String user, DateTime selectedDay) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: TodaySchedule(user, selectedDay),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 35.0),
          child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KakaoMapTest()));
              },
              child: Icon(
                Icons.add,
                size: 30,
              )),
        )
      ],
    );
  }

  Padding TodaySchedule(String user, DateTime selectedDay) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: RichText(
          text: TextSpan(
              text: '$user님의 \n',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontFamily: 'NotoSansKR',
                  fontWeight: FontWeight.w300),
              children: <TextSpan>[
            TextSpan(
                text: '${selectedDay.month}월 ${selectedDay.day}일',
                style: TextStyle(
                  color: Color(0xffFF00A8),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansKR',
                  fontSize: 23,
                )),
            TextSpan(
                text: ' 일정이에요!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w300))
          ])),
    );
  }

  Padding buildCalendarBody(
      DateTime _now, DateTime selectedDay, DateTime focusedDay) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: TableCalendar(
        firstDay: DateTime(_now.year, _now.month, 1),
        lastDay: DateTime(_now.year, _now.month + 1, 0),
        focusedDay: _now,
        locale: 'ko-KR',
        headerVisible: false,
        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          if (selectedDay == _now) {
          } else {
            setState(() {
              this.selectedDay = selectedDay;
              this.focusedDay = focusedDay;
            });
          }
        },
        selectedDayPredicate: (DateTime day) {
          // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
          return isSameDay(selectedDay, day);
        },
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            switch (day.weekday) {
              case 1:
                return const Center(
                  child: Text(
                    '월',
                    style: TextStyle(),
                  ),
                );
              case 2:
                return const Center(
                  child: Text('화'),
                );
              case 3:
                return const Center(
                  child: Text('수'),
                );
              case 4:
                return const Center(
                  child: Text('목'),
                );
              case 5:
                return const Center(
                  child: Text('금'),
                );
              case 6:
                return const Center(
                  child: Text('토'),
                );
              case 7:
                return const Center(
                  child: Text(
                    '일',
                  ),
                );
            }
          },
        ),
        calendarStyle: CalendarStyle(
            selectedTextStyle: TextStyle(color: Colors.black),
            defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(7.39)),
            selectedDecoration: BoxDecoration(
                // color: Color(0xffFBEFF5),
                color: Color(0xffF9F7F7),
                borderRadius: BorderRadius.circular(7.39)),
            markersAutoAligned: true,
            markerSize: 100,
            markerSizeScale: 50,
            markersAnchor: 20,
            markerMargin: const EdgeInsets.symmetric(horizontal: 3),
            todayTextStyle: const TextStyle(
              decoration: TextDecoration.underline,
              color: Color(0xffFF3F9B),
              fontSize: 16.0,
            ),
            todayDecoration: BoxDecoration(
                // color: const Color(0xffF9E6EF),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(7.39))

            // isTodayHighlighted:
            ),
      ),
    );
  }

  Padding buildCalendarHeader(int month) {
    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 20),
      child: Text(
        "$month월",
        style: const TextStyle(
            fontSize: 25,
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w600),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Image.asset(
              'assets/image/logo.png',
              height: 45,
            ),
          ),
        ),
        const SizedBox(
          width: 130,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FriendsListPage(friendsList: friendsList)));
                },
                child: const Text('친구목록',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'NotoSansKR',
                        color: Color(0xffFF3F9B),
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NoticePage()));
                  },
                  child: const Icon(Icons.notifications,
                      color: Color(0xffFFC98A), size: 30)),
            ],
          ),
        ),
      ]),
      centerTitle: false,
      backgroundColor: const Color(0xffFFFFFF),
      elevation: 0,
    );
  }
}
