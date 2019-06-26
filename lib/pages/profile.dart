import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: Column(
          children: <Widget>[
            Center(
              child: GestureDetector(
                child: CircleAvatar(
                  backgroundImage: ExactAssetImage("assets/avatar.jpg"),
                  maxRadius: 60.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
