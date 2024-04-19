import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

import '../../helper/text_helper.dart';
import '../controller/MenuAppController.dart';
import '../dashboard/components/header.dart';
import 'components/annoucement_form.dart';


class AddAnnoucementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider =   Provider.of<MenuAppController>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(height: defaultDrawerHeadHeight + 20),
            TextHelper().mNormalText(text: "Annoucements",color: Colors.white,size: 18.0),
            const SizedBox(height: defaultDrawerHeadHeight-10),
            TextHelper().mNormalText(text: "Create new Annoucement",color: Colors.white70,size: 14.0),
            const SizedBox(height: defaultDrawerHeadHeight + 20),
            AnnoucementForm(
              edit: provider.parameters?['edit'] ?? 'false',
              code: provider.parameters?[Constant.KEY_ANNOUCEMENT_ID] ?? "no code",
              name: provider.parameters?[Constant.KEY_ANNOUCEMENT_TITLE] ?? 'Enter Title',
              desc: provider.parameters?[Constant.KEY_ANNOUCEMENT_DESC] ?? 'Enter Description',
            )
          ],
        ),
      ),
      )
    );
  }
}
