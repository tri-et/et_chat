import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/contactItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  FirebaseUser currentUser;
  final searchController = TextEditingController();
  TextEditingController controller = new TextEditingController();
  String filter="";
  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    super.initState();
    _getCurrentUser();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: secondary,
          elevation: 0.0,
          title: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(00.0, 8.0, 00.0, 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(255, 255, 255, .45),
                      hintText: "Type a text",
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.clear();
                          },
                          icon:
                              Icon(filter == "" ? Icons.search : Icons.close)),
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    controller: controller,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.person_add),
                iconSize: 32.0,
                onPressed: () {},
              )
            ],
          ),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection("Users").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (filter == "") {
                      return _buildListItem(
                          context, snapshot.data.documents[index]);
                    } else if (snapshot.data.documents[index].data["userName"]
                        .contains(filter.toLowerCase())) {
                      return _buildListItem(
                          context, snapshot.data.documents[index]);
                    } else {
                      return new Container();
                    }
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot user) {
    return ContactItem(user);
  }

  _getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      currentUser = user;
    });
  }
}
