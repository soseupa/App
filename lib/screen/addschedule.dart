import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({Key? key}) : super(key: key);

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  // Size size = MediaQuery.of(context).size;
  static String kakaoMapKey = '	2c9d8c32312ebbee555a90fb9aa2faf4';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          KakaoMapView(
            width: 600,
            height: 600,
            kakaoMapKey: kakaoMapKey,
            lat: 33.450701,
            lng: 126.570667,
            showMapTypeControl: true,
            showZoomControl: true,
            markerImageURL:
                'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
            onTapMarker: (message) async {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Marker is clicked')));

              //await _openKakaoMapScreen(context);
            },
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: const Color(0xffFFFFFF),
      elevation: 0,
      title: Text('일정 추가',
          style: TextStyle(
              fontSize: 23,
              fontFamily: 'NotoSansKR',
              color: Colors.black,
              fontWeight: FontWeight.w500)),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20, top: 13),
          child: InkWell(
            onTap: () {},
            child: Text(
              '완료',
              style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'NotoSansKR',
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    );
  }
}
