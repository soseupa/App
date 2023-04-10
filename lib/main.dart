import 'package:flutter/material.dart';
import 'package:gaori/screen/map.dart';
import 'package:intl/date_symbol_data_local.dart';



 void main(){
   initializeDateFormatting().then((_) => runApp(MaterialApp(
     home: MapPage(),
   )));


 }



