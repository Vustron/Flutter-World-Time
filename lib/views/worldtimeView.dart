// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors, unused_import, avoid_print, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import '../components/worldtimeContent.dart';

class WorldTime extends StatefulWidget {
  const WorldTime({super.key});

  @override
  State<WorldTime> createState() => _WorldTimeState();
}

class _WorldTimeState extends State<WorldTime> {
  late Map<dynamic, dynamic> data;

  @override
  Widget build(BuildContext context) {
    data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    print(data);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: WorldTimeContent(
              data: data,
              bgImage: getBackgroundImage(),
              textColor: getTextColor(),
            ),
          ),
        ],
      ),
    );
  }

  String getBackgroundImage() {
    return (data['isDayTime'] ?? false) ? 'day.jpg' : 'night.jpg';
  }

  Color getTextColor() {
    return (data['isDayTime'] ?? false) ? Colors.white : Colors.amber;
  }
}
