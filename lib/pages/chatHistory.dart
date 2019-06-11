import 'package:et_chat/widgets/chatHistoryItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHistoryPage extends StatefulWidget {
  @override
  _ChatHistoryPageState createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> {
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser != null)
      return StreamBuilder(
        stream: Firestore.instance
            .collection("Histories")
            .document(currentUser.uid)
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
    return Center(
      child: Text("Connecting..."),
    );
  }

  _getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      currentUser = user;
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot user) {
    return ChatHistoryItem(user);
  }
}
