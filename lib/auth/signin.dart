// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, camel_case_types, unused_import, avoid_unnecessary_containers, sort_child_properties_last, unused_field, unused_local_variable, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controller/localAuth.dart';
import 'package:social_auth_buttons/social_auth_buttons.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../controller/googleAuth.dart';
import '../utils/loader.dart';
import '../utils/wrapper.dart';
import 'signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthController _auth = AuthController();
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.0),
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo.png'),
                    radius: 50.0,
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  'World Time',
                  style: GoogleFonts.zenDots(
                    fontSize: 30.0,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.amber),
                    labelStyle: TextStyle(color: Colors.amber),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                  validator: (val) => val!.isEmpty ? "Enter an email" : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  style: GoogleFonts.zenDots(color: Colors.amber),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.amber),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    labelStyle: TextStyle(color: Colors.amber),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: (val) =>
                      val!.length < 6 ? "Enter a password 6+ chars long" : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  style: GoogleFonts.zenDots(color: Colors.amber),
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState != null &&
                            _formkey.currentState!.validate()) {
                          EasyLoading.show(status: 'Logging in...');
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            print('SignIn error');
                            EasyLoading.showError('SignIn Failed with Error');
                          } else {
                            print('signed in');
                            EasyLoading.showSuccess('SignIn Success!');
                            print(result.uid);
                            await Future.delayed(Duration(seconds: 1));
                            Navigator.pushNamed(context, '/getdata');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        'Sign-In',
                        style: GoogleFonts.zenDots(
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        EasyLoading.show(status: 'Loading...');
                        await Future.delayed(Duration(seconds: 1));
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    SignUp(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(-1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                        EasyLoading.dismiss();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        'Sign-Up',
                        style: GoogleFonts.zenDots(
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.amber,
                ),
                SizedBox(height: 10.0),
                Text(
                  'Or',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GoogleAuthButton(
                      onPressed: () async {
                        try {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          EasyLoading.show(status: 'Loading...');
                          await provider.googleLogin();
                          EasyLoading.showSuccess('SignIn Success!');
                          Navigator.pushNamed(context, '/getdata');
                        } catch (error) {
                          print('Error during Google login: $error');
                          EasyLoading.showError('Something went wrong');
                        } finally {
                          EasyLoading.dismiss();
                        }
                      },
                      style: AuthButtonStyle.icon,
                    ),
                    Text(
                      'Sign in using Google    ',
                      style: GoogleFonts.zenDots(
                        color: Colors.amberAccent,
                        letterSpacing: 1.0,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80.0),
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
      ),
    );
  }
}
