import 'package:drago_admin/chat/components/chat_list.dart';
import 'package:drago_admin/user/components/user_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../dashboard/components/header.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
             Header(title: 'User Chat',),
            SizedBox(height: defaultDrawerHeadHeight + 20),
            ChatList()
          ],
        ),
      ),
    );
  }
}
