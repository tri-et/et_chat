import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:et_chat/theme.dart';
import 'package:flutter/material.dart';
import '../pages/chat.dart';

class ChatHistoryItem extends StatelessWidget {
  final DocumentSnapshot itemHistory;
  ChatHistoryItem(this.itemHistory);
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  builder: (BuildContext context) => Chat("sdsdsds")));
        },
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: itemHistory.data["img"] == null
                  ? ExactAssetImage("assets/avatar.jpg")
                  : NetworkImage(itemHistory.data["img"]),
              minRadius: 30,
              maxRadius: 30,
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    itemHistory.data["name"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(itemHistory.data["message"],
                      style: TextStyle(
                          color: Colors.black38, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            Text(
              "Just Now",
              style: TextStyle(color: Colors.black38),
            )
          ],
        ),
      ),
    );
  }
}
