import 'package:flutter/material.dart';
import '../widgets/contactItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsPage extends StatelessWidget {
  Widget _buildListItem(BuildContext context, dynamic user) {
    return ContactItem(user);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("Users").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) =>
                _buildListItem(context, snapshot.data.documents[index]),
          );
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
