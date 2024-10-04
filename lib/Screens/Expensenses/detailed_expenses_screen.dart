import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quaide_millat/Views/expenses_model.dart';
import 'package:quaide_millat/constants/my_functions.dart';

import '../../constants/my_colors.dart';
import '../../constants/text_style.dart';

class DetailedExpensesScreen extends StatelessWidget {
  ExpensesModel item;
   DetailedExpensesScreen({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;

    print('Images List: ${item.images}');
    print('Images List: ${item.images.length}');
    List<dynamic> imagesList = item.images;

    print('List: ${imagesList.length}');


    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(84),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(item.name,style: wardAppbarTxt),
          centerTitle: true,
          leadingWidth: 55,
          toolbarHeight: height*0.12,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: InkWell(
                onTap: (){
                  finish(context);
                },
                child: CircleAvatar(
                    radius: 18,
                    backgroundColor: cl000008.withOpacity(0.05),
                    child: const Icon(Icons.arrow_back_ios_outlined,color: myBlack,))),
          ),

        ),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            item.images.isNotEmpty? const Padding(
              padding: EdgeInsets.only(left: 18.0,top: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Gallery",
                style: TextStyle(
                  fontFamily: "Poppins",fontWeight: FontWeight.w600,fontSize: 14,color: myBlack
                ),),
              ),
            ):SizedBox(),
           item.images.length==0?SizedBox():
           Container(
              // height: 50,
              width: width,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              // color: Colors.red,
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: item.images.asMap().entries.map((entry) {
                  int index = entry.key;
                  String item1 = entry.value;

                  // Check if the URL is valid
                  if (item1.isEmpty || !Uri.parse(item1).isAbsolute) {
                    return SizedBox(); // Return an empty widget for invalid URLs
                  }

                  // Condition based on list length or index
                  if (item.images.length ==1 ) {
                    // Example condition: fewer items, make them larger
                    return StaggeredGridTile.count(
                      crossAxisCellCount: 4,
                      mainAxisCellCount: 2,
                      child: buildNetworkImage(item1),
                    );
                  }
                  else if (item.images.length ==2 ) {
                    // Example condition: even index items are larger
                    return StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: buildNetworkImage(item1),
                    );
                  }
                  else if (item.images.length ==3 ) {
                    // Example condition: even index items are larger
                    return StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: buildNetworkImage(item1),
                    );
                  }
                  else {
                    // Odd index items are smaller
                    return StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: buildNetworkImage(item1),
                    );
                  }
                }).toList(),
              ),
        
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
              child: Text(item.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
              ),),
            ),

            SizedBox(height: 15,),
            item.invoiceImage!=''?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Document and Invoice",
                        style: TextStyle(fontFamily: "Poppins",fontSize: 14,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: width,
                          child: Image.network(item.invoiceImage,fit: BoxFit.fill,)),
                      SizedBox(height: 15,)
                    ],
                  ),
                ):SizedBox(),
          ],
        ),
      ),
    );
  }
}
Widget buildNetworkImage(String url) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(url),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
