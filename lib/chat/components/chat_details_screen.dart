
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drago_admin/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../helper/custom_textfield.dart';
import '../../responsive.dart';


class ChatDetailsScreen extends StatefulWidget {
  String? id,name,className,collectionPath,leftText,rightText;
   ChatDetailsScreen({Key? key,
     required this.id,
     required this.name,
     required this.className,
     required this.collectionPath,
     required this.leftText,
     required this.rightText,
   }) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {

 var messageController = TextEditingController();

 bool _isSend = false;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text(widget.name.toString()),
       backgroundColor: Colors.amber,
     ),
     body: Column(
       children: [
         Expanded(
           flex: 7,
           child: Container(
             color: Colors.red,
             child:  Visibility(
               visible: true,
               child: Container(
                   width: MediaQuery.sizeOf(context).width,
                   height: MediaQuery.sizeOf(context).height /1.5 ,
                   margin: EdgeInsets.only(left: 10,right: 10),
                   padding: EdgeInsets.all(10.0),
                   child: StreamBuilder<QuerySnapshot>(
                       stream: FirebaseFirestore.instance
                           .collection(widget.collectionPath.toString())
                       .doc(widget.id.toString())
                       .collection("chats")
                           .snapshots(),
                       builder: (context, snapshots) {
                         return (snapshots.connectionState ==
                             ConnectionState.waiting)
                             ? const Center(
                           child: CircularProgressIndicator(color: Colors.amber,),
                         ) : snapshots.data!.size <=0 ? const Center(child: Text("No Chat List Found",style: TextStyle(
                             fontSize: 18,fontWeight: FontWeight.bold
                         ),)
                           ,)
                             :
                         ListView.builder(
                             itemCount:
                             snapshots.data!.docs.length,
                             shrinkWrap: true,
                             itemBuilder: (context, index) {
                               var data = snapshots
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
                                             color: Colors.yellow.shade300,
                                           ),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               data[Constant.KEY_TYPE] == 'user' ?
                                               Padding(
                                                 padding: const EdgeInsets.all(8.0),
                                                 child: Text(data[Constant.KEY_NOTIFICATION_MESSAGE],style: const TextStyle(
                                                   fontSize: 20,
                                                   fontWeight: FontWeight.bold,
                                                 ),),
                                               ) : Text(""),

                                               data[Constant.KEY_TYPE] == 'user' ?
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

                                       Align(
                                         alignment: Alignment.centerRight,
                                         child: Container(
                                           margin: EdgeInsets.all(5.0),
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(10.0),
                                             color: Colors.amber,
                                           ),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               data[Constant.KEY_TYPE] == 'admin' ?
                                               Padding(
                                                 padding: const EdgeInsets.all(8.0),
                                                 child: Text(data[Constant.KEY_NOTIFICATION_MESSAGE],style: const TextStyle(
                                                   fontSize: 20,
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
                       })
               ),
             ),
           ),
         ),

         Expanded(
           flex: 1,
           child: Container(
             margin: EdgeInsets.only(left: 10,right: 10,bottom: 30),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                 Container(
                     width: Get.width / 1.5 ,
                     height: 50,
                     child: CustomTextField(
                       controller: messageController,
                       hintText: "type here.....",)
                 ),
                 SizedBox(width: 20,),



                 InkWell(
                   onTap: (){
                     if(messageController.text.toString().isEmpty){
                       Get.snackbar("Alert!!", "Please enter message",backgroundColor: Colors.red,snackPosition: SnackPosition.TOP);
                     }else{
                       _isSend = true;
                       // saveChat();
                     }
                   },
                   child:  Container(
                     width: 100,
                     height: 50,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10.0),
                       color: Colors.amber,
                     ),
                     child: const Center(child: Text("Send"))
                   )
                 ),
               ],
             ),
           ),
         ),
       ],
     ),
   );
  }
  //
  // void saveChat() {
  //   DateTime now = DateTime.now();
  //   int currentTimeMillis = now.millisecondsSinceEpoch;
  //   print(currentTimeMillis);
  //
  //   String? date = Constant().formatDate(currentTimeMillis).toString();
  //   String? time = Constant().formatTime(currentTimeMillis);
  //
  //
  //   firestore.collection(widget.collectionPath.toString()).doc(widget.id.toString())
  //   .set({
  //     Constant.KEY_CHAT_SENDER_ID : widget.id.toString(),
  //     Constant.KEY_CHAT_NAME : widget.name.toString(),
  //     Constant.KEY_CHAT_CLASS_NAME : widget.className.toString(),
  //
  //   }).whenComplete(() {
  //     updateChat(currentTimeMillis,date,time);
  //   });
  //
  // }
  //
  // void updateChat(timestamp,date,time) {
  //    firestore.collection(widget.collectionPath.toString())
  //       .doc(widget.id.toString())
  //       .collection("chats")
  //       .doc(timestamp.toString())
  //       .set({
  //      Constant.KEY_CHAT_ID : timestamp.toString(),
  //      Constant.KEY_CHAT_DATE : date,
  //      Constant.KEY_CHAT_MESSAGE : messageController.text.toString(),
  //      Constant.KEY_CHAT_NAME : widget.name.toString(),
  //      Constant.KEY_CHAT_SENDER_ID : widget.id.toString(),
  //      Constant.KEY_CHAT_CLASS_NAME : widget.className.toString(),
  //      Constant.KEY_CHAT_TIME : time,
  //      Constant.KEY_CHAT_TYPE : "admin",
  //   }).whenComplete(() {
  //     messageController.text = "";
  //     _isSend = false;
  //
  //    });
  // }
}
