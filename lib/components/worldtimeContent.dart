// ignore_for_file: file_names, prefer_const_constructors, prefer_const_constructors_in_immutables, camel_case_types, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, must_be_immutable, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/localAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorldTimeContent extends StatefulWidget {
  late Map<dynamic, dynamic>? data;
  late String bgImage;
  late Color textColor;

  WorldTimeContent({
    super.key,
    this.data,
    required this.bgImage,
    required this.textColor,
  });

  @override
  State<WorldTimeContent> createState() => _WorldTimeContentState();
}

class _WorldTimeContentState extends State<WorldTimeContent> {
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

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/${widget.bgImage}'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 140.0, 0, 0),
            child: Column(
              children: <Widget>[
                Center(
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: SpinKitPouringHourGlass(
                              color: Colors.amber,
                              size: 80.0,
                            ),
                          );
                        },
                      );
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.pop(context); // Close the dialog
                        Navigator.pushNamed(context, '/profile');
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: user != null
                                  ? (photoUrl.startsWith('http') ||
                                          photoUrl.startsWith('https'))
                                      ? NetworkImage(photoUrl)
                                      : AssetImage(photoUrl)
                                          as ImageProvider<Object>?
                                  : AssetImage(photoUrl),
                              radius: 20.0,
                            ),
                            SizedBox(
                              width: 8.0,
                            ), // Adjust the spacing between CircleAvatar and Text
                            Text(
                              name,
                              style: GoogleFonts.zenDots(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        TextButton.icon(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Center(
                                  child: SpinKitPouringHourGlass(
                                    color: Colors.amber,
                                    size: 80.0,
                                  ),
                                );
                              },
                            );
                            Future.delayed(Duration(seconds: 1), () async {
                              Navigator.pop(context); // Close the dialog
                              dynamic result = await Navigator.pushNamed(
                                  context, '/changelocation');
                              setState(() {
                                widget.data = {
                                  'time': result['time'],
                                  'location': result['location'],
                                  'flag': result['flag'],
                                  'isDayTime': result['isDayTime'],
                                };
                              });
                            });
                          },
                          icon:
                              Icon(Icons.location_pin, color: widget.textColor),
                          label: Text('Change Location',
                              style: GoogleFonts.zenDots(
                                color: widget.textColor,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.data != null ? widget.data!['location'] ?? '' : '',
                      style: GoogleFonts.abrilFatface(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: widget.textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.data?['time'] ?? '',
                      style: GoogleFonts.kdamThmorPro(
                        fontSize: 66.0,
                        color: widget.textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
