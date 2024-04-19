
import 'package:drago_admin/annoucement/add_annoucement_screen.dart';
import 'package:drago_admin/annoucement/annoucement_screen.dart';
import 'package:drago_admin/chat/chat_screen.dart';
import 'package:drago_admin/deposit/deposit_screen.dart';
import 'package:drago_admin/transfer/transfer_screen.dart';
import 'package:drago_admin/user/components/user_login_history_list.dart';
import 'package:drago_admin/user/user_screen.dart';
import 'package:drago_admin/withdraw/withdraw_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../chat/components/chat_details.dart';
import '../controller/MenuAppController.dart';
import '../dashboard/dashboard_screen.dart';
import '../responsive.dart';
import '../route/routes.dart';
import 'components/side_menu.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuAppController = Provider.of<MenuAppController>(context);
    Widget screen;
    switch(menuAppController.selectedIndex){
      case Routes.DASHBOARD_ROUTE:
        screen = DashboardScreen();
        break;

      case Routes.USER:
        screen = const UserScreen();
        break;

      case Routes.DEPOSIT:
        screen = const DepositScreen();
        break;
      case Routes.WITHDRAW:
        screen = const WithdrawScreen();
        break;

      case Routes.USER_LOGIN_HISTORY_SCREEN:
        screen =  UserLoginHistoryList();
        break;

        case Routes.CHAT:
        screen =  ChatScreen();
        break;

        case Routes.CHAT_DETAILS:
        screen =  ChatDetails();
        break;

        case Routes.TRANSFER:
        screen =  TransferScreen();
        break;

        case Routes.ANNOUNCEMENT:
        screen =  AnnoucememtScreen();
        break;

        case Routes.ADD_ANNOUNCEMENT:
        screen =  AddAnnoucementScreen();
        break;

      default:
        screen = DashboardScreen();
        break;
    }
    return Scaffold(
      extendBody: true,
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                flex: 2,
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 8,
              child: screen,
            ),
          ],
        ),
      ),
    );
  }
}
