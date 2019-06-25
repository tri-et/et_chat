import 'dart:collection';
import 'package:et_chat/widgets/avartaModal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AvatarModal modal = new AvatarModal();
  String uidCurrentUser = "";
  String image = "";
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
     _getCurrentUserInfo();
  }
 void _getCurrentUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userInfo =
        await Firestore.instance.collection("Users").document(user.uid).get();
    setState(() {
      image = userInfo.data["img"];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: new EdgeInsets.all(60.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(image),
            ),
            onTap: () => modal.showCaptureModal(context),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: RaisedButton(
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
              padding: EdgeInsets.fromLTRB(25.0, 11.0, 25.0, 11.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.power_settings_new,
                    color: Color.fromRGBO(28, 28, 28, .46),
                    size: 24.0,
                  ),
                  Text(
                    "SIGN OUT",
                    style: TextStyle(
                        color: Color.fromRGBO(245, 238, 238, 1),
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              color: secondary,
            ),
          ),
        ],
      ),
    );
  }
}
