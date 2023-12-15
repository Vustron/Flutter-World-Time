// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, camel_case_types, unused_import, avoid_unnecessary_containers, sort_child_properties_last, unused_field, unused_local_variable, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../controller/localAuth.dart';
import 'package:social_auth_buttons/social_auth_buttons.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../controller/googleAuth.dart';
import '../../utils/loader.dart';
import '../../utils/wrapper.dart';
import '../main.dart';
import 'auth/signin.dart';
import 'worldtime.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () async {
      // Exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Color.fromRGBO(0, 0, 0, 1),
      ));
      if (AuthController.auth.currentUser != null) {
        print('\nUser: ${AuthController.auth.currentUser}');

        Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.size,
              alignment: Alignment.bottomCenter,
              child: Loading(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.size,
              alignment: Alignment.bottomCenter,
              child: SignIn(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // init media query
    mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 200.0, horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40.0),
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.png'),
                radius: 50.0,
              ),
            ),
            SizedBox(height: 30.0),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'World Time',
                  textStyle: GoogleFonts.zenDots(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: [
                    Colors.amber,
                    Color.fromARGB(255, 255, 255, 255),
                  ],
                ),
              ],
            ),
            AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  'Made by Vustron Vustronus',
                  textStyle: const TextStyle(
                    color: Colors.amber,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                  speed: const Duration(milliseconds: 70),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const SpinKitThreeBounce(
              color: Colors.amber,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
