// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, camel_case_types, unused_import, avoid_unnecessary_containers, unused_field, unused_local_variable, avoid_print, empty_catches, file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/user.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromFirebaseUser(UserCredential userCredential) {
    return userCredential.user;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map((User? user) => user);
  }

  //Sign in anonymously
  Future<User?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = _userFromFirebaseUser(result);
      return user;
    } catch (e) {
      print('Error signing in anonymously: $e');
      return null;
    }
  }

  //Sign in email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register new account
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Update user data
  Future<User?> updateUserData(String displayName, String email) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await user.updateDisplayName(displayName);
        await user.updateEmail(email);
        await user.reload();
        user = _auth.currentUser;

        return user;
      } else {
        print('User is null');
        return null;
      }
    } catch (e) {
      print('Error updating user data: $e');
      return null;
    }
  }

  //Signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
