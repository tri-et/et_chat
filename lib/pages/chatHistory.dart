import 'package:et_chat/widgets/chatHistoryItem.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatHistoryPage extends StatefulWidget {
  @override
  _ChatHistoryPageState createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> {
  String uidUser;
  Widget _buildListItem(BuildContext context, DocumentSnapshot user) {
    return ChatHistoryItem(user);
  }

  _readCurrentUid() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString("currentUid");
    setState(() {
      this.uidUser = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _readCurrentUid();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("Histories")
          .document(uidUser)
          .collection("Histories")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildListItem(context, snapshot.data.documents[index]));
        } else {
          return Center(
              child: Text(
            'Loading...',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ));
        }
      },
    );
  }
}
