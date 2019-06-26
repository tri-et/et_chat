import 'package:et_chat/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class AvatarModal {
  showImageSelection(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('View profile picture'),
                onTap: () {
                 Navigator.pushNamed(context, "/profile");
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a picture'),
                onTap: () {
                  Navigator.pop(context,Profile());
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Select a picture'),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
