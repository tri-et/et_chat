import 'package:flutter/material.dart';

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
                  showFullImageVer1(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a picture'),
                onTap: () {
                  Navigator.pop(context);
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

  showFullImageVer1(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Container(
              child: Center(
                child: Image.asset("assets/avatar.jpg"),
              ),
            ),
          );
        });
  }
}
