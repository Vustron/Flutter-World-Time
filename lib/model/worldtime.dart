// ignore_for_file: file_names, prefer_const_constructors, prefer_const_constructors_in_immutables, camel_case_types, unused_import, avoid_print, unused_local_variable, duplicate_import

import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorldTimeData {
  String location; // location name for the UI
  late String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for app
  late bool isDayTime; // true or false if daytime or not

  WorldTimeData({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Adjusted calculation considering UTC offset
      isDayTime = now.hour >= 6 && now.hour < 18;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught error: $e');
      time = 'Error';
    }
  }
}
