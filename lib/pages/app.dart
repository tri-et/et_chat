import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'contacts.dart';
import 'chatHistory.dart';
import 'setting.dart';
import '../theme.dart';

class ETPage extends StatefulWidget {
  @override
  _ETPageState createState() => _ETPageState();
}

class _ETPageState extends State<ETPage> {
  int _selectedPage = 0;
  bool isShowAppBar = true;
  final _pageOptions = [
    ContactsPage(),
    ChatHistoryPage(),
    SettingPage(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: secondary,
        currentIndex: _selectedPage,
        fixedColor: Colors.white,
        iconSize: 35,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
            if (index == 2)
              isShowAppBar = false;
            else
              isShowAppBar = true;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
  
}
