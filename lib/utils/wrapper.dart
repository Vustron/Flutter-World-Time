// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, camel_case_types, unused_import, avoid_unnecessary_containers, unused_field, unused_local_variable, avoid_print, empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_world_time_app/views/worldtimeView.dart';
import 'package:provider/provider.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import '../auth/authenticate.dart';
import '../auth/signin.dart';
import 'loader.dart';

class Wrapper extends StatefulWidget {
  final Widget child;

  const Wrapper({super.key, required this.child});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user != null) {
      return widget.child;
    } else {
      return Authenticate();
    }
  }
}
