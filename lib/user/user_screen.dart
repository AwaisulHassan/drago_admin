import 'package:drago_admin/user/components/user_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../dashboard/components/header.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
             Header(title: 'Users',),
            SizedBox(height: defaultDrawerHeadHeight + 20),
            UserList()
          ],
        ),
      ),
    );
  }
}
