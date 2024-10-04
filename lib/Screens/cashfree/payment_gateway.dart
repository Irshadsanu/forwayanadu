import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quaide_millat/Screens/mindgate_payment_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import 'package:provider/provider.dart';

class PaymentGateway extends StatelessWidget {
  const PaymentGateway({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    // homeProvider.checkInternet(context);
    DonationProvider donationProvider = Provider.of<DonationProvider>(
        context, listen: false);



    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }
  Widget body(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);

    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(height: 10,),

          Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Consumer<DonationProvider>(
                    builder: (context, value, child) {
                      return Container(
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:cl036FEB.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("₹",style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 38,
                                color:cl3686C5),),
                            Text(
                              value.kpccAmountController.text.toString(),
                              style: rupeeBig3,
                            ),
                          ],
                        ),
                      );
                    }
                ),
              )),
          const SizedBox(height:30,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 12),
                    child: Text(
                      'Payment Options',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color:cl313131,
                        fontWeight: FontWeight.w700
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Consumer<HomeProvider>(
                        builder: (context,value,child) {
                          return Platform.isAndroid&&value.intentOptionNew=="ON"?Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  HomeProvider homeProvider =
                                  Provider.of<HomeProvider>(context, listen: false);
                                  donationProvider.attempt3(donationProvider.transactionID.text, homeProvider.appVersion.toString());

                                  String amount=donationProvider.kpccAmountController.text.toString();
                                  String name=donationProvider.nameTC.text;
                                  String phone=donationProvider.phoneTC.text;
                                  donationProvider.upiIntent(context, amount, name, phone,"GPay",homeProvider.appVersion.toString());
                                },
                                child: Container(
                                    width: 158,
                                    height: 61,
                                    decoration: ShapeDecoration(
                                        color: clfcfcfc,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: cl706a77,width: 0.5),
                                          borderRadius: BorderRadius.circular(60),
                                        )),

                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child:Row(
                                            children: [
                                              Image.asset('assets/gpayNew.png',scale: 4,),
                                              // SizedBox(width: 35,),
                                              const Text(
                                                'Google Pay',
                                                style: TextStyle(
                                                  color: myBlack,
                                                  fontSize: 11.5,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ) ,
                                        ),

                                        SizedBox(width: 2,),

                                        Container(
                                          width:17,
                                          height:10,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),
                                            border:  Border.all(color: cl706a77,width: 0.6),),
                                          child: const Center(
                                            child: Text("UPI",
                                            style: TextStyle(color: Colors.grey,fontSize: 6,fontFamily: "Poppins",fontWeight: FontWeight.w600),),
                                          ),
                                        ),
                                        // Icon(Icons.arrow_forward_ios_outlined,size: 15,),
                                      ],
                                    )),
                              ),

                              SizedBox(width: 5,),

                              InkWell(
                                onTap: () {
                                  HomeProvider homeProvider =
                                  Provider.of<HomeProvider>(context, listen: false);
                                  String amount=donationProvider.kpccAmountController.text.toString();
                                  String name=donationProvider.nameTC.text;
                                  String phone=donationProvider.phoneTC.text;
                                  donationProvider.upiIntent(context, amount, name, phone,"BHIM",homeProvider.appVersion.toString());
                                },
                                child:
                                Container(
                                    width:150,
                                    height: 61,
                                    decoration: ShapeDecoration(
                                        color: clfcfcfc,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: cl706a77,width: 0.5),
                                          borderRadius: BorderRadius.circular(60),
                                        )),
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child:  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child:Row(
                                            children: [
                                              Image.asset('assets/bhim.png',scale: 4.3,),
                                              // SizedBox(width: 15,),
                                              const Text(
                                                'BHIM',
                                                style: TextStyle(
                                                  color: myBlack,
                                                  fontSize: 13,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width:17,
                                          height:10,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),
                                            border:  Border.all(color: cl706a77,width: 0.6),),
                                          child: const Center(
                                            child: Text("UPI",
                                              style: TextStyle(color: Colors.grey,fontSize: 6,fontFamily: "Poppins",fontWeight: FontWeight.w600),),
                                          ),
                                        ),
                                        // Icon(Icons.arrow_forward_ios_outlined,size: 15,),
                                      ],
                                    )

                                ),
                              ),

                            ],
                          ):SizedBox();
                        }
                      ),



                      Consumer<HomeProvider>(
                          builder: (context,value,child) {
                            return value.mindGatePaymentNew=="ON"?Column(
                              children: [
                                SizedBox(height: 30,),
                                // Consumer<DonationProvider>(
                                //     builder: (context,value,child) {
                                //       return InkWell(
                                //         onTap: () {
                                //
                                //           String amount=donationProvider.kpccAmountController.text.toString();
                                //           // String amount="1";
                                //           var string =
                                //           // await donationProvider.encryptQR(
                                //               "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=km%20${donationProvider.transactionID.text}&am=${amount}&cu=INR";
                                //           // );
                                //
                                //           callNext(MindGatePaymentScreen(id:string,), context);
                                //
                                //
                                //         },
                                //         child: Card(
                                //
                                //           shape: RoundedRectangleBorder(
                                //             borderRadius: BorderRadius.circular(30),
                                //             //set border radius more than 50% of height and width to make circle
                                //           ),
                                //
                                //
                                //           child: Container(
                                //             decoration: BoxDecoration(
                                //               borderRadius: BorderRadius.circular(18),
                                //               border: Border.all(color: cl0EA3A9,width: 1),
                                //               color: myWhite
                                //               // gradient:  const LinearGradient(
                                //               //     begin: Alignment.topCenter,
                                //               //     end: Alignment.bottomCenter,
                                //               //     colors: [cl0EA3A9, cl3686C5,]),
                                //             ),
                                //             height: 50,
                                //             alignment: Alignment.center,
                                //             padding: const EdgeInsets.symmetric(
                                //                 vertical: 10, horizontal: 10),
                                //               child: Row(
                                //                 mainAxisAlignment: MainAxisAlignment.center,
                                //                 children: [
                                //                   Image.asset('assets/QR.png',color: myBlack,),
                                //                  const Text(
                                //                     'Scan QR & Pay',
                                //                     style:  TextStyle(
                                //                         fontFamily: 'Poppins',
                                //                         fontSize: 14,
                                //                         color:myBlack
                                //                     ),
                                //                   ),
                                //
                                //
                                //                 ],
                                //               ),
                                //
                                //           ),
                                //         ),
                                //       );
                                //     }
                                // ),
                                // SizedBox(height: 20,),

                                ///payment method1
                                Consumer<DonationProvider>(
                                    builder: (context,val,child) {
                                      return InkWell(
                                        onTap: (){
                                          HomeProvider homeProvider =
                                          Provider.of<HomeProvider>(context, listen: false);
                                          donationProvider.attempt3(donationProvider.transactionID.text, homeProvider.appVersion.toString());


                                          // String amount=donationProvider.kpccAmountController.text.toString();
                                          // // String amount="1";
                                          //
                                          //
                                          // var string =
                                          // // await donationProvider.encryptQR(
                                          //     "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=km%20${donationProvider.transactionID.text}&am=${amount}&cu=INR";
                                          // // );
                                          //
                                          // print(string + " QQQQQQQQQQQ");
                                          // _launchUrlUPI(context, Uri.parse(string));
                                          // donationProvider.listenForPayment(donationProvider.transactionID.text.toString(), context);


                                          String amount=donationProvider.kpccAmountController.text.toString();
                                          // String amount="1";
                                          var string =
                                          // await donationProvider.encryptQR(
                                              "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=km${homeProvider.appVersion.toString()}%20${donationProvider.transactionID.text}&am=${amount}&cu=INR";
                                          // );

                                          callNext(MindGatePaymentScreen(id:string,), context);

                                        },
                                        child: Container(
                                          // height: 50,
                                          alignment: Alignment.center,
                                          decoration: ShapeDecoration(
                                              color: Colors.grey.shade50,
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(color: cl706a77,width: 0.5),
                                                borderRadius: BorderRadius.circular(18),
                                              )),
                                          padding: const EdgeInsets.fromLTRB(14,10,10, 10),
                                          width: width * .86,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    value.method1,
                                                    style: black16,
                                                  ),
                                                  SizedBox(height: 7,),
                                                  Row(
                                                    children: [


                                                      Image.asset(
                                                        'assets/gpay.png',
                                                        scale: 4.3,
                                                      ),
                                                      const SizedBox(
                                                        width: 7,
                                                      ),
                                                      Image.asset(
                                                        'assets/paytm.png',
                                                        scale: 4.3,
                                                      ),
                                                      const SizedBox(
                                                        width: 7,
                                                      ),
                                                      Image.asset(
                                                        'assets/phonepay.png',
                                                        scale: 3,
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                              Image.asset("assets/arrow.png",scale:5),

                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                ),

                              ],
                            ):SizedBox();
                          }
                      ),
                      SizedBox(height: 30,),

                      ///payment method2
                      Consumer<HomeProvider>(
                        builder: (context,val,child) {
                          return val.eazyPayGateOption=="ON"?Consumer<DonationProvider>(
                              builder: (context,value,child) {
                                return InkWell(
                                  onTap: (){
                                    HomeProvider homeProvider =
                                    Provider.of<HomeProvider>(context, listen: false);
                                    donationProvider.attempt3(donationProvider.transactionID.text, homeProvider.appVersion.toString());

                                    String amount=donationProvider.kpccAmountController.text.toString();
                                    String name=donationProvider.nameTC.text;
                                    String phone=donationProvider.phoneTC.text;
                                    String id=donationProvider.transactionID.text;
                                    donationProvider.eazypayGateway(name,id,phone,amount,context);

                                  },
                                  child: Container(
                                    // height: 50,
                                    alignment: Alignment.center,
                                    decoration: ShapeDecoration(
                                        color: Colors.grey.shade50,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: cl706a77,width: 0.5),
                                          borderRadius: BorderRadius.circular(18),
                                        )),
                                    padding: const EdgeInsets.fromLTRB(14,10,10, 10),
                                    width: width * .86,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              val.method2,
                                              style: black16,
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                Image.asset('assets/card.png',scale:4),
                                                SizedBox(width: 2,),

                                                Image.asset('assets/gpay2.png',scale: 4),
                                                SizedBox(width: 2,),

                                                Image.asset('assets/visa.png', scale:4),
                                                SizedBox(width: 2,),

                                                Image.asset('assets/paytm2.png',scale: 4),
                                                SizedBox(width:2,),

                                                Image.asset('assets/netBanking.png',scale: 4),
                                                SizedBox(width:2,),

                                                Image.asset('assets/icici.png',scale: 4),
                                                SizedBox(width:4,),
                                              ],
                                            ),

                                          ],
                                        ),
                                        Image.asset("assets/arrow.png",scale:5),

                                      ],
                                    ),
                                  ),
                                );
                              }
                          ):SizedBox();
                        }
                      ),

                      SizedBox(height: 30,),
                      ///payment method3
                      Consumer<HomeProvider>(
                          builder: (context,val,child) {
                            return
                              // val.iciciGatewayOption=="ON"&&Platform.isAndroid||Platform.isIOS&&val.iosIciciGatewayOption=="ON"?
                            Consumer<DonationProvider>(
                                builder: (context,value,child) {
                                  return InkWell(
                                    onTap: (){
                                      HomeProvider homeProvider =
                                      Provider.of<HomeProvider>(context, listen: false);
                                      donationProvider.attempt3(donationProvider.transactionID.text, homeProvider.appVersion.toString());

                                      String amount=donationProvider.kpccAmountController.text.toString();
                                      String name=donationProvider.nameTC.text;
                                      String phone=donationProvider.phoneTC.text;
                                      String id=donationProvider.transactionID.text;
                                      donationProvider.icicPaymentIntegration(context, amount, name, phone, donationProvider.transactionID.text);

                                    },
                                    child: Container(
                                      // height: 50,
                                      alignment: Alignment.center,
                                      decoration: ShapeDecoration(
                                          color: Colors.grey.shade50,
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(color: cl706a77,width: 0.5),
                                            borderRadius: BorderRadius.circular(18),
                                          )),
                                      padding: const EdgeInsets.fromLTRB(14,10,10, 10),
                                      width: width * .86,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                val.method3,
                                                style: black16,
                                              ),
                                              SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Image.asset('assets/iciciIcon.png',scale: 12),
                                                  SizedBox(width: 2,),

                                                  Image.asset(
                                                    'assets/gpay.png',
                                                    scale: 4.3,
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  Image.asset(
                                                    'assets/paytm.png',
                                                    scale: 4.3,
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  Image.asset(
                                                    'assets/phonepay.png',
                                                    scale: 3,
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                          Image.asset("assets/arrow.png",scale:5),

                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );
                            // :SizedBox();
                          }
                      ),

                      SizedBox(height: 20,),
                      Container(
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(
                              width: width/1.3,
                              child: Column(
                                children: [
                                  Text("Make payment and wait until you get confirmation",style: TextStyle(fontSize: width/32.72),),
                                  Text("പേയ്മെൻ്റ് നടത്തി സ്ഥിരീകരണം ലഭിക്കുന്നതുവരെ കാത്തിരിക്കുക",textAlign: TextAlign.center,style: TextStyle(fontSize: width/32.72, ),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                      width: 10, height: 10, child: CircularProgressIndicator())
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                      // Consumer<DonationProvider>(
                      //   builder: (context,value,child) {
                      //
                      //     return InkWell(
                      //       onTap: () async {
                      //         DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                      //         String amount=donationProvider.kpccAmountController.text.toString();
                      //
                      //         if(await  donationProvider.intiateIntent(donationProvider.transactionID.text, amount)){
                      //         print("successsssssssssssssss");
                      //
                      //         var string="upi://pay?pa=iumlksd@hdfcbank&pn=INDIAN%UNION%MUSLIM%LEAGUE&mc=6012&tr=${donationProvider.transactionID.text}&mode=04&am=${amount}&cu=INR";
                      //         print(string + " QQQQQQQQQQQ");
                      //         _launchUrlUPI(context, Uri.parse(string));
                      //         donationProvider.listenForPayment(donationProvider.transactionID.text.toString(), context);
                      //
                      //         }
                      //
                      //       },
                      //       child: Container(
                      //         color: Colors.red,
                      //         height: 100,
                      //         width: 100,
                      //
                      //       ),
                      //     );
                      //   }
                      // )







                    ],
                  ),
                ),


              ],
            ),
          ),








        ],
      ),
    );
  }
  

  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:   PreferredSize(
          preferredSize: const Size.fromHeight(84),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            toolbarHeight: height*0.12,
            // shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
            title: Text('Participate Now',style: wardAppbarTxt),
            centerTitle: true,
            leadingWidth: 55,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: InkWell(
                  onTap: (){
                    finish(context);
                  },

                  child: CircleAvatar(
                      radius: 14,
                      backgroundColor: cl000008.withOpacity(0.05),
                      child: const Icon(Icons.arrow_back_ios_outlined,color: myBlack,))),
            ),

          ),
        ),
        body: body(context),
      ),
    );
  }
  Widget web(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    return Stack(
      children: [
        Row(
          children: [
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/KnmWebBacound1.jpg'),fit: BoxFit.cover
                  )
              ),
              child: Row(
                children: [
                  SizedBox(
                      height: height,
                      width: width / 3,
                      child: Image.asset("assets/Grou 2.png",scale: 4,)),
                  SizedBox(
                    height: height,
                    width: width / 3,
                  ),
                  SizedBox(
                      height: height,
                      width: width / 3,
                      child: Image.asset("assets/Grup 3.png",scale: 6,)),
                ],
              ),
            ),


          ],
        ),
        Center(child: queryData.orientation==Orientation.portrait?  Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: width/3,),
            SizedBox(width: width,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: myGreen,
                  centerTitle: true,
                  title: Text(
                    'Payment Method',
                    style: white18,
                  ),
                ),
                body: body(context),
              ),
            ),
            // SizedBox(width: width/3,),
          ],
        ):
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: width/3,),
            SizedBox(width: width/3,
              child: Scaffold(

                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: myGreen,
                  centerTitle: true,
                  title: Text(
                    'Payment Method',
                    style: white18,
                  ),
                ),
                body: body(context),
              ),
            ),
            // SizedBox(width: width/3,),
          ],
        ),)
      ],
    );
  }


  void showLoaderDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) =>
          Center(
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
              ),
            ),
          ),
    );
  }
  Future<void> _launchUrlUPI(BuildContext context, Uri _url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    } else {
      // callNext(PaymentGateway(), context);

    }
  }

}