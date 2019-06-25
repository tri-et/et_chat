import 'package:flutter/material.dart';

class AvatarModal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.account_circle),
                    SizedBox(
                      width: 20,
                    ),
                    Text("View Profile Picture")
                  ],
                ),
              ),
              FlatButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.camera_alt),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Select Profile Picture")
                  ],
                ),
              ),
            ],
          );
        });
  }
}
