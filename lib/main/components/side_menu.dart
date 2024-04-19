
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


import '../../constants.dart';
import '../../helper/drawer_list_tile.dart';
import '../../helper/text_helper.dart';
import '../../route/routes.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: drawerBackground,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const DrawerHeader(
               // child: Image.asset("assets/images/logo.png"),
                child: Center(child: Text("Drago Trade",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
              ),

            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TextHelper().mNormalText(text: "Main",color: Colors.blue,size: 14.0),
            ),
            const DrawerListTile(
          index: 0,
          screenIndex: Routes.DASHBOARD_ROUTE,
          title: "Dashboard",
          svgSrc: DASHBOARD_SVG,
          // press: () {
          //
          // },
        ),

            const Divider(thickness: 0.5,),
            const SizedBox(height: defaultDrawerHeadHeight-5,),
            const DrawerListTile(
              index: 1,
              screenIndex: Routes.USER,
              title: "Users",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            //Purchase LIST
            const Divider(thickness: 0.5,),
            const SizedBox(height: defaultDrawerHeadHeight-5,),
            const DrawerListTile(
              index: 2,
              screenIndex: Routes.DEPOSIT,
              title: "Deposit",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            //Sale LIST
            const Divider(thickness: 0.5,),
            const SizedBox(height: defaultDrawerHeadHeight-5,),
            const DrawerListTile(
              index: 3,
              screenIndex: Routes.WITHDRAW,
              title: "Withdraw",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),


            //Reports LIST
           const Divider(thickness: 0.5,),
           const SizedBox(height: defaultDrawerHeadHeight-5,),
           const DrawerListTile(
              index: 4,
              screenIndex: Routes.TRANSFER,
              title: "Transfer",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const Divider(thickness: 0.5,),
            const SizedBox(height: defaultDrawerHeadHeight-5,),
            const DrawerListTile(
              index: 5,
              screenIndex: Routes.CHAT,
              title: "Chat",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const Divider(thickness: 0.5,),
            const SizedBox(height: defaultDrawerHeadHeight-5,),
            const DrawerListTile(
              index: 6,
              screenIndex: Routes.ANNOUNCEMENT,
              title: "Announcements",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

          ],
        ),
      ),
      // child: ListView(
      //   children: [
      //     DrawerHeader(
      //      // child: Image.asset("assets/images/logo.png"),
      //       child: Center(child: Text("Waqas Hassan P.O.S")),
      //     ),
      //     DrawerListTile(
      //       title: "Dashboard",
      //       svgSrc: "assets/icons/menu_dashboard.svg",
      //       press: () {
      //         Provider.of<MenuAppController>(context, listen: false)
      //             .changeScreen(0);
      //         if(Responsive.isMobile(context)){
      //           Navigator.pop(context);
      //         }
      //       },
      //     ),
      //     DrawerListTile(
      //       title: "Transaction",
      //       svgSrc: "assets/icons/menu_tran.svg",
      //       press: () {
      //         Provider.of<MenuAppController>(context, listen: false)
      //             .changeScreen(1);
      //         if(Responsive.isMobile(context)){
      //           Navigator.pop(context);
      //         }
      //       },
      //     ),
      //     DrawerListTile(
      //       title: "Task",
      //       svgSrc: "assets/icons/menu_task.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Documents",
      //       svgSrc: "assets/icons/menu_doc.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Store",
      //       svgSrc: "assets/icons/menu_store.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Notification",
      //       svgSrc: "assets/icons/menu_notification.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Profile",
      //       svgSrc: "assets/icons/menu_profile.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Settings",
      //       svgSrc: "assets/icons/menu_setting.svg",
      //       press: () {},
      //     ),
      //   ],
      // ),
    );
  }
}


