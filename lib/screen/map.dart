import 'package:flutter/material.dart';
import 'package:gaori/screen/notice.dart';
import 'package:intl/intl.dart';
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
  @override
  Widget build(BuildContext context) {
    var month = DateTime.now().month;
    DateTime? _selectedDay;
    DateTime _now = DateTime.now();

    return Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: buildAppBar(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 70, bottom: 40),
              child: Text(
                "$month월",
                style: const TextStyle(
                    fontSize: 25,
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: TableCalendar(
                firstDay: DateTime(_now.year, _now.month, 1),
                lastDay: DateTime(_now.year, _now.month + 1, 0),
                focusedDay: _now,
                locale: 'ko-KR',
                headerVisible: false,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _now = focusedDay;
                    });
                  }
                },
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    switch (day.weekday) {
                      case 1:
                        return const Center(
                          child: Text('월'),
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
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
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
                        color: const Color(0xffF9E6EF),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(7.39))

                    // isTodayHighlighted:
                    ),
              ),
            ),
          ],
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));

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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const FriendsListPage()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NoticePage()));
                  },
                  child: const Icon(Icons.notifications,
                      color: Color(0xffFFC98A), size: 30)),
            ],
          ),
        ),
      ]),
      centerTitle: false,
      backgroundColor: const Color(0xffF5F5F5),
      elevation: 0,
    );
  }
}
