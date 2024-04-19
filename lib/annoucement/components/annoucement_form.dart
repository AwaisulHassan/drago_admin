import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../helper/custom_shadow_button.dart';
import '../../../helper/custom_textfield.dart';
import '../../../helper/text_helper.dart';
import '../../../provider/count_value_provider.dart';
import '../../../route/routes.dart';
import '../../controller/MenuAppController.dart';
import '../../helper/button_widget.dart';

class AnnoucementForm extends StatefulWidget {
  final String code, name, desc;
  final String edit;

  AnnoucementForm({
    super.key,
    required this.edit,
    required this.code,
    required this.name,
    required this.desc,
  });

  @override
  State<AnnoucementForm> createState() => _AnnoucementFormState();
}

class _AnnoucementFormState extends State<AnnoucementForm> {
  var categoryNameController = TextEditingController();

  var categoryDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final countProvider =
        Provider.of<CountValueProvider>(context, listen: false);
    return Container(
        width: size.width,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(
              height: 15,
            ),
            TextHelper().mNormalText(
                text: "Annoucement Title", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15,
            ),
            Container(
                width: size.width / 1.9,
                child: CustomTextField(
                  controller: categoryNameController,
                  hintText: widget.edit == 'true'
                      ? categoryNameController.text = widget.name
                      : widget.name,
                )),
            const SizedBox(
              height: 20,
            ),
            TextHelper().mNormalText(
                text: "Annoucement Description", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15,
            ),
            Container(
                width:  size.width / 1.9,
                child: CustomTextField(
                  controller: categoryDescriptionController,
                  hintText: widget.edit == 'true'
                      ? categoryDescriptionController.text = widget.desc
                      : widget.desc,
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width,
              child: Row(
                children: [
                  widget.edit == 'true'
                      ? Container(
                          width: 100,
                          child: ButtonWidget(
                            text: "Update",
                            onClicked: () {
                              if (categoryNameController.text.isNotEmpty &&
                                  categoryDescriptionController
                                      .text.isNotEmpty) {
                                countProvider.updateAnnoucement(
                                  code: widget.code,
                                  name: categoryNameController.text.toString(),
                                  description: categoryDescriptionController
                                      .text
                                      .toString(),
                                );
                                Get.snackbar("Category Updated...", "",
                                    backgroundColor: hoverColor,
                                    colorText: Colors.white);
                              } else {
                                Get.snackbar(
                                    "Alert!!!", "Please filled missing fields",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              }
                            },
                            icons: false,
                            width: 50.0,
                            height: 50.0,
                          ),
                        )
                      : Container(
                          width: 100,
                          child: ButtonWidget(
                            text: "Save",
                            onClicked: () {
                              if (categoryNameController.text.isNotEmpty &&
                                  categoryDescriptionController
                                      .text.isNotEmpty) {
                                countProvider.uploadAnnoucement(
                                    name:
                                        categoryNameController.text.toString(),
                                    description: categoryDescriptionController
                                        .text
                                        .toString());
                                categoryNameController.text = "";
                                categoryDescriptionController.text = "";
                                Get.snackbar("New Annoucement Added", "",
                                    backgroundColor: hoverColor,
                                    colorText: Colors.white);
                              } else {
                                Get.snackbar(
                                    "Alert!!!", "Please filled missing fields",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              }
                            },
                            icons: false,
                            width: 100.0,
                            height: 50.0,
                          ),
                        ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 100,
                    child: ButtonWidget(
                      text: "Cancel",
                      onClicked: () {
                        Provider.of<MenuAppController>(context, listen: false)
                            .changeScreen(Routes.ANNOUNCEMENT);
                      },
                      icons: false,
                      width: 50.0,
                      height: 50.0,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
