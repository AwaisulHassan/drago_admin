import 'package:drago_admin/dashboard/components/header.dart';
import 'package:drago_admin/helper/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controller/MenuAppController.dart';
import '../../helper/custom_shadow_button.dart';
import '../../helper/text_widget.dart';
import '../../responsive.dart';
import '../../route/routes.dart';

class ChatDetails extends StatelessWidget {

  var controller = TextEditingController();

  bool _isSend = false;
  @override
  Widget build(BuildContext context) {
    final provider =   Provider.of<MenuAppController>(context, listen: false);
    return SafeArea(
      child: Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Expanded(
                flex: 7,
                child: Column(
              children: [
                Header(title: "Customer Support",),
                SizedBox(height: 20,),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: CustomNeumorphicButton(
                    width: Responsive.isMobile(context) ?  150 : 200,
                    height: 50,
                    isIcon: false,
                    label: 'Back',
                    press: (){
                      provider.parameters?.clear();
                      provider.changeScreen(Routes.CHAT);
                    },),
                ),
                SizedBox(height: 20,),
                StreamBuilder(
                  stream: firestore.collection(Constant.COLLECTION_CHATS)
                      .doc(provider.parameters?[Constant.KEY_USERUID].toString() ?? 'false')
                      .collection(Constant.COLLECTION_CHATS)
                      .orderBy(Constant.KEY_TIMESTAMP,descending: false)
                      .snapshots(),
                  builder: (context, snapshot){
                    return (snapshot.connectionState == ConnectionState.waiting) ?
                    const Center(
                      child: CircularProgressIndicator(color: hoverColor,),
                    ) : snapshot.data!.docs.isEmpty ?
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: secondaryColor,
                      ),
                      child: Center(child: Text("No chat  Found",style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 12.0 : 18.0,fontWeight: FontWeight.bold
                      ),)
                        ,),
                    ) :
                    ListView.builder(
                        itemCount:
                        snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data = snapshot
                              .data!.docs[index]
                              .data() as Map<String, dynamic>;
                          // marksLists.add(StudentMarksModel(data['marksDate'], data["marksTime"],data['obtMarks'],data['present']
                          //             ,data['subject'],data['subjectPercentAge'],data['submittedID'],data['submittedName'],data['totalMarks']));
                          return Container(
                              width: Get.width,
                              margin: EdgeInsets.only(left: 10,right: 10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(
                                    Radius.circular(10)),
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.grey,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          data[Constant.KEY_TYPE] == 'user' ?
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(data[Constant.KEY_NOTIFICATION_MESSAGE],style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ) : Text(""),

                                          data[Constant.KEY_TYPE] == 'user' ?
                                          Container(
                                            margin: const EdgeInsets.only(left: 8,bottom: 8,right: 5),
                                            child: Text(Constant().getRelativeTimeWithDetails(int.parse(data[Constant.KEY_TIMESTAMP])),style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ) : Text(""),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Colors.orange
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          data[Constant.KEY_TYPE] == 'admin' ?
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(data[Constant.KEY_NOTIFICATION_MESSAGE],style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ) : Text(""),

                                          data[Constant.KEY_TYPE] == 'admin' ?
                                          Container(
                                            margin: EdgeInsets.only(left: 8,bottom: 8,right: 5),
                                            child: Text(Constant().getRelativeTimeWithDetails(int.parse(data[Constant.KEY_TIMESTAMP])),style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ) : Text(""),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        });
                  },
                ),
              ],
            )),
            
          Expanded(
            flex: 1,
            child: Container(
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: Get.width / 1.5,
                  height: 50,
                  child: CustomTextField(hintText: 'type some thing here....', controller: controller,

                  ),
                ),

                SizedBox(width: 20,),



                InkWell(
                    onTap: (){
                      if(controller.text.toString().isEmpty){
                        Get.snackbar("Alert!!", "Please enter message",backgroundColor: Colors.red,snackPosition: SnackPosition.TOP);
                      }else{
                        _isSend = true;
                         saveChat(
                           userUID: provider.parameters?[Constant.KEY_USERUID].toString(),
                           fullName: provider.parameters?[Constant.KEY_FULLNAME].toString(),
                           username: provider.parameters?[Constant.KEY_USERNAME].toString(),
                           email: provider.parameters?[Constant.KEY_EMAIL].toString(),
                           message: controller.text.toString(),
                         );
                         controller.text = "";
                      }
                    },
                    child:  _isSend ?
                    const CircularProgressIndicator(color: Colors.orange,) :
                    Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.orange,
                        ),
                        child: Center(child: Text("Send"))
                    )
                ),
              ],
            ),
          ),)
          ],
        ),
      ),
    );
  }


  void saveChat({required userUID,required fullName,required email,required username,required message}) {
    DateTime now = DateTime.now();
    int currentTimeMillis = now.millisecondsSinceEpoch;
    print(currentTimeMillis);

    String? date = Constant().formatDate(currentTimeMillis).toString();
    String? time = Constant().formatTime(currentTimeMillis);


    firestore.collection("chats").doc(userUID)
        .set({
      Constant.KEY_EMAIL :email.toString(),
      Constant.KEY_USERNAME : username.toString(),
      Constant.KEY_USERUID : userUID.toString(),
      Constant.KEY_FULLNAME : fullName.toString(),

    }).whenComplete(() {
      updateChat(currentTimeMillis,date,time,userUID,message);
    });

  }

  void updateChat(timestamp,date,time,userUID,message) {
    firestore.collection("chats")
        .doc(userUID)
        .collection("chats")
        .doc(timestamp.toString())
        .set({
      Constant.KEY_TIMESTAMP : timestamp.toString(),
      Constant.KEY_DATE : date.toString(),
      Constant.KEY_TIME : time.toString(),
      Constant.KEY_NOTIFICATION_MESSAGE : message,
      "type" : "admin",
    }).whenComplete(() {
      _isSend = false;

    });
  }

}


