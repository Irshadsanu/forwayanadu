import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/constants/my_colors.dart';
import 'package:quaide_millat/providers/home_provider.dart';

import '../constants/text_style.dart';
import '../providers/donation_provider.dart';

class FinaleDayScreen extends StatelessWidget {
  const FinaleDayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: myWhite,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.15,
              width: width,
              color: myWhite,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: const Color(0xFF2f4e9c),
                      alignment: Alignment.center,
                      height: height * 0.15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 200,
                            height: 20,
                            decoration: BoxDecoration(
                                color: myWhite.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: const Text("Collected Amount",style: TextStyle(
                                color: myWhite,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                fontSize: 13
                            ),),
                          ),
                          Consumer<HomeProvider>(builder: (context, value, child) {
                            return Text(getAmount(value.totalCollection),
                                style: GoogleFonts.akshar(textStyle: whiteGoogle));
                          }),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Consumer<HomeProvider>(builder: (context, value, child) {
                      return Container(
                        alignment: Alignment.center,
                        // color: const Color(0xFF008ddd),
                        height: height * 0.15,
                        width: width * 0.5,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFF30A8DA),Color(0xFF006EBB)]
                            )
                        ),
                        child:value.paymentDetailsList.length>0? ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var item = value.paymentDetailsList[index];
                              return Container(
                                height: height * 0.15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 200,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: myWhite.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: const Text("Live Transactions",style: TextStyle(
                                          color: myWhite,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins",
                                          fontSize: 13
                                      ),),
                                    ),
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: myWhite,
                                          fontFamily: "Poppins"
                                      ),
                                    ),
                                    Text(
                                      "₹ " + item.amount,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: myWhite,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }):SizedBox(),
                      );
                    }),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                        width: width * 0.5,
                        child:Image.asset("assets/poweredByBottom.png",fit: BoxFit.cover,)
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      // bottomNavigationBar: Container(
      //   height: height * 0.15,
      //   width: width,
      //   color: myWhite,
      //   child: Row(
      //     children: [
      //       Expanded(
      //         flex: 2,
      //         child: Container(
      //           color: const Color(0xFF2f4e9c),
      //           alignment: Alignment.center,
      //           height: height * 0.15,
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //               Container(
      //                 alignment: Alignment.center,
      //                 width: 200,
      //                 height: 20,
      //                 decoration: BoxDecoration(
      //                 color: myWhite.withOpacity(0.15),
      //                   borderRadius: BorderRadius.circular(20)
      //                 ),
      //                 child: const Text("Collected Amount",style: TextStyle(
      //                   color: myWhite,
      //                   fontWeight: FontWeight.w500,
      //                   fontFamily: "Poppins",
      //                   fontSize: 13
      //                 ),),
      //               ),
      //               Consumer<HomeProvider>(builder: (context, value, child) {
      //                 return Text(getAmount(value.totalCollection),
      //                     style: GoogleFonts.akshar(textStyle: whiteGoogle));
      //               }),
      //             ],
      //           ),
      //         ),
      //       ),
      //       Expanded(
      //         flex: 2,
      //         child: Consumer<HomeProvider>(builder: (context, value, child) {
      //           return Container(
      //             alignment: Alignment.center,
      //             // color: const Color(0xFF008ddd),
      //             height: height * 0.15,
      //             width: width * 0.5,
      //             decoration: const BoxDecoration(
      //               gradient: LinearGradient(
      //                 begin: Alignment.topCenter,
      //                 end: Alignment.bottomCenter,
      //                 colors: [Color(0xFF30A8DA),Color(0xFF006EBB)]
      //               )
      //             ),
      //             child: ListView.builder(
      //                 itemCount: 1,
      //                 shrinkWrap: true,
      //                 physics: const ScrollPhysics(),
      //                 itemBuilder: (BuildContext context, int index) {
      //                   var item = value.paymentDetailsList[index];
      //                   return Container(
      //                     height: height * 0.15,
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                       children: [
      //                         Container(
      //                           alignment: Alignment.center,
      //                           width: 200,
      //                           height: 20,
      //                           decoration: BoxDecoration(
      //                               color: myWhite.withOpacity(0.15),
      //                               borderRadius: BorderRadius.circular(20)
      //                           ),
      //                           child: const Text("Live Transactions",style: TextStyle(
      //                               color: myWhite,
      //                               fontWeight: FontWeight.w500,
      //                               fontFamily: "Poppins",
      //                               fontSize: 13
      //                           ),),
      //                         ),
      //                         Text(
      //                           item.name,
      //                           style: const TextStyle(
      //                               fontSize: 18,
      //                               fontWeight: FontWeight.w600,
      //                               color: myWhite,
      //                           fontFamily: "Poppins"
      //                           ),
      //                         ),
      //                         Text(
      //                           "₹ " + item.amount,
      //                           style: const TextStyle(
      //                               fontSize: 18,
      //                               fontWeight: FontWeight.w600,
      //                               color: myWhite,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   );
      //                 }),
      //           );
      //         }),
      //       ),
      //       Expanded(
      //         flex: 1,
      //         child: SizedBox(
      //           width: width * 0.5,
      //           child:Image.asset("assets/poweredByBottom.png",fit: BoxFit.cover,)
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

String getAmount(double totalCollection) {
  final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
  String newText1 = formatter.format(totalCollection);
  String newText =
  formatter.format(totalCollection).substring(0, newText1.length - 3);
  return newText;
}
