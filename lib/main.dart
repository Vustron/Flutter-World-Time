// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, camel_case_types, unused_import, unused_element

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/auth/signup.dart';
import 'controller/localAuth.dart';
import 'screens/auth/signin.dart';
import 'controller/googleAuth.dart';
import 'screens/splashscreen.dart';
import 'utils/wrapper.dart';
import 'screens/worldtime.dart';
import 'screens/changeLocation.dart';
import 'utils/loader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'utils/firebase_options.dart';

//global object for accessing device screen size
late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Enter full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // for setting orientations to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const App());
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          // local user
          StreamProvider<User?>.value(
            value: AuthController().user,
            initialData: null,
          ),
          // google user
          ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ],
        child: MaterialApp(
          themeMode: ThemeMode.system,
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      );
}
