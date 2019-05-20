import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String uidCurrentUser = "";
  DataSnapshot currentUser;
  _readUid() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString("currentUid");
    setState(() {
      uidCurrentUser = uid;
      FirebaseDatabase.instance
          .reference()
          .child("Users")
          .child(uid)
          .once()
          .then((user) {
        setState(() {
          currentUser = user;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _readUid();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: RaisedButton(
        child: Text("Sign Out"),
        onPressed: () {
          Map<dynamic, dynamic> user = currentUser.value;
          user["status"] = "offline";
          DatabaseReference reference = FirebaseDatabase.instance
              .reference()
              .child("Users")
              .child(uidCurrentUser);
          reference.set(user);
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, "/");
        },
      ),
    );
  }
}
