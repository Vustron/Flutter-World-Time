// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/worldtimeModel.dart';

class ChangeLocationContent extends StatefulWidget {
  final List<WorldTimeData> locations;

  ChangeLocationContent({required this.locations});

  @override
  State<ChangeLocationContent> createState() => _ChangeLocationContentState();
}

class _ChangeLocationContentState extends State<ChangeLocationContent> {
  void updateTime(int index) async {
    WorldTimeData instance = widget.locations[index];
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: ListView.builder(
        itemCount: widget.locations.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[700],
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ListTile(
              onTap: () {
                updateTime(index);
              },
              title: Text(
                widget.locations[index].location,
                style: GoogleFonts.zenDots(
                  color: Colors.amber,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                widget.locations[index].url,
                style: GoogleFonts.zenDots(
                  color: Colors.amber,
                  fontSize: 13,
                ),
              ),
              leading: CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/${widget.locations[index].flag}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
