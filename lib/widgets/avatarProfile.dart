import 'package:flutter/material.dart';

class AvatarProfile extends StatelessWidget {
  final String imgUrl;
  AvatarProfile(this.imgUrl);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          Positioned(
            left: 10.0,
            top: MediaQuery.of(context).padding.top + 10.0,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Center(
            child: Image.network(imgUrl),
          ),
        ],
      ),
    );
  }
}
