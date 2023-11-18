// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, camel_case_types, avoid_print, unused_import, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_local_variable, file_names, unused_field, depend_on_referenced_packages, sort_child_properties_last, unused_element
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/localAuth.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _auth = AuthController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _currentDisplayName = '';
  String _currentEmail = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      children: <Widget>[
        Center(
          child: Text(
            'Update User Profile',
            style: GoogleFonts.zenDots(
              fontSize: 14.0,
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                style: TextStyle(color: Colors.amber),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: GoogleFonts.zenDots(color: Colors.amber),
                  prefixIcon: Icon(Icons.person,
                      color: Colors.grey), // Change icon color to grey
                ),
                validator: (val) => val!.isEmpty ? "Enter a name" : null,
                onChanged: (val) {
                  setState(() => _currentDisplayName = val);
                },
              ),
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: Colors.amber),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: GoogleFonts.zenDots(color: Colors.amber),
                  prefixIcon: Icon(Icons.email,
                      color: Colors.grey), // Change icon color to grey
                ),
                validator: (val) => val!.isEmpty ? "Enter an email" : null,
                onChanged: (val) {
                  setState(() => _currentEmail = val);
                },
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    EasyLoading.show(status: 'Updating user profile...');

                    await _auth.updateUserData(
                        _currentDisplayName, _currentEmail);

                    EasyLoading.showSuccess('Update Success!');
                    Navigator.pushNamed(context, '/profile');
                    EasyLoading.dismiss();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Update',
                  style: GoogleFonts.zenDots(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
