import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quaide_millat/Screens/reciept_page.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cashfree/payment_gateway.dart';
import 'donate_page.dart';
import 'home.dart';
import 'home_screen.dart';

class DonationSuccess extends StatefulWidget {
  @override
  _DonationSuccessState createState() => _DonationSuccessState();
}

class _DonationSuccessState extends State<DonationSuccess> {
  ConfettiController controllerCenter = ConfettiController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);



    Future.delayed(const Duration(seconds: 3), () {
      print(donationProvider.donorStatus.toString()+"11144555");

      if (donationProvider.donorStatus == "Success") {
        print("wise code here");

        callNextReplacement(ReceiptPage(nameStatus: 'YES',), context);



      }
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    // homeProvider.checkInternet(context);
    if (!kIsWeb) {
      return mobile(context, controllerCenter);
    } else {
      return web(context);
    }
  }
}

Widget body(BuildContext context) {
  DonationProvider donationProvider =
      Provider.of<DonationProvider>(context, listen: false);
  MediaQueryData queryData;
  queryData = MediaQuery.of(context);
  var width = queryData.size.width;
  var height = queryData.size.height;
  return SafeArea(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SizedBox(height: 45,),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  // child:
            //       Consumer<HomeProvider>(
            //         builder: (context,value,child) {
            //           return Align(alignment: Alignment.topRight,
            //             child: InkWell(onTap: (){
            //               launch("whatsapp://send?phone=${value.contactNumber}");
            //             },
            //               child:
            //               Card(
            // shape: const RoundedRectangleBorder(
            // borderRadius: BorderRadius.all(Radius.circular(25))),
            //                 elevation: 5,
            //                child:   SizedBox(
            //                  height: height*0.06,width: width*0.35,
            //                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                    children: [
            //                      Image.asset(
            //                           "assets/whatsapIconNew.png",
            //                           scale: 3,
            //                         ),
            //                      const Text( "Get Support",
            //                                  style: TextStyle(color: myBlack3,fontSize: 15),
            //                                ),
            //                    ],
            //                  ),
            //                )
            //               ),
            //             ),
            //           );
            //         }
            //       ),
                ),
                Consumer<DonationProvider>(
                  builder: (context,value,child) {
                    // value.donorStatus = "Success";
                    return value.donorStatus == "Success"?
                    SizedBox(height: height*0.15,):SizedBox(height: height*0.15,);
                  }
                ),
                SizedBox(
                  child: Consumer<DonationProvider>(builder: (context, value, child) {

                    return value.donorStatus == "Success"
                        ? Image.asset(
                            "assets/paymentsucces.gif",
                            scale: 7,
                          )
                        : value.donorStatus == "Failed"
                            ? Image.asset(
                                "assets/paymentfail.gif",
                                scale: 7
                              )
                            : Center(
                              child: const SizedBox(
                               width: 200,
                              height: 200,

                        child: CircularProgressIndicator(color: cl0EA3A9,)),
                            );
                  }),
                ),
              ],
            ),
          ),
          Consumer<DonationProvider>(builder: (context, value, child) {
            return value.donorStatus == "Success"
                ?Column(
                  children: [
                    // const SizedBox(height: 15,),
                    Text("Payment was Successful",
                    style: skyPoppinsBoldM17,
                    textAlign: TextAlign.center,
                   ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text('We have received your payment\nThankyou',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 13,color: cl000000)
                          // TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: KnmFailedtxtColor)
                        ),
                      ],
                    )
                  ],
                ):value.donorStatus == "Failed"
                ?Column(
                  children: [
                    // const SizedBox(height: 10,),
                    const Text('Payment was Failed',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: KnmFailedtxtColor,fontFamily: "Poppins")),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Something went wrong.\n We couldn’t process your payment.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 13,color: cl000000.withOpacity(0.5))
                          // TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: KnmFailedtxtColor)
                        ),
                        const SizedBox(height: 15,),
                        // const Padding(
                        //   padding: EdgeInsets.only(top: 8.0),
                        //   child: Text("₹",style: TextStyle(
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 30,
                        //       color:Colors.black),),
                        // ),
                        // Text(value.donorAmount,style: rupeeBig3,),
                      ],
                    )
                  ],
                ):const SizedBox();
          }),
          // const SizedBox(height: 25,),
        Consumer<DonationProvider>(
          builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10,),
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 25),
                    //   child: Consumer<DonationProvider>(
                    //       builder: (context, value, child) {
                    //         return Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             Row(mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 value.donorStatus == "Failed"?
                    //                 SizedBox()
                    //                 // SizedBox(
                    //                 //   width: 30,
                    //                 //   child: Column(
                    //                 //     children: [
                    //                 //       Image.asset(
                    //                 //         "assets/rupaIcon.png",
                    //                 //         scale: 4,
                    //                 //         color: primary,
                    //                 //       ),
                    //                 //     ],
                    //                 //   ),
                    //                 // )
                    //                     :   SizedBox(
                    //                   width: 30,
                    //                   child: Column(
                    //                     children: [
                    //                       Image.asset(
                    //                         "assets/rs.png",
                    //                         scale: 4,
                    //                         color: Colors.black,
                    //                       ),
                    //                       // SizedBox(height: 10,)
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 value.donorStatus == "Failed"? SizedBox()
                    //                 // Text(
                    //                 //   value.donorAmount,
                    //                 //   style: skyBluePoppinsFailed,
                    //                 // )
                    //                     :Text(
                    //                   value.donorAmount,
                    //                   style: skyBluePoppinsM35New,
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         );
                    //       }),
                    // ),
                    // value.donorStatus == "Failed"?Padding(
                    //   padding: const EdgeInsets.only(top: 13.0),
                    //   child: InkWell(
                    //     onTap: (){
                    //       print("retryworkkk");
                    //       HomeProvider homeProvider =
                    //       Provider.of<HomeProvider>(context, listen: false);
                    //       donationProvider.transactionID.text = DateTime.now().microsecondsSinceEpoch.toString()+generateRandomString(2);
                    //       donationProvider.attempt(value.transactionID.text,homeProvider.appVersion.toString());
                    //       String amount = donationProvider.kpccAmountController.text.toString().replaceAll(',', '');
                    //       String name = donationProvider.nameTC.text;
                    //       String phone = donationProvider.phoneTC.text;
                    //
                    //
                    //       callNext(PaymentGateway(), context);
                    //     },
                    //     child: Container(
                    //       width:248,
                    //       height:46,
                    //       decoration: BoxDecoration(
                    //         gradient: const LinearGradient(
                    //             begin: Alignment.centerLeft,
                    //             end: Alignment.centerRight,
                    //             colors: [cl3655A2,cl19A391]),
                    //         // border: Border.all(color: primary,width: 0.5),
                    //
                    //         borderRadius: BorderRadius.circular(20),
                    //       ),
                    //       alignment: Alignment.center,
                    //       child:const Text(
                    //         'Try Again',
                    //         style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12),
                    //       ),
                    //     ),
                    //   ),
                    // ):const SizedBox(),
                    value.donorStatus == "Failed"?Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: InkWell(
                        onTap: (){
                          callNextReplacement(HomeScreenNew(), context);
                        },
                        child: Container(
                          width:157,
                          height:46,
                          decoration: BoxDecoration(
                            color: cl0EA3A9,
                            // border: Border.all(color: clD8D8D8,width: 1),

                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text("Home",
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Poppins"),),
                          ),
                        ),
                      ),
                    ):
                    SizedBox(),

                    // Text(
                    //   "Details",
                    //   style: blackPoppinsBoldM20,
                    // ),
                    // const SizedBox(height: 20,),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(child: Text("Transaction ID", style: black14New)),
                    //     Text(
                    //       ":  ",
                    //       style: black14New,
                    //     ),
                    //     Expanded(child: Consumer<DonationProvider>(
                    //         builder: (context, value, child) {
                    //           return Text(value.donorID, style: black14New);
                    //         }))
                    //   ],
                    // ),
                    // const SizedBox(height: 10,),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(child: Text("Name", style: black14New)),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 15),
                    //       child: Text(
                    //         ":  ",
                    //         style: black14New,
                    //       ),
                    //     ),
                    //     Expanded(child: Consumer<DonationProvider>(
                    //         builder: (context, value, child) {
                    //           return Text(value.donorName, style: black14New);
                    //         }))
                    //   ],
                    // ),
                    // const SizedBox(height: 10,),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(child: Text("Phone number", style: black14New)),
                    //     Text(
                    //       ":  ",
                    //       style: black14New,
                    //     ),
                    //     Expanded(child: Consumer<DonationProvider>(
                    //         builder: (context, value, child) {
                    //           return Text(value.donorNumber, style: black14New);
                    //         }))
                    //   ],
                    // ),
                    // const SizedBox(height: 10,),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Expanded(child: Text("Unit", style: black14New)),
                    //     Text(
                    //       ":  ",
                    //       style: black14New,
                    //     ),
                    //     Expanded(child: Consumer<DonationProvider>(
                    //         builder: (context, value, child) {
                    //           return Text(value.donorPlace, style: black14New);
                    //         }))
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    ///commented
                    // value.donorStatus == "Failed"
                    // ?Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     InkWell(
                    //       onTap: (){
                    //         value.transactionID.text = DateTime.now().millisecondsSinceEpoch.toString();
                    //         donationProvider.attempt(value.transactionID.text);
                    //         String amount = value.dhothiAmount.toString();
                    //         String name = value.nameTC.text;
                    //         String phone = donationProvider.phoneTC.text;
                    //         donationProvider.upiIntent(
                    //             context, amount, name, phone, value.donorApp);
                    //       },
                    //       child: Container(
                    //         width: 150,
                    //         height: 50,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(30),
                    //           color: myWhite
                    //         ),
                    //         alignment: Alignment.center,
                    //         child:Text(
                    //           'Retry',
                    //           style: blackPoppinsBoldM15,
                    //         ),
                    //       ),
                    //     ),
                    //     // InkWell(
                    //     //   onTap: (){
                    //     //     callNext(DonatePage(), context);
                    //     //   },
                    //     //   child: Container(
                    //     //     width: 150,
                    //     //     height: 50,
                    //     //     decoration: BoxDecoration(
                    //     //         borderRadius: BorderRadius.circular(30),
                    //     //       color: myWhite
                    //     //     ),
                    //     //     alignment: Alignment.center,
                    //     //     child:Text(
                    //     //       'Edit Dhoti',
                    //     //       style: blackPoppinsBoldM15,
                    //     //     ),
                    //     //   ),
                    //     // ),
                    //   ],
                    // )
                    //     :const SizedBox(),
                    // const SizedBox(height: 20,),
                    // InkWell(
                    //   onTap: (){
                    //     if (value.donorStatus == 'Success') {
                    //       callNextReplacement(ReceiptPage(), context);
                    //     }else{
                    //       callNextReplacement(HomeScreen(), context);
                    //     }
                    //   },
                    //   child: Container(
                    //     width: width,
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(30),
                    //       color: myWhite
                    //     ),
                    //     alignment: Alignment.center,
                    //     child:value.donorStatus == "Success"
                    //         ?Text('Done', style: blackPoppinsBoldM15,)
                    //         :value.donorStatus == "Failed"?
                    //     Text('Home', style: blackPoppinsBoldM15,)
                    //         :const SizedBox(),
                    //   )
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              // value.donorStatus == "Success"?
              // InkWell(
              //     onTap: (){
              //       callNextReplacement(ReceiptPage(nameStatus: '',), context);
              //     },
              //     child: Container(
              //         width:248,
              //         height:46,
              //         decoration: BoxDecoration(
              //             gradient: const LinearGradient(
              //                 begin: Alignment.centerLeft,
              //                 end: Alignment.centerRight,
              //                 colors: [cl323A71, cl1177BB]),
              //             border: Border.all(color: primary,width: 0.5),
              //
              //             borderRadius: BorderRadius.circular(20),
              //         ),
              //         alignment: Alignment.center,
              //         child:Text('Get Receipt', style: blackPoppinsBoldM15,)
              //     )
              // ):SizedBox()


              // value.donorStatus == "Failed"
              //     ?Column(
              //   children: [
              //     InkWell(
              //       onTap:(){
              //         callNextReplacement(const HomeScreen(), context);
              //       },
              //       child:
              //       Card(
              //         color: myWhite,
              //         elevation:0,
              //         margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //         shape: const RoundedRectangleBorder(
              //           borderRadius: BorderRadius.only(
              //             bottomLeft: Radius.circular(0),
              //             bottomRight: Radius.circular(0),
              //           ),
              //         ),
              //         child: Container(
              //             width: width,
              //             height: 65,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(30),
              //                 color: myWhite
              //             ),
              //             child: Center(child: Text('Home', style: blackPoppinsBoldM15New,))),),
              //     ),
              //     InkWell(
              //       onTap:(){
              //         value.transactionID.text = DateTime.now().microsecondsSinceEpoch.toString();
              //         donationProvider.attempt(value.transactionID.text);
              //         String amount = value.knmAmountController.text.toString();
              //         String name = value.nameTC.text;
              //         String phone = donationProvider.phoneTC.text;
              //         donationProvider.upiIntent(
              //             context, amount, name, phone, value.donorApp);
              //       },
              //       child: Card(color: myWhite,
              //           elevation:0,
              //           margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //           shape: const RoundedRectangleBorder(
              //             borderRadius: BorderRadius.only(
              //               bottomLeft: Radius.circular(30),
              //               bottomRight: Radius.circular(30),
              //             ),
              //           ),
              //           child: Container(
              //             width: width,
              //             height: 65,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(30),
              //                 color: myWhite
              //             ),
              //             alignment: Alignment.center,
              //             child:Text(
              //               'Retry',
              //               style: blackPoppinsBoldM15New,
              //             ),
              //
              //           )),
              //     )
              //   ],
              // ):const SizedBox();

            ],
          );
        })
        ],
      ),
    ),
  );
}

Widget mobile(BuildContext context, ConfettiController controllerCenter) {
  return WillPopScope(
    onWillPop: () async {
      return false;
    },
    child: Builder(builder: (context) {
      MediaQueryData queryData;
      queryData = MediaQuery.of(context);
      var width = queryData.size.width;
      var height = queryData.size.height;
      DonationProvider donationProvider =
      Provider.of<DonationProvider>(context, listen: false);
      return SafeArea(
        child: Scaffold(
          appBar:   PreferredSize(
            preferredSize: const Size.fromHeight(84),
            child: AppBar(
              // actions: [Icon(Icons.qr_code)],
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 5,
              shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
              flexibleSpace: Container(
                height: height*0.12,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(17),bottomRight:  Radius.circular(17))

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [

                    Text('Payment Status',style: wardAppbarTxt),

                  ],),
              ),

            ),
          ),
          backgroundColor: donationProvider.donorStatus == "Success"
              ?Colors.white
          :donationProvider.donorStatus == "Failed"
              ? Colors.white:Colors.white,
          body: body(context),
        ),
      );
    }),
  );
}

Widget web(BuildContext context) {
  MediaQueryData queryData;
  queryData = MediaQuery.of(context);
  var width = queryData.size.width;
  DonationProvider donationProvider =
      Provider.of<DonationProvider>(context, listen: false);
  return Stack(
    children: [
      Center(
          child: queryData.orientation == Orientation.portrait
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width,
                      child: Scaffold(
                        backgroundColor: myGreen,
                        body: body(context),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width / 3,
                      child: Scaffold(
                        backgroundColor: myGreen,
                        body: body(context),
                      ),
                    ),
                  ],
                ))
    ],
  );
}

Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}
