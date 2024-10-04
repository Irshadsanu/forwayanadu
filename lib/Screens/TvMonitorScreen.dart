import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/Screens/payment_history.dart';
import 'package:quaide_millat/providers/donation_provider.dart';
import 'package:quaide_millat/providers/home_provider.dart';

import '../constants/my_colors.dart';
import '../constants/text_style.dart';

class TvMonitorScreem extends StatefulWidget {
  const TvMonitorScreem({Key? key}) : super(key: key);

  @override
  State<TvMonitorScreem> createState() => _TvMonitorScreemState();
}

class _TvMonitorScreemState extends State<TvMonitorScreem> {
  DateTime _targetTime =
      DateTime(2024, 03, 01, 00, 00, 00); // Replace this with your target time

  Duration _remainingTime = const Duration();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(_duration, (_) {
      if (_currentPage < _totalPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void startTimer() {
    const oneSec = const Duration(milliseconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        DateTime currentTime = DateTime.now();
        if (currentTime.isAfter(_targetTime)) {
          timer.cancel();
          // Add your code here to handle timer completion
          // For example, you could display a message or execute some function.
        } else {
          setState(() {
            _remainingTime = _targetTime.difference(currentTime);
          });
        }
      },
    );
  }

  late PageController _pageController;
  int _currentPage = 0;
  int _totalPages =
      5; // Change this to the total number of pages in your PageView
  final _duration = const Duration(seconds: 10);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: myWhite,
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
              //assets/kkdBgCom.png
                image: AssetImage("assets/kkdBgCom2.png"), fit: BoxFit.fill)),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Consumer<HomeProvider>(builder: (context, value, child) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: width * .05),
                  height: height,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Image.asset(
                        'assets/logo.png',
                        scale: 2,
                      ),
                      1==0?
                      SizedBox(
                        height: height * .40,
                      ):
                      Column(
                        children: [
                          SizedBox(height: height*.05,),
                          Container(
                            alignment: Alignment.centerLeft,
                              height: height*.30,
                              width:400,
                              child: Image.asset("assets/splashCenterImage.png")),
                          SizedBox(height: height*.05,),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20.0,bottom: 8),
                      //   child: Container(
                      //     height: 100,
                      //     width: width*0.5,
                      //     decoration:  BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //         color: clFFFFFF,
                      //         image: DecorationImage(image: AssetImage('assets/VolunRA.png'),fit: BoxFit.fill),
                      //         boxShadow: [
                      //           BoxShadow(
                      //               color: cl0x40CACACA,
                      //               blurRadius: 16
                      //           )
                      //
                      //         ]
                      //
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.only(left:12,bottom: 8,right: 8),
                      //           child: Image.asset("assets/todaysTopper.png",scale: 3.3,),
                      //         ),
                      //         Container(width: 1,color: clD4D4D4,margin: EdgeInsets.only(top: 12,bottom: 12),),
                      //         // const VerticalDivider(color: clD4D4D4,thickness: 1,endIndent: 12,indent: 12,),
                      //         Flexible(fit: FlexFit.tight,
                      //           child: Consumer<DonationProvider>(
                      //               builder: (context,value,child) {
                      //                 return Container(
                      //                   // color: Colors.yellow,
                      //
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.only(left: 10.0),
                      //                     child: Column(
                      //                       mainAxisAlignment: MainAxisAlignment.center,
                      //                       crossAxisAlignment: CrossAxisAlignment.start,
                      //                       children: [
                      //                         SizedBox(height: 2,),
                      //                         Container(
                      //                           width: double.infinity,
                      //                           // color: Colors.red,
                      //                           child: Text(
                      //                             value.todayTopperName,
                      //                             style: const TextStyle(
                      //                                 height: 1.3,
                      //                                 fontSize: 14,
                      //                                 fontWeight: FontWeight.bold,
                      //                                 fontFamily: "PoppinsMedium",
                      //                                 color: cl3655A2),
                      //                           ),
                      //                         ),
                      //                         SizedBox(height: 2,),
                      //                         value.todayTopperPlace != ""
                      //                             ? Text(
                      //                           value.todayTopperPlace,
                      //                           style: const TextStyle(
                      //                               height: 1.3,
                      //                               fontSize: 12,
                      //                               fontWeight: FontWeight.w400,
                      //                               fontFamily: "PoppinsMedium",
                      //                               color: cl6B6B6B),
                      //                         )
                      //                             : const SizedBox(),
                      //                         Row(
                      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                           crossAxisAlignment: CrossAxisAlignment.center,
                      //                           children: [
                      //                             value.todayTopperPanchayath=="FAMILY CONTRIBUTION"?SizedBox():
                      //                             Text(
                      //                               value.todayTopperPanchayath,
                      //                               style: const TextStyle(
                      //                                   height: 1.3,
                      //                                   fontSize: 12,
                      //                                   fontWeight: FontWeight.w400,
                      //                                   fontFamily: "PoppinsMedium",
                      //                                   color: cl6B6B6B
                      //                               ),
                      //                             ),
                      //                             Row(
                      //                               mainAxisAlignment: MainAxisAlignment.start,
                      //                               crossAxisAlignment: CrossAxisAlignment.start,
                      //                               children: [
                      //                                 const Padding(
                      //                                   padding: EdgeInsets.only(
                      //                                       right: 2),
                      //                                   child: SizedBox(
                      //                                     height: 15,
                      //                                     child: Text(
                      //                                       "₹",
                      //                                       style: TextStyle(color: clblue,fontSize: 16),
                      //                                       // scale: 7,
                      //                                       // color: myBlack2,
                      //                                     ),
                      //                                   ),
                      //                                 ),
                      //                                 AutoSizeText(
                      //                                   getAmount(value.todayTopperAmount),
                      //                                   style: const TextStyle(
                      //                                       fontWeight: FontWeight.w700,
                      //                                       fontFamily: "PoppinsMedium",
                      //                                       fontSize: 18,
                      //                                       color: clblue),
                      //                                 )
                      //                               ],
                      //                             ),
                      //
                      //                             // AutoSizeText.rich(
                      //                             //   TextSpan(children: [
                      //                             //     const TextSpan(
                      //                             //         text: "₹ ",
                      //                             //         style: TextStyle(fontSize: 14,color: cl323A71)),
                      //                             //     TextSpan(
                      //                             //       text: getAmount(value.todayTopperAmount),
                      //                             //       style: const TextStyle(
                      //                             //           fontWeight: FontWeight.w700,
                      //                             //           fontFamily: "PoppinsMedium",
                      //                             //           fontSize: 18,
                      //                             //           color: cl323A71
                      //                             //       ),
                      //                             //     )
                      //                             //   ]),
                      //                             //   textAlign: TextAlign.center,
                      //                             //   minFontSize: 5,
                      //                             //   maxFontSize: 18,
                      //                             //   maxLines: 1,
                      //                             // ),
                      //                           ],
                      //                         ),
                      //                         SizedBox(width: 40,),
                      //
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 );
                      //               }
                      //           ),
                      //         ),
                      //
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Consumer<DonationProvider>(
                          builder: (context,value,child) {
                            return
                              value.todayTopperName!="No payments yet" &&
                                  value.todayTopperName!="" && value.todayTopperName!="null"?
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0,bottom: 8),
                                child: Container(
                                  height: 100,
                                  width: width,
                                  decoration:  BoxDecoration(
                                      color: clFFFFFF,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: cl0x40CACACA,
                                            blurRadius: 16
                                        )
                                      ],
                                      border: Border.all(
                                        width: 0.20,
                                        strokeAlign: BorderSide.strokeAlignOutside,
                                        color: clCACACA,
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                                      image: const DecorationImage(
                                        image:AssetImage("assets/VolunRA.png"),
                                        fit:BoxFit.cover,
                                      )
                                  ),
                                  child: Consumer<DonationProvider>(
                                      builder: (context,value,child) {
                                        return SizedBox(
                                          // color: Colors.yellow,
                                          width: width,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal:10),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child:Image.asset("assets/trophy.png")
                                                ),

                                                const SizedBox(width:10),

                                                Flexible(
                                                  fit:FlexFit.tight,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        // color: Colors.red,
                                                        // width: 125,
                                                        height: 30,
                                                        child: Center(
                                                          child: Stack(
                                                            children:  [
                                                              Positioned(
                                                                top:3,
                                                                left: 2,
                                                                child: Image.asset('assets/Today’s Topper.png',scale: 1.2,),
                                                                // child: Text(
                                                                //   'Today’s Topper',
                                                                //   style: TextStyle(
                                                                //     color: Colors.white,
                                                                //     fontSize: 16,
                                                                //     fontFamily: 'ChangaOneRegular',
                                                                //     fontWeight: FontWeight.w400,
                                                                //     height: 0,
                                                                //   ),
                                                                // ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height:5),
                                                      Text(
                                                        value.todayTopperName,
                                                        maxLines:2,
                                                        overflow:TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            height: 1.3,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: "PoppinsMedium",
                                                            color: myWhite),
                                                      ),
                                                      value.todayTopperPlace != ""
                                                          ? Text(
                                                        value.todayTopperPlace,
                                                        style: const TextStyle(
                                                            height: 1.3,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: "PoppinsMedium",
                                                            color: Colors.white),
                                                      )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                ),

                                                const SizedBox(width:10),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 2),
                                                      child: SizedBox(
                                                        height: 30,
                                                        child: Text(
                                                          "₹",
                                                          style: TextStyle(color: myWhite,fontSize: 28),
                                                          // scale: 7,
                                                          // color: myBlack2,
                                                        ),
                                                      ),
                                                    ),
                                                    AutoSizeText(
                                                      getAmount(value.todayTopperAmount),
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w800,
                                                          fontFamily: "PoppinsBold",
                                                          fontSize: 25,
                                                          color: myWhite),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ):const SizedBox();
                          }
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: PageView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: _pageController,
                            itemCount: value.toppReportsList.length,
                            onPageChanged: (int index) {
                              value.activeIndex = index;
                              value.notifyListeners();
                            },
                            itemBuilder: (BuildContext context, int index) {
                              var item = value.toppReportsList[index];
                              return ListView(
                                children: [
                                  Stack(
                                    children: <Widget>[
                                      // Stroked text as border.
                                      Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "argentum",
                                          // color:bluue,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 2
                                            ..color = myWhite,
                                        ),
                                      ),
                                      // Solid text as fill.
                                      Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "argentum",
                                          color: bluue,
                                        ),
                                      ),
                                    ],
                                  ),


                                  const SizedBox(
                                    height: 10,
                                  ),

                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          value.finaleToopers(item).length,
                                      itemBuilder: (context, index) {
                                        print(value
                                                .finaleToopers(item)
                                                .length
                                                .toString() +
                                            ' FIEOJFIOE');
                                        var itemss =
                                            value.finaleToopers(item)[index];
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 15),
                                          height: 70,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              color: myWhite.withOpacity(0.50),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              // border: Border.all(color: myWhite, width: 0.5),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: myBlack
                                                        .withOpacity(0.08),
                                                    offset: const Offset(0, 1),
                                                    blurRadius: 1,
                                                    spreadRadius: 1)
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  itemss.name,
                                                  style: const TextStyle(
                                                      color: myBlack,
                                                      fontSize: 20,
                                                      fontFamily: "Poppins"),
                                                ),
                                                Row(
                                                  children: [
                                                    Text('₹',style: TextStyle(
                                                        fontSize:
                                                        25,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color:
                                                        myBlack, fontFamily:
                                                    'Lato'),),
                                                    Text(
                                                     getAmount(double.parse(itemss.collected.toString())),
                                                      style: TextStyle(
                                                          fontSize:
                                                          25,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontFamily:
                                                          'PoppinsBold',
                                                          color:
                                                          myBlack)
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                );
              }),
            ),
            Expanded(
              flex: 3,
              child: Consumer<HomeProvider>(builder: (context, value, child) {
                return Container(
                  height: height,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    (_remainingTime.inHours)
                                        .toString()
                                        .padLeft(2, '0'),
                                    style: GoogleFonts.akshar(
                                        textStyle: monitoTvTextAmmountbluue),
                                  ),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: myBlack.withOpacity(0.2),
                                  ),
                                  Text(
                                      (_remainingTime.inMinutes % 60)
                                          .toString()
                                          .padLeft(2, '0'),
                                      style: GoogleFonts.akshar(
                                          textStyle: monitoTvTextAmmountbluue)),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: myBlack.withOpacity(0.2),
                                  ),
                                  Text(
                                      (_remainingTime.inSeconds % 60)
                                          .toString()
                                          .padLeft(2, '0'),
                                      style: GoogleFonts.akshar(
                                          textStyle: monitoTvTextAmmountbluue)),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: myBlack.withOpacity(0.2),
                                  ),
                                  Container(
                                    height: 100,width: 150,
                                    // color: Colors.red,
                                    child: Text(
                                        (_remainingTime.inMilliseconds % 100).toString().padLeft(2, '0'),
                                        style: GoogleFonts.akshar(textStyle: monitoTvTextAmmountbluue)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '  Hours',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 25,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(),
                                  Text(
                                    "       Minutes",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 25,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(),
                                  Text(
                                    "    Seconds",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 25,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(),
                                  Text(
                                    "Milliseconds",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 25,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * .03,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 180,
                            width: width,
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(30),
                                image: const DecorationImage(
                                    image:
                                        AssetImage("assets/iumlksdbgLst.png"),
                                    fit: BoxFit.fill)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: SizedBox(
                                // color: Colors.red,
                                height: 170,
                                child: FittedBox(
                                  child: Text(
                                    getAmount(value.totalCollection),
                                    style: monitoTvTextAmmount,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Consumer<HomeProvider>(
                              builder: (context, value, child) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.paymentDetailsList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  var item = value.paymentDetailsList[index];
                                  // homeProvider.buzzer(item.status.toString());

                                  return queryData.orientation ==
                                              Orientation.landscape &&
                                          item.status == "Success"
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: myWhite.withOpacity(0.6),
                                            boxShadow: [
                                              BoxShadow(
                                                color: c_Grey.withOpacity(0.15),
                                                blurRadius: 2,
                                                spreadRadius: 2,
                                                offset: const Offset(
                                                  0,
                                                  3,
                                                ),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Stack(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                        flex: 3,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                              child: SizedBox(
                                                                width:
                                                                    width / 2.7,
                                                                child: Text(
                                                                  item.name,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: item.status ==
                                                                          "Success"
                                                                      ? const TextStyle(
                                                                          color: bluue,
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.w800,
                                                                          fontFamily: "Poppins")
                                                                      : const TextStyle(
                                                                          color: c40000,
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.w800,
                                                                          fontFamily: "Poppins"),
                                                                ),
                                                              ),
                                                            ),
                                                            // Padding(
                                                            //   padding:
                                                            //       const EdgeInsets
                                                            //               .only(
                                                            //           left: 20),
                                                            //   child: SizedBox(
                                                            //     width:
                                                            //         width / 2.7,
                                                            //     child: Text(
                                                            //       item.ward,
                                                            //       maxLines: 2,
                                                            //       overflow:
                                                            //           TextOverflow
                                                            //               .ellipsis,
                                                            //       style: const TextStyle(
                                                            //           color:
                                                            //               myBlack,
                                                            //           fontSize:
                                                            //               13,
                                                            //           fontWeight:
                                                            //               FontWeight
                                                            //                   .w500,
                                                            //           fontFamily:
                                                            //               "PoppinsMedium"),
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            // Padding(
                                                            //   padding:
                                                            //       const EdgeInsets
                                                            //               .only(
                                                            //           left: 20),
                                                            //   child: SizedBox(
                                                            //     width:
                                                            //         width / 2.7,
                                                            //     child: Text(
                                                            //       item.panchayath,
                                                            //       maxLines: 2,
                                                            //       overflow:
                                                            //           TextOverflow
                                                            //               .ellipsis,
                                                            //       style: const TextStyle(
                                                            //           color:
                                                            //               myBlack,
                                                            //           fontSize:
                                                            //               13,
                                                            //           fontWeight:
                                                            //               FontWeight
                                                            //                   .w500,
                                                            //           fontFamily:
                                                            //               "PoppinsMedium"),
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                          ],
                                                        )),
                                                    Expanded(
                                                        flex: 1,
                                                        child: RichText(
                                                            text: TextSpan(
                                                                children: [
                                                              TextSpan(
                                                                  text: "₹",
                                                                  style: item.status ==
                                                                          "Success"
                                                                      ? const TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              bluue)
                                                                      : const TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              c40000)),
                                                              TextSpan(
                                                                  text:
                                                                      "${item.amount.split(".").first}",
                                                                  style: item.status ==
                                                                          "Success"
                                                                      ? const TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              'PoppinsBold',
                                                                          color:
                                                                              bluue)
                                                                      : const TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: c40000,
                                                                    fontFamily: 'PoppinsBold',
                                                                  )),
                                                            ]))
                                                        // Text(
                                                        //   " ₹ ${item.amount.split(".").first}",
                                                        //   style: item.status ==
                                                        //           "Success"
                                                        //       ? const TextStyle(
                                                        //           fontFamily:
                                                        //               'PoppinsBold',
                                                        //           fontSize: 22,
                                                        //           fontWeight:
                                                        //               FontWeight.bold,
                                                        //           color: bluue
                                                        //           )
                                                        //       : const TextStyle(
                                                        //           fontFamily:
                                                        //               'PoppinsBold',
                                                        //           fontSize: 22,
                                                        //           fontWeight:
                                                        //               FontWeight.bold,
                                                        //           color: c40000
                                                        //           ),
                                                        // ),
                                                        ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, right: 8),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Text(
                                                      getDateFormat(item.time),
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: "Poppins",
                                                        color: c_Grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                });
                          }),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

String getDateFormat(String millis) {
  var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));
  var year = DateFormat('yyyy').format(dt);
  var month = DateFormat('M').format(dt);
  var day = DateFormat('d').format(dt);
  var hour = DateFormat('H').format(dt);
  print("timerrrr" + hour.toString());
  var d12 = DateFormat('dd/MM/yyyy hh:mm a').format(dt);
  return d12.toString();
}

String getAmount(double totalCollection) {
  final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
  String newText1 = formatter.format(totalCollection);
  String newText =
      formatter.format(totalCollection).substring(0, newText1.length - 3);
  return newText;
}
