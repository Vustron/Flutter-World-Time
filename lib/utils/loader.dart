// ignore_for_file: file_names, prefer_const_constructors, prefer_const_constructors_in_immutables, camel_case_types, unused_import, avoid_print, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../model/worldtime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../screens/worldtime.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> setupWorldTimeData() async {
    WorldTimeData instance = WorldTimeData(
        location: 'Manila', flag: 'philippines.jpg', url: 'Asia/Manila');
    await instance.getTime();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
        settings: RouteSettings(
          arguments: {
            'location': instance.location,
            'flag': instance.flag,
            'time': instance.time,
            'isDayTime': instance.isDayTime,
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('InitState function run');
    Future.delayed(Duration(seconds: 2), () async {
      await setupWorldTimeData();
      // getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SpinKitPouringHourGlass(
          color: Colors.amber,
          size: 80.0,
        ),
      ),
    );
  }
}
