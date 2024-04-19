import 'package:drago_admin/dashboard/components/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controller/MenuAppController.dart';
import '../../helper/custom_shadow_button.dart';
import '../../helper/text_widget.dart';
import '../../responsive.dart';
import '../../route/routes.dart';

class UserLoginHistoryList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider =   Provider.of<MenuAppController>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: "Notification History",),
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
                  provider.changeScreen(Routes.USER);
                },),
            ),
            SizedBox(height: 20,),
            StreamBuilder(
              stream: firestore.collection(Constant.COLLECTION_USER)
                  .doc(provider.parameters?[Constant.KEY_USERUID].toString() ?? 'false')
                .collection("notification")
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
                  child: Center(child: Text("No user Found",style: TextStyle(
                      fontSize: Responsive.isMobile(context) ? 12.0 : 18.0,fontWeight: FontWeight.bold
                  ),)
                    ,),
                ) :
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: PaginatedDataTable(
                      header: TextWidget(text: "Total Notifications: ${snapshot.data!.docs.length}",size: 20,color: Colors.white, isBold: false,),
                      headingRowColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return hoverColor; // Default color
                        },
                      ),
                      columnSpacing: 20.0,
                      arrowHeadColor: Colors.white,
                      rowsPerPage: snapshot.data!.docs.length >20 ? 20 : snapshot.data!.docs.length,
                      columns: const [
                        DataColumn(label: TextWidget(text: "Date", color: Colors.black,
                          size: 14.0, isBold: true,),),
                        DataColumn(label: TextWidget(text: "Time", color:  Colors.black,
                          size: 14.0, isBold: true,),),
                        DataColumn(label: TextWidget(text: "Title", color:  Colors.black,
                          size: 14.0, isBold: true,),),
                        DataColumn(label: TextWidget(text: "Message", color:  Colors.black,
                          size: 14.0, isBold: true,),),
                      ],
                      source: DataTableSourceImpl(
                          notification: snapshot.data!.docs,
                          length: snapshot.data!.docs.length,
                          context: context
                      )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DataTableSourceImpl extends DataTableSource {
  final notification;
  final length;
  final context;

  DataTableSourceImpl({required this.notification,required this.length,required this.context});

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return bgColor; // Default color
        },
      ),
      cells: [
        DataCell(
          TextWidget(text: notification[index][Constant.KEY_DATE].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),

        DataCell(
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.only(left: 2,top: 5,bottom: 10),
                  decoration: BoxDecoration(
                      color: hoverColor,
                      borderRadius: BorderRadius.circular(3)
                  ),
                  child: const Center(child: Icon(Icons.lock_clock)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 5.0,bottom: 5.0,top: 5.0),
                  child: TextWidget(text: notification[index][Constant.KEY_TIME].toString(), color: Colors.white,
                    size: 14.0, isBold: false,),),
              ],
            )
        ),
        DataCell(
          TextWidget(text: notification[index][Constant.KEY_NOTIFICATION_TITLE].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),
         DataCell(
          TextWidget(text: notification[index][Constant.KEY_NOTIFICATION_MESSAGE].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),

      ],
    );
  }

  @override
  int get rowCount => length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
