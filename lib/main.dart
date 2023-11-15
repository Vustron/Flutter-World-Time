// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, camel_case_types, unused_import, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/signup.dart';
import 'controller/localAuth.dart';
import 'auth/signin.dart';
import 'controller/googleAuth.dart';
import 'utils/wrapper.dart';
import 'views/profileView.dart';
import 'views/worldtimeView.dart';
import 'views/changeLocationView.dart';
import 'utils/loader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'utils/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          StreamProvider<User?>.value(
            value: AuthController().user,
            initialData: null,
          ),
          ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ],
        child: MaterialApp(
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          initialRoute: '/signin',
          routes: {
            '/': (context) => Wrapper(
                  child: WorldTime(),
                ),
            '/getdata': (context) => Wrapper(
                  child: Loading(),
                ),
            '/signin': (context) => SignIn(),
            '/signup': (context) => SignUp(),
            '/profile': (context) => Wrapper(
                  child: Profile(),
                ),
            '/changelocation': (context) => Wrapper(
                  child: ChangeLocation(),
                ),
          },
        ),
      );
}
