import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/Screens/reciept_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Views/receipt_list_model.dart';
import '../Views/ward_model.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import 'home_screen.dart';

class ReceiptListMonitorScreen extends StatelessWidget {
   ReceiptListMonitorScreen({Key? key}) : super(key: key);
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    if(!kIsWeb){
      return mob(context);
    }else {
      return web(context);}
  }

   Widget mob (BuildContext context){
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return queryData.orientation==Orientation.portrait?
    Scaffold(
      appBar: AppBar(
        centerTitle:true ,
        automaticallyImplyLeading: false,
        leadingWidth: 55,
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
        title:Consumer<HomeProvider>(
          builder: (context,value,child) {
            return RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                        text:  getAmount(value.totalCollection),
                        style:  const TextStyle(
                          fontFamily: 'LilitaOne-Regular',
                           fontSize: 38,
                          color:myBlack,
                        ),
                      ),
                    ])
            );
          }
        ) ,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Consumer<HomeProvider>(
                    builder: (context,value,child) {
                      return RichText(text: TextSpan(children: [
                        TextSpan(text:  getAmount(value.totalCount),
                          style:  const TextStyle(
                            fontFamily: 'LilitaOne-Regular',
                            // fontWeight: FontWeight.bold,
                            fontSize: 38,
                            color:myBlack,
                          ),),

                      ]));

                    }
                ),

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
                            controller: value.searchEt,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              fillColor: myWhite,
                              filled: true,
                              hintText: 'Phone Number/Transaction ID',
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
                                  onTap: () {
                                    homeProvider.searchPayments(
                                        value.searchEt.text, context);
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: gold_C3A570,
                                  )),
                            ),
                            onChanged: (item) {
                              if (item.isEmpty) {

                                homeProvider.currentLimit = 50;
                                homeProvider.fetchReceiptListForMonitorApp(50);

                              }
                            },
                          );
                        }),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom:5),
                  child: Row(
                    children: [
                      // from != "home"
                      //     ? SizedBox(
                      //         child: Text(
                      //           'S.No',
                      //           style: green14N,
                      //         ),
                      //         width: 40,
                      //       )
                      //     : const SizedBox(),
                      Expanded(
                          flex: 4,
                          child: Text(
                            'Details',
                            style: receipt_AmountDetailse,
                          )),
                      Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Text(
                                'Amount',
                                style: receipt_AmountDetailse,
                              ),
                            ],
                          )),
                      // Expanded(
                      //     flex: 1,
                      //     child: Text(
                      //       'Amount/Dhoti',
                      //       style: black14N,
                      //     )),
                    ],
                  ),
                ),
                Consumer<HomeProvider>(
                    builder: (context,value,child) {

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.paymentDetailsList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {

                            var item = value.paymentDetailsList[index];
                            // homeProvider.buzzer(item.status.toString());

                            return queryData.orientation == Orientation.landscape?
                            Padding(
                              padding:  EdgeInsets.only(top:5,left: 5,right: 5),
                              child: Container(

                                decoration: BoxDecoration(
                                    color: item.status == "Success"
                                        ? myWhite
                                        : myfailed,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 0.2,
                                    )

                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey,
                                  //     blurRadius:3, // soften the shadow
                                  //
                                  //   )
                                  // ],
                                ),
                                // color: const Color(0xffF2EADD),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(right:15.0,),
                                      child: Text(getDate(item.time),style:
                                      receipt_DT
                                        ,)
                                      ,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // from != "home"
                                          //     ? SizedBox(
                                          //         child: Text(
                                          //           (index + 1).toString(),
                                          //           style: black14,
                                          //         ),
                                          //         width: 40,
                                          //       )
                                          //     : const SizedBox(),

                                          Expanded(
                                              flex: 3,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('Name',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.name,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('District',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          // width: width/2.7,
                                                          child: Text(item.district,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('Assembly',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.assembly,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('Panchayath',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.panchayath,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('Unit',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.wardName,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('UpiId',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.upiId,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('App',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.paymentApp,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: width/4.9,
                                                          child: Text('Platform',style: receiptNDMU,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: width/25,
                                                            child: const Text(':')
                                                        ),
                                                        SizedBox(
                                                          width: width/2.7,
                                                          child: Text(item.paymentplatform,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: receiptNDMU2,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,)




                                                ],
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                              )),
                                          Expanded(
                                            child: Text(
                                              //item.name,
                                              " ₹ ${item.amount.split(".").first}",
                                              style: black141,
                                            ),
                                            flex: 1,
                                          ),

                                        ],
                                      ),
                                    ),



                                  ],
                                ),
                              ),
                            )
                                :Padding(
                              padding: const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                              child: Container(

                                decoration: BoxDecoration(
                                  color: item.status == "Success"
                                      ? myWhite
                                      : myfailed,
                                  borderRadius: BorderRadius.circular(30),

                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius:3, // soften the shadow

                                    )
                                  ],
                                ),
                                // color: const Color(0xffF2EADD),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right:15.0,top:7),
                                      child: Text(getDate(item.time),style:
                                      receipt_DT
                                        ,)
                                      ,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // from != "home"
                                          //     ? SizedBox(
                                          //         child: Text(
                                          //           (index + 1).toString(),
                                          //           style: black14,
                                          //         ),
                                          //         width: 40,
                                          //       )
                                          //     : const SizedBox(),

                                          Expanded(
                                              flex: 3,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('Name',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.name,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('District',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.district,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('Assembly',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.assembly,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('Panchayath',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.panchayath,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('Unit',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.wardName,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('UpiId',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.upiId,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('App',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.paymentApp,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width/4.9,
                                                        child: Text('Platform',style: receiptNDMU,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width/25,
                                                          child: const Text(':')
                                                      ),
                                                      SizedBox(
                                                        width: width/2.7,
                                                        child: Text(item.paymentplatform,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: receiptNDMU2,),
                                                      ),
                                                    ],
                                                  ),




                                                ],
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                              )),
                                          Expanded(
                                            child: Text(
                                              //item.name,
                                              " ₹ ${item.amount.split(".").first}",
                                              style: black141,
                                            ),
                                            flex: 1,
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(height:height*0.02,),


                                    Padding(
                                      padding: const EdgeInsets.only(bottom:10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          // value.receiptPinWard=='ON'
                                          //     ?
                                          // InkWell(
                                          //   onTap: () {
                                          //
                                          //   },
                                          //   child: Container(
                                          //       alignment: Alignment.center,
                                          //       width: width * .320,
                                          //       height: 30,
                                          //       decoration: const BoxDecoration(
                                          //         gradient: LinearGradient(
                                          //             begin: Alignment.topLeft,
                                          //             end: Alignment.bottomRight,
                                          //             colors: [myDarkBlue,myLightBlue3]
                                          //         ),
                                          //         borderRadius: BorderRadius.all(
                                          //           Radius.circular(25),
                                          //
                                          //         ),
                                          //       ),
                                          //       child: Text('Change Booth',
                                          //         style:receiptCG,
                                          //       )),
                                          // )
                                          //     : SizedBox(
                                          //   width: width * .385,
                                          // ),

                                          item.status == "Success"?
                                          InkWell(
                                            onTap: () {
                                              DonationProvider
                                              donationProvider =
                                              Provider.of<DonationProvider>(context, listen: false);
                                              donationProvider.getSharedPrefName();
                                              if (item.paymentApp == 'Bank' && item.name == 'No Name') {
                                                // showReceiptAlert(context, item);
                                              } else {
                                                print("receipt click here");
                                                DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                                donationProvider.getDonationDetailsForReceipt(item.id);
                                                // donationProvider.fetchDonationDetails(item.id);
                                                // donationProvider.receiptSuccessStatus(item.id);

                                                callNext(ReceiptPage(nameStatus: 'YES',),
                                                    context);
                                              }
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                width: width * .320,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(40),

                                                    gradient: const LinearGradient(
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                        colors: [myDarkBlue,myLightBlue3]
                                                    )
                                                ),
                                                child: Text('Receipt',style: receiptCG,)),
                                          )
                                          :SizedBox(),


                                        ],
                                      ),
                                    ),



                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [


                                        InkWell(
                                          onTap: () {
                                            launch("tel://${item.phoneNumber}");
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              width: width * .385,
                                              height: 35,
                                              decoration:  BoxDecoration(
                                                  color: myDarkBlue,
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft: Radius
                                                          .circular(10))),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.call,color: myWhite,),
                                                  const SizedBox(width: 10,),
                                                  Text('Call',
                                                    style:knmTerms3,
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),

                                        InkWell(

                                          onTap: () {
                                            launch("whatsapp://send?phone=${"+91"+item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                          },

                                          child: Container(
                                              alignment: Alignment.center,
                                              width: width * .385,
                                              height: 35,
                                              decoration: const BoxDecoration(
                                                  color:  myDarkBlue,
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      bottomRight:
                                                      Radius.circular(
                                                          10))),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.phone,color: myWhite,),
                                                  const SizedBox(width: 10,),
                                                  Text('WhatsApp',
                                                    style:knmTerms3,
                                                  ),
                                                ],
                                              )
                                            // child: Text('WhatsApp',style: knmTerms3,)
                                          ),
                                        ),

                                      ],
                                    )


                                  ],
                                ),
                              ),
                            );
                          });
                    }
                ),
                Consumer<HomeProvider>(builder: (context, value, child) {
                  return value.currentLimit == value.paymentDetailsList.length || value.currentWardLimit == value.paymentDetailsList.length
                      ? TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              primary),
                          foregroundColor:
                          MaterialStateProperty.all<Color>(myWhite),
                          overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                          animationDuration:
                          const Duration(microseconds: 500)),
                      onPressed: () async {
                        PackageInfo packageInfo = await PackageInfo.fromPlatform();
                        String packageName = packageInfo.packageName;
                        if(packageName=='com.spine.knmMonitor'){

                          HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                          homeProvider.currentLimit=50;
                          homeProvider.fetchReceiptListForMonitorApp(50);
                          homeProvider.checkStarRating();

                        }else{
                          value.currentLimit = value.currentLimit + 20;
                          homeProvider
                              .fetchReceiptList(value.currentLimit);
                        }

                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(child: Text('Load More')),
                      ))
                      : SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Divider(
                          thickness: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10),
                          child: Text(
                            value.paymentDetailsList.isNotEmpty
                                ? 'No More Payments'
                                : 'No Payments',
                            style: black16,
                          ),
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
            // Consumer<HomeProvider>(
            //     builder: (context,value,child) {
            //       return Align(
            //         alignment:Alignment.topRight ,
            //         child: ConfettiWidget(
            //           gravity: .3,
            //           minBlastForce: 5, maxBlastForce: 1000,
            //           numberOfParticles: 500,
            //           confettiController: value.controllerCenter,
            //           blastDirectionality: BlastDirectionality.explosive,
            //           // don't specify a direction, blast randomly
            //           //blastDirection: BorderSide.strokeAlignOutside,
            //           shouldLoop:
            //           true, // start again as soon as the animation is finished
            //           colors: const [
            //             Colors.green,
            //             Colors.blue,
            //             Colors.pink,
            //             Colors.orange,
            //             Colors.purple,
            //             Colors.red,
            //             Colors.greenAccent,
            //             Colors.white,
            //             Colors.lightGreen,
            //             Colors.lightGreenAccent
            //           ], // manually specify the colors to be used
            //           createParticlePath: value.drawStar, // define a custom shape/path.
            //         ),
            //       );
            //     }
            // ),
          ],
        ),
      ),
    ):Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width:width,
          child: Scaffold(
            appBar: AppBar(
              centerTitle:true ,
              leadingWidth: 55,
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
              title:Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return RichText(
                        text: TextSpan(
                            children: [
                      TextSpan(text:  getAmount(value.totalCollection),
                        style:  const TextStyle(
                          fontFamily: 'LilitaOne-Regular',
                          // fontWeight: FontWeight.bold,
                          fontSize: 38,
                          color:myBlack,
                        ),),

                    ]));

                  }
              ) ,
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [

                  Column(

                    children: [
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return RichText(text: TextSpan(children: [

                              TextSpan(text:  getAmount(value.totalCount),
                                style:  const TextStyle(
                                  fontFamily: 'LilitaOne-Regular',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                  color:myBlack,
                                ),),

                            ]));

                          }
                      ),

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
                                  controller: value.searchEt,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    fillColor: myWhite,
                                    filled: true,
                                    hintText: 'Phone Number/Transaction ID',
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
                                        onTap: () {
                                          homeProvider.searchPayments(
                                              value.searchEt.text, context);
                                        },
                                        child: const Icon(
                                          Icons.search,
                                          color: gold_C3A570,
                                        )),
                                  ),
                                  onChanged: (item) {
                                    if (item.isEmpty) {

                                      homeProvider.currentLimit = 50;
                                      homeProvider.fetchReceiptListForMonitorApp(50);

                                    }
                                  },
                                );
                              }),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom:5),
                        child: Row(
                          children: [
                            // from != "home"
                            //     ? SizedBox(
                            //         child: Text(
                            //           'S.No',
                            //           style: green14N,
                            //         ),
                            //         width: 40,
                            //       )
                            //     : const SizedBox(),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Details',
                                  style: receipt_AmountDetailse,
                                )),
                            Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Text(
                                      'Amount',
                                      style: receipt_AmountDetailse,
                                    ),
                                  ],
                                )),
                            // Expanded(
                            //     flex: 1,
                            //     child: Text(
                            //       'Amount/Dhoti',
                            //       style: black14N,
                            //     )),
                          ],
                        ),
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {

                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.paymentDetailsList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {

                                  var item = value.paymentDetailsList[index];
                                  // homeProvider.buzzer(item.status.toString());

                                  return queryData.orientation == Orientation.landscape?
                                  Padding(
                                    padding:  EdgeInsets.only(top:5,left: 5,right: 5),
                                    child: Container(

                                      decoration: BoxDecoration(
                                          color: item.status == "Success"
                                              ? myWhite
                                              : myfailed,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 0.2,
                                          )

                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.grey,
                                        //     blurRadius:3, // soften the shadow
                                        //
                                        //   )
                                        // ],
                                      ),
                                      // color: const Color(0xffF2EADD),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(right:15.0,),
                                            child: Text(getDate(item.time),style:
                                            receipt_DT
                                              ,)
                                            ,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Row(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // from != "home"
                                                //     ? SizedBox(
                                                //         child: Text(
                                                //           (index + 1).toString(),
                                                //           style: black14,
                                                //         ),
                                                //         width: 40,
                                                //       )
                                                //     : const SizedBox(),

                                                Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Name',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.name,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('District',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                // width: width/2.7,
                                                                child: Text(item.district,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Assembly',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.assembly,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Panchayath',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.panchayath,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Unit',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.wardName,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('UpiId',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.upiId,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('App',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.paymentApp,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,)




                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                    )),
                                                Expanded(
                                                  child: Text(
                                                    //item.name,
                                                    " ₹ ${item.amount.split(".").first}",
                                                    style: black141,
                                                  ),
                                                  flex: 1,
                                                ),

                                              ],
                                            ),
                                          ),





                                        ],
                                      ),
                                    ),
                                  )
                                      :Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                                    child: Container(

                                      decoration: BoxDecoration(
                                        color: item.status == "Success"
                                            ? myWhite
                                            : myfailed,
                                        borderRadius: BorderRadius.circular(30),

                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius:3, // soften the shadow

                                          )
                                        ],
                                      ),
                                      // color: const Color(0xffF2EADD),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:15.0,top:7),
                                            child: Text(getDate(item.time),style:
                                            receipt_DT
                                              ,)
                                            ,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Row(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // from != "home"
                                                //     ? SizedBox(
                                                //         child: Text(
                                                //           (index + 1).toString(),
                                                //           style: black14,
                                                //         ),
                                                //         width: 40,
                                                //       )
                                                //     : const SizedBox(),

                                                Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Name',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.name,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('District',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.district,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Assembly',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.assembly,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Panchayath',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.panchayath,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Unit',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.wardName,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('UpiId',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.upiId,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('App',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.paymentApp,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),




                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                    )),
                                                Expanded(
                                                  child: Text(
                                                    //item.name,
                                                    " ₹ ${item.amount.split(".").first}",
                                                    style: black141,
                                                  ),
                                                  flex: 1,
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height:height*0.02,),


                                          Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                // value.receiptPinWard=='ON'
                                                //     ?
                                                // InkWell(
                                                //   onTap: () {
                                                //
                                                //   },
                                                //   child: Container(
                                                //       alignment: Alignment.center,
                                                //       width: width * .320,
                                                //       height: 30,
                                                //       decoration: const BoxDecoration(
                                                //         gradient: LinearGradient(
                                                //             begin: Alignment.topLeft,
                                                //             end: Alignment.bottomRight,
                                                //             colors: [myDarkBlue,myLightBlue3]
                                                //         ),
                                                //         borderRadius: BorderRadius.all(
                                                //           Radius.circular(25),
                                                //
                                                //         ),
                                                //       ),
                                                //       child: Text('Change Booth',
                                                //         style:receiptCG,
                                                //       )),
                                                // )
                                                //     : SizedBox(
                                                //   width: width * .385,
                                                // ),

                                                InkWell(

                                                  onTap: () {
                                                    DonationProvider
                                                    donationProvider =
                                                    Provider.of<DonationProvider>(context, listen: false);
                                                    donationProvider.getSharedPrefName();
                                                    if (item.paymentApp == 'Bank' && item.name == 'No Name') {
                                                      // showReceiptAlert(context, item);
                                                    } else {
                                                      print("receipt click here");
                                                      DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                                      donationProvider.getDonationDetailsForReceipt(item.id);
                                                      // donationProvider.fetchDonationDetails(item.id);
                                                      // donationProvider.receiptSuccessStatus(item.id);

                                                      callNext(ReceiptPage(nameStatus: 'YES',),
                                                          context);
                                                    }
                                                  },

                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: width * .320,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(40),

                                                          gradient: const LinearGradient(
                                                              begin: Alignment.centerLeft,
                                                              end: Alignment.centerRight,
                                                              colors: [myDarkBlue,myLightBlue3]
                                                          )
                                                      ),
                                                      child: Text('Receipt',style: receiptCG,)),
                                                ),


                                              ],
                                            ),
                                          ),



                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [


                                              InkWell(
                                                onTap: () {
                                                  launch("tel://${item.phoneNumber}");
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: width * .385,
                                                    height: 35,
                                                    decoration:  BoxDecoration(
                                                        color: myDarkBlue,
                                                        borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(10))),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.call,color: myWhite,),
                                                        const SizedBox(width: 10,),
                                                        Text('Call',
                                                          style:knmTerms3,
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ),

                                              InkWell(

                                                onTap: () {
                                                  launch("whatsapp://send?phone=${"+91"+item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                                },

                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: width * .385,
                                                    height: 35,
                                                    decoration: const BoxDecoration(
                                                        color:  myDarkBlue,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                            Radius.circular(
                                                                10))),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.phone,color: myWhite,),
                                                        const SizedBox(width: 10,),
                                                        Text('WhatsApp',
                                                          style:knmTerms3,
                                                        ),
                                                      ],
                                                    )
                                                  // child: Text('WhatsApp',style: knmTerms3,)
                                                ),
                                              ),

                                            ],
                                          )


                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                      ),
                      Consumer<HomeProvider>(builder: (context, value, child) {
                        return value.currentLimit == value.paymentDetailsList.length || value.currentWardLimit == value.paymentDetailsList.length
                            ? TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    primary),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(myWhite),
                                overlayColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.red),
                                animationDuration:
                                const Duration(microseconds: 500)),
                            onPressed: () async {
                              PackageInfo packageInfo = await PackageInfo.fromPlatform();
                              String packageName = packageInfo.packageName;
                              if(packageName=='com.spine.knmMonitor'){

                                HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                                homeProvider.currentLimit=50;
                                homeProvider.fetchReceiptListForMonitorApp(50);
                                homeProvider.checkStarRating();

                              }else{
                                value.currentLimit = value.currentLimit + 20;
                                homeProvider
                                    .fetchReceiptList(value.currentLimit);
                              }

                            },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Center(child: Text('Load More')),
                            ))
                            : SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const Divider(
                                thickness: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10),
                                child: Text(
                                  value.paymentDetailsList.isNotEmpty
                                      ? 'No More Payments'
                                      : 'No Payments',
                                  style: black16,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                  // Consumer<HomeProvider>(
                  //     builder: (context,value,child) {
                  //       return Align(
                  //         alignment:Alignment.topRight ,
                  //         child: ConfettiWidget(
                  //           gravity: .3,
                  //           minBlastForce: 5, maxBlastForce: 1000,
                  //           numberOfParticles: 500,
                  //           confettiController: value.controllerCenter,
                  //           blastDirectionality: BlastDirectionality.explosive,
                  //           // don't specify a direction, blast randomly
                  //           //blastDirection: BorderSide.strokeAlignOutside,
                  //           shouldLoop:
                  //           true, // start again as soon as the animation is finished
                  //           colors: const [
                  //             Colors.green,
                  //             Colors.blue,
                  //             Colors.pink,
                  //             Colors.orange,
                  //             Colors.purple,
                  //             Colors.red,
                  //             Colors.greenAccent,
                  //             Colors.white,
                  //             Colors.lightGreen,
                  //             Colors.lightGreenAccent
                  //           ], // manually specify the colors to be used
                  //           createParticlePath: value.drawStar, // define a custom shape/path.
                  //         ),
                  //       );
                  //     }
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget web (BuildContext context){
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);

    return queryData.orientation==Orientation.portrait? Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width:width,
          child: Scaffold(
            appBar: AppBar(
              centerTitle:true ,
              title:Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return RichText(text: TextSpan(children: [

                      TextSpan(text:  getAmount(value.totalCollection),
                        style:  const TextStyle(
                          fontFamily: 'LilitaOne-Regular',
                          // fontWeight: FontWeight.bold,
                          fontSize: 38,
                          color:myBlack,
                        ),),

                    ]));

                  }
              ) ,
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [

                  Column(

                    children: [
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return RichText(text: TextSpan(children: [

                              TextSpan(text:  getAmount(value.totalCount),
                                style:  const TextStyle(
                                  fontFamily: 'LilitaOne-Regular',
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                  color:myBlack,
                                ),),

                            ]));

                          }
                      ),

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
                                  controller: value.searchEt,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    fillColor: myWhite,
                                    filled: true,
                                    hintText: 'Phone Number/Transaction ID',
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
                                        onTap: () {
                                          homeProvider.searchPayments(
                                              value.searchEt.text, context);
                                        },
                                        child: const Icon(
                                          Icons.search,
                                          color: gold_C3A570,
                                        )),
                                  ),
                                  onChanged: (item) {
                                    if (item.isEmpty) {

                                      homeProvider.currentLimit = 50;
                                      homeProvider.fetchReceiptListForMonitorApp(50);

                                    }
                                  },
                                );
                              }),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom:5),
                        child: Row(
                          children: [
                            // from != "home"
                            //     ? SizedBox(
                            //         child: Text(
                            //           'S.No',
                            //           style: green14N,
                            //         ),
                            //         width: 40,
                            //       )
                            //     : const SizedBox(),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Details',
                                  style: receipt_AmountDetailse,
                                )),
                            Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Text(
                                      'Amount',
                                      style: receipt_AmountDetailse,
                                    ),
                                  ],
                                )),
                            // Expanded(
                            //     flex: 1,
                            //     child: Text(
                            //       'Amount/Dhoti',
                            //       style: black14N,
                            //     )),
                          ],
                        ),
                      ),
                      Consumer<HomeProvider>(
                          builder: (context,value,child) {

                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.paymentDetailsList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {

                                  var item = value.paymentDetailsList[index];
                                  // homeProvider.buzzer(item.status.toString());

                                  return queryData.orientation == Orientation.landscape?
                                  Padding(
                                    padding:  EdgeInsets.only(top:5,left: 5,right: 5),
                                    child: Container(

                                      decoration: BoxDecoration(
                                          color: item.status == "Success"
                                              ? myWhite
                                              : myfailed,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 0.2,
                                          )

                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.grey,
                                        //     blurRadius:3, // soften the shadow
                                        //
                                        //   )
                                        // ],
                                      ),
                                      // color: const Color(0xffF2EADD),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(right:15.0,),
                                            child: Text(getDate(item.time),style:
                                            receipt_DT
                                              ,)
                                            ,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Row(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // from != "home"
                                                //     ? SizedBox(
                                                //         child: Text(
                                                //           (index + 1).toString(),
                                                //           style: black14,
                                                //         ),
                                                //         width: 40,
                                                //       )
                                                //     : const SizedBox(),

                                                Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Name',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.name,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('District',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                // width: width/2.7,
                                                                child: Text(item.district,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Assembly',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.assembly,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Panchayath',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.panchayath,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Unit',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.wardName,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('UpiId',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.upiId,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('App',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.paymentApp,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left:20),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('App',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.paymentApp,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,)




                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                    )),
                                                Expanded(
                                                  child: Text(
                                                    //item.name,
                                                    " ₹ ${item.amount.split(".").first}",
                                                    style: black141,
                                                  ),
                                                  flex: 1,
                                                ),

                                              ],
                                            ),
                                          ),





                                        ],
                                      ),
                                    ),
                                  )
                                      :Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                                    child: Container(

                                      decoration: BoxDecoration(
                                        color: item.status == "Success"
                                            ? myWhite
                                            : myfailed,
                                        borderRadius: BorderRadius.circular(30),

                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius:3, // soften the shadow

                                          )
                                        ],
                                      ),
                                      // color: const Color(0xffF2EADD),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:15.0,top:7),
                                            child: Text(getDate(item.time),style:
                                            receipt_DT
                                              ,)
                                            ,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Row(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // from != "home"
                                                //     ? SizedBox(
                                                //         child: Text(
                                                //           (index + 1).toString(),
                                                //           style: black14,
                                                //         ),
                                                //         width: 40,
                                                //       )
                                                //     : const SizedBox(),

                                                Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Name',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.name,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('District',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.district,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Assembly',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.assembly,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Panchayath',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.panchayath,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('Unit',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.wardName,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('UpiId',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.upiId,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: width/4.9,
                                                              child: Text('App',style: receiptNDMU,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: width/25,
                                                                child: const Text(':')
                                                            ),
                                                            SizedBox(
                                                              width: width/2.7,
                                                              child: Text(item.paymentApp,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: receiptNDMU2,),
                                                            ),
                                                          ],
                                                        ),




                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                    )),
                                                Expanded(
                                                  child: Text(
                                                    //item.name,
                                                    " ₹ ${item.amount.split(".").first}",
                                                    style: black141,
                                                  ),
                                                  flex: 1,
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height:height*0.02,),


                                          Padding(
                                            padding: const EdgeInsets.only(bottom:10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                // value.receiptPinWard=='ON'
                                                //     ?
                                                // InkWell(
                                                //   onTap: () {
                                                //
                                                //   },
                                                //   child: Container(
                                                //       alignment: Alignment.center,
                                                //       width: width * .320,
                                                //       height: 30,
                                                //       decoration: const BoxDecoration(
                                                //         gradient: LinearGradient(
                                                //             begin: Alignment.topLeft,
                                                //             end: Alignment.bottomRight,
                                                //             colors: [myDarkBlue,myLightBlue3]
                                                //         ),
                                                //         borderRadius: BorderRadius.all(
                                                //           Radius.circular(25),
                                                //
                                                //         ),
                                                //       ),
                                                //       child: Text('Change Booth',
                                                //         style:receiptCG,
                                                //       )),
                                                // )
                                                //     : SizedBox(
                                                //   width: width * .385,
                                                // ),

                                                InkWell(

                                                  onTap: () {
                                                    DonationProvider
                                                    donationProvider =
                                                    Provider.of<DonationProvider>(context, listen: false);
                                                    donationProvider.getSharedPrefName();
                                                    if (item.paymentApp == 'Bank' && item.name == 'No Name') {
                                                      // showReceiptAlert(context, item);
                                                    } else {
                                                      print("receipt click here");
                                                      DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                                      donationProvider.getDonationDetailsForReceipt(item.id);
                                                      // donationProvider.fetchDonationDetails(item.id);
                                                      // donationProvider.receiptSuccessStatus(item.id);

                                                      callNext(ReceiptPage(nameStatus: 'YES',),
                                                          context);
                                                    }
                                                  },

                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: width * .320,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(40),

                                                          gradient: const LinearGradient(
                                                              begin: Alignment.centerLeft,
                                                              end: Alignment.centerRight,
                                                              colors: [myDarkBlue,myLightBlue3]
                                                          )
                                                      ),
                                                      child: Text('Receipt',style: receiptCG,)),
                                                ),


                                              ],
                                            ),
                                          ),



                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [


                                              InkWell(
                                                onTap: () {
                                                  launch("tel://${item.phoneNumber}");
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: width * .385,
                                                    height: 35,
                                                    decoration:  BoxDecoration(
                                                        color: myDarkBlue,
                                                        borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(10))),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.call,color: myWhite,),
                                                        const SizedBox(width: 10,),
                                                        Text('Call',
                                                          style:knmTerms3,
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ),

                                              InkWell(

                                                onTap: () {
                                                  launch("whatsapp://send?phone=${"+91"+item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                                },

                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: width * .385,
                                                    height: 35,
                                                    decoration: const BoxDecoration(
                                                        color:  myDarkBlue,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                            Radius.circular(
                                                                10))),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.phone,color: myWhite,),
                                                        const SizedBox(width: 10,),
                                                        Text('WhatsApp',
                                                          style:knmTerms3,
                                                        ),
                                                      ],
                                                    )
                                                  // child: Text('WhatsApp',style: knmTerms3,)
                                                ),
                                              ),

                                            ],
                                          )


                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                      ),
                      Consumer<HomeProvider>(builder: (context, value, child) {
                        return value.currentLimit == value.paymentDetailsList.length || value.currentWardLimit == value.paymentDetailsList.length
                            ? TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    primary),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(myWhite),
                                overlayColor: MaterialStateColor.resolveWith(
                                        (states) => Colors.red),
                                animationDuration:
                                const Duration(microseconds: 500)),
                            onPressed: () async {
                              PackageInfo packageInfo = await PackageInfo.fromPlatform();
                              String packageName = packageInfo.packageName;
                              if(packageName=='com.spine.knmMonitor'){

                                HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                                homeProvider.currentLimit=50;
                                homeProvider.fetchReceiptListForMonitorApp(50);
                                homeProvider.checkStarRating();

                              }else{
                                value.currentLimit = value.currentLimit + 20;
                                homeProvider
                                    .fetchReceiptList(value.currentLimit);
                              }

                            },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Center(child: Text('Load More')),
                            ))
                            : SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const Divider(
                                thickness: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10),
                                child: Text(
                                  value.paymentDetailsList.isNotEmpty
                                      ? 'No More Payments'
                                      : 'No Payments',
                                  style: black16,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                  // Consumer<HomeProvider>(
                  //     builder: (context,value,child) {
                  //       return Align(
                  //         alignment:Alignment.topRight ,
                  //         child: ConfettiWidget(
                  //           gravity: .3,
                  //           minBlastForce: 5, maxBlastForce: 1000,
                  //           numberOfParticles: 500,
                  //           confettiController: value.controllerCenter,
                  //           blastDirectionality: BlastDirectionality.explosive,
                  //           // don't specify a direction, blast randomly
                  //           //blastDirection: BorderSide.strokeAlignOutside,
                  //           shouldLoop:
                  //           true, // start again as soon as the animation is finished
                  //           colors: const [
                  //             Colors.green,
                  //             Colors.blue,
                  //             Colors.pink,
                  //             Colors.orange,
                  //             Colors.purple,
                  //             Colors.red,
                  //             Colors.greenAccent,
                  //             Colors.white,
                  //             Colors.lightGreen,
                  //             Colors.lightGreenAccent
                  //           ], // manually specify the colors to be used
                  //           createParticlePath: value.drawStar, // define a custom shape/path.
                  //         ),
                  //       );
                  //     }
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    )
        :Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width:width,
            child: Scaffold(
              appBar: AppBar(
                centerTitle:true ,
                title:Consumer<HomeProvider>(
                    builder: (context,value,child) {
                      return RichText(text: TextSpan(children: [

                        TextSpan(text:  getAmount(value.totalCollection),
                          style:  const TextStyle(
                            fontFamily: 'LilitaOne-Regular',
                            // fontWeight: FontWeight.bold,
                            fontSize: 38,
                            color:myBlack,
                          ),),

                      ]));

                    }
                ) ,
              ),
              body: SingleChildScrollView(
                child: Stack(
                  children: [

                    Column(

                      children: [
                        Consumer<HomeProvider>(
                            builder: (context,value,child) {
                              return RichText(text: TextSpan(children: [

                                TextSpan(text:  getAmount(value.totalCount),
                                  style:  const TextStyle(
                                    fontFamily: 'LilitaOne-Regular',
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 38,
                                    color:myBlack,
                                  ),),

                              ]));

                            }
                        ),

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
                                    controller: value.searchEt,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      fillColor: myWhite,
                                      filled: true,
                                      hintText: 'Phone Number/Transaction ID',
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
                                          onTap: () {
                                            homeProvider.searchPayments(
                                                value.searchEt.text, context);
                                          },
                                          child: const Icon(
                                            Icons.search,
                                            color: gold_C3A570,
                                          )),
                                    ),
                                    onChanged: (item) {
                                      if (item.isEmpty) {

                                        homeProvider.currentLimit = 50;
                                        homeProvider.fetchReceiptListForMonitorApp(50);

                                      }
                                    },
                                  );
                                }),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom:5),
                          child: Row(
                            children: [
                              // from != "home"
                              //     ? SizedBox(
                              //         child: Text(
                              //           'S.No',
                              //           style: green14N,
                              //         ),
                              //         width: 40,
                              //       )
                              //     : const SizedBox(),
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Details',
                                    style: receipt_AmountDetailse,
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Amount',
                                        style: receipt_AmountDetailse,
                                      ),
                                    ],
                                  )),
                              // Expanded(
                              //     flex: 1,
                              //     child: Text(
                              //       'Amount/Dhoti',
                              //       style: black14N,
                              //     )),
                            ],
                          ),
                        ),
                        Consumer<HomeProvider>(
                            builder: (context,value,child) {

                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.paymentDetailsList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {

                                    var item = value.paymentDetailsList[index];
                                    // homeProvider.buzzer(item.status.toString());

                                    return queryData.orientation == Orientation.landscape?
                                    Padding(
                                      padding:  EdgeInsets.only(top:5,left: 5,right: 5),
                                      child: Container(

                                        decoration: BoxDecoration(
                                            color: item.status == "Success"
                                                ? myWhite
                                                : myfailed,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.blue,
                                              width: 0.2,
                                            )

                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.grey,
                                          //     blurRadius:3, // soften the shadow
                                          //
                                          //   )
                                          // ],
                                        ),
                                        // color: const Color(0xffF2EADD),

                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [

                                            Padding(
                                              padding: const EdgeInsets.only(right:15.0,),
                                              child: Text(getDate(item.time),style:
                                              receipt_DT
                                                ,)
                                              ,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Row(
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // from != "home"
                                                  //     ? SizedBox(
                                                  //         child: Text(
                                                  //           (index + 1).toString(),
                                                  //           style: black14,
                                                  //         ),
                                                  //         width: 40,
                                                  //       )
                                                  //     : const SizedBox(),

                                                  Expanded(
                                                      flex: 3,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('Name',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.name,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('District',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  // width: width/2.7,
                                                                  child: Text(item.district,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('Assembly',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.assembly,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('Panchayath',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.panchayath,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('Unit',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.wardName,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('UpiId',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.upiId,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('App',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.paymentApp,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('Platform',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.paymentplatform,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          item.enroller!="NILL"?Padding(
                                                            padding: const EdgeInsets.only(left:20),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: width/4.9,
                                                                  child: Text('Volunteer',style: receiptNDMU,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: width/25,
                                                                    child: const Text(':')
                                                                ),
                                                                SizedBox(
                                                                  width: width/2.7,
                                                                  child: Text(item.enroller,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: receiptNDMU2,),
                                                                ),
                                                              ],
                                                            ),
                                                          ):SizedBox(),
                                                          SizedBox(height: 5,)




                                                        ],
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                      )),
                                                  Expanded(
                                                    child: Text(
                                                      //item.name,
                                                      " ₹ ${item.amount.split(".").first}",
                                                      style: black141,
                                                    ),
                                                    flex: 1,
                                                  ),

                                                ],
                                              ),
                                            ),


                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                item.status == 'Success'
                                                    ? Consumer<HomeProvider>(
                                                    builder: (context, value, child) {
                                                      return  Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                        child: InkWell(
                                                          onTap: () {
                                                            DonationProvider donationProvider =
                                                            Provider.of<DonationProvider>(context, listen: false);
                                                            donationProvider.transactionID.text = item.id;
                                                            showPinWardAlert(context, item);
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 130,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.circular(40),

                                                              gradient: const LinearGradient(
                                                                  begin: Alignment.centerLeft,
                                                                  end: Alignment.centerRight,
                                                                  colors: [cl0EA3A9,cl3686C5]
                                                              ),
                                                              image: const DecorationImage(image: AssetImage("assets/Vector2.png"),alignment: Alignment.bottomCenter),
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              item.wardName == 'GENERAL'
                                                                  ? 'Change Unit'
                                                                  : 'Change Unit',
                                                              style: whitePoppinsBoldM12,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    })
                                                    : const SizedBox(),
                                                SizedBox(width: 5,),
                                                item.status == 'Success'&&item.enroller=="NILL"?
                                                InkWell(
                                                  onTap: (){
                                                    print(item.id+"hgjghjgh");
                                                    homeProvider.addEntrollerPhoneCT.clear();
                                                    beAnEnrollerAlert(context,item.amount,item.id);
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 130,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40),
                                                      gradient: const LinearGradient(
                                                          begin: Alignment.centerLeft,
                                                          end: Alignment.centerRight,
                                                          colors: [cl0EA3A9,cl3686C5]
                                                      ),
                                                      image: const DecorationImage(image: AssetImage("assets/Vector2.png"),
                                                          alignment: Alignment.bottomCenter),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text('Map Volunteer',
                                                      style: whitePoppinsBoldM12,
                                                    ),
                                                  ),
                                                ):SizedBox(),
                                              ],
                                            ),

                                            SizedBox(height: 5,)
                                          ],
                                        ),
                                      ),
                                    )
                                        :Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:7,vertical: 5),
                                      child: Container(

                                        decoration: BoxDecoration(
                                          color: item.status == "Success"
                                              ? myWhite
                                              : myfailed,
                                          borderRadius: BorderRadius.circular(30),

                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius:3, // soften the shadow

                                            )
                                          ],
                                        ),
                                        // color: const Color(0xffF2EADD),

                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right:15.0,top:7),
                                              child: Text(getDate(item.time),style:
                                              receipt_DT
                                                ,)
                                              ,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                              child: Row(
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // from != "home"
                                                  //     ? SizedBox(
                                                  //         child: Text(
                                                  //           (index + 1).toString(),
                                                  //           style: black14,
                                                  //         ),
                                                  //         width: 40,
                                                  //       )
                                                  //     : const SizedBox(),

                                                  Expanded(
                                                      flex: 3,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Name',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.name,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('District',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.district,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Assembly',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.assembly,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Panchayath',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.panchayath,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('Unit',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.wardName,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('UpiId',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.upiId,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width/4.9,
                                                                child: Text('App',style: receiptNDMU,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width/25,
                                                                  child: const Text(':')
                                                              ),
                                                              SizedBox(
                                                                width: width/2.7,
                                                                child: Text(item.paymentApp,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: receiptNDMU2,),
                                                              ),
                                                            ],
                                                          ),




                                                        ],
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                      )),
                                                  Expanded(
                                                    child: Text(
                                                      //item.name,
                                                      " ₹ ${item.amount.split(".").first}",
                                                      style: black141,
                                                    ),
                                                    flex: 1,
                                                  ),

                                                ],
                                              ),
                                            ),
                                            SizedBox(height:height*0.02,),


                                            Padding(
                                              padding: const EdgeInsets.only(bottom:10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  // value.receiptPinWard=='ON'
                                                  //     ?
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //
                                                  //   },
                                                  //   child: Container(
                                                  //       alignment: Alignment.center,
                                                  //       width: width * .320,
                                                  //       height: 30,
                                                  //       decoration: const BoxDecoration(
                                                  //         gradient: LinearGradient(
                                                  //             begin: Alignment.topLeft,
                                                  //             end: Alignment.bottomRight,
                                                  //             colors: [myDarkBlue,myLightBlue3]
                                                  //         ),
                                                  //         borderRadius: BorderRadius.all(
                                                  //           Radius.circular(25),
                                                  //
                                                  //         ),
                                                  //       ),
                                                  //       child: Text('Change Booth',
                                                  //         style:receiptCG,
                                                  //       )),
                                                  // )
                                                  //     : SizedBox(
                                                  //   width: width * .385,
                                                  // ),

                                                  InkWell(

                                                    onTap: () {
                                                      DonationProvider
                                                      donationProvider =
                                                      Provider.of<DonationProvider>(context, listen: false);
                                                      donationProvider.getSharedPrefName();
                                                      if (item.paymentApp == 'Bank' && item.name == 'No Name') {
                                                        // showReceiptAlert(context, item);
                                                      } else {
                                                        print("receipt click here");
                                                        DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                                        donationProvider.getDonationDetailsForReceipt(item.id);
                                                        // donationProvider.fetchDonationDetails(item.id);
                                                        // donationProvider.receiptSuccessStatus(item.id);

                                                        callNext(ReceiptPage(nameStatus: 'YES',),
                                                            context);
                                                      }
                                                    },

                                                    child: Container(
                                                        alignment: Alignment.center,
                                                        width: width * .320,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(40),

                                                            gradient: const LinearGradient(
                                                                begin: Alignment.centerLeft,
                                                                end: Alignment.centerRight,
                                                                colors: [myDarkBlue,myLightBlue3]
                                                            )
                                                        ),
                                                        child: Text('Receipt',style: receiptCG,)),
                                                  ),


                                                ],
                                              ),
                                            ),



                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [


                                                InkWell(
                                                  onTap: () {
                                                    launch("tel://${item.phoneNumber}");
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: width * .385,
                                                      height: 35,
                                                      decoration:  BoxDecoration(
                                                          color: myDarkBlue,
                                                          borderRadius:
                                                          const BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(10))),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(Icons.call,color: myWhite,),
                                                          const SizedBox(width: 10,),
                                                          Text('Call',
                                                            style:knmTerms3,
                                                          ),
                                                        ],
                                                      )
                                                  ),
                                                ),

                                                InkWell(

                                                  onTap: () {
                                                    launch("whatsapp://send?phone=${"+91"+item.phoneNumber.replaceAll("+91", '').replaceAll(" ", '')}");
                                                  },

                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: width * .385,
                                                      height: 35,
                                                      decoration: const BoxDecoration(
                                                          color:  myDarkBlue,
                                                          borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                              Radius.circular(
                                                                  10))),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const Icon(Icons.phone,color: myWhite,),
                                                          const SizedBox(width: 10,),
                                                          Text('WhatsApp',
                                                            style:knmTerms3,
                                                          ),
                                                        ],
                                                      )
                                                    // child: Text('WhatsApp',style: knmTerms3,)
                                                  ),
                                                ),

                                              ],
                                            )


                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                        ),
                        Consumer<HomeProvider>(builder: (context, value, child) {
                          return value.currentLimit == value.paymentDetailsList.length || value.currentWardLimit == value.paymentDetailsList.length
                              ? TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      primary),
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(myWhite),
                                  overlayColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.red),
                                  animationDuration:
                                  const Duration(microseconds: 500)),
                              onPressed: () async {
                                PackageInfo packageInfo = await PackageInfo.fromPlatform();
                                String packageName = packageInfo.packageName;
                                if(packageName=='com.spine.knmMonitor'){

                                  HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                                  homeProvider.currentLimit=50;
                                  homeProvider.fetchReceiptListForMonitorApp(50);
                                  homeProvider.checkStarRating();

                                }else{
                                  value.currentLimit = value.currentLimit + 20;
                                  homeProvider
                                      .fetchReceiptList(value.currentLimit);
                                }

                              },
                              child: const SizedBox(
                                width: double.infinity,
                                child: Center(child: Text('Load More')),
                              ))
                              : SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                const Divider(
                                  thickness: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10),
                                  child: Text(
                                    value.paymentDetailsList.isNotEmpty
                                        ? 'No More Payments'
                                        : 'No Payments',
                                    style: black16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                    // Consumer<HomeProvider>(
                    //     builder: (context,value,child) {
                    //       return Align(
                    //         alignment:Alignment.topRight ,
                    //         child: ConfettiWidget(
                    //           gravity: .3,
                    //           minBlastForce: 5, maxBlastForce: 1000,
                    //           numberOfParticles: 500,
                    //           confettiController: value.controllerCenter,
                    //           blastDirectionality: BlastDirectionality.explosive,
                    //           // don't specify a direction, blast randomly
                    //           //blastDirection: BorderSide.strokeAlignOutside,
                    //           shouldLoop:
                    //           true, // start again as soon as the animation is finished
                    //           colors: const [
                    //             Colors.green,
                    //             Colors.blue,
                    //             Colors.pink,
                    //             Colors.orange,
                    //             Colors.purple,
                    //             Colors.red,
                    //             Colors.greenAccent,
                    //             Colors.white,
                    //             Colors.lightGreen,
                    //             Colors.lightGreenAccent
                    //           ], // manually specify the colors to be used
                    //           createParticlePath: value.drawStar, // define a custom shape/path.
                    //         ),
                    //       );
                    //     }
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


   showPinWardAlert(
       BuildContext context,
       PaymentDetails item,
       ) {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           shape:
           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
           contentPadding:
           const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
           content: Form(
             key: _formKey,
             child: SingleChildScrollView(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(vertical: 5),
                     child: Consumer<DonationProvider>(
                         builder: (context, value, child) {
                           return Text(
                             'Transaction ID (4 digit)${value.phonePinWard == 'ON' ? '/Phone No' : ''}',
                             style: const TextStyle(fontSize: 14),
                           );
                         }),
                   ),
                   Consumer<DonationProvider>(builder: (context, value, child) {
                     return TextFormField(
                       controller: value.transactionID,
                       decoration: InputDecoration(
                         contentPadding:
                         const EdgeInsets.symmetric(horizontal: 10),
                         fillColor: myGray2,
                         filled: true,
                         focusedBorder: OutlineInputBorder(
                           borderSide: const BorderSide(color: myGray2),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         enabledBorder: UnderlineInputBorder(
                           borderSide: const BorderSide(color: myGray2),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         errorBorder: UnderlineInputBorder(
                           borderSide: const BorderSide(color: myGray2),
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                       validator: (name) => name != '' &&
                           (name!.toLowerCase() == item.id.toLowerCase() ||
                               name.toLowerCase() ==
                                   newString(item.id.toLowerCase(), 4) ||
                               (value.phonePinWard == 'ON' &&
                                   name.toLowerCase() ==
                                       item.phoneNumber.toLowerCase()))
                           ? null
                           : 'Please Enter Valid Transaction ID',
                     );
                   }),
                   // const Padding(
                   //   padding: EdgeInsets.symmetric(vertical: 5),
                   //   child: Text(
                   //     'Booth',
                   //     style: TextStyle(fontSize: 14),
                   //   ),
                   // ),
                   // Consumer<DonationProvider>(builder: (context, value, child) {
                   //   return Autocomplete<WardModel>(
                   //     optionsBuilder: (TextEditingValue textEditingValue) {
                   //       return (value.wards + value.newWards)
                   //           .where((WardModel wardd) =>
                   //               wardd.booth.toLowerCase().contains(
                   //                   textEditingValue.text.toLowerCase()) ||
                   //               wardd.mandalam.toLowerCase().contains(
                   //                   textEditingValue.text.toLowerCase()))
                   //           .toList();
                   //     },
                   //     displayStringForOption: (WardModel option) =>
                   //         option.booth,
                   //     fieldViewBuilder: (BuildContext context,
                   //         TextEditingController fieldTextEditingController,
                   //         FocusNode fieldFocusNode,
                   //         VoidCallback onFieldSubmitted) {
                   //       return TextFormField(
                   //         decoration: InputDecoration(
                   //           contentPadding:
                   //               const EdgeInsets.symmetric(horizontal: 10),
                   //           hintText: 'Select Booth',
                   //           suffixIcon: const Icon(Icons.arrow_drop_down),
                   //           hintStyle: blackPoppinsR12,
                   //           filled: true,
                   //           fillColor: myLightWhiteNewUI,
                   //           border: OutlineInputBorder(
                   //             borderSide: const BorderSide(color: myGray2),
                   //             borderRadius: BorderRadius.circular(10),
                   //           ),
                   //           enabledBorder: OutlineInputBorder(
                   //             borderSide: const BorderSide(color: myGray2),
                   //             borderRadius: BorderRadius.circular(10),
                   //           ),
                   //           focusedBorder: OutlineInputBorder(
                   //             borderSide: const BorderSide(color: myGray2),
                   //             borderRadius: BorderRadius.circular(10),
                   //           ),
                   //         ),
                   //         validator: (name) => name == '' ||
                   //                 !(value.wards + value.newWards)
                   //                     .map((e) => e.booth)
                   //                     .contains(name)
                   //             ? 'Please Enter Valid Booth Name'
                   //             : null,
                   //         controller: fieldTextEditingController,
                   //         focusNode: fieldFocusNode,
                   //         style: const TextStyle(fontWeight: FontWeight.bold),
                   //       );
                   //     },
                   //     onSelected: (WardModel selection) {
                   //       value.selectPinWard(selection);
                   //     },
                   //     optionsViewBuilder: (BuildContext context,
                   //         AutocompleteOnSelected<WardModel> onSelected,
                   //         Iterable<WardModel> options) {
                   //       return Align(
                   //         alignment: Alignment.topLeft,
                   //         child: Material(
                   //           child: Container(
                   //             width: MediaQuery.of(context).size.width / 1.5,
                   //             height: 200,
                   //             color: Colors.white,
                   //             child: ListView.builder(
                   //               padding: const EdgeInsets.all(10.0),
                   //               itemCount: options.length,
                   //               itemBuilder: (BuildContext context, int index) {
                   //                 final WardModel option =
                   //                     options.elementAt(index);
                   //
                   //                 return GestureDetector(
                   //                   onTap: () {
                   //                     onSelected(option);
                   //                   },
                   //                   child: SizedBox(
                   //                     height: 50,
                   //                     child: Column(
                   //                         crossAxisAlignment:
                   //                             CrossAxisAlignment.start,
                   //                         children: [
                   //                           Text(option.booth,
                   //                               style: const TextStyle(
                   //                                   fontWeight:
                   //                                       FontWeight.bold)),
                   //                           Text(option.mandalam),
                   //                           const SizedBox(height: 10)
                   //                         ]),
                   //                   ),
                   //                 );
                   //               },
                   //             ),
                   //           ),
                   //         ),
                   //       );
                   //     },
                   //   );
                   // }),

                   // const Padding(
                   //   padding: EdgeInsets.symmetric(vertical: 5),
                   //   child: Text(
                   //     'Select Assembly',
                   //     style: TextStyle(fontSize: 14),
                   //   ),
                   // ),
                   // Consumer<DonationProvider>(builder: (context, value, child) {
                   //   return Autocomplete<AssemblyModel>(
                   //     optionsBuilder: (TextEditingValue textEditingValue) {
                   //       return (value.assemblyList)
                   //       // (value.wards+value.newWards).map((e) => PanjayathModel(e.district, e.panchayath)).toSet().toList())
                   //
                   //           .where((AssemblyModel wardd) => wardd.assembly.toLowerCase()
                   //           .contains(textEditingValue.text.toLowerCase()))
                   //           .toList();
                   //     },
                   //     displayStringForOption: (AssemblyModel option) =>
                   //     option.assembly,
                   //     fieldViewBuilder: (BuildContext context,
                   //         TextEditingController fieldTextEditingController,
                   //         FocusNode fieldFocusNode,
                   //         VoidCallback onFieldSubmitted) {
                   //       return TextFormField(
                   //         decoration: InputDecoration(
                   //           contentPadding:
                   //           const EdgeInsets.symmetric(horizontal: 10),
                   //           hintText: 'Select Assembly',
                   //           suffixIcon: const Icon(Icons.arrow_drop_down),
                   //           hintStyle: blackPoppinsR12,
                   //           filled: true,
                   //           fillColor: myLightWhiteNewUI,
                   //           border: OutlineInputBorder(
                   //             borderSide: const BorderSide(color: myGray2),
                   //             borderRadius: BorderRadius.circular(10),
                   //           ),
                   //           enabledBorder: OutlineInputBorder(
                   //             borderSide: const BorderSide(color: myGray2),
                   //             borderRadius: BorderRadius.circular(10),
                   //           ),
                   //           focusedBorder: OutlineInputBorder(
                   //             borderSide: const BorderSide(color: myGray2),
                   //             borderRadius: BorderRadius.circular(10),
                   //           ),
                   //         ),
                   //         validator: (value2) {
                   //           if (value2!.trim().isEmpty || !value.assemblyList.map((item) => item.assembly).contains(value2)) {
                   //             return "Please Select Valid Assembly";
                   //           } else {
                   //             return null;
                   //           }
                   //         },
                   //         controller: fieldTextEditingController,
                   //         focusNode: fieldFocusNode,
                   //         style: const TextStyle(fontWeight: FontWeight.bold),
                   //       );
                   //     },
                   //     onSelected: (AssemblyModel selection) {
                   //       // value.selectPinWard(selection);
                   //       // value.fetchBoothChipset(selection,context);
                   //     },
                   //     optionsViewBuilder: (BuildContext context,
                   //         AutocompleteOnSelected<AssemblyModel> onSelected,
                   //         Iterable<AssemblyModel> options) {
                   //       return Align(
                   //         alignment: Alignment.topLeft,
                   //         child: Material(
                   //           child: Container(
                   //             width: MediaQuery.of(context).size.width / 1.5,
                   //             height: 200,
                   //             color: Colors.white,
                   //             child: ListView.builder(
                   //               padding: const EdgeInsets.all(10.0),
                   //               itemCount: options.length,
                   //               itemBuilder: (BuildContext context, int index) {
                   //                 final AssemblyModel option =
                   //                 options.elementAt(index);
                   //
                   //                 return GestureDetector(
                   //                   onTap: () {
                   //                     onSelected(option);
                   //                   },
                   //                   child: SizedBox(
                   //                     height: 50,
                   //                     child: Column(
                   //                         crossAxisAlignment:
                   //                         CrossAxisAlignment.start,
                   //                         children: [
                   //                           Text(option.assembly,
                   //                               style: const TextStyle(
                   //                                   fontWeight:
                   //                                   FontWeight.bold)),
                   //                           Text(option.district),
                   //                           const SizedBox(height: 10)
                   //                         ]),
                   //                   ),
                   //                 );
                   //               },
                   //             ),
                   //           ),
                   //         ),
                   //       );
                   //     },
                   //   );
                   // }),
                   const Padding(
                     padding: EdgeInsets.symmetric(vertical: 5),
                     child: Text(
                       'Select Unit',
                       style: TextStyle(fontSize: 14),
                     ),
                   ),

                   Consumer<DonationProvider>(builder: (context, value, child) {
                     return Autocomplete<WardModel>(
                       optionsBuilder: (TextEditingValue textEditingValue) {
                         return (value.wards + value.newWards)
                         // (value.wards+value.newWards).map((e) => PanjayathModel(e.district, e.panchayath)).toSet().toList())

                             .where((WardModel wardd) =>
                         wardd.wardName.toLowerCase().contains(
                             textEditingValue.text.toLowerCase()) ||
                             wardd.panchayath.toLowerCase().contains(
                                 textEditingValue.text.toLowerCase()))
                             .toList();
                       },
                       displayStringForOption: (WardModel option) =>
                       option.wardName,
                       fieldViewBuilder: (BuildContext context,
                           TextEditingController fieldTextEditingController,
                           FocusNode fieldFocusNode,
                           VoidCallback onFieldSubmitted) {
                         return TextFormField(
                           decoration: InputDecoration(
                             contentPadding:
                             const EdgeInsets.symmetric(horizontal: 10),
                             hintText: 'Select Unit  ',
                             suffixIcon: const Icon(Icons.arrow_drop_down),
                             hintStyle: blackPoppinsR12,
                             filled: true,
                             fillColor: myLightWhiteNewUI,
                             border: OutlineInputBorder(
                               borderSide: const BorderSide(color: myGray2),
                               borderRadius: BorderRadius.circular(10),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderSide: const BorderSide(color: myGray2),
                               borderRadius: BorderRadius.circular(10),
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderSide: const BorderSide(color: myGray2),
                               borderRadius: BorderRadius.circular(10),
                             ),
                           ),
                           validator: (name) => name == '' ||
                               !(value.wards + value.newWards)
                                   .map((e) => e.wardName)
                                   .contains(name)
                               ? 'Please Enter Valid Unit Name'
                               : null,
                           controller: fieldTextEditingController,
                           focusNode: fieldFocusNode,
                           style: const TextStyle(fontWeight: FontWeight.bold),
                         );
                       },
                       onSelected: (WardModel selection) {
                         value.selectPinWard(selection);
                         // value.onSelectWard(selection);
                       },
                       optionsViewBuilder: (BuildContext context,
                           AutocompleteOnSelected<WardModel> onSelected,
                           Iterable<WardModel> options) {
                         return Align(
                           alignment: Alignment.topLeft,
                           child: Material(
                             child: Container(
                               width: MediaQuery.of(context).size.width / 1.5,
                               height: 200,
                               color: Colors.white,
                               child: ListView.builder(
                                 padding: const EdgeInsets.all(10.0),
                                 itemCount: options.length,
                                 itemBuilder: (BuildContext context, int index) {
                                   final WardModel option =
                                   options.elementAt(index);

                                   return GestureDetector(
                                     onTap: () {
                                       onSelected(option);
                                     },
                                     child: Container(
                                       height: 60,
                                       color: Colors.white,
                                       // width: MediaQuery.of(context).size.width / 1.5,
                                       child: Column(
                                           crossAxisAlignment:
                                           CrossAxisAlignment.start,
                                           children: [
                                             Text(option.wardName,
                                                 style: const TextStyle(
                                                     fontWeight:
                                                     FontWeight.bold)),
                                             Text(option.panchayath),
                                             const SizedBox(height: 10)
                                           ]),
                                     ),
                                   );
                                 },
                               ),
                             ),
                           ),
                         );
                       },
                     );
                   }),

                   Align(
                     alignment: Alignment.bottomCenter,
                     child: Padding(
                       padding: const EdgeInsets.only(top: 20),
                       child: InkWell(
                         onTap: () async {
                           final FormState? form = _formKey.currentState;
                           if (form!.validate()) {
                             finish(context);
                             DonationProvider donationProvider =
                             Provider.of<DonationProvider>(context,
                                 listen: false);
                             donationProvider.addPinWard(
                                 context, item.time, item.id, item.amount, item);
                             HomeProvider homeProvider =
                             Provider.of<HomeProvider>(context,
                                 listen: false);
                             homeProvider.fetchReceiptListForMonitorApp(50);
                           }
                         },
                         child: Container(
                           decoration: BoxDecoration(
                             gradient: const LinearGradient(
                                 begin: Alignment.topLeft,
                                 end: Alignment.bottomRight,
                                 colors: [cl0EA3A9,cl3686C5
                                 ]),
                             borderRadius: BorderRadius.circular(10),
                           ),
                           width: 130,
                           height: 50,
                           alignment: Alignment.center,
                           child: Text(
                             'Change Unit',
                             style: whitePoppinsBoldM15,
                           ),
                         ),
                       ),
                       // TextButton(
                       //   style: ButtonStyle(
                       //     foregroundColor:
                       //         MaterialStateProperty.all<Color>(myWhite),
                       //     backgroundColor:
                       //         MaterialStateProperty.all<Color>(myGreen),
                       //     shape:
                       //         MaterialStateProperty.all<RoundedRectangleBorder>(
                       //       RoundedRectangleBorder(
                       //         borderRadius: BorderRadius.circular(10.0),
                       //         side: const BorderSide(
                       //           color: myGreen,
                       //           width: 2.0,
                       //         ),
                       //       ),
                       //     ),
                       //     padding: MaterialStateProperty.all(
                       //         const EdgeInsets.symmetric(
                       //             vertical: 15, horizontal: 30)),
                       //   ),
                       //   onPressed: () async {
                       //     final FormState? form = _formKey.currentState;
                       //     if (form!.validate()) {
                       //       finish(context);
                       //       DonationProvider donationProvider =
                       //           Provider.of<DonationProvider>(context,
                       //               listen: false);
                       //       donationProvider.addPinWard(
                       //           item.time, item.id, item.amount, item);
                       //     }
                       //   },
                       //   child: Text(
                       //     'Pin Ward',
                       //     style: white16,
                       //   ),
                       // ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         );
       },
     );
   }


  getDate(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

// 12 Hour format:
    var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
    return d12;
  }

   String newString(String oldString, int n) {
     if (oldString.length >= n) {
       return oldString.substring(oldString.length - n);
     } else {
       return '';
       // return whatever you want
     }
   }

   Future<AlertDialog?> beAnEnrollerAlert(BuildContext context,String amount,String PaymentId) {
     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
     return showDialog(
         context: context,
         builder: (BuildContext context) {
           return AlertDialog(
               title: const Center(
                 child: Text("*"+"സേവ് ചെയ്ത് കഴിഞ്ഞാൽ Volunteer ഡീറ്റെയിൽസ് പിന്നീട് മാറ്റം വരുത്താൻ കഴിയുകയില്ല ",
                   style: TextStyle(color: myRed,fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
               ),
               backgroundColor: myWhite,
               contentPadding: const EdgeInsets.only(
                 top: 10.0,
               ),
               shape: const RoundedRectangleBorder(
                   borderRadius: BorderRadius.all(Radius.circular(12.0))),
               content: Consumer<HomeProvider>(
                   builder: (context,value,child) {
                     return Container(
                         width: 400,
                         padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
                         decoration: const BoxDecoration(
                             color: myWhite,
                             borderRadius:
                             BorderRadius.vertical(bottom: Radius.circular(10))),
                         child: SingleChildScrollView(
                             child: Form(
                               key: _formKey,
                               child: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.symmetric(vertical:5),
                                       child: SizedBox(
                                         height: 68,
                                         child: TextFormField(
                                             controller: value.addEntrollerPhoneCT,
                                             maxLength: 10,
                                             keyboardType: TextInputType.number,
                                             decoration: InputDecoration(
                                               labelText: "Volunteer ID",
                                               contentPadding: const EdgeInsets.symmetric(horizontal: 17),
                                               enabledBorder: border2,
                                               focusedBorder: border2,
                                               border: border2,

                                             ),
                                             validator: (text) {
                                               if (text!.isEmpty) {
                                                 return 'Volunteer Id cannot be blank';
                                               } else if (text.length != 10) {
                                                 return 'Volunteer Id Must be 10 letter';
                                               } else {
                                                 return null;
                                               }
                                             }
                                         ),
                                       ),
                                     ),
                                     Consumer<HomeProvider>(
                                         builder: (context,value3,child) {
                                           return InkWell(
                                             onTap: () async {
                                               final FormState? form = _formKey.currentState;
                                               if(form!.validate()) {
                                                 HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                                                 await homeProvider.enrollerExistCheck(value3.addEntrollerPhoneCT.text.toString());
                                                 if(value3.checkEnrollerExist==false){

                                                   print("Sorry no Volunteer found");
                                                   ScaffoldMessenger.of(context).showSnackBar(
                                                       const SnackBar(backgroundColor: Colors.red,
                                                        content: Text("Volunteer Not Found"),
                                                        duration: Duration(milliseconds: 3000),
                                                   ));

                                                 }else{

                                                   confirmationAlert(context, value3.EnrollerName, value3.addEntrollerPhoneCT.text.toString(),amount,PaymentId,value3.EnrollerPlace);

                                                 }

                                               }








                                             },
                                             child: Container(
                                                 height: 40,
                                                 width: MediaQuery.of(context).size.width * 0.3,
                                                 decoration: const BoxDecoration(
                                                     borderRadius:
                                                     BorderRadius.all(Radius.circular(35)),
                                                     gradient: LinearGradient(
                                                         begin: Alignment.centerLeft,
                                                         end: Alignment.centerRight,
                                                         colors: [cl0EA3A9, cl3686C5,])),
                                                 child: const Center(
                                                   child: Text(
                                                     "Save",
                                                     style: TextStyle(
                                                       color: myWhite,
                                                       fontSize: 14,
                                                       fontWeight: FontWeight.bold,
                                                     ),
                                                   ),
                                                 )),
                                           );
                                         }
                                     ),
                                   ] ),
                             )
                         )
                     );
                   }
               )
           );
         }
     );
   }
   Future<AlertDialog?> confirmationAlert(BuildContext context,String name,String phone,String amount,String paymnetID,String place) {
     MediaQueryData queryData;
     queryData = MediaQuery.of(context);
     var width = queryData.size.width;
     var height = queryData.size.height;
     return showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           title: const Center(
             child: Text("Confirmation",
               style: TextStyle(
                   color: Colors.black
               ),
             ),
           ),
           backgroundColor: myWhite,
           contentPadding: const EdgeInsets.only(
             top: 15.0,
           ),
           shape: const RoundedRectangleBorder(
               borderRadius: BorderRadius.all(Radius.circular(12.0))),
           content: Consumer<HomeProvider>(
               builder: (context,value2,child) {
                 return Container(
                   // width: 400,
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(top: 3),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             SizedBox(
                                 width: 120,
                                 child: Text("Volunteer ID ",style: gray12white,)),
                             Text(": ",style: gray12white,),
                             SizedBox(
                                 width:width/2.8,
                                 child: Text(phone,style: gray16White,)),
                           ],
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 3),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             SizedBox(
                                 width: 120,
                                 child: Text("Volunteer Name ",style: gray12white,)),
                             Text(": ",style: gray12white,),
                             SizedBox(
                                 width:width/2.8,
                                 child: Text(name,style: gray16White,)),
                           ],
                         ),
                       ),

                       Padding(
                         padding: const EdgeInsets.only(top: 5),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             SizedBox(
                                 width: 120,
                                 child: Text("Volunteer Place ",style: gray12white,)),
                             Text(": ",style: gray12white,),
                             SizedBox(
                                 width:width/2.8,
                                 child: Text(place,style: gray16White,)),
                           ],
                         ),
                       ),
                       SizedBox(height: 20,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           InkWell(
                             onTap: () {

                               print(paymnetID+"kkhhkhk");
                               finish(context);
                             },
                             child: Container(
                                 height: 40,
                                 width: 150,
                                 decoration: const BoxDecoration(
                                     borderRadius: BorderRadius.all(Radius.circular(35)),
                                     // color: Color(0xff050066),
                                     gradient: LinearGradient(
                                         begin: Alignment.centerLeft,
                                         end: Alignment.centerRight,
                                         colors: [cl0EA3A9, cl3686C5,])
                                 ),
                                 child: const Center(
                                   child: Text(
                                     "Cancel",
                                     style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 15,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                 )),
                           ),
                           SizedBox(width: 10,),
                           InkWell(
                             onTap: (){
                               HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
                               homeProvider.addToEnrollList(name,phone, amount,paymnetID,place);
                               finish(context);
                               finish(context);
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                 backgroundColor: Colors.blue,
                                 content: Text("Added Successfully."),
                                 duration: Duration(milliseconds: 3000),
                               ));


                             },
                             child: Container(
                                 height: 40,
                                 width: 150,
                                 decoration: const BoxDecoration(
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(35)),
                                     gradient: LinearGradient(
                                         begin: Alignment.centerLeft,
                                         end: Alignment.centerRight,
                                         colors: [cl0EA3A9, cl3686C5,])),
                                 child: const Center(
                                   child: Text(
                                     "Ok",
                                     style: TextStyle(
                                       color: myWhite,
                                       fontSize: 16,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                 )),
                           ),
                         ],
                       ),
                       SizedBox(height: 25,)
                     ],
                   ),
                 );
               }
           ),
         );
       },
     );
   }

   OutlineInputBorder border2= OutlineInputBorder(
       borderSide: const BorderSide(color: myGray2),
       borderRadius: BorderRadius.circular(10));

}
String getAmount(double totalCollection) {
  final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
  String newText1 = formatter.format(totalCollection);
  String newText =
  formatter.format(totalCollection).substring(0, newText1.length - 3);
  return newText;
}