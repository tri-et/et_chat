import 'dart:collection';

import 'package:et_chat/widgets/avatarMenu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  DocumentSnapshot _userInfo;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_userInfo != null) {
      return Container(
        padding: EdgeInsets.only(top: 10.0),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return AvatarMenu(
                          userInfo: _userInfo,
                        );
                      });
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_userInfo.data["img"]),
                  maxRadius: 60.0,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.keyboard),
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('QR Code'),
              onTap: () {
                print('1235656');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Sign Out'),
              onTap: () {
                Map<String, String> userInfo = new HashMap();
                userInfo["status"] = "offline";
                Firestore.instance
                    .collection("Users")
                    .document(_userInfo.documentID)
                    .updateData(userInfo);
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, "/");
              },
            ),
          ],
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Future _getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uidCurrentUser");
    DocumentSnapshot userInfo =
        await Firestore.instance.collection("Users").document(uid).get();
    setState(() {
      _userInfo = userInfo;
    });
  }
}
