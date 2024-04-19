import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../route/routes.dart';
import '../../controller/MenuAppController.dart';
import '../../dashboard/components/header.dart';
import '../../helper/text_widget.dart';
import '../../provider/count_value_provider.dart';

class AnnoucementList extends StatelessWidget {
  const AnnoucementList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder(
          stream: firestore.collection(Constant.COLLECTION_ANNOUNCEMENT)
              .orderBy('timeStamp',descending: false)
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
              child: Center(child: Text("No Announcement Found",style: TextStyle(
                  fontSize: 18.0,fontWeight: FontWeight.bold
              ),)
                ,),
            ) :
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: PaginatedDataTable(
                  header: TextWidget(text: "Total Annoucement: ${snapshot.data!.docs.length}",size: 20,color: Colors.white, isBold: false,),
                  headingRowColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return hoverColor; // Default color
                    },
                  ),
                  columnSpacing: 20.0,
                  arrowHeadColor: Colors.white,
                  rowsPerPage: snapshot.data!.docs.length >10 ? 10 : snapshot.data!.docs.length,
                  columns: const [
                    DataColumn(label: TextWidget(text: "Code", color: Colors.black,
                      size: 14.0, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Name", color:  Colors.black,
                      size: 14.0, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Description", color:  Colors.black,
                      size: 14.0, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Created By", color:  Colors.black,
                      size: 14.0, isBold: true,),),
                    DataColumn(label: TextWidget(text: "Action", color:  Colors.black,
                      size: 14.0, isBold: true,),),
                  ],
                  source: DataTableSourceImpl(
                      category: snapshot.data!.docs,
                      length: snapshot.data!.docs.length,
                      context: context
                  )),
            );
          },
        ),
      ],
    );
  }
}

class DataTableSourceImpl extends DataTableSource {
  final category;
  final length;
  final context;

  DataTableSourceImpl({required this.category,required this.length,required this.context});

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
          TextWidget(text: category[index][Constant.KEY_ANNOUCEMENT_ID].toString(), color: Colors.white,
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
                  child: const Center(child: Icon(Icons.category)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 5.0,bottom: 5.0,top: 5.0),
                  child: TextWidget(text: category[index][Constant.KEY_ANNOUCEMENT_TITLE].toString(), color: Colors.white,
                    size: 14.0, isBold: false,),),
              ],
            )
        ),
        DataCell(
          TextWidget(text: category[index][Constant.KEY_ANNOUCEMENT_DESC].toString(), color: Colors.white,
            size: 14.0, isBold: false,),
        ),
        const DataCell(
          TextWidget(text: "admin", color: Colors.white,
            size: 14.0, isBold: false,),
        ),

        DataCell(
            Row(
              children: [
                GestureDetector(
                    onTap:(){
                      Provider.of<MenuAppController>(context,listen: false)
                          .changeScreenWithParams(Routes.ADD_ANNOUNCEMENT, parameters: {
                        'edit':'true',
                        Constant.KEY_ANNOUCEMENT_ID.toString():category[index][Constant.KEY_ANNOUCEMENT_ID].toString(),
                        Constant.KEY_ANNOUCEMENT_TITLE.toString():category[index][Constant.KEY_ANNOUCEMENT_TITLE].toString(),
                        Constant.KEY_ANNOUCEMENT_DESC.toString():category[index][Constant.KEY_ANNOUCEMENT_DESC].toString(),
                      });
                    },
                    child: Icon(Icons.edit,color: hoverColor,size: 30.0,)),
                const SizedBox(width: 5,),
                GestureDetector(
                    onTap: (){
                      Provider.of<CountValueProvider>(context, listen: false)
                          .deleteCategory(id: category[index][Constant.KEY_ANNOUCEMENT_ID].toString());
                    },
                    child: Icon(Icons.delete,color: Colors.red,size: 30.0,)),
              ],)
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

