// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, camel_case_types, avoid_print, unused_import, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_local_variable, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_world_time_app/components/editProfileContent.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/profileContent.dart';
import '../controller/localAuth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../controller/googleAuth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    print('InitState function run');
  }

  @override
  Widget build(BuildContext context) {
    void _showEditProfilePanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              color: Colors.grey[900],
              child: EditProfile(),
            ),
          );
        },
      );
    }

    final AuthController _auth = AuthController();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Center(
            child: ProfileContent(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/getdata');
                    },
                    icon: Icon(Icons.timer_sharp),
                    label: Text(
                      'Home',
                      style: GoogleFonts.zenDots(fontSize: 8),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton.icon(
                    onPressed: () => _showEditProfilePanel(),
                    icon: Icon(Icons.settings),
                    label: Text(
                      'Edit',
                      style: GoogleFonts.zenDots(fontSize: 8),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.green,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        EasyLoading.show(status: 'Logging out...');
                        await Future.delayed(Duration(seconds: 1));
                        await _auth.signOut();
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogout();
                        EasyLoading.showSuccess('Logout Success!');
                      } catch (e) {
                        EasyLoading.showError('Logout Failed: $e');
                      }
                    },
                    icon: Icon(Icons.logout),
                    label: Text(
                      'Logout',
                      style: GoogleFonts.zenDots(fontSize: 8),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 120.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => {},
                child: Text(
                  '\u00A9 Made by Vustron Vustronus 2023',
                  style: GoogleFonts.zenDots(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
