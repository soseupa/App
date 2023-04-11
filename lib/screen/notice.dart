import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: buildAppBar(),
      body: Center(
        child: Column(
          children: [
            for(int i=0; i<5; i++)
            Notice()
          ],
        ),
      ),

    );
  }

  Padding Notice() {
    return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '김혜린',
                        style: TextStyle(
                          fontSize: 16,
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text('hyehye@gmail.com',
                          style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w300,
                          color: Colors.black
                      ),)
                    ],
                  ),
                  SizedBox(width: 30,),
                  ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(10, 15),
                        elevation: 0,
                        backgroundColor: Color(0xffFFE0EF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                      ),
                      child: Text(
                          '수락',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFF3F9B)
                        ),
                      )
                  )
                ],
              ),
            ),
          );
  }

  AppBar buildAppBar() {
    return AppBar(
        iconTheme: const IconThemeData(
            color: Colors.black
        ),
        backgroundColor: const Color(0xffFFFFFF),
        elevation: 0,
        title: const Text(
            '알람',
            style: TextStyle(
                fontSize: 23,
                fontFamily: 'NotoSansKR',
                color: Colors.black,
                fontWeight: FontWeight.w500))
    );
  }
}
