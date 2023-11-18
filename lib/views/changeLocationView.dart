// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, camel_case_types, avoid_print, unused_local_variable, unused_import, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/changeLocationContent.dart';
import '../model/worldtime.dart';

class ChangeLocation extends StatefulWidget {
  const ChangeLocation({super.key});

  @override
  _ChangeLocationState createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  final List<WorldTimeData> locations = [
    WorldTimeData(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTimeData(
        url: 'Europe/Berlin', location: 'Berlin', flag: 'germany.png'),
    WorldTimeData(url: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
    WorldTimeData(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTimeData(
        url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTimeData(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTimeData(
        url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTimeData(
        url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTimeData(
        url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTimeData(
        url: 'Asia/Manila', location: 'Manila', flag: 'philippines.jpg'),
    WorldTimeData(url: 'Asia/Tokyo', location: 'Tokyo', flag: 'japan.png'),
    WorldTimeData(url: 'Asia/Riyadh', location: 'Riyadh', flag: 'saudi.png'),
    WorldTimeData(
        url: 'Asia/Vladivostok', location: 'Vladivostok', flag: 'russia.jpg'),
    WorldTimeData(url: 'Asia/Yakutsk', location: 'Yakutsk', flag: 'russia.jpg'),
    WorldTimeData(
        url: 'Asia/Yekaterinburg',
        location: 'Yekaterinburg',
        flag: 'russia.jpg'),
    WorldTimeData(url: 'Europe/Rome', location: 'Rome', flag: 'italy.png'),
  ];

  @override
  Widget build(BuildContext context) {
    print('Build function run');
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Change Location',
          style: GoogleFonts.zenDots(
            color: Colors.amber,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: ChangeLocationContent(locations: locations),
    );
  }
}
