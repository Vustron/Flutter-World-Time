// ignore_for_file: file_names, prefer_const_constructors, prefer_const_constructors_in_immutables, camel_case_types, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, must_be_immutable, unused_field, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controller/googleAuth.dart';
import '../controller/localAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/changeLocation.dart';
import 'editProfileContent.dart';

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
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 150.0, 0, 0),
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
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.supervised_user_circle,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    name,
                    style: GoogleFonts.zenDots(
                      color: Colors.amberAccent,
                      letterSpacing: 1.0,
                      fontSize: 12.0,
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
              SizedBox(height: 10.0),
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
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Consumer<GoogleSignInProvider>(
                  builder: (context, provider, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          width: 100,
                          child: ElevatedButton.icon(
                            onPressed: () => _showEditProfilePanel(),
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Edit',
                              style: GoogleFonts.zenDots(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.green,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 121,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                EasyLoading.show(status: 'Logging out...');
                                await Future.delayed(Duration(seconds: 1));
                                await _auth.signOut();
                                final provider =
                                    Provider.of<GoogleSignInProvider>(context,
                                        listen: false);
                                provider.googleLogout();
                                EasyLoading.showSuccess('Logout Success!');
                              } catch (e) {
                                EasyLoading.showError('Logout Failed: $e');
                              }
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Logout',
                              style: GoogleFonts.zenDots(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 126),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => {},
                    child: Text(
                      'Ver.2.3.2 \u00A9 Made by Vustron Vustronus 2023',
                      style: GoogleFonts.zenDots(
                        fontSize: 7.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
                Builder(
                  builder: (context) => InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
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
                            ),
                            Text(
                              name,
                              style: GoogleFonts.zenDots(
                                color: widget.textColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                            size: 100.0,
                          ),
                        );
                      },
                    );
                    Future.delayed(Duration(seconds: 1), () async {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      dynamic result = await Navigator.pushReplacementNamed(
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
                  icon: Icon(Icons.location_pin, color: widget.textColor),
                  label: Text('Change Location',
                      style: GoogleFonts.zenDots(
                        color: widget.textColor,
                      )),
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
