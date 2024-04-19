import 'package:drago_admin/deposit/components/deposit_list.dart';
import 'package:drago_admin/route/routes.dart';
import 'package:drago_admin/user/components/user_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../controller/MenuAppController.dart';
import '../dashboard/components/header.dart';
import '../helper/custom_shadow_button.dart';
import '../helper/text_helper.dart';
import 'components/annoucement_list.dart';

class AnnoucememtScreen extends StatelessWidget {
  const AnnoucememtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider  =  Provider.of<MenuAppController>(context, listen: false);
    return SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: defaultDrawerHeadHeight + 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextHelper().mNormalText(text: "Items Annoucement list",color: Colors.white,
                      size: 18.0),
                  CustomNeumorphicButton(
                    width: 200.0,
                    height: 50,
                    isIcon: false,
                    label: 'Add New',
                    press: (){
                      provider.parameters?.clear();
                      provider.changeScreen(Routes.ADD_ANNOUNCEMENT);
                    },),
                  // ButtonWidget(text: "Add New", width: 120, height: 50,backgroundColor: hoverColor,icons: true,
                  //     onClicked: (){
                  //       Provider.of<MenuAppController>(context, listen: false)
                  //           .changeScreen(Routes.ADD_CATEGORY_ROUTE);
                  //     }
                  // )
                ],
              ),
              const SizedBox(height: defaultDrawerHeadHeight + 20),
              AnnoucementList()

            ],
          ),
        )
    );
  }
}
