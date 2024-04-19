import 'package:drago_admin/deposit/components/deposit_list.dart';
import 'package:drago_admin/user/components/user_list.dart';
import 'package:drago_admin/withdraw/components/withdraw_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../dashboard/components/header.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultDrawerHeadHeight + 20),
            WithdrawList()
          ],
        ),
      ),
    );
  }
}
