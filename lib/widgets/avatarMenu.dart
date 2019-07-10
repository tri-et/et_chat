import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'avatarProfile.dart';

class AvatarMenu extends StatelessWidget {
  final DocumentSnapshot userInfo;

  AvatarMenu({this.userInfo});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('View Profile Picture'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AvatarProfile(userInfo.data['img'])));
          },
        ),
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Take a picture'),
          onTap: () async {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.photo),
          title: Text('Select a picture'),
          onTap: () async {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
