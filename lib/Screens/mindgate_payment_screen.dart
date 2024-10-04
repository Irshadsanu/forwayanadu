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
import '../providers/home_provider.dart';

class MindGatePaymentScreen extends StatefulWidget {
  String id;
  MindGatePaymentScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<MindGatePaymentScreen> createState() =>
      _MindGatePaymentScreenState();
}

class _MindGatePaymentScreenState extends State<MindGatePaymentScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    print(width.toString()+'aasswww');
    print(height.toString());

    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    donationProvider.listenForPayment(
        donationProvider.transactionID.text.toString(), context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(84),
        child: AppBar(
          // actions: [Icon(Icons.qr_code)],
          automaticallyImplyLeading: false,
          leadingWidth: 55,
          leading:   InkWell(
              onTap: () {
                finish(context);
              },
              child:  CircleAvatar(
                  radius: 14,
                  backgroundColor: cl000008.withOpacity(0.05),
                  child: const Icon(Icons.arrow_back_ios_outlined,color: myBlack,)
              )),
              centerTitle: true,
              title: Text("Payment Method",style: wardAppbarTxt,),
              backgroundColor: Colors.white,
             elevation: 0,
             toolbarHeight: height*0.12,
          // title: Center(child: Text('My Contribution')),
          // flexibleSpace: Center(
          //   child: Container(
          //     height: 100,
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [cl1177BB, cl1177BB]),
          //       //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:  Radius.circular(30))
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 20),
          //       child: Row(
          //         children: [
          //           SizedBox(
          //             width: width * 0.03,
          //           ),
          //           InkWell(
          //               onTap: () {
          //                 finish(context);
          //               },
          //               child: const Icon(
          //                 Icons.arrow_back_ios_outlined,
          //                 color: Colors.white,
          //               )),
          //           SizedBox(
          //             width: width * 0.2,
          //           ),
          //
          //           const Text(
          //             'PAYMENT METHOD',
          //             style: TextStyle(
          //                 fontFamily: "PoppinsLight",
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 18,
          //                 color: Colors.white),
          //           ),
          //           // SizedBox(width: width*0.2,),
          //
          //           // Image.asset(
          //           //   "assets/help2.png",color: myWhite,scale: 4,
          //           // ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<DonationProvider>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Screenshot(
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
                            height: 473,
                            width: width,
                            decoration:  BoxDecoration(
                              boxShadow:[
                                BoxShadow(
                                    offset: const Offset(0, 4),
                                    color:cl000000.withOpacity(0.03),
                                    blurRadius:6,
                                    spreadRadius:1
                                )
                              ],
                              image: DecorationImage(
                                image: AssetImage("assets/newQrI.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 145,
                                ),
                                Consumer<DonationProvider>(
                                    builder: (context, value, child) {
                                      return GradientText(
                                        '₹${value.kpccAmountController.text.toString()}',
                                        style: rupeeBig7,
                                        gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [Colors.black, Colors.black]),
                                      );
                                    }),
                                Consumer<DonationProvider>(
                                    builder: (context, value, child) {
                                      return Text(
                                        value.nameTC.text.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      );
                                    }),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  color: Colors.white,
                                  width: 170,
                                  height: 170,
                                  child: QrImageView(
                                    data: widget.id,
                                    version: QrVersions.auto,
                                    size: 200.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2
                                ),
                                Text(
                                  "Scan or Share",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey.shade400),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),




            InkWell(
              onTap: () {
                donationProvider.createQrImage('Send', "test", screenshotController);

              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 1,
                child: Container(
                    height: 50,
                    width: 160,
                    // width: MediaQuery.of(context).size.width * 0.85,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: cl0EA3A9,width: 1),
                        //   gradient: const LinearGradient(
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //       colors: [cl0EA3A9, cl3686C5,]),
                        borderRadius: BorderRadius.circular(15)),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/QR.png",scale: 3,),
                        const Text(
                          'Share Qr',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold),
                        ),
                        Image.asset("assets/shareIcon.png",scale: 3,),

                      ],
                    )),
              ),
            ),

            // const SizedBox(
            //   height: 20,
            // ),
            //
            // Consumer<DonationProvider>(builder: (context, val3, child) {
            //   return Platform.isIOS?Column(
            //     children: [
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             val3.iosGPayButton == "ON"
            //                 ? InkWell(
            //               onTap: () {
            //                 var androidGpay =
            //                     "tez://upi/pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=km%20${donationProvider.transactionID.text}&am=${donationProvider.kpccAmountController.text}&cu=INR";
            //                 _launchUrlUPI(context, Uri.parse(androidGpay));
            //               },
            //               child: Container(
            //                   height: 70,
            //                   width: 70,
            //                   decoration: BoxDecoration(boxShadow: [
            //                     BoxShadow(
            //                         color: Colors.grey.withOpacity(.2),
            //                         blurRadius: 12.0),
            //                   ], shape: BoxShape.circle, color: Colors.white),
            //                   child: Center(
            //                       child: Image.asset(
            //                         "assets/gpayIphone.png",
            //                         scale: 1.4,
            //                       ))),
            //             )
            //                 : const SizedBox(),
            //             const SizedBox(
            //               width: 20,
            //             ),
            //             val3.iosPhonePayButton == "ON"
            //                 ? InkWell(
            //               onTap: () {
            //                 var androidPhonepe =
            //                     "phonepe://upi/pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=km%20${donationProvider.transactionID.text}&am=${donationProvider.kpccAmountController.text}&cu=INR";
            //                 _launchUrlUPI(context, Uri.parse(androidPhonepe));
            //               },
            //               child: Container(
            //                   height: 70,
            //                   width: 70,
            //                   decoration: BoxDecoration(boxShadow: [
            //                     BoxShadow(
            //                         color: Colors.grey.withOpacity(.2),
            //                         blurRadius: 12.0),
            //                   ], shape: BoxShape.circle, color: Colors.white),
            //                   child: Center(
            //                     child: Image.asset(
            //                       "assets/PhonepayIphone.png",
            //                       scale: 1.4,
            //                     ),
            //                   )),
            //             )
            //                 : SizedBox(),
            //           ],
            //         ),
            //       ),
            //       const SizedBox(
            //         height: 10,
            //       ),
            //     ],
            //   ):SizedBox(height: 20,);
            // }),
            //

            Consumer<DonationProvider>(builder: (context, value, child) {
              return Platform.isIOS? Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: (){
                      HomeProvider homeProvider =
                      Provider.of<HomeProvider>(context, listen: false);
                      donationProvider.attempt3(donationProvider.transactionID.text, homeProvider.appVersion.toString());

                      var androidGpay =
                          "tez://upi/pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=km${homeProvider.appVersion.toString()}%20${donationProvider.transactionID.text}&am=${donationProvider.kpccAmountController.text}&cu=INR";
                      _launchUrlUPI(context, Uri.parse(androidGpay));
                    },
                    child: Card(
                      color: myWhite,
                      margin:const EdgeInsets.symmetric(horizontal: 30),
                      shape:  RoundedRectangleBorder(
                        side:  BorderSide(color: cl0EA3A9,width:1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        // width: width * .85,
                        // height: 60,
                        alignment: Alignment.center,
                        // decoration: ShapeDecoration(
                        //     color: Colors.white,
                        //     shape: RoundedRectangleBorder(
                        //       side: const BorderSide(color: cl706a77,width: 0.1),
                        //       borderRadius: BorderRadius.circular(12),
                        //     )),
                        // margin: EdgeInsets.symmetric(horizontal: 30),
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
                              children: [
                                Image.asset(
                                  'assets/gpayNew.png',
                                  scale: 4.8,
                                ),
SizedBox(width: 8,),
                                Text(
                                  'Google Pay',
                                  style: black16,
                                ),
                              ],
                            ),

                            Image.asset("assets/arrow.png",scale:5,color: cl0EA3A9,),


                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ):SizedBox(
                height: 10,
              );
            }),


            Consumer<DonationProvider>(builder: (context, value, child) {
              return InkWell(
                onTap: (){
                  HomeProvider homeProvider =
                  Provider.of<HomeProvider>(context, listen: false);
                  donationProvider.attempt3(donationProvider.transactionID.text, homeProvider.appVersion.toString());

                  donationProvider.launchUrlUPI(context, Uri.parse(widget.id));
                },
                child: Card(
                  color: myWhite,
                  margin:const EdgeInsets.symmetric(horizontal: 30),
                  shape:  RoundedRectangleBorder(
                    side:  BorderSide(color: cl0EA3A9,width:1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    // width: width * .85,
                    // height: 60,
                    alignment: Alignment.center,
                    // decoration: ShapeDecoration(
                    //     color: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //       side: const BorderSide(color: cl706a77,width: 0.1),
                    //       borderRadius: BorderRadius.circular(12),
                    //     )),
                    // margin: EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              'Select UPI Apps',
                              style: black16,
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                SizedBox(width: 15,),
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


                                // Image.asset(
                                //   'assets/sbi.png',
                                //   scale: 5.3,
                                // ),
                                // SizedBox(
                                //   width: 7,
                                // ),

                              ],
                            )
                          ],
                        ),
                        Image.asset("assets/arrow.png",scale:5,color: cl0EA3A9,),
                      ],
                    ),
                  ),
                ),
              );
            }),




            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  width: width/1.2,
                  child: Column(
                    children: [
                       Text("Make payment and wait until you get confirmation",style: TextStyle(fontSize: width/32.72),),
                       Text("പേയ്മെൻ്റ് നടത്തി സ്ഥിരീകരണം ലഭിക്കുന്നതുവരെ കാത്തിരിക്കുക",textAlign: TextAlign.center,style: TextStyle(fontSize: width/32.72, ),),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                          width: 10, height: 10, child: CircularProgressIndicator())
                    ],
                  ),
                ),


              ],
            ),
            const SizedBox(
              height: 10,
            ),


            SizedBox(height: 50,)
          ],
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
