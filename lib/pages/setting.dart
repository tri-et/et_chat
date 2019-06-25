import 'dart:collection';

import 'package:et_chat/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/avatarModal.dart';
import '../theme.dart';

class SettingPage extends StatefulWidget {
  final String uid;
  SettingPage({this.uid});
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String img = "";
  String imgCurrentUser = "";
  String userName = "";
  AvatarModal modal = AvatarModal();

  String uidCurrentUser = "";
  _readUid() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString("currentUid");
    setState(() {
      uidCurrentUser = uid;
    });
  }
void _getCurrentUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userInfo =
        await Firestore.instance.collection("Users").document(user.uid).get();
    setState(() {
      imgCurrentUser = userInfo.data["img"];
      userName = userInfo.data["userName"];
    });
  }
  @override
  void initState() {
    super.initState();
    _readUid();
    _getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 130),
          child: Column(
            children: <Widget>[
              SizedBox(height: 80),
              FlatButton(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imgCurrentUser) ,
                  radius: 50,
                ),
                onPressed: () => modal.showCaptureModal(context)
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(userName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Container(
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
        ));
  }
}
