import 'package:et_chat/theme.dart';
import 'package:flutter/material.dart';
import '../pages/chat.dart';
// import './drawCircle.dart';
import '../widgets/avatar.dart';

class ContactItem extends StatelessWidget {
  final dynamic user;
  ContactItem(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      padding:
          EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
      decoration: new BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: secondary,
            width: 0.5,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Chat(user["id"])));
        },
        child: Row(
          children: <Widget>[
            Avatar(user["img"], user["status"]),
            SizedBox(width: 15.0),
            Expanded(
              child: Text(
                user["userName"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
