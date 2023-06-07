import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gaori/class/friendListUserInfo.dart';
import 'package:http/http.dart' as http;

import 'Login.dart';

class searchPlacePage extends StatefulWidget {

  @override
  State<searchPlacePage> createState() => _searchPlacePageState();
}

class _searchPlacePageState extends State<searchPlacePage> {
  Token? inputData = InputData.inputData;
  String searchedNickname = '';
  String searchedEmail = '';
  bool showContainer = false;
  bool _isfriend = false;
  List<dynamic> friendlist = [];
  int length = 0;
  String email = '';
  String nickname = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: buildAppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Search(),
            if(showContainer==true)
              for(int i=0; i<3; i++) searchedPlace(), // Todo : 여기 바꾸시면 됩니다!!
            //for(var request in requestList) Notice(request['email'], request['nickname'], request['id'])
            // HavenoFriend(),
          ],
        ),
      ),
    );
  }

  Padding searchedPlace() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 97,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xff767676),
                  width: 0.3,
                ),),),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:26.0),
                    child: Text('맥도날드 김해삼정DT점',
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'NotoSansKR',
                            color: Colors.black)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0, left:26.0),
                    child: Text('맥도날드 김해삼정DT점',
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'NotoSansKR',
                            color: Color(0xff767676))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.0, left:26.0),
                    child: Text('영업 중 · 오전 3:00에 영업 종료',
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'NotoSansKR',
                            color: Color(0xff767676))),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 23, top:10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Image.asset(
                        'assets/image/select.png',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0, top:5.0),
                      child: Text('지정하기',
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'NotoSansKR',
                              color: Color(0xffFF3F9B),
                              fontWeight: FontWeight.w300)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Padding UserList(int i) {
  //   return
  // }

  Row Search() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: SizedBox(
            width: 333,
            height : 49,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  hintText: '원하는 장소를 검색해 보세요!',
                  hintStyle: TextStyle(
                    color: Color(0xffDEDEDE),
                    fontSize: 15,
                    fontFamily: 'NotoSansKR',
                  ),
                  border: InputBorder.none,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        showContainer = true;
                      });
                    },
                    child: Icon(
                      Icons.search_rounded,
                      color: Color(0xffFF00A8),
                      size: 30,
                    ),
                  ),
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
                  fillColor: Color(0xffFDF7FA)),
              // style: ,
            ),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xffFFFFFF),
        elevation: 0,
        title: const Text('일정추가',
            style: TextStyle(
                fontSize: 23,
                fontFamily: 'NotoSansKR',
                color: Colors.black,
                fontWeight: FontWeight.w500)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:18.0),
            child: Center(
              child: Text(
                '완료',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFF7CBB),
                ),
              ),
            ),
          ),
        ],
    );
  }
}
