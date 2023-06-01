import 'package:floating_pullup_card/floating_layout.dart';
import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:geolocator/geolocator.dart';

const String kakaoMapKey = '2c9d8c32312ebbee555a90fb9aa2faf4';

class KakaoMapTest extends StatelessWidget {
  bool starttouch = true;
  bool firsttouch = false;
  bool secondtouch = false;
  double latitude =  0.0;
  double longitude = 0.0;

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;

  }

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
        body:
        // FloatingPullUpCardLayout(
          // collpsedStateOffset: (maxHeight, cardHeight) => 700,
          // hiddenStateOffset: (maxHeight, cardHeight) => 300,
          // uncollpsedStateOffset: (maxHeight) => 0,
          //
          // borderRadius: BorderRadius.circular(60),
          // child: Container(
          //   decoration: BoxDecoration(color: Colors.white),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
                KakaoMapView(
                    width: size.width,
                    height: 660,
                    kakaoMapKey: kakaoMapKey,
                    lat: latitude,
                    lng: longitude,
                    showMapTypeControl: true,
                    showZoomControl: true,
                    markerImageURL:
                        'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
                    onTapMarker: (message) async {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Marker is clicked')));
                    }),
          //     ],
          //   ),
          // ),
          // body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          //   SizedBox(
          //     height: 12,
          //   ),
          //   Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Padding(
          //           padding: const EdgeInsets.only(left: 20.0),
          //           child: TextFormField()),
          //       SizedBox(),
          //     ],
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.only(top: 23.0),
          //     child: Divider(thickness: 2, height: 1, color: Color(0xffF3F3F3)),
          //   ),
          //   Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(right: 10.0),
          //         child: ElevatedButton(
          //           onPressed: () {},
          //           child: Text('친구 추가'),
          //           style: ElevatedButton.styleFrom(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(40.0),
          //               // side: BorderSide(style: )x/x
          //             ),
          //             minimumSize: Size(60, 35),
          //             backgroundColor: Color(0xffFF3F9B),
          //             elevation: 0,
          //             fixedSize: Size(130, 30),
          //           ),
          //         ),
          //       )
          //     ],
          //   )
          // ]),
        // )
    );
  }
}
