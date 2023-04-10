import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'notice.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({Key? key}) : super(key: key);

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: buildAppBar(),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Search()

          ],
        ),
      ),

    );
  }

  SizedBox Search() {
    return SizedBox(
            width: 400,
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                  suffixIcon:InkWell(
                    onTap: (){
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
                        color: Color(0xffFCD8E9),),

                  ),
                filled: true,
                fillColor: Color(0xffF9E6EF)
              ),
              // style: ,
            ),
          );
  }

  AppBar buildAppBar() {
    return AppBar(
        iconTheme: const IconThemeData(
            color: Colors.black
        ),
        backgroundColor: const Color(0xffF5F5F5),
        elevation: 0,
      title: const Text(
          '친구목록',
          style: TextStyle(
          fontSize: 23,
          fontFamily: 'NotoSansKR',
          color: Colors.black,
          fontWeight: FontWeight.w500))
      );
  }
}
