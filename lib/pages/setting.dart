import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String uidCurrentUser = "";
  _readUid() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString("currentUid");
    setState(() {
      uidCurrentUser = uid;
    });
  }

  @override
  void initState() {
    super.initState();
    _readUid();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: RaisedButton(
            child: Text("Sign Out"),
            onPressed: () {
              Map<String, String> userInfo = new HashMap();
              userInfo["status"] = "offline";
              Firestore.instance
                  .collection("Users")
                  .document(uidCurrentUser)
                  .updateData(userInfo);
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
        ),
      ],
    );
  }
}
