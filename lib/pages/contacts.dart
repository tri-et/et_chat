import 'package:flutter/material.dart';
import '../widgets/contactItem.dart';
import 'package:firebase_database/firebase_database.dart';

class ContactsPage extends StatelessWidget {
  Widget _buildListItem(BuildContext context, dynamic user) {
    return ContactItem(user);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance.reference().child("Users").onValue,
      builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
        if (snapshot.hasData) {
          Map map = snapshot.data.snapshot.value;
          return ListView.builder(
              itemCount: map.values.toList().length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildListItem(context, map.values.toList()[index]));
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
