import 'package:et_chat/widgets/chatHistoryItem.dart';
import 'package:flutter/material.dart';

class ChatHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ChatHistoryItem(),
        ChatHistoryItem(),
        ChatHistoryItem(),
        ChatHistoryItem(),
        ChatHistoryItem(),
        ChatHistoryItem(),
        ChatHistoryItem(),
        ChatHistoryItem(),
        ChatHistoryItem()
      ],
    );
  }
}
