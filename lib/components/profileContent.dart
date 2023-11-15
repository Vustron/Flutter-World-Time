// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unused_import, unused_local_variable, unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/authController.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileContent extends StatefulWidget {
  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  final AuthController _auth = AuthController();

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    // Default values if user is null
    String name = 'Default Name';
    String email = 'default@email.com';
    String photoUrl = 'assets/images/vustron.png';

    if (user != null) {
      // Update values if user is not null
      name = user.displayName ?? name;
      email = user.email ?? email;
      photoUrl = user.photoURL ?? photoUrl;
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 120.0, 40.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Column(
              children: [
                Text(
                  'User Profile',
                  style: GoogleFonts.zenDots(
                    color: Colors.amberAccent,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                CircleAvatar(
                  backgroundImage: user != null
                      ? (photoUrl.startsWith('http') ||
                              photoUrl.startsWith('https'))
                          ? NetworkImage(photoUrl)
                          : AssetImage(photoUrl) as ImageProvider<Object>?
                      : AssetImage(photoUrl),
                  radius: 50.0,
                ),
              ],
            ),
          ),
          Divider(
            height: 40.0,
            color: Colors.grey,
          ),
          Text(
            'Name',
            style: GoogleFonts.zenDots(
              color: Colors.grey,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 30.0),
          Row(
            children: <Widget>[
              Icon(
                Icons.supervised_user_circle,
                color: Colors.grey,
              ),
              SizedBox(width: 10.0),
              Text(
                name,
                style: GoogleFonts.zenDots(
                  color: Colors.amberAccent,
                  letterSpacing: 1.0,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Text(
            'Email',
            style: GoogleFonts.zenDots(
              color: Colors.grey,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 30.0),
          Row(
            children: <Widget>[
              Icon(
                Icons.email,
                color: Colors.grey,
              ),
              SizedBox(width: 10.0),
              Text(
                email,
                style: GoogleFonts.zenDots(
                  color: Colors.amberAccent,
                  letterSpacing: 1.0,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
