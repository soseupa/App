import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

const String kakaoMapKey = '2c9d8c32312ebbee555a90fb9aa2faf4';

class KakaoMapTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          KakaoMapView(
              width: size.width,
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
              }),
        ],
      ),
    );
  }
}
