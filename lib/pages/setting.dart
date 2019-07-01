import 'dart:collection';

import 'package:et_chat/widgets/avatarMenu.dart';
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
  DocumentSnapshot _userInfo;
  AvatarModal avatarMenu;

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
            SizedBox(height: 50,),
            Center(
              child: GestureDetector(
                onTap: () {
                  avatarMenu = new AvatarModal(_userInfo);
                  showAvatarMenu();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_userInfo.data["img"]),
                  maxRadius: 60.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(_userInfo.data["userName"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic),),
            ),
            RaisedButton(
              onPressed: () {
                Map<String, String> userInfo = new HashMap();
                userInfo["status"] = "offline";
                Firestore.instance
                    .collection("Users")
                    .document(_userInfo.documentID)
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
          ],
        ),
      );
    }else {
      return Center(child: Container());
    }
  }

  Future _getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("currentUid");
    DocumentSnapshot userInfo =
        await Firestore.instance.collection("Users").document(uid).get();
    setState(() {
      _userInfo = userInfo;
    });
  }
  dynamic showAvatarMenu(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return avatarMenu;
      }
    );
  }
}
