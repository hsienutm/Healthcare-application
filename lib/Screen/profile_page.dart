import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paragonhealth/Screen/edit_profile.dart';
import 'package:paragonhealth/Screen/home.dart';
import 'package:paragonhealth/user.dart';
import 'package:paragonhealth/Component/profile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: ListView(
        //padding: const EdgeInsets.all(50.0),
        physics: const BouncingScrollPhysics(),
        children: [
          const ClipOval(
            child: Material(
              color: Colors.transparent,
            ),
          ),
          SizedBox(
            height: 50,
            child: Text(
              "$registeredEmail",
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 100),
          ListTile(
            tileColor: Colors.lightBlue[100],
            title: const Text('Change Password'),
            trailing: const Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () async {
              //Navigator.push(context,MaterialPageRoute(builder: (context) => const AppointmentPage(),
            },
          ),
        ],
      ),
    );
  }
}
