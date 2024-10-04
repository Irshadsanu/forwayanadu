import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/gradientTextClass.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import 'donate_page.dart';

class NewPaymentGatewayScreen extends StatefulWidget {
  String id,gpayLink,phonePeLink,payTmLink;
  NewPaymentGatewayScreen({Key? key, required this.id,required this.gpayLink,required this.phonePeLink,required this.payTmLink}) : super(key: key);

  @override
  State<NewPaymentGatewayScreen> createState() =>
      _NewPaymentGatewayScreenState();
}

class _NewPaymentGatewayScreenState extends State<NewPaymentGatewayScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    donationProvider.listenForPayment(
        donationProvider.transactionID.text.toString(), context);
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   // actions: [Icon(Icons.qr_code)],
          //   automaticallyImplyLeading: false,
          //   // leading: Icon(Icons.arrow_back_ios_outlined),
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          //   // title: Center(child: Text('My Contribution')),
          //   flexibleSpace: Center(
          //     child: Container(
          //       height: 100,
          //       decoration: BoxDecoration(
          //         color:cl3655A2,
          //         // gradient: LinearGradient(
          //         //     begin: Alignment.topCenter,
          //         //     end: Alignment.bottomCenter,-
          //         //     colors: [Colors.red, Colors.red]),
          //         //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:  Radius.circular(30))
          //       ),
          //       child: Padding(
          //         padding: const EdgeInsets.only(top: 30),
          //         child: Row(
          //           children: [
          //             SizedBox(
          //               width: width * 0.03,
          //             ),
          //             InkWell(
          //                 onTap: () {
          //                   callNextReplacement(DonatePage(), context);
          //                 },
          //                 child: const Icon(
          //                   Icons.arrow_back_ios_outlined,
          //                   color: Colors.white,
          //                 )),
          //             SizedBox(
          //               width: width * 0.2,
          //             ),
          //
          //             const Text(
          //               'PAYMENT METHOD',
          //               style: TextStyle(
          //                   fontFamily: "PoppinsLight",
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: 18,
          //                   color: Colors.white),
          //             ),
          //             // SizedBox(width: width*0.2,),
          //
          //             // Image.asset(
          //             //   "assets/help2.png",color: myWhite,scale: 4,
          //             // ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<DonationProvider>(builder: (context, value, child) {
                  return Screenshot(
                    controller: screenshotController,
                    child: InkWell(
                      onTap: () {
                        donationProvider.launchUrlUPI(context, Uri.parse(widget.id));
                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              height: 600,
                              width: width,
                              decoration: const BoxDecoration(
                               // gradient: LinearGradient(colors: [
                               //   Color(0xFF0191D7),
                               //   Color(0xFF00A5E3),
                               // ]),
                                image: DecorationImage(
                                  image: AssetImage("assets/qrCodeBg.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    height: 70,
                                    decoration: const BoxDecoration(
                                        color: cl3556A8,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x11000000),
                                          blurRadius: 5.10,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        )
                                      ]
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              callNextReplacement(DonatePage(), context);
                                            },
                                            child: const Icon(Icons.arrow_back_ios_new,color: myWhite,)),

                                        const Text(
                                          'PAYMENT METHOD',
                                          style: TextStyle(
                                              fontFamily: "PoppinsLight",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),

                                        const SizedBox()
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 125.0),
                                    child: Consumer<DonationProvider>(
                                        builder: (context, value, child) {
                                          return Text(
                                            '₹${value.kpccAmountController.text.toString()}',
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 35,
                                                color:myWhite
                                            ),
                                          );
                                        }),
                                  ),
                                  Consumer<DonationProvider>(
                                      builder: (context, value, child) {
                                        return Container(
                                          height: 40,
                                          width: width*.70,
                                          // color: Colors.red,
                                          child: Text(
                                            value.nameTC.text.toString(),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: myWhite,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        );
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    width: 170,
                                    height: 170,
                                    // child: QrImage(
                                    //   data: widget.id,
                                    //   version: QrVersions.auto,
                                    //   size: 200.0,
                                    // ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Scan or Share',
                                    style: TextStyle(
                                      color: myWhite,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  // Text(
                                  //   "Scan or Share",
                                  //   style: TextStyle(
                                  //       fontSize: 10, color: Colors.grey.shade400),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Scan and await your receipt"),
                    const SizedBox(
                      width: 5,
                    ),
                    const SizedBox(
                        width: 10, height: 10, child: CircularProgressIndicator())
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                InkWell(
                  onTap: () {
                    donationProvider.createQrImage('Send', "test", screenshotController);
                  },
                  child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.85,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:  cl3556A8,
                        //   gradient: LinearGradient(
                        //       begin: Alignment.topCenter,
                        //       end: Alignment.bottomCenter,
                        //       colors: [Colors.red, Colors.red]),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          const Text(
                            'Share',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                  ),
                ),
                 SizedBox(
                  height:Platform.isIOS?0: 30,
                ),

                Consumer<DonationProvider>(
                  builder: (context,va,_) {
                    return  Platform.isIOS&&va.androidGooglePayButton == "ON"||va.iosPaytmPayButton == "ON"? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Other Payments',
                          style: TextStyle(
                              fontFamily: "PoppinsLight",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ),
                    ):SizedBox();
                  }
                ),

                Consumer<DonationProvider>(builder: (context, val3, child) {
                  return Platform.isAndroid?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      val3.androidGooglePayButton == "ON"
                          ? InkWell(
                        onTap: () {
                          _launchUrlUPI(context, Uri.parse(widget.gpayLink));
                        },
                        child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  blurRadius: 12.0),
                            ], shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                                child: Image.asset(
                                  "assets/gpayIphone.png",
                                  scale: 1.4,
                                ))),
                      )
                          : const SizedBox(),
                      const SizedBox(
                        width: 25,
                      ),
                      val3.androidPhonePayButton == "ON"
                          ? InkWell(
                        onTap: () {
                          _launchUrlUPI(context, Uri.parse(widget.phonePeLink));
                        },
                        child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  blurRadius: 12.0),
                            ], shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: Image.asset(
                                "assets/PhonepayIphone.png",
                                scale: 1.4,
                              ),
                            )),
                      )
                          : const SizedBox(),
                      const SizedBox(
                        width: 25,
                      ),
                      val3.androidPaytmPayButton == "ON"
                          ? InkWell(
                        onTap: () {
                          _launchUrlUPI(context, Uri.parse(widget.payTmLink));
                        },
                        child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  blurRadius: 12.0),
                            ], shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: Image.asset(
                                "assets/paytm.png",
                                scale: 1.4,
                              ),
                            )),
                      )
                          : const SizedBox(),
                    ],
                  ):
                  Platform.isIOS?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      val3.iosGooglePayButton == "ON"
                          ? InkWell(
                        onTap: () {
                          _launchUrlUPI(context, Uri.parse(widget.gpayLink));
                        },
                        child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  blurRadius: 12.0),
                            ], shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                                child: Image.asset(
                                  "assets/gpayIphone.png",
                                  scale: 1.4,
                                ))),
                      )
                          : const SizedBox(),
                      const SizedBox(
                        width: 25,
                      ),
                      val3.iosPhonePayButtonNew == "ON"
                          ? InkWell(
                        onTap: () {
                          _launchUrlUPI(context, Uri.parse(widget.phonePeLink));
                        },
                        child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  blurRadius: 12.0),
                            ], shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: Image.asset(
                                "assets/PhonepayIphone.png",
                                scale: 1.4,
                              ),
                            )),
                      )
                          : const SizedBox(),
                      const SizedBox(
                        width: 25,
                      ),
                      val3.iosPaytmPayButton == "ON"
                          ? InkWell(
                        onTap: () {
                          _launchUrlUPI(context, Uri.parse(widget.payTmLink));
                        },
                        child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  blurRadius: 12.0),
                            ], shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: Image.asset(
                                "assets/paytm.png",
                                scale: 1.4,
                              ),
                            )),
                      )
                          : const SizedBox(),
                    ],
                  ):SizedBox();
                }),
                // Consumer<DonationProvider>(builder: (context, value, child) {
                //   return InkWell(
                //     onTap: () {
                //       donationProvider.launchUrlUPI(context, Uri.parse(widget.id));
                //     },
                //     child: Card(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(80),
                //         //set border radius more than 50% of height and width to make circle
                //       ),
                //       margin:
                //       const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                //       child: Container(
                //         height: 50,
                //         alignment: Alignment.center,
                //         padding:
                //         const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Text(
                //               'Other Apps',
                //               style: black16,
                //             ),
                //             const SizedBox(
                //               width: 10,
                //             ),
                //             Image.asset(
                //               'assets/phonepay.png',
                //               scale: 4,
                //             ),
                //             const SizedBox(
                //               width: 7,
                //             ),
                //             Image.asset(
                //               'assets/gpay.png',
                //               scale: 6,
                //             ),
                //             const SizedBox(
                //               width: 7,
                //             ),
                //             Image.asset(
                //               'assets/sbi.png',
                //               scale: 6,
                //             ),
                //             const SizedBox(
                //               width: 7,
                //             ),
                //             Image.asset(
                //               'assets/paytm.png',
                //               scale: 5,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   );
                // }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _launchUrlUPI(BuildContext context, Uri _url) async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  } else {
    // callNext(PaymentGateway(), context);
  }
}
