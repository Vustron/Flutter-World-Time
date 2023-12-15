// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors, unused_import, avoid_print, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import '../components/worldtimeContent.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return data['isDayTime'] ?? true ? 'day.jpg' : 'night.jpg';
  }

  Color getTextColor() {
    return data['isDayTime'] ?? true ? Colors.white : Colors.amber;
  }
}
