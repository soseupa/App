import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:gaori/screen/map.dart';
import 'package:gaori/screen/searchPlace.dart';
import 'package:http/http.dart' as http;

import 'AddScheduleUsers.dart';
import 'Login.dart';

class ScheduleDetailPage extends StatefulWidget {
  final int id;
  final String title;

  ScheduleDetailPage({required this.id, required this.title});

  @override
  State<ScheduleDetailPage> createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState extends State<ScheduleDetailPage> {
  Token? inputData = InputData.inputData;
  List<dynamic> scheduleUsers = [];
  List<dynamic> scheduleDetails = [];
  String nickname = '';
  int userId = 0;
  String title = '';
  String location = '';
  double latitude = 0;
  double longitude = 0;
  var order = 0;
  var id = 0;
  int scheduleCount = 0;

  @override
  void initState() {
    super.initState();
    findScheduleDetails();
  }

  // @override
  // void dispose() {
  //   setState(() {
  //     findScheduleDetails();
  //   });
  //   super.dispose();
  // }

  Future<void> findScheduleDetails() async {
    String token = inputData?.token ?? "";

    final url =
        Uri.parse('http://34.64.137.179:8080/schedule/detail/${widget.id}');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    final values = json.decode(responseBody);
    if (response.statusCode == 200) {
      scheduleDetails = values['scheduleDetails'];
      scheduleUsers = values['scheduleUsers'];
      scheduleCount = scheduleDetails.length;
      print('개수 : ${scheduleDetails.length}');

      for (var user in scheduleUsers) {
        nickname = user['nickname'];
        userId = user['userId'];
        setState(() {
          nickname = user['nickname'];
          userId = user['userId'];
        });
        scheduleuser(nickname, userId);
      }
      for (var detail in scheduleDetails) {
        title = detail['title'];
        location = detail['location'];
        latitude = detail['latitude'];
        longitude = detail['longitude'];
        order = detail['orderIndex'];
        id = detail['id'];
        setState(() {
          scheduleCount = scheduleDetails.length;
          title = detail['title'];
          location = detail['location'];
          latitude = detail['latitude'];
          longitude = detail['longitude'];
          order = detail['orderIndex'];
          id = detail['id'];
        });
        tasks(title, location, latitude, longitude, order, id);
      }
    } else {
      // 요청 실패 처리
      print("실패");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '${widget.title}',
          style: TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  if (scheduleCount == 0) {
                    showAnimatedDialog(
                        context: context,
                        barrierDismissible: true,
                        animationType: DialogTransitionType.fadeScale,
                        duration: const Duration(milliseconds: 350),
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: const Color(0xffECECEC),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            //Dialog Main Title
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.cancel_rounded,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  'assets/image/ggamnol.png',
                                  height: 100,
                                ),
                              ],
                            ),
                            content: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Text('일정을 추가해 주세요!',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'NotoSansKR',
                                          fontSize: 18,
                                        )),
                                  ),
                                  const Center(
                                    child: Text('하나 이상의 일정이 추가되어야 저장할 수 있어요.',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w200,
                                          fontFamily: 'NotoSansKR',
                                          fontSize: 13,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapPage(
                                  id: widget.id,
                                  title: widget.title,
                                )));
                  }
                },
                child: const Text('지도로 보기',
                    style: TextStyle(
                        fontSize: 17,
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 21.0),
                      ),
                      for (var user in scheduleUsers)
                        scheduleuser(user['nickname'], user['userId']),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 8, right: 20),
                        child: InkWell(
                          child: Icon(
                            Icons.add_circle,
                            color: Color(0xffFF3F9B),
                            size: 35,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddScheduleUsers(
                                          id: widget.id,
                                        )));
                          },
                        ),
                      ),
                    ]),
              ),
            ),
            for (var detail in scheduleDetails)
              tasks(detail['title'], detail['location'], detail['latitude'],
                  detail['longitude'], detail['order'], detail['id']),
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => searchPlacePage()));
                        },
                        child: Column(
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
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 3),
                              child: Text('위치를 설정해 주세요',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'NotoSansKR',
                                      color: Color(0xffD9D9D9),
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
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

  Center tasks(String title, String location, double latitude, double longitude,
      int? order, int? id) {
    return Center(
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
                child: Text("$title",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'NotoSansKR',
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 3),
                child: Text('$location',
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
    );
  }

  Padding scheduleuser(String name, int userId) {
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
