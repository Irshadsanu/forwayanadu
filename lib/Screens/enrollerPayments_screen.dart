import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/Screens/top_enrollers_screen.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/home_provider.dart';
import 'home_screen.dart';

class EnrollerPaymentsScreen extends StatelessWidget {
  const EnrollerPaymentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(84),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: height*0.12,
            // shape: const RoundedRectangleBorder(
            //     borderRadius:BorderRadius.only(
            //         bottomRight: Radius.circular(17),
            //         bottomLeft: Radius.circular(17))
            // ),
            title: Text('Volunteer Payments',style: wardAppbarTxt),
            centerTitle: true,
            leadingWidth: 55,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: InkWell(
                  onTap: (){
                    callNextReplacement(const HomeScreenNew(), context);
                  },
                  child: CircleAvatar(
                      radius: 18,
                      backgroundColor: cl000008.withOpacity(0.05),
                      child: const Icon(Icons.arrow_back_ios_outlined,color: myBlack,))),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              SizedBox(
                height: 65,
                child: Consumer<HomeProvider>(
                    builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22.0),
                        child: TextField(
                          controller: value.EnrollerPaymentSearchCt,
                          style: const TextStyle(fontSize: 14,fontFamily: "Poppins",color: myBlack,fontWeight:FontWeight.w600),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Search Volunteer ID",
                            hintStyle: const TextStyle(fontSize: 10,fontFamily: "Poppins",color: cl898989),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: clD4D4D4,width: 1),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: clD4D4D4,width: 1),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            suffixIcon: InkWell(
                                onTap: () async {
                                  homeProvider.aa();
                                  if(value.EnrollerPaymentSearchCt.text==""){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                backgroundColor:Colors.red,
                                                  content: Text("Please enter Volunteer ID")));

                                  }else{
                                    await homeProvider.getEnrollerPayments(value.EnrollerPaymentSearchCt.text.toString());

                                  }
                                },
                                child: const Icon(
                                  Icons.search,
                                  color: cl323A71,
                                )),
                          ),
                          onChanged: (item) {

                          },
                          onSubmitted: (txt){

                          },
                        ),
                      );
                    }),
              ),


              Consumer<HomeProvider>(
                builder: (context,value,child) {
                  return
                    value.enrollerPaymentsList.isNotEmpty?
                    Container(
                    // height: 110,
                    width: width,
                    margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                            color: cl323A71,
                            width: 1),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(15.0)),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Consumer<HomeProvider>(
                          builder: (context,value,child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height:8,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width/2.7,
                                    child: const Text('Volunteer Name',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(fontSize: 15,color: cl898989,fontFamily: "Poppins",fontWeight: FontWeight.w400)
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: SizedBox(
                                        width: width/25,
                                        child: const Text(':')
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    width: width/2.7,
                                    child: Text(value.EnrollerPaymentName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: cl0EA3A9,fontFamily: "Poppins"),),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width/2.7,
                                    child: const Text('No of Payments',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 15,color: cl898989,fontFamily: "Poppins",fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: SizedBox(
                                        width: width/25,
                                        child: const Text(':')
                                    ),
                                  ),
                                  SizedBox(
                                    width: width/2.7,
                                    child: Text(value.enrollerNoOfPayments,
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: cl323A71,fontFamily: "Poppins"),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width/2.7,
                                    child: const Text('Amount',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 15,color: cl898989,fontFamily: "Poppins",fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: SizedBox(
                                        width: width/25,
                                        child: const Text(':')
                                    ),
                                  ),
                                  Container(
                                    height: 25,
                                    // color: Colors.red,
                                    width: width/2.7,
                                    decoration: BoxDecoration(
                                        color: cl323A71,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text(value.EnrollerPaymenttotal.toString(),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white,fontFamily: "Poppins"),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8,)

                            ],
                          );
                        }
                      ),
                    )
                  )
                  :SizedBox()
                  ;
                }
              ),

              SizedBox(height: 10,),

              Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return value.enrollerPaymentsList.isNotEmpty?
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.enrollerPaymentsList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var item = value.enrollerPaymentsList[index];
                          return InkWell(
                            onTap: (){

                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Container(
                                // height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius:3, // soften the shadow

                                    )
                                  ],),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: width / 4.9,
                                                      child:  Text(
                                                        "Name",
                                                        style: gray12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width / 25,
                                                        child: const Text(':')),
                                                    SizedBox(
                                                      width: width / 2.7,
                                                      child: Text(item.name,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: gray16,
                                                    ),
                                                    )

                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: width / 4.9,
                                                      child: Text(
                                                        "ID",
                                                        style: gray12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width / 25,
                                                        child: const Text(':')),
                                                    SizedBox(
                                                      width:
                                                      width / 2.7,
                                                      child: Text(
                                                        item.enrollerid.substring(0, item.enrollerid.length - 4) + getStar(4),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: gray12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Row(
                                                //   children: [
                                                //     SizedBox(
                                                //       width: width / 4.9,
                                                //       child: Text(
                                                //         "State",
                                                //         style: gray12,
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //         width: width / 25,
                                                //         child: const Text(':')),
                                                //
                                                //     SizedBox(
                                                //       width: width / 2.7,
                                                //       child: Text(
                                                //         item.state,
                                                //         maxLines: 2,
                                                //         overflow: TextOverflow.ellipsis,
                                                //         style: gray12,
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: width / 4.9,
                                                      child: Text(
                                                        "District",
                                                        style: gray12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width / 25,
                                                        child: const Text(':')),

                                                    SizedBox(
                                                      width: width / 2.7,
                                                      child: Text(
                                                        item.district,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: gray12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width / 4.9,
                                                      child: Text(
                                                       "Assembly",
                                                        style: gray12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width / 25,
                                                        child: const Text(':')),
                                                    SizedBox(
                                                      width: width / 2.7,
                                                      child: Text(
                                                        item.assembly,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: gray12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width / 4.9,
                                                      child: Text(
                                                       "Panchayath",
                                                        style: gray12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width / 25,
                                                        child: const Text(':')),
                                                    SizedBox(
                                                      width: width / 2.7,
                                                      child: Text(
                                                        item.panchayath,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: gray12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width / 4.9,
                                                      child: Text(
                                                       "Unit",
                                                        style: gray12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width / 25,
                                                        child:
                                                        const Text(':')),
                                                    SizedBox(
                                                      width: width / 2.7,
                                                      child: Text(
                                                        item.ward,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: gray12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    height: 25,
                                                    width: 120,
                                                    // color: Colors.red,
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          '₹',
                                                          overflow: TextOverflow.fade,
                                                          style: greenB18,
                                                        ),
                                                        SizedBox(
                                                          height: 25,
                                                          // width: 95,
                                                          //color: Colors.black,
                                                          child: Text(
                                                            item.amount.toString(),
                                                            overflow: TextOverflow.fade,
                                                            maxLines: 1,
                                                            style: greenB18,
                                                          ),
                                                        ),
                                                      ],
                                                    )

                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }):Padding(
                          padding: const EdgeInsets.only(top:200),
                          child: SizedBox(
                            width: width/1.5,
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: value.enrollerNoPaymet,
                                      child: const Text("No payments found.",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Poppins"),)),
                                  Visibility(
                                      visible: value.enrollerNoPaymet,
                                      child: SizedBox(height:30,)),

                                  value.enrollerNoPaymet!=true?
                                  const Text("Volunteer id /Volunteer Phone Number ഉപയോഗിച്ച് Search ചെയ്യുക",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Poppins"),):SizedBox(),
                                ],
                              )),
                        );
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget web(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration( image: DecorationImage(
          image: AssetImage("assets/KPCCWebBackground.jpg",),
          fit:BoxFit.fill
      )),
      child: Center(
        child: queryData.orientation == Orientation.portrait
            ?Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height*0.12),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    toolbarHeight: height*0.13,
                    centerTitle: true,
                    title: Text('Volunteer Payments',style: wardAppbarTxt,),
                    automaticallyImplyLeading: false,
                    leading:  InkWell(
                      onTap: (){
                        callNextReplacement(HomeScreenNew(),context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [myDarkBlue,myLightBlue3]
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)
                        ),
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          // elevation: 0.5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Consumer<HomeProvider>(
                              builder: (context, value, child) {
                                return TextField(
                                  controller: value.EnrollerPaymentSearchCt,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: myWhite,
                                    filled: true,
                                    hintText: 'Enter Volunteer ID/ Volunteer Phone Number',
                                    hintStyle: const TextStyle(fontSize: 12,fontFamily: "Heebo"),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: myWhite),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(color: myWhite),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    suffixIcon: InkWell(
                                        onTap: () async {
                                          homeProvider.aa();
                                          if(value.EnrollerPaymentSearchCt.text==""){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        backgroundColor:Colors.red,
                                                          content: Text("Please enter Volunteer ID")));

                                          }else{

                                            await homeProvider.getEnrollerPayments(value.EnrollerPaymentSearchCt.text.toString());


                                          }


                                        },
                                        child: const Icon(
                                          Icons.search,
                                          color: gold_C3A570,
                                        )),
                                  ),
                                  onChanged: (item) {

                                  },
                                  onSubmitted: (txt){


                                  },
                                );
                              }),
                        ),
                      ),
                      Consumer<HomeProvider>(
                        builder: (context,value,child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RichText(
                                  text: TextSpan(
                               children: [
                                 TextSpan(
                                   text:"No of Payments:",style: TextStyle(fontSize: 16,color: myBlack)
                                 ),
                                 TextSpan(
                                     text:value.enrollerNoOfPayments.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: myBlack)
                                 ),
                               ] ,
                              )),
                              RichText(
                                  text: TextSpan(
                               children: [
                                 TextSpan(
                                   text:"Amount:",style: TextStyle(fontSize: 16,color: myBlack)
                                 ),
                                 TextSpan(
                                     text:value.EnrollerPaymenttotal.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: myBlack)
                                 ),
                               ] ,
                              )),



                            ],
                          );
                        }
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return value.enrollerPaymentsList.isNotEmpty?ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.enrollerPaymentsList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  var item = value.enrollerPaymentsList[index];
                                  return InkWell(
                                    onTap: (){

                                    },
                                    child: Container(


                                      child: Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        elevation:2,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 20,
                                              // margin: const EdgeInsets.all(10),
                                              // padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: myWhite,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              // child: Image.asset(
                                              //   'assets/dsitrict_logo.png',
                                              //   fit: BoxFit.contain,
                                              // ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 8,),
                                                  RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'Name        : ',style: TextStyle(color: Colors.black,fontFamily: 'Montserrat',)),
                                                    TextSpan(text:  item.name,
                                                      style: gray16,),

                                                  ])),
                                                  SizedBox(height: 2,),RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'ID                  : ' ,style: gray12,),
                                                    TextSpan(text: item.enrollerid ,style: gray12,)

                                                  ])),SizedBox(height: 2,),
                                                  // RichText(text: TextSpan(children: [
                                                  //   TextSpan(text: 'State              : ' ,style: gray12,),
                                                  //   TextSpan(text: item.state ,style: gray12,)
                                                  //
                                                  // ])),
                                                  // SizedBox(height: 2,),
                                                  RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'District              : ' ,style: gray12,),
                                                    TextSpan(text: item.district ,style: gray12,)

                                                  ])),
                                                  SizedBox(height: 2,),RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'Assembly           : ' ,style: gray12,),
                                                    TextSpan(text: item.assembly ,style: gray12,)

                                                  ])),
                                                  SizedBox(height: 2,),RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'Unit          : ' ,style: gray12,),
                                                    TextSpan(text: item.ward ,style: gray12,)

                                                  ])),
                                                  SizedBox(height: 8,),


                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    height: 25,
                                                    width: 120,
                                                    // color: Colors.red,
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          '₹',
                                                          overflow: TextOverflow.fade,
                                                          style: greenB18,
                                                        ),
                                                        SizedBox(
                                                          height: 25,
                                                          width: 95,
                                                          //color: Colors.black,
                                                          child: Text(
                                                            item.amount.toString(),
                                                            overflow: TextOverflow.fade,
                                                            maxLines: 1,
                                                            style: greenB18,
                                                          ),
                                                        ),
                                                      ],
                                                    )

                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }):Padding(
                                  padding: const EdgeInsets.only(top:200),
                                  child: Text("No data Found.."),
                                );
                          }
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        )
            :Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width/3,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height*0.12),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    toolbarHeight: height*0.13,
                    centerTitle: true,
                    title: Text('Enroller Payments',style: wardAppbarTxt,),
                    automaticallyImplyLeading: false,
                    leading:  InkWell(
                      onTap: (){
                        callNextReplacement(HomeScreenNew(),context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [myDarkBlue,myLightBlue3]
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)
                        ),
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          // elevation: 0.5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Consumer<HomeProvider>(
                              builder: (context, value, child) {
                                return TextField(
                                  controller: value.EnrollerPaymentSearchCt,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: myWhite,
                                    filled: true,
                                    hintText:'Enter Enroller ID/ Enroller Phone Number',
                                    hintStyle: const TextStyle(fontSize: 12,fontFamily: "Heebo"),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: myWhite),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(color: myWhite),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    suffixIcon: InkWell(
                                        onTap: () async {
                                          homeProvider.aa();
                                          if(value.EnrollerPaymentSearchCt.text==""){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                    backgroundColor:Colors.red,
                                                    content: Text("Please enter Enroller ID")));

                                          }else{

                                            await homeProvider.getEnrollerPayments(value.EnrollerPaymentSearchCt.text.toString());


                                          }


                                        },
                                        child: const Icon(
                                          Icons.search,
                                          color: gold_C3A570,
                                        )),
                                  ),
                                  onChanged: (item) {

                                  },
                                  onSubmitted: (txt){


                                  },
                                );
                              }),
                        ),
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                            text:"No of Payments:",style: TextStyle(fontSize: 16,color: myBlack)
                                        ),
                                        TextSpan(
                                            text:value.enrollerNoOfPayments.toString(),
                                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: myBlack)
                                        ),
                                      ] ,
                                    )),
                                RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                            text:"Amount:",style: TextStyle(fontSize: 16,color: myBlack)
                                        ),
                                        TextSpan(
                                            text:value.EnrollerPaymenttotal.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: myBlack)
                                        ),
                                      ] ,
                                    )),



                              ],
                            );
                          }
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return value.enrollerPaymentsList.isNotEmpty?ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.enrollerPaymentsList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  var item = value.enrollerPaymentsList[index];
                                  return InkWell(
                                    onTap: (){

                                    },
                                    child: Container(
                                      height: 130,

                                      child: Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        elevation:2,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 20,
                                              // margin: const EdgeInsets.all(10),
                                              // padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: myWhite,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              // child: Image.asset(
                                              //   'assets/dsitrict_logo.png',
                                              //   fit: BoxFit.contain,
                                              // ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 8,),
                                                  RichText(
                                                      text: TextSpan(
                                                      children: [
                                                    const TextSpan(text: 'Name        : ',style: TextStyle(color: Colors.black,fontFamily: 'Montserrat',)),
                                                    TextSpan(text:  item.name,
                                                      style: gray16,),

                                                  ])),
                                                  const SizedBox(height: 2,),
                                                  RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'ID                  : ' ,style: gray12,),
                                                    TextSpan(text: item.enrollerid ,style: gray12,)

                                                  ])),SizedBox(height: 2,),
                                                  // RichText(text: TextSpan(children: [
                                                  //   TextSpan(text: 'State              : ' ,style: gray12,),
                                                  //   TextSpan(text: item.state ,style: gray12,)
                                                  //
                                                  // ])),
                                                  // SizedBox(height: 2,),
                                                  RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'District              : ' ,style: gray12,),
                                                    TextSpan(text: item.district ,style: gray12,)

                                                  ])),SizedBox(height: 2,),
                                                  RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'Assembly  : ' ,style: gray12,),
                                                    TextSpan(text: item.assembly ,style: gray12,)

                                                  ])),
                                                  SizedBox(height: 2,),RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'Panchayath           : ' ,style: gray12,),
                                                    TextSpan(text: item.panchayath ,style: gray12,)

                                                  ])),SizedBox(height: 2,),RichText(text: TextSpan(children: [
                                                    TextSpan(text: 'Unit          : ' ,style: gray12,),
                                                    TextSpan(text: item.ward ,style: gray12,)

                                                  ])),
                                                  SizedBox(height: 8,),


                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    height: 25,
                                                    width: 120,
                                                    // color: Colors.red,
                                                    child:
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          '₹',
                                                          overflow: TextOverflow.fade,
                                                          maxLines: 1,
                                                          style: greenB18,
                                                        ),
                                                        SizedBox(
                                                          height: 25,
                                                          width: 95,
                                                          //color: Colors.black,
                                                          child: Text(
                                                            item.amount.toString(),
                                                            overflow: TextOverflow.fade,
                                                            maxLines: 1,
                                                            style: greenB18,
                                                          ),
                                                        ),
                                                      ],
                                                    )

                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }):Padding(
                              padding: const EdgeInsets.only(top:200),
                              child: Text("No data Found.."),
                            );
                          }
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
