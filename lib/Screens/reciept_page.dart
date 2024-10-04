import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quaide_millat/Screens/makestatus_type_screen.dart';
import 'package:share_plus/share_plus.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import '../providers/web_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import 'home.dart';
import 'home_screen.dart';
import 'make_status_page.dart';

class ReceiptPage extends StatelessWidget {
  String nameStatus;
  ReceiptPage({Key? key,required this.nameStatus}) : super(key: key);

  ScreenshotController screenshotController = ScreenshotController();

  final LinearGradient _gradient = const LinearGradient(colors: <Color>[
    Colors.yellow,
    Colors.redAccent,
  ]);
  final List<int> amount = [
    10,
    20,
    50,
    100,
    200,
    500,

  ];

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    Future.delayed(const Duration(seconds:4), () async {
      // if (donationProvider.monthlyAmountAlert) {
      //   receiptPageAlert(context);
      //
      // }

    });

    // homeProvider.checkInternet(context);

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
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [

          Card(
            // margin: const EdgeInsets.only(right: 15,left: 15,top: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Consumer<DonationProvider>(builder: (context, value, child) {
              return Screenshot(
                controller: screenshotController,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                          Container(
                            height: 500,
                            width: 375,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                image: AssetImage("assets/receiptImage.jpg"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child:Column(
                              children:[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0,right: 5),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text:
                                              "  Date : ${DateFormat('dd/MM/yyyy, hh:mm a').format(value.donationTime)}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10,
                                                  fontFamily: "Poppins",
                                                  color: Colors.white30)),
                                        ])),
                                  ),
                                ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 165.0),
                                  child: Container(
                                    height: 35,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Color(0XFF00AEEF),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 12.0),
                                          child: Text("RECEIPT",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),),
                                        ),
                                        Container(
                                        width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(25),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF000000).withOpacity(0.2),
                                                  blurRadius: 5,
                                                  // offset: Offset(0, 4),

                                                )
                                              ]
                                          ),
                                          child:  FittedBox(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Text(
                                                      "₹"+value.donorAmount.toString(),
                                                      style: const TextStyle(
                                                        color: myBlack,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize:25,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:EdgeInsets.only(top:53, left:120,),
                                    child:nameStatus=="NO"?const Text(
                                      "അനുഭാവി,",
                                      style: TextStyle(
                                        color: myBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ): Container(
                                      width: 230,
                                      padding: EdgeInsets.only(top: 0,bottom: 4),
                                      // color: Colors.red,
                                      child: Text(
                                       value.donorName.toString()+",",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: myBlack,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ),
                              ),
                  // Positioned(
                  //   bottom:3,left:5,
                  //   child: RichText(
                  //       text: TextSpan(children: [
                  //         TextSpan(
                  //             text:
                  //             "  Date : ${DateFormat('dd/MM/yyyy, hh:mm a').format(value.donationTime)}",
                  //             style: const TextStyle(
                  //                 fontWeight: FontWeight.normal,
                  //                 fontSize: 10,
                  //                 fontFamily: "PoppinsMedium",
                  //                 color: Colors.black54)),
                  //       ])),
                  // ),
                  // Positioned(
                  //   top:height*.26,
                  //   left:width*.27,
                  //   child:nameStatus=="NO"?const Text(
                  //     "അനുഭാവി,",
                  //     style: TextStyle(
                  //       color: myBlack,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 12,
                  //     ),
                  //   ): Container(
                  //     width: 240,
                  //     // color: Colors.red,
                  //     child: Text(
                  //      value.donorName.toString()+",",
                  //       maxLines: 1,
                  //       style: const TextStyle(
                  //         color: myBlack,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 15,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //
                  // Positioned(
                  //   top: height*.19,
                  //   right: width * .33,
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     height: height *.04,
                  //     width: width*.34,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: myWhite,
                  //     ),
                  //     child: FittedBox(
                  //       child: Text(
                  //         "₹"+value.donorAmount.toString(),
                  //         style: const TextStyle(
                  //           color: cl1D9000,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize:30,
                  //         ),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                              ]
                            )
                          ),

                    ],
                  ),
                ),
              );
            }),
          ),

          // Card(
          //   margin:
          //       const EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 5),
          //   elevation: 0,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(15.0),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 15),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.max,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Center(child: Consumer<DonationProvider>(
          //             builder: (context, value, child) {
          //           return Text(
          //             'Paid through ' + value.donorApp,
          //             style: black16,
          //           );
          //         })),
          //       ],
          //     ),
          //   ),
          // ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 15, left: 20),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     children: [
                //       Container(
                //           height: 22,
                //           width: 22,
                //           decoration: const BoxDecoration(
                //               gradient: LinearGradient(colors: [
                //                 buttonGradient,
                //                 buttonGradient1,
                //                 buttonGradient2,
                //               ]),
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(20))),
                //           child: Image.asset(
                //             'assets/Tik.png',
                //             width: 14,
                //             scale: 5,
                //             color: myWhite,
                //           )),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10),
                //         child: Consumer<DonationProvider>(
                //             builder: (context, value, child) {
                //           return Text(
                //             homeProvider.historyList
                //                     .map((item) => item.id)
                //                     .contains(value.donorID)
                //                 ? value.donorID
                //                 : value.donorID.substring(
                //                         0, value.donorID.length - 4) +
                //                     getStar(4),
                //             style: GoogleFonts.montserrat(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 10),
                //           );
                //         }),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 15, left: 20),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisSize: MainAxisSize.max,
                //     children: [
                //       Container(
                //         child: const Icon(
                //           Icons.person,
                //           color: myWhite,
                //           size: 15,
                //         ),
                //         padding: const EdgeInsets.all(3),
                //         decoration: BoxDecoration(
                //             gradient: const LinearGradient(colors: [
                //               buttonGradient,
                //               buttonGradient1,
                //               buttonGradient2,
                //             ]),
                //             borderRadius: BorderRadius.circular(100)),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 10),
                //         child: Consumer<DonationProvider>(
                //             builder: (context, value, child) {
                //           return SizedBox(
                //               width: (width) / 2,
                //               child: nameStatus == "YES"
                //                   ? Text(value.donorName,
                //                       style: GoogleFonts.montserrat(
                //                           color: Colors.black,
                //                           fontWeight: FontWeight.bold,
                //                           fontSize: 10))
                //                   : Text(
                //                       "അനുഭാവി",
                //                       style: GoogleFonts.montserrat(
                //                           color: Colors.black,
                //                           fontWeight: FontWeight.bold,
                //                           fontSize: 10),
                //                     ));
                //         }),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10, left: 20),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     children: [
                //       Container(
                //         child: Image.asset(
                //           mobileIcon,
                //           scale: 3,
                //         ),
                //         height: 22,
                //         width: 22,
                //         // const Icon(
                //         //   Icons.call,
                //         //   color: myWhite,
                //         //   size: 15,
                //         // ),
                //         padding: const EdgeInsets.all(3),
                //         decoration: BoxDecoration(
                //             gradient: const LinearGradient(colors: [
                //               buttonGradient,
                //               buttonGradient1,
                //               buttonGradient2,
                //             ]),
                //             borderRadius: BorderRadius.circular(100)),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10),
                //         child: Consumer<DonationProvider>(
                //             builder: (context, value, child) {
                //           //getStar(5)+value.donorNumber.substring(value.donorNumber.length-5,value.donorNumber.length)
                //           return Text(getPhone(value.donorNumber),
                //               style: GoogleFonts.montserrat(
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 10));
                //         }),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisSize: MainAxisSize.max,
                //     children: [
                //       Container(
                //         child: const Icon(
                //           Icons.location_pin,
                //           color: myWhite,
                //           size: 15,
                //         ),
                //         padding: const EdgeInsets.all(3),
                //         decoration: BoxDecoration(
                //             gradient: const LinearGradient(colors: [
                //               buttonGradient,
                //               buttonGradient1,
                //               buttonGradient2,
                //             ]),
                //             borderRadius: BorderRadius.circular(100)),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 10),
                //         child: Consumer<DonationProvider>(
                //             builder: (context, value, child) {
                //           return SizedBox(
                //               width: (width) / 2,
                //               child: Text(
                //                 value.donorPlace,
                //                 style: GoogleFonts.montserrat(
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 10),
                //               ));
                //         }),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 0, left: 20, bottom: 0),
                //   child: Consumer<DonationProvider>(
                //       builder: (context, value, child) {
                //     return value.donorReceiptPrinted == "Printed"
                //         ? Row(
                //             mainAxisSize: MainAxisSize.max,
                //             children: [
                //               Container(
                //                 child: const Icon(
                //                   Icons.print,
                //                   color: myWhite,
                //                   size: 15,
                //                 ),
                //                 padding: const EdgeInsets.all(3),
                //                 decoration: BoxDecoration(
                //                     gradient: const LinearGradient(colors: [
                //                       buttonGradient,
                //                       buttonGradient1,
                //                       buttonGradient2,
                //                     ]),
                //                     borderRadius: BorderRadius.circular(100)),
                //               ),
                //               Padding(
                //                   padding: const EdgeInsets.symmetric(
                //                       horizontal: 10),
                //                   child: Text("Receipt Printed",
                //                       style: GoogleFonts.montserrat(
                //                           color: Colors.black,
                //                           fontWeight: FontWeight.bold,
                //                           fontSize: 10))),
                //             ],
                //           )
                //         : const SizedBox();
                //   }),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20, bottom: 20),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     children: [
                //       Container(
                //           height: 22,
                //           width: 22,
                //           decoration: const BoxDecoration(
                //               gradient: LinearGradient(colors: [
                //                 buttonGradient,
                //                 buttonGradient1,
                //                 buttonGradient2,
                //               ]),
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(20))),
                //           child: Center(
                //             child: Image.asset(
                //               upiIcon,
                //               scale: 3,
                //               color: white,
                //             ),
                //           )),
                //       // Image.asset('assets/payment.png',scale: 30,),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10),
                //         child: Consumer<DonationProvider>(
                //             builder: (context, value, child) {
                //           return Text(value.donorApp,
                //               style: GoogleFonts.montserrat(
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 10));
                //         }),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              height: 22,
                              width: 22,
                              decoration: const BoxDecoration(
                                color: cl1B9BB2,
                                //   gradient: LinearGradient(
                                //     begin: Alignment.centerLeft,
                                //     end: Alignment.centerRight,
                                //     colors: [
                                //       cl1D9000,
                                //       cl20A200
                                //     ],
                                //   ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20))),
                              child: Image.asset(
                                'assets/Tik.png',
                                scale: 5,
                                color: myWhite,
                              )),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10),
                            child: Consumer<DonationProvider>(
                                builder: (context, value, child) {
                                  return Text(
                                    homeProvider.historyList
                                        .map((item) => item.id)
                                        .contains(value.donorID)
                                        ? value.donorID
                                        : value.donorID.substring(
                                        0, value.donorID.length - 4) +
                                        getStar(4),
                                    style: black12,
                                  );
                                }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            child: const Icon(
                              Icons.phone_iphone_outlined,
                              color: myWhite,
                              size: 15,
                            ),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                               color: cl1B9BB2,
                              //   gradient: const LinearGradient(
                              //     begin: Alignment.centerLeft,
                              //     end: Alignment.centerRight,
                              //     colors: [
                              //       cl1D9000,
                              //       cl20A200
                              //     ],
                              //   ),
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10),
                            child: Consumer<DonationProvider>(
                                builder: (context, value, child) {
                                  //getStar(5)+value.donorNumber.substring(value.donorNumber.length-5,value.donorNumber.length)
                                  return Text(
                                    getPhone(value.donorNumber),
                                    style: black12,
                                  );
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            child: const Icon(
                              Icons.person,
                              color: myWhite,
                              size: 15,
                            ),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                // gradient: const LinearGradient(
                                //   begin: Alignment.centerLeft,
                                //   end: Alignment.centerRight,
                                //   colors: [
                                //     cl1D9000,
                                //     cl20A200
                                //   ],
                                // ),
                                color: cl1B9BB2,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Consumer<DonationProvider>(
                                builder: (context, value, child) {
                                  return Container(
                                    // color: Colors.red,
                                      width: (width) / 2.8,
                                      child: nameStatus == "YES"
                                          ? Text(
                                        value.donorName,
                                        style: black12,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                          : Text(
                                        "അനുഭാവി",
                                        style: black12,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ));
                                }),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            child: const Icon(
                              Icons.location_pin,
                              color: myWhite,
                              size: 15,
                            ),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: cl1B9BB2,
                                // gradient: const LinearGradient(
                                //   begin: Alignment.centerLeft,
                                //   end: Alignment.centerRight,
                                //   colors: [
                                //     cl1D9000,
                                //     cl20A200
                                //   ],
                                // ),
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Consumer<DonationProvider>(
                                builder: (context, value, child) {
                                  return Container(
                                    // color: Colors.red,
                                      width: (width) / 4,
                                      child: Text(
                                        value.donorPlace,
                                        style: black12,
                                      ));
                                }),
                          ),
                        ],
                      ),
                      const SizedBox()
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 0, left: 20, bottom: 0),
                  child: Consumer<DonationProvider>(
                      builder: (context, value, child) {
                        return value.donorReceiptPrinted == "Printed"
                            ? Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: const Icon(
                                Icons.print,
                                color: myWhite,
                                size: 15,
                              ),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: cl1B9BB2,
                                  // gradient: const LinearGradient(
                                  //   begin: Alignment(0.00, -1.00),
                                  //   end: Alignment(0, 1),
                                  //   colors: [
                                  //     cl1D9000,
                                  //     cl20A200
                                  //   ],
                                  // ),
                                  borderRadius:
                                  BorderRadius.circular(100)),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Text(
                                  "Receipt Printed",
                                  style: black12,
                                )),
                          ],
                        )
                            : const SizedBox();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            child: const Icon(
                              Icons.date_range,
                              color: myWhite,
                              size: 15,
                            ),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: cl1B9BB2,
                                // gradient: const LinearGradient(
                                //   begin: Alignment.centerLeft,
                                //   end: Alignment.centerRight,
                                //   colors: [
                                //     cl1D9000,
                                //     cl20A200
                                //   ],
                                // ),
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Consumer<DonationProvider>(
                                builder: (context, value, child) {
                                  return Container(
                                    // color: Colors.red,
                                      width: (width) / 4,
                                      child: FittedBox(
                                        child: Text(
                                          DateFormat('dd/MM/yyyy, hh:mm a').format(value.donationTime),
                                          style: black12,
                                        ),
                                      ));
                                }),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              height: 22,
                              width: 22,
                              decoration: const BoxDecoration(
                                  color: cl1B9BB2,
                                  //   gradient: LinearGradient(
                                  //     begin: Alignment.centerLeft,
                                  //     end: Alignment.centerRight,
                                  //     colors: [
                                  //       cl1D9000,
                                  //       cl20A200
                                  //     ],
                                  //   ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                              child: Image.asset(
                                "assets/payment.png",
                                scale: 4,
                                color: myWhite,
                              )),
                          // Image.asset('assets/payment.png',scale: 30,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Consumer<DonationProvider>(
                                builder: (context, value, child) {
                                  return Text(
                                    value.donorApp,
                                    style: black12,
                                  );
                                }),
                          ),
                        ],
                      ),
                      const SizedBox()
                    ],
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 20, bottom: 20),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.max,
                //     children: [
                //       Row(
                //         mainAxisSize: MainAxisSize.max,
                //         children: [
                //           Container(
                //               height: 22,
                //               width: 22,
                //               decoration: const BoxDecoration(
                //                 color: cl1B9BB2,
                //                 //   gradient: LinearGradient(
                //                 //     begin: Alignment.centerLeft,
                //                 //     end: Alignment.centerRight,
                //                 //     colors: [
                //                 //       cl1D9000,
                //                 //       cl20A200
                //                 //     ],
                //                 //   ),
                //                   borderRadius:
                //                   BorderRadius.all(Radius.circular(20))),
                //               child: Image.asset(
                //                 "assets/payment.png",
                //                 scale: 4,
                //                 color: myWhite,
                //               )),
                //           // Image.asset('assets/payment.png',scale: 30,),
                //           Padding(
                //             padding: const EdgeInsets.symmetric(horizontal: 10),
                //             child: Consumer<DonationProvider>(
                //                 builder: (context, value, child) {
                //                   return Text(
                //                     value.donorApp,
                //                     style: black12,
                //                   );
                //                 }),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         mainAxisSize: MainAxisSize.max,
                //         children: [
                //           Container(
                //               height: 22,
                //               width: 22,
                //               decoration: const BoxDecoration(
                //                 color: cl1B9BB2,
                //
                //                   borderRadius:
                //                   BorderRadius.all(Radius.circular(20))),
                //               child: Image.asset(
                //                 "assets/payment.png",
                //                 scale: 4,
                //                 color: myWhite,
                //               )),
                //           // Image.asset('assets/payment.png',scale: 30,),
                //           Padding(
                //             padding: const EdgeInsets.symmetric(horizontal: 10),
                //             child: Consumer<DonationProvider>(
                //                 builder: (context, value, child) {
                //                   return Text(
                //                     DateFormat('dd/MM/yyyy, hh:mm a').format(value.donationTime),
                //                     style: black12,
                //                   );
                //                 }),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          // TextButton(
          //   style: ButtonStyle(
          //     foregroundColor: MaterialStateProperty.all<Color>(myWhite),
          //     backgroundColor: MaterialStateProperty.all<Color>(primary),
          //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //       RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30.0),
          //         side: const BorderSide(
          //           color: secondary,
          //           width: 2.0,
          //         ),
          //       ),
          //     ),
          //     padding: MaterialStateProperty.all(
          //         const EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
          //
          //   ),
          //   onPressed: () {
          //     donationProvider.whatsappStatus=null;
          //     callNext( MakeStatusPage(), context);
          //   },
          //   child:  Text(' Make Whatsapp Status',style: white16,),
          // ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget webBody(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    return SingleChildScrollView(
      child: SizedBox(
        width:width,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Consumer<DonationProvider>(builder: (context, value, child) {
                return Screenshot(
                  controller: screenshotController,
                  child: Container(
                    color: myWhite,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 550,
                              width: width,
                              decoration: const BoxDecoration(
                                color: myWhite,
                                // borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                  image: AssetImage("assets/ksdReceiptImg.jpg"),
                                  fit: BoxFit.fill,
                                ),
                              ),

                            ),
                            Positioned(
                              top: 5,
                              right: 8,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: SizedBox(
                                  child: Center(
                                    child: Text(
                                      'Date : ${getDate(value.donationTime.millisecondsSinceEpoch.toString())}',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top:175,
                              left:width*.03,
                              child: Text(
                                value.donorName.toString(),
                                style: const TextStyle(
                                  color: myBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 255,
                              right: width*.03,
                              child: Center(
                                child: Text(
                                  "₹"+value.donorAmount.toString(),
                                  style: const TextStyle(
                                    color: myWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize:24,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                );
              }),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 15, left: 20),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     children: [
                  //       Container(
                  //           height: 22,
                  //           width: 22,
                  //           decoration: const BoxDecoration(
                  //               gradient: LinearGradient(colors: [
                  //                 buttonGradient,
                  //                 buttonGradient1,
                  //                 buttonGradient2,
                  //               ]),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(20))),
                  //           child: Image.asset(
                  //             'assets/Tik.png',
                  //             width: 14,
                  //             scale: 5,
                  //             color: myWhite,
                  //           )),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10),
                  //         child: Consumer<DonationProvider>(
                  //             builder: (context, value, child) {
                  //           return Text(
                  //             homeProvider.historyList
                  //                     .map((item) => item.id)
                  //                     .contains(value.donorID)
                  //                 ? value.donorID
                  //                 : value.donorID.substring(
                  //                         0, value.donorID.length - 4) +
                  //                     getStar(4),
                  //             style: GoogleFonts.montserrat(
                  //                 color: Colors.black,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 10),
                  //           );
                  //         }),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 15, left: 20),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisSize: MainAxisSize.max,
                  //     children: [
                  //       Container(
                  //         child: const Icon(
                  //           Icons.person,
                  //           color: myWhite,
                  //           size: 15,
                  //         ),
                  //         padding: const EdgeInsets.all(3),
                  //         decoration: BoxDecoration(
                  //             gradient: const LinearGradient(colors: [
                  //               buttonGradient,
                  //               buttonGradient1,
                  //               buttonGradient2,
                  //             ]),
                  //             borderRadius: BorderRadius.circular(100)),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 10),
                  //         child: Consumer<DonationProvider>(
                  //             builder: (context, value, child) {
                  //           return SizedBox(
                  //               width: (width) / 2,
                  //               child: nameStatus == "YES"
                  //                   ? Text(value.donorName,
                  //                       style: GoogleFonts.montserrat(
                  //                           color: Colors.black,
                  //                           fontWeight: FontWeight.bold,
                  //                           fontSize: 10))
                  //                   : Text(
                  //                       "അനുഭാവി",
                  //                       style: GoogleFonts.montserrat(
                  //                           color: Colors.black,
                  //                           fontWeight: FontWeight.bold,
                  //                           fontSize: 10),
                  //                     ));
                  //         }),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, left: 20),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     children: [
                  //       Container(
                  //         child: Image.asset(
                  //           mobileIcon,
                  //           scale: 3,
                  //         ),
                  //         height: 22,
                  //         width: 22,
                  //         // const Icon(
                  //         //   Icons.call,
                  //         //   color: myWhite,
                  //         //   size: 15,
                  //         // ),
                  //         padding: const EdgeInsets.all(3),
                  //         decoration: BoxDecoration(
                  //             gradient: const LinearGradient(colors: [
                  //               buttonGradient,
                  //               buttonGradient1,
                  //               buttonGradient2,
                  //             ]),
                  //             borderRadius: BorderRadius.circular(100)),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10),
                  //         child: Consumer<DonationProvider>(
                  //             builder: (context, value, child) {
                  //           //getStar(5)+value.donorNumber.substring(value.donorNumber.length-5,value.donorNumber.length)
                  //           return Text(getPhone(value.donorNumber),
                  //               style: GoogleFonts.montserrat(
                  //                   color: Colors.black,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 10));
                  //         }),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisSize: MainAxisSize.max,
                  //     children: [
                  //       Container(
                  //         child: const Icon(
                  //           Icons.location_pin,
                  //           color: myWhite,
                  //           size: 15,
                  //         ),
                  //         padding: const EdgeInsets.all(3),
                  //         decoration: BoxDecoration(
                  //             gradient: const LinearGradient(colors: [
                  //               buttonGradient,
                  //               buttonGradient1,
                  //               buttonGradient2,
                  //             ]),
                  //             borderRadius: BorderRadius.circular(100)),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 10),
                  //         child: Consumer<DonationProvider>(
                  //             builder: (context, value, child) {
                  //           return SizedBox(
                  //               width: (width) / 2,
                  //               child: Text(
                  //                 value.donorPlace,
                  //                 style: GoogleFonts.montserrat(
                  //                     color: Colors.black,
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 10),
                  //               ));
                  //         }),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 0, left: 20, bottom: 0),
                  //   child: Consumer<DonationProvider>(
                  //       builder: (context, value, child) {
                  //     return value.donorReceiptPrinted == "Printed"
                  //         ? Row(
                  //             mainAxisSize: MainAxisSize.max,
                  //             children: [
                  //               Container(
                  //                 child: const Icon(
                  //                   Icons.print,
                  //                   color: myWhite,
                  //                   size: 15,
                  //                 ),
                  //                 padding: const EdgeInsets.all(3),
                  //                 decoration: BoxDecoration(
                  //                     gradient: const LinearGradient(colors: [
                  //                       buttonGradient,
                  //                       buttonGradient1,
                  //                       buttonGradient2,
                  //                     ]),
                  //                     borderRadius: BorderRadius.circular(100)),
                  //               ),
                  //               Padding(
                  //                   padding: const EdgeInsets.symmetric(
                  //                       horizontal: 10),
                  //                   child: Text("Receipt Printed",
                  //                       style: GoogleFonts.montserrat(
                  //                           color: Colors.black,
                  //                           fontWeight: FontWeight.bold,
                  //                           fontSize: 10))),
                  //             ],
                  //           )
                  //         : const SizedBox();
                  //   }),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20, bottom: 20),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     children: [
                  //       Container(
                  //           height: 22,
                  //           width: 22,
                  //           decoration: const BoxDecoration(
                  //               gradient: LinearGradient(colors: [
                  //                 buttonGradient,
                  //                 buttonGradient1,
                  //                 buttonGradient2,
                  //               ]),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(20))),
                  //           child: Center(
                  //             child: Image.asset(
                  //               upiIcon,
                  //               scale: 3,
                  //               color: white,
                  //             ),
                  //           )),
                  //       // Image.asset('assets/payment.png',scale: 30,),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10),
                  //         child: Consumer<DonationProvider>(
                  //             builder: (context, value, child) {
                  //           return Text(value.donorApp,
                  //               style: GoogleFonts.montserrat(
                  //                   color: Colors.black,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 10));
                  //         }),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                height: 22,
                                width: 22,
                                decoration: const BoxDecoration(
                                  // color: cl1177BB,
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        cl1D9000,
                                        cl20A200
                                      ],
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))),
                                child: Image.asset(
                                  'assets/Tik.png',
                                  scale: 5,
                                  color: myWhite,
                                )),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Consumer<DonationProvider>(
                                  builder: (context, value, child) {
                                    return Text(
                                      homeProvider.historyList
                                          .map((item) => item.id)
                                          .contains(value.donorID)
                                          ? value.donorID
                                          : value.donorID.substring(
                                          0, value.donorID.length - 4) +
                                          getStar(4),
                                      style: black12,
                                    );
                                  }),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: const Icon(
                                Icons.phone_iphone_outlined,
                                color: myWhite,
                                size: 15,
                              ),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                // color: cl1177BB,
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      cl1D9000,
                                      cl20A200
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Consumer<DonationProvider>(
                                  builder: (context, value, child) {
                                    //getStar(5)+value.donorNumber.substring(value.donorNumber.length-5,value.donorNumber.length)
                                    return Text(
                                      getPhone(value.donorNumber),
                                      style: black12,
                                    );
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: const Icon(
                                Icons.person,
                                color: myWhite,
                                size: 15,
                              ),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      cl1D9000,
                                      cl20A200
                                    ],
                                  ),
                                  // color: cl1177BB,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Consumer<DonationProvider>(
                                  builder: (context, value, child) {
                                    return Container(
                                      // color: Colors.red,
                                        width: (width) / 2.4,
                                        child: nameStatus == "YES"
                                            ? Text(
                                          value.donorName,
                                          style: black12,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                            : Text(
                                          "അനുഭാവി",
                                          style: black12,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ));
                                  }),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: const Icon(
                                Icons.location_pin,
                                color: myWhite,
                                size: 15,
                              ),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                // color: cl1177BB,
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      cl1D9000,
                                      cl20A200
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Consumer<DonationProvider>(
                                  builder: (context, value, child) {
                                    return Container(
                                      // color: Colors.red,
                                        width: (width) / 4,
                                        child: Text(
                                          value.donorPlace,
                                          style: black12,
                                        ));
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox()
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 0, left: 20, bottom: 10),
                    child: Consumer<DonationProvider>(
                        builder: (context, value, child) {
                          return value.donorReceiptPrinted == "Printed"
                              ? Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                child: const Icon(
                                  Icons.print,
                                  color: myWhite,
                                  size: 15,
                                ),
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  // color: cl1177BB,
                                    gradient: const LinearGradient(
                                      begin: Alignment(0.00, -1.00),
                                      end: Alignment(0, 1),
                                      colors: [
                                        cl1D9000,
                                        cl20A200
                                      ],
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(100)),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "Receipt Printed",
                                    style: black12,
                                  )),
                            ],
                          )
                              : const SizedBox();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            height: 22,
                            width: 22,
                            decoration: const BoxDecoration(
                              // color: cl1177BB,
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    cl1D9000,
                                    cl20A200
                                  ],
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            child: Image.asset(
                              "assets/payment.png",
                              scale: 4,
                              color: myWhite,
                            )),
                        // Image.asset('assets/payment.png',scale: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Consumer<DonationProvider>(
                              builder: (context, value, child) {
                                return Text(
                                  value.donorApp,
                                  style: black12,
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            // TextButton(
            //   style: ButtonStyle(
            //     foregroundColor: MaterialStateProperty.all<Color>(myWhite),
            //     backgroundColor: MaterialStateProperty.all<Color>(primary),
            //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //       RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //         side: const BorderSide(
            //           color: primary,
            //           width: 2.0,
            //         ),
            //       ),
            //     ),
            //     padding: MaterialStateProperty.all(
            //         const EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
            //   ),
            //   onPressed: () {
            //     donationProvider.whatsappStatus = null;
            //     callNext(MakeStatusPage(), context);
            //   },
            //   child: Text(
            //     ' Make Whatsapp Status',
            //     style: white16,
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
          ],
        ),
      ),
    );
  }

  Widget mobile(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async{
         return callNextReplacement(const HomeScreenNew(), context);

         },
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(84),
            child: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height*0.12,
              title: Text('Receipt',style: wardAppbarTxt),
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
              backgroundColor: Colors.white,

            ),
          ),


          floatingActionButton:
              Consumer<HomeProvider>(builder: (context, value, child) {
            return Column(mainAxisAlignment: MainAxisAlignment.end,
              children: [

                // Consumer<HomeProvider>(
                //     builder: (context,value1,child) {
                //       return Consumer<DonationProvider>(
                //           builder: (context, value, child) {
                //             return
                //
                //               value.enrollerAdded ==''&& ( value1.historyList.map((item) => item.id)
                //                   .contains(donationProvider.donorID)) && value.receiptChangeWard=="ON"
                //
                //                   ? InkWell(
                //                     onTap: () {
                //                     value1.addEntrollerPhoneCT.clear();
                //                     beAnEnrollerAlert(context,value.donorAmount,value.donorID);
                //                    },
                //                     // onTap: () {
                //                 //   if(from!='monitor') {
                //                 //     donationProvider.whatsappStatus = null;
                //                 //     donationProvider.statusImage = null;
                //                 //     homeProvider.fileimage = null;
                //                 //     callNext(MakeStatusPage(from: ""), context);
                //                 //   }
                //                 //
                //                 //   ///old code family status
                //                 //   // donationProvider.whatsappStatus = null;
                //                 //   // callNext(MakeStatusPage(from: "family"), context);
                //                 // },
                //                    child: Container(
                //                      alignment: Alignment.center,
                //                   height: 50,
                //                   width: width*0.87,
                //                   decoration: const BoxDecoration(
                //                     // border: Border.all(
                //                     //   color: border,
                //                     //   width: 1,
                //                     // ),
                //                     borderRadius: BorderRadius.all(Radius.circular(10)),
                //                     gradient: LinearGradient(
                //                         begin: Alignment.centerLeft,
                //                         end: Alignment.centerRight,
                //                         colors: [cl1D9000,cl20A200]),
                //                   ),
                //                   child: const Row(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       Icon(Icons.add_circle_outline_sharp,color: Colors.white,size: 20,),
                //                       SizedBox(width: 2,),
                //                       Center(
                //                           child: Text(
                //                             "Map Volunteer",
                //                             style: TextStyle(
                //                               color: Colors.white,
                //                               fontSize: 16,
                //                               fontFamily: 'Poppins',
                //                               fontWeight: FontWeight.w800,
                //                               height: 0,
                //                             ),
                //                           )),
                //                     ],
                //                   ),
                //                 ),
                //               ):const SizedBox();
                //           });
                //     }
                // ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    ///
                    Consumer<HomeProvider>(
                        builder: (context,value1,child) {
                          return Consumer<DonationProvider>(
                              builder: (context, value, child) {
                                return value.enrollerAdded ==''&& ( value1.historyList.map((item) => item.id)
                                    .contains(donationProvider.donorID)) && value.receiptChangeWard=="ON"
                                    ? InkWell(
                                        onTap: () {
                                      value1.addEntrollerPhoneCT.clear();
                                      beAnEnrollerAlert(context,value.donorAmount,value.donorID);
                                    },
                                    // onTap: () {
                                    //   if(from!='monitor') {
                                    //     donationProvider.whatsappStatus = null;
                                    //     donationProvider.statusImage = null;
                                    //     homeProvider.fileimage = null;
                                    //     callNext(MakeStatusPage(from: ""), context);
                                    //   }
                                    //
                                    //   ///old code family status
                                    //   // donationProvider.whatsappStatus = null;
                                    //   // callNext(MakeStatusPage(from: "family"), context);
                                    // },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 160,
                                      decoration: const BoxDecoration(
                                        // border: Border.all(
                                        //   color: border,
                                        //   width: 1,
                                        // ),
                                        borderRadius: BorderRadius.all(Radius.circular(14)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x11000000),
                                              blurRadius: 5,
                                              offset: Offset(0, 4),
                                              spreadRadius: 0,
                                            )
                                          ]
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add_circle_outline_sharp,color: cl1B9BB2,size: 20,),
                                          SizedBox(width: 4,),
                                          Center(
                                              child: Text(
                                                "Map Volunteer",
                                                style: TextStyle(
                                                    color: cl1B9BB2,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ):const SizedBox();
                              });
                        }
                    ),
                    const SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0,),
                      child: Consumer<HomeProvider>(
                        builder: (context,value1,child) {
                          return Consumer<DonationProvider>(
                            builder: (context,value,child) {
                              return InkWell(
                                onTap: () async {
                                  if (!kIsWeb) {

                                    donationProvider.createImage(
                                        'Send', value.donorName, screenshotController);

                                  }
                                  else {
                                    Uint8List? screenshotBytes =await screenshotController.capture();
                                    await Share.shareXFiles([
                                      XFile.fromData(screenshotBytes!,name:'Image${generateRandomString(1)}.png' ),],
                                        subject:'',
                                        text: 'IUML ELECTION'
                                    );
                                    // WebProvider webProvider =
                                    //     Provider.of<WebProvider>(context, listen: false);
                                    // webProvider.createImage(screenshotController);
                                  }
                                  },
                                child: Container(
                                  height: 50,
                                  width:  value.enrollerAdded ==''&& ( value1.historyList.map((item) => item.id)
                                      .contains(donationProvider.donorID)) && value.receiptChangeWard=="ON"
                                      ? 160: width*0.86,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(14)),
                                    color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x11000000),
                                          blurRadius: 5,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        )
                                      ]
                                    // gradient: LinearGradient(
                                    //     begin: Alignment.centerLeft,
                                    //     end: Alignment.centerRight,
                                    //     colors: [cl1177BB,cl264186]),
                                  ),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/share.png',scale: 3,color: cl1B9BB2,),
                                      const SizedBox(width: 4,),
                                      const Center(
                                          child: Text(
                                            "Share",
                                            style: TextStyle(
                                                color: cl1B9BB2,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            }
                          );
                        }
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 10,),
                // ///make status
                // Padding(
                //   padding: const EdgeInsets.only(left: 0.0,),
                //   child: InkWell(
                //     onTap: () {
                //       donationProvider.familyNameTC.clear();
                //       HomeProvider homeProvider =
                //       Provider.of<HomeProvider>(context, listen: false);
                //       homeProvider.fileimage=null;
                //       donationProvider.whatsappStatus = null;
                //       callNext(MakeStatusPage(from: ""), context);
                //     },
                //     child: Container(
                //       height: 50,
                //       width: width*0.87,
                //       decoration: const BoxDecoration(
                //           borderRadius: BorderRadius.all(Radius.circular(20)),
                //         gradient: LinearGradient(
                //             begin: Alignment.centerLeft,
                //             end: Alignment.centerRight,
                //             colors: [cl0EA3A9,cl3686C5]),
                //
                //         // gradient: const LinearGradient(
                //         //     begin: Alignment.centerLeft,
                //         //     end: Alignment.centerRight,
                //         //     colors: [cl1177BB,cl264186]),
                //       ),
                //       child:  Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Image.asset('assets/share.png',scale: 3,color: Colors.white),
                //           const SizedBox(width: 4,),
                //           const Center(
                //               child: Text(
                //                 "Make WhatsApp Status",
                //                 style: TextStyle(
                //                     fontFamily: "Poppins",
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.w700,
                //                     fontSize: 15),
                //               )),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            );
          }),
          body: body(context),
        ),
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SizedBox(
        height: height,
        width: width,
        child: queryData.orientation == Orientation.portrait
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width,
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(84),
                        child: AppBar(
                          flexibleSpace: Container(
                            height: MediaQuery.of(context).size.height*0.12,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(17),
                                  bottomRight: Radius.circular(17)),
                            ),
                          ),
                          shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
                          backgroundColor: Colors.transparent,
                          elevation: 5,
                          // leading: IconButton(
                          //   onPressed: () {
                          //     callNextReplacement(const HomeScreenNew(), context);
                          //   },
                          //   icon: const Padding(
                          //     padding: EdgeInsets.only(top: 8.0),
                          //     child: Icon(Icons.arrow_back_ios,color: cl323A71,),
                          //   ),
                          // ),
                          centerTitle: true,
                          title: Column(
                            children: [
                              const SizedBox(height: 18,),
                              Text(
                                'Successful',
                                style: white17,
                              ),
                              Consumer<DonationProvider>(builder: (context, value, child) {
                                return Text(
                                  DateFormat('dd/MM/yyyy, hh:mm a').format(value.donationTime),
                                  style: white12,
                                );
                              }),
                            ],
                          ),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: InkWell(onTap: (){
                                donationProvider.createImageNew(screenshotController,'','',0);
                              },
                                  child: const Icon(Icons.download,color: cl323A71,)),
                            ),
                            // Consumer<DonationProvider>(builder: (context, value, child) {
                            //   return IconButton(
                            //     onPressed: () {
                            //       if (!kIsWeb) {
                            //
                            //         donationProvider.createImage(
                            //             'Print', value.donorName, screenshotController);
                            //
                            //       }
                            //     },
                            //     icon: const Icon(Icons.print,color: cl323A71,),
                            //   );
                            // }),
                            Consumer<DonationProvider>(builder: (context, value, child) {
                              return IconButton(
                                onPressed: () async {
                                  Uint8List? screenshotBytes =await screenshotController.capture();
                                  await Share.shareXFiles([
                                    XFile.fromData(screenshotBytes!,name:'Image${generateRandomString(1)}.png' ),],
                                      subject:'',
                                      text: 'IUML ELECTION'
                                  );
                                  // if (!kIsWeb) {
                                  //
                                  //   donationProvider.createImage(
                                  //       'Send', value.donorName, screenshotController);
                                  //
                                  // }else {
                                  //   WebProvider webProvider =
                                  //   Provider.of<WebProvider>(context, listen: false);
                                  //   webProvider.createImage(screenshotController);
                                  // }
                                },
                                icon: const Icon(Icons.share,color: cl323A71,),
                              );
                            })
                          ],
                        ),
                      ),

                      body: body(context),
                    ),
                  ),
                ],
              )
            : SizedBox(
              width: width,
              child: Row(
                children: [
                  Expanded(
                      flex:1,
                      child: Image.asset("assets/webShowReceipt1.png",fit: BoxFit.cover,)),
                  Expanded(
                    flex: 1,
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(84),
                        child: AppBar(
                          flexibleSpace: Container(
                            height: MediaQuery.of(context).size.height*0.12,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(17),
                                  bottomRight: Radius.circular(17)),
                            ),
                          ),
                          shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
                          backgroundColor: Colors.transparent,
                          elevation: 5,
                          // leading: IconButton(
                          //   onPressed: () {
                          //     callNextReplacement(const HomeScreenNew(), context);
                          //   },
                          //   icon: const Padding(
                          //     padding: EdgeInsets.only(top: 8.0),
                          //     child: Icon(Icons.arrow_back_ios,color: cl323A71,),
                          //   ),
                          // ),
                          centerTitle: true,
                          title: Column(
                            children: [
                              const SizedBox(height: 18,),
                              Text(
                                'Successful',
                                style: white17,
                              ),
                              Consumer<DonationProvider>(builder: (context, value, child) {
                                return Text(
                                  DateFormat('dd/MM/yyyy, hh:mm a').format(value.donationTime),
                                  style: white12,
                                );
                              }),
                            ],
                          ),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: InkWell(onTap: (){
                                donationProvider.createImageNew(screenshotController,'','',0);
                              },
                                  child: const Icon(Icons.download,color: cl323A71,)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Consumer<DonationProvider>(builder: (context, value, child) {
                                return IconButton(
                                  onPressed: () async {
                                    Uint8List? screenshotBytes =await screenshotController.capture();
                                    await Share.shareXFiles([
                                      XFile.fromData(screenshotBytes!,name:'Image${generateRandomString(1)}.png' ),],
                                        subject:'',
                                        text: 'IUML ELECTION'
                                    );
                                    // if (!kIsWeb) {
                                    //
                                    //   donationProvider.createImage(
                                    //       'Print', value.donorName, screenshotController);
                                    //
                                    // }
                                  },
                                  icon: const Icon(Icons.share,color: cl323A71,),
                                );
                              }),
                            ),
                            // Consumer<DonationProvider>(builder: (context, value, child) {
                            //   return IconButton(
                            //     onPressed: () {
                            //       if (!kIsWeb) {
                            //
                            //         donationProvider.createImage(
                            //             'Send', value.donorName, screenshotController);
                            //
                            //       }else {
                            //         WebProvider webProvider =
                            //         Provider.of<WebProvider>(context, listen: false);
                            //         webProvider.createImage(screenshotController);
                            //       }
                            //     },
                            //     icon: const Icon(Icons.download,color: cl323A71,),
                            //   );
                            // })
                          ],
                        ),
                      ),

                      body: webBody(context),
                    ),
                  ),
                  Expanded(
                      flex:1,
                      child: Image.asset("assets/webShowReceipt2.jpg",fit: BoxFit.cover)),
                ],
              ),
            ),
      ),
    );
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
                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
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
                                                        colors: [cl0EA3A9,cl3686C5])),
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
                  width: 400,
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
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {


                              finish(context);
                            },
                            child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(35)),
                                    // color: Color(0xff050066),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [cl0EA3A9,cl3686C5])
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
                          const SizedBox(width: 10,),
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
                              callNextReplacement(const HomeScreenNew(), context);


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
                                        colors: [cl0EA3A9,cl3686C5])),
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
                      const SizedBox(height: 25,)
                    ],
                  ),
                );
              }
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

  String getStar(int length) {
    String star = '';
    for (int i = 0; i < length; i++) {
      star = star + '*';
    }
    return star;
  }

  String getPhone(String donorNumber) {
    try {
      int ph = 0;
      ph = int.parse(donorNumber.replaceAll("+", ""));

      return getStar(donorNumber.length - 5) +
          donorNumber
              .toString()
              .substring(donorNumber.length - 5, donorNumber.length);
    } catch (e) {
      return donorNumber;
    }
  }


  OutlineInputBorder border2 = OutlineInputBorder(
      borderSide: BorderSide(color: textfieldTxt.withOpacity(0.7)),
      borderRadius: BorderRadius.circular(10));
}
