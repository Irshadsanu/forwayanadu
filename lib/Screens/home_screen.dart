import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/Screens/Toppers_home_screen.dart';
import 'package:quaide_millat/Screens/assembly_report.dart';
import 'package:quaide_millat/Screens/be_an_enroller.dart';
import 'package:quaide_millat/Screens/Expensenses/expensesList_screen.dart';
import 'package:quaide_millat/Screens/house_donation_List.dart';
import 'package:quaide_millat/Screens/payment_history.dart';
import 'package:quaide_millat/Screens/receiptlist_monitor_screen.dart';
import 'package:quaide_millat/Screens/reciept_list_page.dart';
import 'package:quaide_millat/Screens/top_enrollers_screen.dart';
import 'package:quaide_millat/Screens/ward_history.dart';
import 'package:quaide_millat/Screens/ward_history_home.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../constants/alerts.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import '../providers/web_provider.dart';
import 'district_report.dart';
import 'donate_page.dart';
import 'enrollerPayments_screen.dart';
import 'leadReport.dart';
import 'no_paymet_gatway.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({Key? key}) : super(key: key);

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew>  with WidgetsBindingObserver{
  late ConfettiController controllerCenter = ConfettiController(duration: const Duration(seconds: 5000));


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add observer for lifecycle changes

    // sss();
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
homeProvider.fetchTotal();
homeProvider.fetchExpensesTotal();
    // homeProvider.inagurationTriggerKKD(context);
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    homeProvider.clearTotalStream();// Remove observer on dispose
    super.dispose();

  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    if (state == AppLifecycleState.paused) {
      // The app is minimized (goes to background)
      homeProvider.clearTotalStream();
      print("Listener canceled, app minimized.");
    } else if (state == AppLifecycleState.resumed) {
      // The app is resumed (comes to foreground)
      homeProvider.fetchTotal();
      print("Listener restarted, app resumed.");
    }
  }
  final List<int> amount = [
    100,
    500,
    1000,
    2000,
    5000,
    10000
  ];

  final List<Color> colors = [
    clB3EFD2,
    clEFB3B3,
    clCAE8F1,
    clB3EFEF
  ];

    // void sss(){
    //   controllerCenter.play();
    //   setState(() {
    //
    //   });
    // }
  final List<String> amountInWords = [
    "Five Hundred",
    "Thousand",
    "Five Thousand",
    "Ten Thousand",
    "Twenty Five Thousand",
    "Fifty Thousand",
  ];

  List<String> images = [
    "assets/c1.jpeg",
    "assets/c1.jpeg",

  ];

  List<String> contriImg = [
    "assets/Transactions.png",
    "assets/History.png",
    "assets/LeaderBoard.png",
    "assets/Reports.png",
    "assets/VolunteerRegistration.png",
    "assets/VolunteerPayments.png",
    "assets/TopVolunteers.png",
    "assets/TopReport.png",

  ];

  List<String> contriText = [
    "Transactions",
    "My History",
    "Leader board",
    "Reports",
    "Volunteer\nRegistration",
    "Volunteer\nPayments",
    "Top\nVolunteers",
    "Top\nReports",
  ];
  List<String> contriImgNew = [
    "assets/Transactions.png",
    "assets/History.png",
    "assets/LeaderBoard.png",
    "assets/VolunteerRegistration.png",
    "assets/VolunteerPayments.png",
    "assets/TopVolunteers.png",

  ];

  List<String> contriTextNew = [
    "Transactions",
    "My History",
    "Leader board",
    "Volunteer\nRegistration",
    "Volunteer\nPayments",
    "Top\nVolunteers",
  ];



  List<String> PTCImg = [
    "assets/privacyPolicy.png",
    "assets/TermsAndCondition.png",
    "assets/helpline.png",
  ];
  List<IconData> PTCIcon = [
    Icons.privacy_tip_outlined,
    Icons.gavel,
    Icons.wifi_tethering,
    Icons.info_outline,
  ];


  List<String> PTCText = [
    "Privacy Policy",
    "Terms and condition",
    "Contact Us",
    "About Us",
  ];

  List<String> reportText = [
    "Transactions",
    "My History",
    "Receipt",
    "Report"
  ];

  List<String> reportImg=[
    "assets/transactions.png",
    "assets/History.png",
    "assets/Reciept.png",
    "assets/report.png",
  ];
  List<String> prizes=[
    "assets/firsPrice.png",
    "assets/topSecond.png",
    "assets/topThird.png",
  ];

  int activeIndex = 0;

  List<Widget> statsScreens = [
    WardHistory(),
    ReceiptListPage(
      from: 'home',
      total: '', ward: '', panchayath: '', district: '', target: '',
    ),
     DistrictReport(from: '',),
    PaymentHistory()
  ];
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {


    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget mobile(context){

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);

    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    ///ba
    // homeProvider.sss();
    homeProvider.getAppVersion();


    return WillPopScope(
      onWillPop: () {
        return showExitPopup();
      },
      child: queryData.orientation == Orientation.portrait?
      SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          backgroundColor: clFFFFFF,

          body: SizedBox(
            height: height,
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
                child: Column(
                    children: [
               Container(
                    // color: Colors.red,
                  height: 340, //height*.58
                  // color:Colors.red,
                  child:
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: width,
                        height:280,//380
                        // height: 0.42*height,
                          padding: const EdgeInsets.only(top: 30),
                        decoration:   BoxDecoration(
                         color: Colors.grey.withOpacity(0.3),
                          image: const DecorationImage(
                            image: AssetImage("assets/Frame 15905.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        // child:Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     // Padding(
                        //     //   padding: const EdgeInsets.only(top: 5.0),
                        //     //   child: Text("INDIAN UNION MUSLIM LEAGUE",
                        //     //   style: GoogleFonts.inter(fontWeight: FontWeight.w300,fontSize: 14,color: cl4F4F4F,),),
                        //     // ),
                        //     Image.asset("assets/league.png",scale: 18,),
                        //     SizedBox(height: 2,),
                        //     Image.asset("assets/munnettam.png",scale: 6,),
                        //     SizedBox(height: 13,),
                        //     Consumer<HomeProvider>(
                        //         builder: (context,valuw1,child) {
                        //           return InkWell(
                        //             onTap: (){
                        //
                        //               // if(valuw1.iosPaymentButton=='ON') {
                        //               //   mRoot
                        //               //       .child('0')
                        //               //       .child('PaymentGateway36')
                        //               //       .onValue
                        //               //       .listen((event) {
                        //               //     if (event.snapshot.value.toString() == 'ON') {
                        //               //       DonationProvider donationProvider = Provider
                        //               //           .of<DonationProvider>(
                        //               //           context, listen: false);
                        //               //       donationProvider.amountTC.text = "";
                        //               //       donationProvider.nameTC.text = "";
                        //               //       donationProvider.phoneTC.text = "";
                        //               //       donationProvider.subCommitteeCT.text = "";
                        //               //       donationProvider.kpccAmountController.text =
                        //               //       "";
                        //               //       donationProvider.onAmountChange('');
                        //               //       donationProvider.clearGenderAndAgedata();
                        //               //       donationProvider.selectedPanjayathChip = null;
                        //               //       donationProvider.chipsetWardList.clear();
                        //               //       donationProvider.selectedWard = null;
                        //               //       '1';
                        //               //       donationProvider.minimumbool = true;
                        //               //
                        //               //       callNext(DonatePage(), context);
                        //               //     } else {
                        //               //       callNext(const NoPaymentGateway(), context);
                        //               //     }
                        //               //   });
                        //               // }
                        //               },
                        //             child:  Container(
                        //               height: 125,
                        //               margin: const EdgeInsets.symmetric(horizontal: 22),
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(30),
                        //                 border: const Border(
                        //                     left: BorderSide(color: Colors.white),
                        //                     right: BorderSide(color: Colors.white),
                        //                   bottom: BorderSide.none,
                        //                   top: BorderSide.none,
                        //
                        //                 )
                        //               ),
                        //               child: Consumer<HomeProvider>(
                        //                   builder: (context, value, child) {
                        //                     return Column(
                        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                       children: [
                        //                         SizedBox(),
                        //                         Container(
                        //                           child: Column(
                        //                             children: [
                        //                               Text("Collected so far,",
                        //                                 style: GoogleFonts.inter(
                        //                                     color: clFFFFFF,
                        //                                     fontSize: 14,
                        //                                     fontWeight: FontWeight.w300
                        //                                 ),
                        //
                        //                               ),
                        //                               Row(
                        //                                 mainAxisAlignment: MainAxisAlignment.center,
                        //                                 children: [
                        //                                   // Padding(
                        //                                   //   padding:
                        //                                   //   const EdgeInsets.only(left: 0, bottom: 0),
                        //                                   //   child: Image.asset(
                        //                                   //     'assets/rs.png',
                        //                                   //     // height:15,
                        //                                   //     scale: 1.5,
                        //                                   //     color: cl1D9000,
                        //                                   //   ),
                        //                                   // ),
                        //                                   Text("₹",style: GoogleFonts.inter(color: clFFFFFF,fontSize: 45.68,fontWeight: FontWeight.w500,),),
                        //                                   Padding(
                        //                                     padding: const EdgeInsets.only(right: 5),
                        //                                     child: Text(
                        //                                         getAmount(value.totalCollection),
                        //                                         style:  GoogleFonts.changaOne(textStyle: whiteGoogle38)
                        //                                     ),
                        //                                   )
                        //                                 ],
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //
                                              ////Transactions
                        //                        InkWell(
                        //                           onTap: () async {
                        //                             if (!kIsWeb) {
                        //                               PackageInfo packageInfo =
                        //                                   await PackageInfo.fromPlatform();
                        //                               String packageName = packageInfo.packageName;
                        //                               if (packageName != 'com.spine.iumlmunnettammonitor' &&
                        //                                   packageName != 'com.spine.dhotiTv') {
                        //                                 print("ifconditionwork");
                        //                                 homeProvider.searchEt.text = "";
                        //                                 homeProvider.currentLimit = 0;
                        //                                 homeProvider.fetchReceiptList(50);
                        //                                 callNext(ReceiptListPage(from: "home", total: '', ward: '', panchayath: '', district: '', target: '',),
                        //                                     context);
                        //                               } else {
                        //                                 homeProvider.currentLimit = 50;
                        //                                 homeProvider.fetchReceiptListForMonitorApp(50);
                        //                                 callNext( ReceiptListMonitorScreen(), context);
                        //
                        //                                 // homeProvider.fetchPaymentReceiptList();
                        //                               }
                        //                             } else {
                        //                               homeProvider.searchEt.text = "";
                        //                               homeProvider.currentLimit = 50;
                        //                               homeProvider.fetchReceiptList(50);
                        //                               callNext(ReceiptListPage(from: "home", total: '', ward: '', panchayath: '', district: '', target: '',),
                        //                                   context);
                        //                             }
                        //                           },
                        //                           child: Container(
                        //                             width:136,
                        //                             height: 28,
                        //                             decoration: BoxDecoration(
                        //                                 borderRadius: BorderRadius.circular(10),
                        //                                 color: myWhite),
                        //                             child: const Row(
                        //                               mainAxisAlignment: MainAxisAlignment.center,
                        //                               children: [
                        //                                 Text("Transactions",
                        //                                 style: TextStyle(
                        //                                   fontWeight: FontWeight.w400,
                        //                                   fontSize: 14,
                        //                                   color: myBlack,
                        //                                   fontFamily: "Poppins"
                        //                                 ),),
                        //                                 Icon(Icons.arrow_forward_ios_sharp,size: 12,)
                        //                               ],
                        //                             ),
                        //                           ),
                        //                         )
                        //                       ],
                        //                     );
                        //                   }),
                        //             ),
                        //             // Container(
                        //             //   margin: const EdgeInsets.symmetric(horizontal: 20),
                        //             //   height: 135,
                        //             //   width: width,
                        //             //   decoration:  const BoxDecoration(
                        //             //     // color:Colors.blue,
                        //             //     image: DecorationImage(
                        //             //         image: AssetImage("assets/homeAmount_bgrnd.png",),
                        //             //         fit: BoxFit.fill
                        //             //     ),
                        //             //
                        //             //   ),
                        //             //   child:Row(
                        //             //     mainAxisAlignment: MainAxisAlignment.center,
                        //             //     children: [
                        //             //       // Image.asset(
                        //             //       //   "assets/splash_text.png",
                        //             //       //   scale: 5.5,
                        //             //       // ),
                        //             //       SizedBox(
                        //             //         height: 0.105*height,
                        //             //         child: Consumer<HomeProvider>(
                        //             //             builder: (context, value, child) {
                        //             //               return Column(
                        //             //                 mainAxisAlignment: MainAxisAlignment.center,
                        //             //                 children: [
                        //             //                   Text("Collected so far,",
                        //             //                     style: blackPoppinsM12,),
                        //             //                   Row(
                        //             //                     mainAxisAlignment: MainAxisAlignment.center,
                        //             //                     children: [
                        //             //                       Padding(
                        //             //                         padding:
                        //             //                         const EdgeInsets.only(left: 0, bottom: 10),
                        //             //                         child: Image.asset(
                        //             //                           'assets/rs.png',
                        //             //                           // height:15,
                        //             //                           scale: 2,
                        //             //                           color: myWhite,
                        //             //                         ),
                        //             //                       ),
                        //             //                       Padding(
                        //             //                         padding: const EdgeInsets.only(right: 5),
                        //             //                         child: Text(
                        //             //                             getAmount(value.totalCollection),
                        //             //                             style:  GoogleFonts.akshar(textStyle: whiteGoogle38)
                        //             //                         ),
                        //             //                       )
                        //             //                     ],
                        //             //                   ),
                        //             //                 ],
                        //             //               );
                        //             //             }),
                        //             //       ),
                        //             //     ],
                        //             //   ),
                        //             //
                        //             // ),
                        //           );
                        //         }
                        //     ),
                        //
                        //   ],
                        // )
                        // Container(
                        //   margin: EdgeInsets.only(left:width*.05),
                        //   height:150,
                        //   width:170,
                        //   decoration: BoxDecoration(
                        //     // color:Colors.red,
                        //     image:DecorationImage(
                        //       image:AssetImage("assets/ksdHomeTope.png")
                        //     )
                        //   ),
                        // ),

                      ),


                      ///total amount
                      ///
                      Positioned(
                        top: 230,
                        child: Consumer<HomeProvider>(
                            builder: (context,value,child) {
                              return InkWell(
                                onTap: (){
                                  // if(value.iosPaymentButton=='ON') {
                                  //   mRoot
                                  //       .child('0')
                                  //       .child('PaymentGateway36')
                                  //       .onValue
                                  //       .listen((event) {
                                  //         if (event.snapshot.value.toString() == 'ON') {
                                  //           DonationProvider donationProvider = Provider
                                  //               .of<DonationProvider>(context, listen: false);
                                  //           donationProvider.amountTC.text = "";
                                  //           donationProvider.nameTC.text = "";
                                  //           donationProvider.phoneTC.text = "";
                                  //           donationProvider.subCommitteeCT.text = "";
                                  //           donationProvider.kpccAmountController.text =
                                  //           "";
                                  //           donationProvider.onAmountChange('');
                                  //           donationProvider.clearGenderAndAgedata();
                                  //           donationProvider.selectedPanjayathChip = null;
                                  //           donationProvider.chipsetAssemblyList.clear();
                                  //           donationProvider.selectedAssembly = null;'1';
                                  //           '1';
                                  //           donationProvider.minimumbool = true;
                                  //
                                  //           callNext(DonatePage(), context);
                                  //         } else {
                                  //           callNext(const NoPaymentGateway(), context);
                                  //         }
                                  //       });
                                  // }
                                },
                                child: Container(
                                  width:width,
                                  height:115,
                                  alignment:Alignment.center,
                                  decoration:const BoxDecoration(
                                    image:DecorationImage(
                                        image:AssetImage("assets/amountBg.png",),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("₹",
                                            style: GoogleFonts.inter(
                                              color: cl019EE3,
                                              fontSize: 45.68,
                                              fontWeight: FontWeight.w700,
                                            ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 5),
                                          child: Text(
                                              getAmount(value.totalCollection),
                                              style:  GoogleFonts.balooChettan2(textStyle: whiteGoogle38)
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),


                    ],
                  ),
               ),


                  // const SizedBox(height: 23,),

              //     Container(
              //       decoration:const BoxDecoration(
              //         color: myWhite,
              //        // border:Border.all(color: Colors.white,width: 0.2),
              //         ),
              //       //  color: myRed,
              //       //  height: 50,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Padding(
              //          padding: const EdgeInsets.only(left: 20.0),
              //         child: Text(
              //           !Platform.isIOS?"Contribute":"Reports",
              //           style: b_myContributiontx,
              //         ),
              //       ),
              //       // SizedBox(
              //       //   width: width * .5,
              //       // ),
              //       Padding(
              //         padding: const EdgeInsets.only(right: 12.0),
              //         child: InkWell(
              //           onTap: (){
              //             print("1254");
              //
              //             alertSupport(context);
              //
              //           },
              //             child: Image.asset("assets/Helpline.png",scale: 3,)),
              //       ),
              //     ],
              //   ),
              // ),


                  Consumer<HomeProvider>(
                    builder: (context,home,_) {
                      return Container(
                        height: 0.23*height,
                        // width: width,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        //color: Colors.purple,
                        // decoration: BoxDecoration(
                        //  //  color: Colors.purple,
                        //   borderRadius: BorderRadius.circular(30),
                        // ),
                        child: CarouselSlider.builder(
                          itemCount:home. carousilImage.length,
                          itemBuilder: (context, index, realIndex) {
                            //final image=value.imgList[index];
                            final image = home. carousilImage[index];
                            return buildImage(image, context);
                          },
                          options: CarouselOptions(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              // autoPlayCurve: Curves.linear,
                              height: 0.212*height,
                              viewportFraction: 1,
                              autoPlay: true,
                              //enableInfiniteScroll: false,
                              pageSnapping: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              enlargeCenterPage: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              }),
                        ),
                      );
                    }
                  ),
                  buidIndiaCator(images.length, context),

                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Consumer<HomeProvider>(
                          builder: (context,value1,child) {
                            return
                              value1.iosPaymentButton =='ON'||Platform.isAndroid?
                              InkWell(
                                onTap: (){
                                  homeProvider.getVideo(context);
                                },
                                child: Container(
                                  width:140,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color:myWhite,
                                      borderRadius: BorderRadius.circular(24),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF000000).withOpacity(0.11),
                                          blurRadius: 4,
                                          // offset: Offset(0, 4),

                                        )
                                      ]
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 5,),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image.asset("assets/youtube.png",scale: 3),
                                      ),
                                      const Text("How to Pay?",
                                        style: TextStyle(fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins",
                                          color: cl434343,
                                        ),),
                                    ],
                                  ),
                                ),
                              )
                            :const SizedBox();
                          }
                      ),

                      const SizedBox(width:20),

                      Container(
                        height: 45,
                        width: 145,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  myWhite,
                                  myWhite,
                                ]),
                            boxShadow:  [
                              BoxShadow(
                                  color: c_Grey.withOpacity(0.15),
                                  blurRadius: 4,
                                  spreadRadius: 2
                              )
                            ],
                            borderRadius: BorderRadius.circular(24)
                        ),
                        child: InkWell(
                          onTap: (){
                            alertSupport(context);
                          },
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(width: 5,),
                              // Padding(
                              //   padding: const EdgeInsets.all(3.0),
                              //   child: Image.asset("assets/appsupport.png",scale: 5,),
                              // ),
                              const Icon(Icons.call_outlined,color: cl0472A5,size: 20),
                              Image.asset("assets/whatsapp.png",scale: 4,),
                              const SizedBox(width: 5,),
                              const Text("App Support",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  color:cl434343,
                                ),),
                              // Row(
                              //   children: [
                              //     SizedBox(width: 10,),
                              //     // Image.asset("assets/whatsapp.png",scale:3.6,color: myWhite,),
                              //   ],
                              // )

                            ],
                          ),
                        ),
                      ),




                    ],
                  ),

        ////
                  // Positioned(
                  //   left: 0,
                  //   bottom: 10,
                  //   child: Stack(
                  //     children: [
                  //       SizedBox(
                  //         height: 0.251*height,
                  //         width: width,
                  //         //color: Colors.purple,
                  //         // decoration: BoxDecoration(
                  //         //  //  color: Colors.purple,
                  //         //   borderRadius: BorderRadius.circular(30),
                  //         // ),
                  //         child: CarouselSlider.builder(
                  //           itemCount: images.length,
                  //           itemBuilder: (context, index, realIndex) {
                  //             //final image=value.imgList[index];
                  //             final image = images[index];
                  //             return buildImage(image, context);
                  //           },
                  //           options: CarouselOptions(
                  //             clipBehavior: Clip.antiAliasWithSaveLayer,
                  //            // autoPlayCurve: Curves.linear,
                  //               height: 0.212*height,
                  //               viewportFraction: 1,
                  //               autoPlay: true,
                  //               //enableInfiniteScroll: false,
                  //               pageSnapping: true,
                  //               enlargeStrategy: CenterPageEnlargeStrategy.height,
                  //               enlargeCenterPage: true,
                  //               autoPlayInterval: const Duration(seconds: 3),
                  //               onPageChanged: (index, reason) {
                  //                 setState(() {
                  //                   activeIndex = index;
                  //                 });
                  //               }),
                  //         ),
                  //       ),
                  //       Positioned(
                  //           left: 150,
                  //           bottom: 20,
                  //           child: buidIndiaCator(images.length, context))
                  //     ],
                  //   ),
                  // ),

                  const SizedBox(height: 8,),

                  Consumer<HomeProvider>(
                    builder: (context,val,child) {
                      return InkWell(
                        onTap: (){
                          homeProvider.getExpenses();
                          callNext(ExpensesListScreen(), context);
                        },
                        child: Container(
                          height: 148,
                          width: width,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 22),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(colors: [cl394871,cl0FA3AA]),
                            image: const DecorationImage(image: AssetImage("assets/homeExpensebg.png"),fit: BoxFit.fill),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 3.0),
                                          child: Text("₹",
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),),
                                        ),

                                        Text(getAmount(val.expenseTotal).toString(),
                                          style: GoogleFonts.balooChettan2(fontSize: 25.67,fontWeight: FontWeight.w700,color: myWhite),
                                        ),
                                      ],
                                    ),
                                    const Text("Spent so far",
                                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,fontFamily: "Poppins",color: Colors.white),),
                                    SizedBox(height: 8,)
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    }
                  ),

                  const SizedBox(height: 8,),



                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 12,),
                      Container(
                        // alignment: Alignment.bottomCenter,
                        width: 120,
                         height: 30,
                         margin: const EdgeInsets.symmetric(horizontal: 30),
                         decoration:  const BoxDecoration(

                           image:DecorationImage(image: AssetImage("assets/todayTopper.png"),fit: BoxFit.fill),
                         ),
                        child: const Center(
                          child: Text("Today's Toppers",
                            style:  TextStyle(
                                fontFamily: "ChangaOneRegular",
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: width,
                          child: Consumer<DonationProvider>(
                              builder: (context, value, child) {
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value.toppersList.length,
                                  // itemCount: 3,
                                  itemBuilder: (context, index) {
                                    var item = value.toppersList[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(width:5),
                                          item.name == 'No payments yet'
                                              ? const SizedBox(
                                            width: 20,
                                          )
                                              : Container(
                                            padding: const EdgeInsets.only(top: 4),
                                            alignment: Alignment.topCenter,
                                            // color:Colors.red,
                                            width: 30,
                                            child: Image.asset(
                                              prizes[index],
                                              width: 35,
                                              height: 35,
                                              scale: 2,
                                            ),
                                          ),
                                          const SizedBox(width: 8,),
                                          // item.name == 'No payments yet'
                                          //     ? const SizedBox(width: 100.0)
                                          //     : const SizedBox(),
                                          // item.name == 'No payments yet'
                                          //     ? const SizedBox()
                                          //     : const SizedBox(width: 20.0),
                                          // Add horizontal spacing
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // item.name == 'No payments yet'
                                                //     ? const SizedBox(
                                                //   height: 10,
                                                // )
                                                //     : const SizedBox(),
                                                // item.name == 'No payments yet'
                                                //     ? const SizedBox()
                                                //     : const SizedBox(
                                                //   width: 100,
                                                // ),
                                                const SizedBox(height: 10,),
                                                Text(
                                                  item.name,
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                    color: myBlack,
                                                  ),
                                                ),
                                                Text(
                                                  item.district,
                                                  style:  TextStyle(
                                                    color: cl4F4F4F.withOpacity(0.4),
                                                    fontSize: 10.63,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // const Spacer(),
                                          // Push the trailing text to the right
                                          item.name == 'No payments yet'
                                              ? const SizedBox()
                                              :  Text("₹"+
                                              getAmount(item.amount),
                                            style: GoogleFonts.inter(
                                                fontWeight:
                                                FontWeight.w800,
                                                fontSize: 17.76,
                                                color:myBlack
                                            ),

                                          ),
                                          const SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                 const SizedBox(height: 4,),
Consumer<HomeProvider>(
  builder: (context,hoPro,_) {
    return hoPro.homeDonationWid=='ON'? InkWell(
      onTap: (){
        hoPro. getHoseDocumentCount();
        hoPro. fetchHomeDonationList();
        callNext(const HouseDonationList(), context);
      },
      child: Container(
        height: 190,
        width: width/1.06,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/Frame 35102.png"),
              fit: BoxFit.fill)),
        child:  Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(bottom: 8,left: 10),
            padding: const EdgeInsets.only(right: 8,left: 8),
            height: 33,
            width: width/1.2,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    offset: Offset(0, 3.49),
                    blurRadius: 3.49,
                  ),
                ],
                color: myWhite,
                borderRadius: BorderRadius.circular(20)),
            child:   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text:  TextSpan(
                    children: [
                      TextSpan(
                        text:hoPro. homeDonationCount,
                        style: const TextStyle(
                          fontFamily: "poppins",
                          fontSize: 13.46,
                          color: Color(0xFF2D8EBF),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                       TextSpan(
                        text: "  ${hoPro.homeButtonContent}",
                        style: const TextStyle(
                          fontFamily: "poppins",
                          fontSize: 13.46,
                          color: Color(0xFF2D8EBF),
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),



                const Row(children: [
                Text("Tap to view",style: TextStyle(fontFamily: "interBold",fontSize: 13.46,color: cl2D8EBF,fontWeight: FontWeight.bold),),
                Icon(Icons.arrow_forward,color: cl2D8EBF,)

              ],)
            ],),
          ),
        ),


      ),
    ):const SizedBox();
  }
),
                      const SizedBox(height: 10,),

                 Consumer<HomeProvider>(
                   builder: (context,ho,_) {
                     return ho.iosPaymentButton=="ON"||Platform.isAndroid? const Text("Quick Pay",style:  TextStyle(
                         fontFamily: "Poppins",
                         color: cl4F4F4F,
                         fontSize: 16,
                         fontWeight: FontWeight.w700)):const SizedBox();
                   }
                 ),


                  Consumer<HomeProvider>(
                    builder: (context,homP,_) {
                      return homP.iosPaymentButton=="ON"||Platform.isAndroid? Container(
                         height: 125,
                        alignment: Alignment.center,
                        child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 8,
                                crossAxisCount: 3,
                                mainAxisExtent: 50),
                            padding: const EdgeInsets.all(12),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: amount.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  donationProvider.kpccAmountController.text = amount[index].toString();
                                  donationProvider.subCommitteeCT.text = "";
                                  donationProvider.nameTC.text = "";
                                  donationProvider.phoneTC.text = "";
                                  donationProvider.clearGenderAndAgedata();
                                  donationProvider.selectedPanjayathChip = null;
                                  donationProvider.chipsetWardList.clear();
                                  donationProvider.selectedWard = null;

                                  donationProvider.minimumbool=false;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DonatePage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
                                  child: Container(
                                      alignment: Alignment.center,
                                      // height: 60,
                                      width: 144,
                                      decoration:   BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                                          border: Border.all(color: cl4F4F4F,width: 0.3),
                                          color: clFFFFFF
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                              "₹ ",
                                              style: TextStyle(
                                                  color: cl4F4F4F,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)
                                          ),
                                          Text(
                                              '${amount[index]}',
                                              style: const TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: cl4F4F4F,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700)
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            }),
                      ):const SizedBox();
                    }
                  ),


              // Container(
              //   padding: EdgeInsets.all(8),
              //   margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(color: myBlack.withOpacity(0.3),width: 0.5)
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       const Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text("Volunteer Registration",
              //           textAlign: TextAlign.start,
              //           style: TextStyle(
              //             color: myBlack,
              //             fontFamily: "Poppins",
              //             fontWeight: FontWeight.w400,
              //             fontSize: 15,
              //
              //           ),),
              //           Text("Join hands to shape IUML's progress",
              //             textAlign: TextAlign.start,
              //           style: TextStyle(
              //             color: myBlack,
              //             fontFamily: "Poppins",
              //             fontSize: 10,
              //
              //           ),),
              //
              //         ],
              //       ),
              //       // SizedBox(width: 4,),
              //       Consumer<HomeProvider>(
              //         builder: (context,value2,child) {
              //           return InkWell(
              //             onTap: () async {
              //               print("device click here");
              //                 HomeProvider homeProvider =
              //                 Provider.of<HomeProvider>(context, listen: false);
              //                 await homeProvider.checkEnrollerDeviceID();
              //                 if (value2.enrollerDeviceID) {
              //                   print("deviceid already exixt");
              //                   deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
              //                 } else {
              //                   homeProvider.clearEnrollerData();
              //                   callNext(BeAnEnroller(), context);
              //                 }
              //             },
              //             child: Container(
              //               height: 45,
              //               width: 120,
              //               alignment: Alignment.center,
              //               decoration: BoxDecoration(
              //                   gradient: const LinearGradient(
              //                       begin: Alignment.topLeft,
              //                       end: Alignment.bottomRight,
              //                       colors: [
              //                         cl1D9000,
              //                         cl20A200,
              //                       ]),
              //                   borderRadius: BorderRadius.circular(13)
              //               ),
              //               child: const Text("Volunteer Now",
              //                 style: TextStyle(color: Colors.white,
              //                     fontSize: 13,fontFamily: "Poppins",
              //                     fontWeight: FontWeight.w500),),
              //             ),
              //           );
              //         }
              //       )
              //     ],
              //   ),
              // ),

              Container(
                padding: const EdgeInsets.all(0),
                // color:myWhite,
                child: Consumer<HomeProvider>(
                  builder: (context,val,child) {
                    return val.lockReport=="OFF"&&val.lockTopReport == "OFF"?
                    GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 0,
                            crossAxisCount: 4 ,
                            mainAxisExtent: 95),
                        itemCount: contriImg.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Consumer<HomeProvider>(
                              builder: (context, value2, child) {
                            return InkWell(
                              onTap: () async {

                                 if (index == 0) {
                                //Transactions
                                   if (!kIsWeb) {
                                     PackageInfo packageInfo =
                                     await PackageInfo.fromPlatform();
                                     String packageName = packageInfo.packageName;
                                     if (packageName != 'com.spine.iumlmunnettammonitor' &&
                                         packageName != 'com.spine.dhotiTv') {
                                       print("ifconditionwork");
                                       homeProvider.searchEt.text = "";
                                       homeProvider.currentLimit = 50;
                                       homeProvider.fetchReceiptList(50);
                                       callNext(ReceiptListPage(from: "home", total: '', ward: '', panchayath: '', district: '',  target: '',),
                                           context);
                                     } else {
                                       homeProvider.currentLimit = 50;
                                       homeProvider.fetchReceiptListForMonitorApp(50);
                                       callNext( ReceiptListMonitorScreen(), context);

                                       // homeProvider.fetchPaymentReceiptList();
                                     }
                                   } else {
                                     homeProvider.searchEt.text = "";
                                     homeProvider.currentLimit = 50;
                                     homeProvider.fetchReceiptList(50);
                                     callNext(ReceiptListPage(from: "home", total: '', ward: '', panchayath: '', district: '',  target: '',),
                                         context);
                                   }
                                }
                                 if (index == 1) {
                                //My History
                                homeProvider.fetchHistoryFromFireStore();
                                callNext(PaymentHistory(), context);
                                }
                                if (index == 3) {
                                  //Report
                                  homeProvider.selectedDistrict = null;
                                  homeProvider.selectedPanjayath = null;
                                  homeProvider.selectedUnit = null;
                                  homeProvider.panchayathTarget=0.0;
                                  homeProvider.panchayathPosterPanchayath="";
                                  homeProvider.panchayathPosterAssembly="";
                                  homeProvider.panchayathPosterDistrict="";
                                  homeProvider.panchayathPosterComplete=false;
                                  homeProvider.panchayathPosterNotCompleteComplete=false;
                                   homeProvider.fetchDropdown('', '');
                                  homeProvider.fetchWard("");
                                  // callNext(WardHistory(), context);
                                  callNext(WardHistoryHome(), context);
                                }
                                else if (index == 2) {
                                  //Lead
                                  homeProvider.topLeadPayments();
                                  callNext(LeadReport(), context);
                                }
                                else if (index == 7) {
                                  //Topper's\nClub
                                  // callNext( DistrictReport(from: '',), context);
                                  callNext( const ToppersHomeScreen(), context);
                                  homeProvider.fetchTopKmccReport();
                                }
                                else if (index == 6){
                                  //Top\nVolunteers
                                  homeProvider.getTopEnrollers();
                                  callNext(const TopEnrollersScreen(), context);
                                }
                                else if (index == 4) {
                                  //Volunteer\nRegistration
                                  print("device click here");
                                  HomeProvider homeProvider =
                                  Provider.of<HomeProvider>(context, listen: false);
                                  await homeProvider.checkEnrollerDeviceID();
                                  if (value2.enrollerDeviceID) {
                                    print("deviceid already exixt");
                                    deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                  } else {
                                    homeProvider.clearEnrollerData();
                                    callNext(BeAnEnroller(), context);
                                  }
                                }
                                else if (index == 5) {
                                  //Volunteer\nPayments
                                  print("clikk22334");
                                  homeProvider.clearEnrollerDetails();
                                  callNext(const EnrollerPaymentsScreen(), context);
                                }
                              },
                              child: Center(
                                child: Container(
                                    padding: const EdgeInsets.all(0),
                                    alignment: Alignment.center,
                                    // width: width * .21,
                                    // height: 48,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Consumer<HomeProvider>(
                                      builder: (context,val,child) {

                                        return Column(
                                          mainAxisAlignment:  MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                           SizedBox(
                                              height: 60,
                                              // width: 45,
                                              child: Image.asset(
                                                contriImg[index],
                                                // width: 45,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            const SizedBox(height: 4,),
                                         Container(
                                              // alignment: Alignment.center,
                                              // width: width,
                                              // height: 35,
                                              // color:Colors.yellow,
                                              child:   Text(
                                                contriText[index],
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: myBlack,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),

                                          ],
                                        );
                                      }
                                    )),
                              ),
                            );
                          });
                        }):
                    GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 0,
                            crossAxisCount: 3 ,
                            mainAxisExtent: 95),
                        itemCount: contriImgNew.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Consumer<HomeProvider>(
                              builder: (context, value2, child) {
                                return InkWell(
                                  onTap: () async {

                                    if (index == 0) {
                                      //Transactions
                                      if (!kIsWeb) {
                                        PackageInfo packageInfo =
                                        await PackageInfo.fromPlatform();
                                        String packageName = packageInfo.packageName;
                                        if (packageName != 'com.spine.iumlmunnettammonitor' &&
                                            packageName != 'com.spine.dhotiTv') {
                                          print("ifconditionwork");
                                          homeProvider.searchEt.text = "";
                                          homeProvider.currentLimit = 50;
                                          homeProvider.fetchReceiptList(50);
                                          callNext(ReceiptListPage(from: "home", total: '', ward: '', panchayath: '', district: '',  target: '',),
                                              context);
                                        } else {
                                          homeProvider.currentLimit = 50;
                                          homeProvider.fetchReceiptListForMonitorApp(50);
                                          callNext( ReceiptListMonitorScreen(), context);

                                          // homeProvider.fetchPaymentReceiptList();
                                        }
                                      } else {
                                        homeProvider.searchEt.text = "";
                                        homeProvider.currentLimit = 50;
                                        homeProvider.fetchReceiptList(50);
                                        callNext(ReceiptListPage(from: "home", total: '', ward: '', panchayath: '', district: '',  target: '',),
                                            context);
                                      }
                                    }
                                    if (index == 1) {
                                      //My History
                                      homeProvider.fetchHistoryFromFireStore();
                                      callNext(PaymentHistory(), context);
                                    }
                                    // if (index == 3) {
                                    //   //Report
                                    //   homeProvider.selectedDistrict = null;
                                    //   homeProvider.selectedPanjayath = null;
                                    //   homeProvider.selectedUnit = null;
                                    //   homeProvider.panchayathTarget=0.0;
                                    //   homeProvider.panchayathPosterPanchayath="";
                                    //   homeProvider.panchayathPosterAssembly="";
                                    //   homeProvider.panchayathPosterDistrict="";
                                    //   homeProvider.panchayathPosterComplete=false;
                                    //   homeProvider.panchayathPosterNotCompleteComplete=false;
                                    //   homeProvider.fetchDropdown('', '');
                                    //   homeProvider.fetchWard("");
                                    //   // callNext(WardHistory(), context);
                                    //   callNext(WardHistoryHome(), context);
                                    // }
                                    else if (index == 2) {
                                      //Lead
                                      homeProvider.topLeadPayments();
                                      callNext(LeadReport(), context);
                                    }
                                    // else if (index == 7) {
                                    //   //Topper's\nClub
                                    //   // callNext( DistrictReport(from: '',), context);
                                    //   callNext( const ToppersHomeScreen(), context);
                                    //   homeProvider.fetchTopKmccReport();
                                    // }
                                    else if (index == 5){
                                      //Top\nVolunteers
                                      homeProvider.getTopEnrollers();
                                      callNext(const TopEnrollersScreen(), context);
                                    }
                                    else if (index == 3) {
                                      //Volunteer\nRegistration
                                      print("device click here");
                                      HomeProvider homeProvider =
                                      Provider.of<HomeProvider>(context, listen: false);
                                      await homeProvider.checkEnrollerDeviceID();
                                      if (value2.enrollerDeviceID) {
                                        print("deviceid already exixt");
                                        deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                      } else {
                                        homeProvider.clearEnrollerData();
                                        callNext(BeAnEnroller(), context);
                                      }
                                    }
                                    else if (index ==4) {
                                      //Volunteer\nPayments
                                      print("clikk22334");
                                      homeProvider.clearEnrollerDetails();
                                      callNext(const EnrollerPaymentsScreen(), context);
                                    }
                                  },
                                  child: Center(
                                    child: Container(
                                        padding: const EdgeInsets.all(0),
                                        alignment: Alignment.center,
                                        // width: width * .21,
                                        // height: 48,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)),
                                        child: Consumer<HomeProvider>(
                                            builder: (context,val,child) {

                                              return Column(
                                                mainAxisAlignment:  MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 60,
                                                    // width: 45,
                                                    child: Image.asset(
                                                      contriImgNew[index],
                                                      // width: 45,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4,),
                                                  Container(
                                                    // alignment: Alignment.center,
                                                    // width: width,
                                                    // height: 35,
                                                    // color:Colors.yellow,
                                                    child:   Text(
                                                      contriTextNew[index],
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.poppins(
                                                          color: myBlack,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),

                                                ],
                                              );
                                            }
                                        )),
                                  ),
                                );
                              });
                        });
                  }
                 ),
                 ),

              const SizedBox(height: 10,),
              Container(
                // color: myWhite,
                child: Container(

                 height: 58,
                 // 0.15*height,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8,top: 10),
                          child: InkWell(
                            onTap:(){
                              if(index==1){
                                alertTermsAndConditions(context);
                              }else if(index==2){
                                alertContact(context);
                              }else if(index==0){
                                alertTerm(context);

                              }else if(index==3){
                                alertAbout(context);

                              }

                            },
                            child: Container(
                              // padding: const EdgeInsets.symmetric(horizontal: 8),
                              alignment: Alignment.center,
                              height: 30,
                              padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                  color:myWhite,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  // border: Border.all(color: clE1E1E1),
                                  boxShadow: [
                                    BoxShadow(
                                        color:cl000000.withOpacity(0.25),
                                        // spreadRadius:,
                                        blurRadius:3,
                                        offset: const Offset(0, 1.78)
                                    )
                                  ]
                              ),
                              child: Row(
                                children: [
                                  Icon( PTCIcon[index],size:17,),
                                  const SizedBox(width:2),
                                  Text(
                                    PTCText[index],
                                    style: const TextStyle(
                                        color: cl4F4F4F,
                                        fontSize: 11,
                                        fontFamily: "Lato",
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                    ),
              ),

                  Consumer<HomeProvider>(builder: (context, value, child) {
                    print("aaaaaaaaaaaaaaaa"+value.buildNumber);
                  return Container(
                    // color: myWhite,
                    child: Align(
                      alignment: Alignment.center,
                        child: Text("Version:${value.appVersion}.${value.buildNumber}.${value.currentVersion}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 8),)),
                  );
                }
              ),
               Container(
                // color: myWhite,
                height: 80,
              )
            ])),
          ),

          ///old body singlechid ,dont remove it
          ///

          ///floating action button
          floatingActionButton: Consumer<HomeProvider>(builder: (context, value, child) {
            return
              ((value.iosPaymentButton == 'ON'))||Platform.isAndroid ?
            Padding(
                    padding: const EdgeInsets.only(left: 0.0, right: 2),
                    child:
                    InkWell(
                      onTap: () {
                        // homeProvider.testBase();
                        mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
                          if (event.snapshot.value.toString() != 'ON') {
                            DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                            donationProvider.amountTC.text = "";
                            donationProvider.nameTC.text = "";
                            donationProvider.phoneTC.text = "";
                            donationProvider.subCommitteeCT.text = "";
                            donationProvider.kpccAmountController.text = "";
                            donationProvider.onAmountChange('');
                            donationProvider.clearGenderAndAgedata();
                            donationProvider.selectedPanjayathChip = null;
                            donationProvider.chipsetWardList.clear();
                            donationProvider.selectedWard = null;'1';
                            donationProvider.minimumbool=true;
                            callNext(DonatePage(), context);
                          } else {
                            callNext(const NoPaymentGateway(), context);
                          }
                        });
                      },
                      child:
                      // SizedBox(
                      //   width: width * .900,
                      //   child: SwipeableButtonView(
                      //
                      //     buttonText: 'Participate Now',
                      //   buttontextstyle: const TextStyle(
                      //     fontSize: 21,
                      //       color: myWhite, fontWeight: FontWeight.bold
                      //   ),
                      //   //  buttonColor: Colors.yellow,
                      //     buttonWidget: Container(
                      //       child: const Icon(
                      //         Icons.arrow_forward_ios_rounded,
                      //         color: Colors.grey,
                      //       ),
                      //     ),
                      //    // activeColor:isFinished==false? const Color(0xFF051270):Colors.white.withOpacity(0.8),
                      //
                      //     activeColor:isFinished==false?  cl_34CC04:cl_34CC04,//change button color
                      //     disableColor: Colors.purple,
                      //
                      //     isFinished: isFinished,
                      //     onWaitingProcess: () {
                      //       Future.delayed(const Duration(milliseconds: 10), () {
                      //         setState(() {
                      //           isFinished = true;
                      //         });
                      //       });
                      //     },
                      //     onFinish: () async {
                      //       mRoot.child('0').child('PaymentGateway35').onValue.listen((event) {
                      //         if (event.snapshot.value.toString() == 'ON') {
                      //           DonationProvider donationProvider =
                      //           Provider.of<DonationProvider>(context,
                      //               listen: false);
                      //           donationProvider.amountTC.text = "";
                      //           donationProvider.nameTC.text = "";
                      //           donationProvider.phoneTC.text = "";
                      //           donationProvider.kpccAmountController.text = "";
                      //           donationProvider.onAmountChange('');
                      //           donationProvider.clearGenderAndAgedata();
                      //           donationProvider.selectedPanjayathChip = null;
                      //           donationProvider.chipsetWardList.clear();
                      //           donationProvider.selectedWard = null;
                      //           '1';
                      //
                      //           callNext(DonatePage(), context);
                      //         } else {
                      //           callNext(const NoPaymentGateway(), context);
                      //         }
                      //       });
                      //       setState(() {
                      //         isFinished = false;
                      //       });
                      //     },
                      //   ),
                      // )
                      ///
                      Container(
                        height: 50,
                        width: width * .83,
                        decoration:  BoxDecoration(
                          boxShadow:  [
                            const BoxShadow(
                              color:cl1E9201,
                            ),
                            BoxShadow(
                              color: cl000000.withOpacity(0.25),
                              spreadRadius: -5.0,
                              // blurStyle: BlurStyle.inner,
                              blurRadius: 20.0,
                            ),

                          ],
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [cl0EA3A9,cl3686C5]),

                        ),
                        child:  Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/CoinGif.gif"),
                                const Text(
                                  "Participate Now",
                                  style: TextStyle(
                                fontSize: 15,
                                  fontFamily: "Poppins",
                                  color: myWhite, fontWeight: FontWeight.w500),
                                                      ),
                              ],
                            )),
                      ),
                    ),
                  )
                : const SizedBox();
          }),
        ),
      ):
      Scaffold(
        backgroundColor: clFFFFFF,
        body: Container(
          width:width,
          child: Stack(
            children: [


              SizedBox(
                width:width,
                // color:Colors.blue,
                child: Row(
                  children: [
                    Expanded(
                        flex:1,
                        child: Container(
                          // color:Colors.red,
                            child:Image.asset("assets/TvLeft4x.png",fit: BoxFit.cover)
                        )),
                    Expanded(
                      flex:1,
                      child: Container(
                        // color:Colors.red,
                        // width:500,
                        height: height,
                        child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(children: [
                              SizedBox(
                                height: 445,//height*.58
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        width: width,
                                        height:380,//380
                                        // height: 0.42*height,
                                        decoration:   BoxDecoration(
                                          color: Colors.grey.withOpacity(0.3),
                                          image: const DecorationImage(
                                            image: AssetImage("assets/ksdHomeTpImg.jpeg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.only(left:width*.05),
                                          height:150,
                                          width:170,
                                          decoration: const BoxDecoration(
                                            // color:Colors.red,
                                              image:DecorationImage(
                                                  image:AssetImage("assets/ksdHomeTope.png")
                                              )
                                          ),
                                        ),
                                      ),
                                    ),


                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: InkWell(
                                        onTap: (){
                                          mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
                                            if (event.snapshot.value.toString() == 'ON') {
                                              DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                              donationProvider.amountTC.text = "";
                                              donationProvider.nameTC.text = "";
                                              donationProvider.phoneTC.text = "";
                                              donationProvider.subCommitteeCT.text = "";
                                              donationProvider.kpccAmountController.text = "";
                                              donationProvider.onAmountChange('');
                                              donationProvider.clearGenderAndAgedata();
                                              donationProvider.selectedPanjayathChip = null;
                                              donationProvider.chipsetWardList.clear();
                                              donationProvider.selectedWard = null;'1';
                                              donationProvider.minimumbool=true;

                                              callNext(DonatePage(), context);
                                            } else {
                                              callNext(const NoPaymentGateway(), context);
                                            }
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 20),
                                          height: 135,
                                          width: width,
                                          decoration:  const BoxDecoration(
                                            // color:Colors.blue,
                                            image: DecorationImage(
                                                image: AssetImage("assets/homeAmount_bgrnd.png",),
                                                fit: BoxFit.fill
                                            ),

                                          ),
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Image.asset(
                                              //   "assets/splash_text.png",
                                              //   scale: 5.5,
                                              // ),
                                              SizedBox(
                                                height: 0.105*height,
                                                child: Consumer<HomeProvider>(
                                                    builder: (context, value, child) {
                                                      return Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text("Collected so far,",
                                                            style: blackPoppinsM12,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.only(left: 0, bottom: 10),
                                                                child: Image.asset(
                                                                  'assets/rs.png',
                                                                  // height:15,
                                                                  scale: 2,
                                                                  color: myWhite,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(right: 5),
                                                                child: Text(
                                                                    getAmount(value.totalCollection),
                                                                    style:  GoogleFonts.akshar(textStyle: whiteGoogle38)
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),

                                        ),
                                      ),
                                    ),

                                    // Positioned(
                                    //   left: 0,
                                    //   bottom: 10,
                                    //   child: Stack(
                                    //     children: [
                                    //       SizedBox(
                                    //         height: 0.251*height,
                                    //         width: width,
                                    //         //color: Colors.purple,
                                    //         // decoration: BoxDecoration(
                                    //         //  //  color: Colors.purple,
                                    //         //   borderRadius: BorderRadius.circular(30),
                                    //         // ),
                                    //         child: CarouselSlider.builder(
                                    //           itemCount: images.length,
                                    //           itemBuilder: (context, index, realIndex) {
                                    //             //final image=value.imgList[index];
                                    //             final image = images[index];
                                    //             return buildImage(image, context);
                                    //           },
                                    //           options: CarouselOptions(
                                    //             clipBehavior: Clip.antiAliasWithSaveLayer,
                                    //            // autoPlayCurve: Curves.linear,
                                    //               height: 0.212*height,
                                    //               viewportFraction: 1,
                                    //               autoPlay: true,
                                    //               //enableInfiniteScroll: false,
                                    //               pageSnapping: true,
                                    //               enlargeStrategy: CenterPageEnlargeStrategy.height,
                                    //               enlargeCenterPage: true,
                                    //               autoPlayInterval: const Duration(seconds: 3),
                                    //               onPageChanged: (index, reason) {
                                    //                 setState(() {
                                    //                   activeIndex = index;
                                    //                 });
                                    //               }),
                                    //         ),
                                    //       ),
                                    //       Positioned(
                                    //           left: 150,
                                    //           bottom: 20,
                                    //           child: buidIndiaCator(images.length, context))
                                    //     ],
                                    //   ),
                                    // ),

                                  ],
                                ),
                              ),

                              // const SizedBox(height: 23,),

                              //     Container(
                              //       decoration:const BoxDecoration(
                              //         color: myWhite,
                              //        // border:Border.all(color: Colors.white,width: 0.2),
                              //         ),
                              //       //  color: myRed,
                              //       //  height: 50,
                              //         child: Row(
                              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Padding(
                              //          padding: const EdgeInsets.only(left: 20.0),
                              //         child: Text(
                              //           !Platform.isIOS?"Contribute":"Reports",
                              //           style: b_myContributiontx,
                              //         ),
                              //       ),
                              //       // SizedBox(
                              //       //   width: width * .5,
                              //       // ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(right: 12.0),
                              //         child: InkWell(
                              //           onTap: (){
                              //             print("1254");
                              //
                              //             alertSupport(context);
                              //
                              //           },
                              //             child: Image.asset("assets/Helpline.png",scale: 3,)),
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              const SizedBox(height: 20,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 38,
                                    width: 163,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow:  [
                                          BoxShadow(
                                              color: c_Grey.withOpacity(0.15),
                                              blurRadius: 2,
                                              spreadRadius: 2
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(19)
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        alertSupport(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text("Support",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "PoppinsMedium",
                                              color:cl3655A2,
                                            ),),
                                          Row(
                                            children: [
                                              const Icon(Icons.phone,size: 17,),
                                              const SizedBox(width: 10,),
                                              Image.asset("assets/whatsapp.png",scale:3.6,),
                                            ],
                                          )

                                        ],
                                      ),
                                    ),
                                  ),

                                  Consumer<HomeProvider>(
                                    builder: (context,value11,child) {
                                      return
                                        value11.iosPaymentButton =='ON'?
                                        InkWell(
                                        onTap: (){
                                          homeProvider.getVideo(context);
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0,right: 2),
                                              child: Image.asset("assets/youtube.png",scale: 2,),
                                            ),
                                            const Text("How to Pay?",
                                              style: TextStyle(fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "PoppinsMedium",
                                                color: cl3655A2,
                                              ),),
                                          ],
                                        ),
                                      ):const SizedBox();
                                    }
                                  ),


                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 20.0,bottom: 8),
                                child: Container(
                                  height: 100,
                                  width: width,
                                  decoration: const BoxDecoration(
                                      color: clFFFFFF,
                                      boxShadow: [
                                        BoxShadow(
                                            color: cl0x40CACACA,
                                            blurRadius: 16
                                        )

                                      ]

                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:12,bottom: 8,right: 8),
                                        child: Image.asset("assets/todaysTopper.png",scale: 3.3,),
                                      ),
                                      Container(width: 1,color: clD4D4D4,margin: const EdgeInsets.only(top: 12,bottom: 12),),
                                      // const VerticalDivider(color: clD4D4D4,thickness: 1,endIndent: 12,indent: 12,),
                                      Flexible(
                                        fit:FlexFit.tight,
                                        child: Consumer<DonationProvider>(
                                            builder: (context,value,child) {
                                              return Container(
                                                // color: Colors.yellow,
                                                // width: width/1.9,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(height: 2,),
                                                      Container(
                                                        width: width/2,
                                                        // color: Colors.red,
                                                        child: Text(
                                                          value.todayTopperName,
                                                          style: const TextStyle(
                                                              height: 1.3,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: "PoppinsMedium",
                                                              color: cl3655A2),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2,),
                                                      value.todayTopperPlace != ""
                                                          ? Text(
                                                        value.todayTopperPlace,
                                                        style: const TextStyle(
                                                            height: 1.3,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: "PoppinsMedium",
                                                            color: cl6B6B6B),
                                                      )
                                                          : const SizedBox(),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          value.todayTopperPanchayath=="FAMILY CONTRIBUTION"?const SizedBox():
                                                          Text(
                                                            value.todayTopperPanchayath,
                                                            style: const TextStyle(
                                                                height: 1.3,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w400,
                                                                fontFamily: "PoppinsMedium",
                                                                color: cl6B6B6B
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Padding(
                                                                padding: EdgeInsets.only(
                                                                    right: 2),
                                                                child: SizedBox(
                                                                  height: 15,
                                                                  child: Text(
                                                                    "₹",
                                                                    style: TextStyle(color: clblue,fontSize: 16),
                                                                    // scale: 7,
                                                                    // color: myBlack2,
                                                                  ),
                                                                ),
                                                              ),
                                                              AutoSizeText(
                                                                getAmount(value.todayTopperAmount),
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontFamily: "PoppinsMedium",
                                                                    fontSize: 18,
                                                                    color: clblue),
                                                              )
                                                            ],
                                                          ),

                                                          // AutoSizeText.rich(
                                                          //   TextSpan(children: [
                                                          //     const TextSpan(
                                                          //         text: "₹ ",
                                                          //         style: TextStyle(fontSize: 14,color: cl323A71)),
                                                          //     TextSpan(
                                                          //       text: getAmount(value.todayTopperAmount),
                                                          //       style: const TextStyle(
                                                          //           fontWeight: FontWeight.w700,
                                                          //           fontFamily: "PoppinsMedium",
                                                          //           fontSize: 18,
                                                          //           color: cl323A71
                                                          //       ),
                                                          //     )
                                                          //   ]),
                                                          //   textAlign: TextAlign.center,
                                                          //   minFontSize: 5,
                                                          //   maxFontSize: 18,
                                                          //   maxLines: 1,
                                                          // ),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 40,),

                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),

                              amount.isEmpty
                                  ? const SizedBox()
                                  : Container(
                                height: 125,
                                alignment: Alignment.center,
                                child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 2,
                                        mainAxisExtent: 50),
                                    padding: const EdgeInsets.all(12),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: amount.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          donationProvider.kpccAmountController.text = amount[index].toString();
                                          donationProvider.subCommitteeCT.text = "";
                                          donationProvider.nameTC.text = "";
                                          donationProvider.phoneTC.text = "";
                                          donationProvider.clearGenderAndAgedata();
                                          donationProvider.selectedPanjayathChip = null;
                                          donationProvider.chipsetWardList.clear();
                                          donationProvider.selectedWard = null;
                                          donationProvider.minimumbool=false;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => DonatePage()));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
                                          child: Container(
                                              height: 42,
                                              width: 144,
                                              decoration:  const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:  cl0x40CACACA,
                                                        spreadRadius: 2,
                                                        blurRadius: 20
                                                    )
                                                  ],
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  color: clFFFFFF
                                              ),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 0,top: 2.0,bottom: 2),
                                                      child: CircleAvatar(
                                                        backgroundColor: colors[index],
                                                        radius: 33,
                                                        foregroundImage: const AssetImage("assets/CoinGif.gif",),
                                                        // child: Image.asset("assets/CoinGif.gif",width: 80,),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.only(top: 5.0),
                                                          child: Text(
                                                              "₹ ",
                                                              style: TextStyle(
                                                                  color: cl264186,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500)
                                                          ),
                                                        ),
                                                        Text(
                                                            '${amount[index]}',
                                                            style: const TextStyle(
                                                                fontFamily: "PoppinsMedium",
                                                                color: cl264186,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w700)
                                                        ),
                                                        const SizedBox(width: 10,)
                                                        // RichText(textAlign: TextAlign.start,
                                                        //   text: TextSpan(children: [
                                                        //     const TextSpan(
                                                        //         text: "₹ ",
                                                        //         style: TextStyle(
                                                        //             color: myBlack,
                                                        //             fontSize: 12,
                                                        //             fontWeight: FontWeight.w500),),
                                                        //     TextSpan(
                                                        //         text: '${amount[index]}',
                                                        //         style: const TextStyle(
                                                        //             fontFamily: "PoppinsMedium",
                                                        //             color: cl323A71,
                                                        //             fontSize: 20,
                                                        //             fontWeight: FontWeight.w700)),
                                                        //   ]),
                                                        // ),
                                                      ],
                                                    )
                                                  ])),
                                        ),
                                      );
                                    }),
                              ),

                              Container(
                                padding: const EdgeInsets.all(0),
                                // color:myWhite,
                                child: GridView.builder(
                                    padding: const EdgeInsets.all(25),
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 0,
                                        crossAxisCount: 4,
                                        mainAxisExtent: 95),
                                    itemCount: contriImg.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Consumer<HomeProvider>(
                                          builder: (context, value2, child) {
                                            return InkWell(
                                              onTap: () async {

                                                if (index == 0) {
                                                  //Transactions
                                                  if (!kIsWeb) {
                                                    PackageInfo packageInfo =
                                                    await PackageInfo.fromPlatform();
                                                    String packageName = packageInfo.packageName;
                                                    if (packageName != 'com.spine.iumlmunnettammonitor' &&
                                                        packageName != 'com.spine.dhotiTv') {
                                                      print("ifconditionwork");
                                                      homeProvider.searchEt.text = "";
                                                      homeProvider.currentLimit = 0;
                                                      homeProvider.fetchReceiptList(50);
                                                      callNext(ReceiptListPage(from: "home", total: '', ward: '', panchayath: '', district: '', target: '',),
                                                          context);
                                                    } else {
                                                      homeProvider.currentLimit = 50;
                                                      homeProvider.fetchReceiptListForMonitorApp(50);
                                                      callNext( ReceiptListMonitorScreen(), context);

                                                      // homeProvider.fetchPaymentReceiptList();
                                                    }
                                                  } else {
                                                    homeProvider.searchEt.text = "";
                                                    homeProvider.currentLimit = 50;
                                                    homeProvider.fetchReceiptList(50);
                                                    callNext(ReceiptListPage(from: "home", total: '', ward: '', panchayath: '', district: '', target: ''),
                                                        context);
                                                  }
                                                }
                                                else if (index == 1) {
                                                  //My History
                                                  homeProvider.fetchHistoryFromFireStore();
                                                  callNext(PaymentHistory(), context);
                                                }
                                                if (index == 2) {
                                                  //Report
                                                  homeProvider.selectedDistrict = null;
                                                  homeProvider.selectedPanjayath = null;
                                                  homeProvider.selectedUnit = null;
                                                  homeProvider.panchayathTarget=0.0;
                                                  homeProvider.panchayathPosterPanchayath="";
                                                  homeProvider.panchayathPosterAssembly="";
                                                  homeProvider.panchayathPosterDistrict="";
                                                  homeProvider.panchayathPosterComplete=false;
                                                  homeProvider.panchayathPosterNotCompleteComplete=false;
                                                  homeProvider.fetchDropdown('', '');
                                                  homeProvider.fetchWard('');
                                                  callNext(WardHistory(), context);
                                                }
                                                else if (index == 3) {
                                                  //Lead
                                                  homeProvider.topLeadPayments();
                                                  callNext(LeadReport(), context);
                                                }
                                                else if (index == 4) {
                                                  //Topper's\nClub
                                                  // callNext( DistrictReport(from: '',), context);
                                                  callNext( const ToppersHomeScreen(), context);
                                                  homeProvider.fetchDistrictWiseReport();
                                                }
                                                else if (index == 5){
                                                  //Top\nVolunteers
                                                  homeProvider.getTopEnrollers();
                                                  callNext(const TopEnrollersScreen(), context);
                                                }
                                                else if (index == 6) {
                                                  //Volunteer\nRegistration
                                                  print("device click here");
                                                  HomeProvider homeProvider =
                                                  Provider.of<HomeProvider>(context, listen: false);
                                                  await homeProvider.checkEnrollerDeviceID();
                                                  if (value2.enrollerDeviceID) {
                                                    print("deviceid already exixt");
                                                    deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                                  } else {
                                                    homeProvider.clearEnrollerData();
                                                    callNext(BeAnEnroller(), context);
                                                  }
                                                }
                                                else if (index == 7) {
                                                  //Volunteer\nPayments
                                                  print("clikk22334");
                                                  homeProvider.clearEnrollerDetails();
                                                  callNext(const EnrollerPaymentsScreen(), context);
                                                }
                                              },
                                              child: Center(
                                                child: Container(
                                                    padding: const EdgeInsets.all(0),
                                                    alignment: Alignment.center,
                                                    width: width * .20,
                                                    // height: 48,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15)),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          decoration: const BoxDecoration(
                                                            shape:BoxShape.circle,
                                                            gradient: LinearGradient(
                                                              begin: Alignment(0.00, -1.00),
                                                              end: Alignment(0, 1),
                                                              colors: [cl3655A2, cl264186],
                                                            ),
                                                          ),
                                                          height: 55,
                                                          child: Image.asset(
                                                            contriImg[index],
                                                            scale: 3,
                                                          ),
                                                        ),
                                                        Container(
                                                            alignment: Alignment.center,
                                                            width: width,
                                                            height: 35,
                                                            // color:Colors.yellow,
                                                            child: Text(
                                                              contriText[index],
                                                              textAlign: TextAlign.center,
                                                              style: const TextStyle(
                                                                  fontFamily: "PoppinsMedium",
                                                                  fontSize: 11,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: cl3655A2
                                                              ),
                                                              overflow: TextOverflow.fade,
                                                            )),

                                                      ],
                                                    )),
                                              ),
                                            );
                                          });
                                    }),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 10, 30,0),
                                child: SizedBox(
                                    height: 0.15*height,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: 3,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          onTap:(){
                                            if(index==1){
                                              alertTermsAndConditions(context);
                                            }else if(index==2){
                                              alertContact(context);
                                            }else if(index==0){
                                              alertTerm(context);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 12.0,left: 12),
                                            child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius:30,
                                                    backgroundColor: clF8F8F8,
                                                    child: Image.asset(
                                                      PTCImg[index],
                                                      scale: 3,
                                                      color: cl3655A2,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    PTCText[index],
                                                    style: const TextStyle(
                                                        color: myBlack,
                                                        fontSize: 11,
                                                        fontFamily: "Lato",
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                ]),
                                          ),
                                        );
                                      },
                                    )
                                ),
                              ),

                              Consumer<HomeProvider>(builder: (context, value, child) {
                                print("aaaaaaaaaaaaaaaa"+value.buildNumber);
                                return Container(
                                  // color: myWhite,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Version:${value.appVersion}.${value.buildNumber}.${value.currentVersion}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 8),)),
                                );
                              }
                              ),
                              Container(
                                // color: myWhite,
                                height: 80,
                              )
                            ])),
                      ),
                    ),

                    Expanded(
                        flex:1,
                        child: Container(
                          // color:Colors.green,
                            child:Image.asset("assets/TvRight4x.png",fit: BoxFit.cover,)
                        )),
                  ],
                ),
              ),

              Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return
                      value.isLaunched ?
                      Align(
                        alignment:Alignment.topRight ,
                        child:ConfettiWidget(
                          gravity: .3,
                          minBlastForce: 5, maxBlastForce: 800,
                          numberOfParticles: 500,
                          confettiController: controllerCenter,
                          blastDirectionality: BlastDirectionality.explosive,
                          // don't specify a direction, blast randomly
                          //blastDirection: BorderSide.strokeAlignOutside,
                          shouldLoop: true, // start again as soon as the animation is finished
                          colors: const [
                            Color(0xFFFFDF00),//Golden yellow
                            Color(0xFFD4AF37),//Metallic gold
                            Color(0xFFCFB53B),//Old gold
                            Color(0xFFC5B358),//Old gold
                            // Colors.green,
                            // Colors.blue,
                            // Colors.pink,
                            // Colors.orange,
                            // Colors.purple,
                            // Colors.red,
                            // Colors.greenAccent,
                            // Colors.white,
                            // Colors.lightGreen,
                            // Colors.lightGreenAccent
                          ], // manually specify the colors to be used
                          createParticlePath: value.drawStar, // define a custom shape/path.
                        ),
                      )
                          :const SizedBox();
                  }
              ),

              Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return value.isLaunched
                        ?Align(
                      alignment:Alignment.bottomLeft,
                      child: ConfettiWidget(
                        gravity: .3,
                        minBlastForce: 5, maxBlastForce: 800,
                        numberOfParticles: 500,
                        confettiController: controllerCenter,
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: true,
                        colors: const [
                          Color(0xFFFFDF00), //Golden yellow
                          Color(0xFFD4AF37), //Metallic gold
                          Color(0xFFCFB53B), //Old gold
                          Color(0xFFC5B358), //Old gold
                        ], // manually specify the colors to be used
                        createParticlePath:
                        value.drawStar, // define a custom shape/path.
                      ),
                    ):const SizedBox();
                  }
              ),
            ],
          ),
        ),

        ///old body singlechid ,dont remove it
        ///

        ///floating action button
        // floatingActionButton: Consumer<HomeProvider>(builder: (context, value, child) {
        //   return ((kIsWeb ||
        //       Platform.isAndroid
        //       || value.iosPaymentGateway == 'ON')
        //       &&!Platform.isIOS
        //   )
        //       ? Padding(
        //     padding: const EdgeInsets.only(left: 0.0, right: 2),
        //     child:
        //     InkWell(
        //       onTap: () {
        //         // homeProvider.testBase();
        //         mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
        //           if (event.snapshot.value.toString() == 'ON') {
        //             DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
        //             donationProvider.amountTC.text = "";
        //             donationProvider.nameTC.text = "";
        //             donationProvider.phoneTC.text = "";
        //             donationProvider.subCommitteeCT.text = "";
        //             donationProvider.kpccAmountController.text = "";
        //             donationProvider.onAmountChange('');
        //             donationProvider.clearGenderAndAgedata();
        //             donationProvider.selectedPanjayathChip = null;
        //             donationProvider.chipsetWardList.clear();
        //             donationProvider.selectedWard = null;'1';
        //             donationProvider.minimumbool=true;
        //             callNext(DonatePage(), context);
        //           } else {
        //             callNext(const NoPaymentGateway(), context);
        //           }
        //         });
        //       },
        //       child:
        //       // SizedBox(
        //       //   width: width * .900,
        //       //   child: SwipeableButtonView(
        //       //
        //       //     buttonText: 'Participate Now',
        //       //   buttontextstyle: const TextStyle(
        //       //     fontSize: 21,
        //       //       color: myWhite, fontWeight: FontWeight.bold
        //       //   ),
        //       //   //  buttonColor: Colors.yellow,
        //       //     buttonWidget: Container(
        //       //       child: const Icon(
        //       //         Icons.arrow_forward_ios_rounded,
        //       //         color: Colors.grey,
        //       //       ),
        //       //     ),
        //       //    // activeColor:isFinished==false? const Color(0xFF051270):Colors.white.withOpacity(0.8),
        //       //
        //       //     activeColor:isFinished==false?  cl_34CC04:cl_34CC04,//change button color
        //       //     disableColor: Colors.purple,
        //       //
        //       //     isFinished: isFinished,
        //       //     onWaitingProcess: () {
        //       //       Future.delayed(const Duration(milliseconds: 10), () {
        //       //         setState(() {
        //       //           isFinished = true;
        //       //         });
        //       //       });
        //       //     },
        //       //     onFinish: () async {
        //       //       mRoot.child('0').child('PaymentGateway35').onValue.listen((event) {
        //       //         if (event.snapshot.value.toString() == 'ON') {
        //       //           DonationProvider donationProvider =
        //       //           Provider.of<DonationProvider>(context,
        //       //               listen: false);
        //       //           donationProvider.amountTC.text = "";
        //       //           donationProvider.nameTC.text = "";
        //       //           donationProvider.phoneTC.text = "";
        //       //           donationProvider.kpccAmountController.text = "";
        //       //           donationProvider.onAmountChange('');
        //       //           donationProvider.clearGenderAndAgedata();
        //       //           donationProvider.selectedPanjayathChip = null;
        //       //           donationProvider.chipsetWardList.clear();
        //       //           donationProvider.selectedWard = null;
        //       //           '1';
        //       //
        //       //           callNext(DonatePage(), context);
        //       //         } else {
        //       //           callNext(const NoPaymentGateway(), context);
        //       //         }
        //       //       });
        //       //       setState(() {
        //       //         isFinished = false;
        //       //       });
        //       //     },
        //       //   ),
        //       // )
        //       ///
        //       Container(
        //         height: 50,
        //         width: width * .760,
        //         decoration:  BoxDecoration(
        //           boxShadow:  [
        //             const BoxShadow(
        //               color:cl3655A2,
        //             ),
        //             BoxShadow(
        //               color: cl000000.withOpacity(0.25),
        //               spreadRadius: -5.0,
        //               // blurStyle: BlurStyle.inner,
        //               blurRadius: 20.0,
        //             ),
        //
        //           ],
        //           borderRadius: const BorderRadius.all(Radius.circular(35)),
        //           gradient: const LinearGradient(
        //               begin: Alignment.centerLeft,
        //               end: Alignment.centerRight,
        //               colors: [cl3655A2,cl19A391]),
        //
        //         ),
        //         child: const Center(
        //             child: Text(
        //               "Participate Now",
        //               style: TextStyle(
        //                   fontSize: 18,
        //                   fontFamily: "PoppinsMedium",
        //                   color: myWhite, fontWeight: FontWeight.w500),
        //             )),
        //       ),
        //     ),
        //   )
        //       : const SizedBox();
        // }),
      )
    );
  }

  Widget web(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);

    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        return showExitPopup();
      },
      child: Container(
        height: height,
        width: width,
        // decoration: const BoxDecoration( image: DecorationImage(
        //     image: AssetImage("assets/webApp.jpg",),
        //     fit:BoxFit.fill
        // )
        // ),
        child: Stack(
          children: [
            Center(
              child:queryData.orientation == Orientation.portrait
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width,
                    child:  Scaffold(
                      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                      backgroundColor: clFFFFFF,

                      body: Container(
                        height: height,

                        // decoration: const BoxDecoration(
                        //   gradient: LinearGradient(
                        //     begin: Alignment.topCenter,
                        //       end: Alignment.bottomCenter,
                        //       colors: [myWhite,myWhite])
                        // ),
                        child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(children: [
                              Container(
                                height: height*.58,
                                // color: Colors.red,
                                // decoration:BoxDecoration(
                                //    color:Colors.red,
                                //   border: Border.all(color: myWhite),
                                // ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      child: Container(
                                        width: width,
                                        // height:340,
                                        height: 0.42*height,
                                        decoration:  const BoxDecoration(
                                          color: Color(0xff616072),
                                          image: DecorationImage(
                                            image: AssetImage("assets/carousel.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 0,
                                      left: 0,
                                      child: InkWell(
                                        onTap: (){
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 20),
                                          height: 135,
                                          width: width,
                                          decoration:  const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage("assets/homeAmount_bgrnd.png",),
                                                fit: BoxFit.fill
                                            ),

                                          ),
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Image.asset(
                                              //   "assets/splash_text.png",
                                              //   scale: 5.5,
                                              // ),
                                              SizedBox(
                                                height: 0.105*height,
                                                child: Consumer<HomeProvider>(
                                                    builder: (context, value, child) {
                                                      return Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text("Collected so far,",
                                                            style: blackPoppinsM12,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.only(left: 0, bottom: 10),
                                                                child: Image.asset(
                                                                  'assets/rs.png',
                                                                  // height:15,
                                                                  scale: 2,
                                                                  color: myWhite,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(right: 5),
                                                                child: Text(
                                                                    getAmount(value.totalCollection),
                                                                    style:  GoogleFonts.akshar(textStyle: whiteGoogle38)
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),

                                        ),
                                      ),
                                    ),

                                    // Positioned(
                                    //   left: 0,
                                    //   bottom: 10,
                                    //   child: Stack(
                                    //     children: [
                                    //       SizedBox(
                                    //         height: 0.251*height,
                                    //         width: width,
                                    //         //color: Colors.purple,
                                    //         // decoration: BoxDecoration(
                                    //         //  //  color: Colors.purple,
                                    //         //   borderRadius: BorderRadius.circular(30),
                                    //         // ),
                                    //         child: CarouselSlider.builder(
                                    //           itemCount: images.length,
                                    //           itemBuilder: (context, index, realIndex) {
                                    //             //final image=value.imgList[index];
                                    //             final image = images[index];
                                    //             return buildImage(image, context);
                                    //           },
                                    //           options: CarouselOptions(
                                    //             clipBehavior: Clip.antiAliasWithSaveLayer,
                                    //            // autoPlayCurve: Curves.linear,
                                    //               height: 0.212*height,
                                    //               viewportFraction: 1,
                                    //               autoPlay: true,
                                    //               //enableInfiniteScroll: false,
                                    //               pageSnapping: true,
                                    //               enlargeStrategy: CenterPageEnlargeStrategy.height,
                                    //               enlargeCenterPage: true,
                                    //               autoPlayInterval: const Duration(seconds: 3),
                                    //               onPageChanged: (index, reason) {
                                    //                 setState(() {
                                    //                   activeIndex = index;
                                    //                 });
                                    //               }),
                                    //         ),
                                    //       ),
                                    //       Positioned(
                                    //           left: 150,
                                    //           bottom: 20,
                                    //           child: buidIndiaCator(images.length, context))
                                    //     ],
                                    //   ),
                                    // ),

                                  ],
                                ),
                              ),
                              // const SizedBox(height: 23,),

                              //     Container(
                              //       decoration:const BoxDecoration(
                              //         color: myWhite,
                              //        // border:Border.all(color: Colors.white,width: 0.2),
                              //         ),
                              //       //  color: myRed,
                              //       //  height: 50,
                              //         child: Row(
                              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Padding(
                              //          padding: const EdgeInsets.only(left: 20.0),
                              //         child: Text(
                              //           !Platform.isIOS?"Contribute":"Reports",
                              //           style: b_myContributiontx,
                              //         ),
                              //       ),
                              //       // SizedBox(
                              //       //   width: width * .5,
                              //       // ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(right: 12.0),
                              //         child: InkWell(
                              //           onTap: (){
                              //             print("1254");
                              //
                              //             alertSupport(context);
                              //
                              //           },
                              //             child: Image.asset("assets/Helpline.png",scale: 3,)),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 38,
                                    width: 163,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(19)
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        alertSupport(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text("Support",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "PoppinsMedium",
                                            ),),
                                          Row(
                                            children: [
                                              const Icon(Icons.phone,size: 17,),
                                              const SizedBox(width: 1,),
                                              Image.asset("assets/whatsapp.png",scale:3.6,),
                                            ],
                                          )

                                        ],
                                      ),
                                    ),
                                  ),


                                  Consumer<HomeProvider>(
                                    builder: (context,value1,child) {
                                      return
                                        value1.iosPaymentButton=='ON'?
                                        InkWell(
                                        onTap: (){
                                          homeProvider.getVideo(context);
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0,right: 2),
                                              child: Image.asset("assets/youtube.png",scale: 2,),
                                            ),
                                            const Text("How to Pay?",
                                              style: TextStyle(fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "PoppinsMedium",
                                              ),),
                                          ],
                                        ),
                                      ):const SizedBox();
                                    }
                                  ),


                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0,bottom: 8),
                                child: Container(
                                  height: 100,
                                  width: width,
                                  decoration: const BoxDecoration(
                                      color: clFFFFFF,
                                      boxShadow: [
                                        BoxShadow(
                                            color: cl0x40CACACA,
                                            blurRadius: 16
                                        )

                                      ]

                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:12,bottom: 8,right: 8),
                                        child: Image.asset("assets/todaysTopper.png",scale: 2.8,),
                                      ),
                                      Container(width: 1,color: clD4D4D4,margin: const EdgeInsets.only(top: 12,bottom: 12),),
                                      // const VerticalDivider(color: clD4D4D4,thickness: 1,endIndent: 12,indent: 12,),
                                      Consumer<DonationProvider>(
                                          builder: (context,value,child) {
                                            return Container(
                                              // color: Colors.yellow,
                                              width: width/1.9,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 2,),
                                                    Container(
                                                      width: width/2,
                                                      // color: Colors.red,
                                                      child: Text(
                                                        value.todayTopperName,
                                                        style: const TextStyle(
                                                            height: 1.3,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: "PoppinsMedium",
                                                            color: clblue),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2,),
                                                    value.todayTopperPlace != ""
                                                        ? Text(
                                                      value.todayTopperPlace,
                                                      style: const TextStyle(
                                                          height: 1.3,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: "PoppinsMedium",
                                                          color: cl6B6B6B),
                                                    )
                                                        : const SizedBox(),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          value.todayTopperPanchayath,
                                                          style: const TextStyle(
                                                              height: 1.3,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w400,
                                                              fontFamily: "PoppinsMedium",
                                                              color: cl6B6B6B
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: 2),
                                                              child: SizedBox(
                                                                height: 15,
                                                                child: Text(
                                                                  "₹",
                                                                  style: TextStyle(color: clblue,fontSize: 16),
                                                                  // scale: 7,
                                                                  // color: myBlack2,
                                                                ),
                                                              ),
                                                            ),
                                                            AutoSizeText(
                                                              getAmount(value.todayTopperAmount),
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.w700,
                                                                  fontFamily: "PoppinsMedium",
                                                                  fontSize: 18,
                                                                  color: clblue),
                                                            )
                                                          ],
                                                        ),

                                                        // AutoSizeText.rich(
                                                        //   TextSpan(children: [
                                                        //     const TextSpan(
                                                        //         text: "₹ ",
                                                        //         style: TextStyle(fontSize: 14,color: cl323A71)),
                                                        //     TextSpan(
                                                        //       text: getAmount(value.todayTopperAmount),
                                                        //       style: const TextStyle(
                                                        //           fontWeight: FontWeight.w700,
                                                        //           fontFamily: "PoppinsMedium",
                                                        //           fontSize: 18,
                                                        //           color: cl323A71
                                                        //       ),
                                                        //     )
                                                        //   ]),
                                                        //   textAlign: TextAlign.center,
                                                        //   minFontSize: 5,
                                                        //   maxFontSize: 18,
                                                        //   maxLines: 1,
                                                        // ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 40,),

                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              amount.isEmpty
                                  ? const SizedBox()
                                  : Container(
                                height: 125,
                                alignment: Alignment.center,
                                child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 2,
                                        mainAxisExtent: 50),
                                    padding: const EdgeInsets.all(12),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: amount.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          donationProvider.kpccAmountController.text = amount[index].toString();

                                          donationProvider.subCommitteeCT.text = "";
                                          donationProvider.nameTC.text = "";
                                          donationProvider.phoneTC.text = "";
                                          donationProvider.clearGenderAndAgedata();
                                          donationProvider.selectedPanjayathChip = null;
                                          donationProvider.chipsetWardList.clear();
                                          donationProvider.selectedWard = null;
                                          donationProvider.minimumbool=false;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => DonatePage()));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
                                          child: Container(
                                              height: 42,
                                              width: 144,
                                              decoration:  const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:  cl0x40CACACA,
                                                        spreadRadius: 2,
                                                        blurRadius: 20
                                                    )
                                                  ],
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  color: clFFFFFF
                                              ),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 0,top: 2.0,bottom: 2),
                                                      child: CircleAvatar(
                                                        backgroundColor: colors[index],
                                                        radius: 33,foregroundImage: const AssetImage("assets/CoinGif.gif",),
                                                        // child: Image.asset("assets/CoinGif.gif",width: 80,),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.only(top: 5.0),
                                                          child: Text(
                                                              "₹ ",
                                                              style: TextStyle(
                                                                  color: myBlack,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w500)
                                                          ),
                                                        ),
                                                        Text(
                                                            '${amount[index]}',
                                                            style: const TextStyle(
                                                                fontFamily: "PoppinsMedium",
                                                                color: clblue,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w700)
                                                        ),
                                                        const SizedBox(width: 10,)
                                                        // RichText(textAlign: TextAlign.start,
                                                        //   text: TextSpan(children: [
                                                        //     const TextSpan(
                                                        //         text: "₹ ",
                                                        //         style: TextStyle(
                                                        //             color: myBlack,
                                                        //             fontSize: 12,
                                                        //             fontWeight: FontWeight.w500),),
                                                        //     TextSpan(
                                                        //         text: '${amount[index]}',
                                                        //         style: const TextStyle(
                                                        //             fontFamily: "PoppinsMedium",
                                                        //             color: cl323A71,
                                                        //             fontSize: 20,
                                                        //             fontWeight: FontWeight.w700)),
                                                        //   ]),
                                                        // ),
                                                      ],
                                                    )
                                                  ])),
                                        ),
                                      );
                                    }),
                              ),
                              Container(
                                padding: const EdgeInsets.all(0),
                                // color:myWhite,
                                child: GridView.builder(
                                    padding: const EdgeInsets.all(25),
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 0,
                                        crossAxisCount: 4,
                                        mainAxisExtent: 95),
                                    itemCount: contriImg.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Consumer<HomeProvider>(
                                          builder: (context, value2, child) {
                                            return InkWell(
                                              onTap: () async {
                                                if (index == 2) {
                                                  // homeProvider.selectedDistrict = null;
                                                  // homeProvider.selectedPanjayath = null;
                                                  // homeProvider.selectedUnit = null;
                                                  // homeProvider.fetchDropdown('', '');
                                                  // homeProvider.fetchWard();
                                                  // callNext(WardHistory(), context);
                                                } else if (index == 6) {
                                                  if (!kIsWeb) {
                                                    PackageInfo packageInfo =
                                                    await PackageInfo.fromPlatform();
                                                    String packageName = packageInfo.packageName;
                                                    if (packageName != 'com.spine.quaide_millatMonitor' &&
                                                        packageName != 'com.spine.dhotiTv') {
                                                      print("ifconditionwork");
                                                      homeProvider.searchEt.text = "";
                                                      homeProvider.currentLimit = 50;
                                                      homeProvider.fetchReceiptList(50);
                                                      callNext(ReceiptListPage(from: "home", total: '', ward: '', panchayath: '', district: '', target: ''),
                                                          context);
                                                    } else {
                                                      homeProvider.currentLimit = 50;
                                                      homeProvider.fetchReceiptListForMonitorApp(50);
                                                      callNext( ReceiptListMonitorScreen(), context);

                                                      // homeProvider.fetchPaymentReceiptList();
                                                    }
                                                  } else {
                                                    // homeProvider.searchEt.text = "";
                                                    // homeProvider.currentLimit = 50;
                                                    // homeProvider.fetchReceiptList(50);
                                                    // callNext(ReceiptListPage(from: "home", total: '', ward: '',),
                                                    //     context);
                                                    homeProvider.currentLimit = 50;
                                                    homeProvider.fetchReceiptListForMonitorApp(50);
                                                    callNext( ReceiptListMonitorScreen(), context);
                                                  }
                                                } else if (index == 7) {
                                                  // homeProvider.fetchHistoryFromFireStore();
                                                  // callNext(PaymentHistory(), context);
                                                } else if (index == 0) {
                                                  // homeProvider.getTopEnrollers();
                                                  // callNext(const TopEnrollersScreen(), context);

                                                } else if (index == 3) {
                                                  // homeProvider.topLeadPayments();
                                                  // callNext(LeadReport(), context);
                                                } else if (index == 1) {
                                                  // homeProvider.fetchDistrictWiseReport();
                                                  // callNext( ToppersHomeScreen(), context);
                                                } else if (index == 4) {
                                                  // print("device click here");
                                                  // HomeProvider homeProvider =
                                                  // Provider.of<HomeProvider>(context, listen: false);
                                                  // await homeProvider.checkEnrollerDeviceID();
                                                  // if (value2.enrollerDeviceID) {
                                                  //   print("deviceid already exixt");
                                                  //   deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                                  // } else {
                                                  //   homeProvider.clearEnrollerData();
                                                  //   callNext(BeAnEnroller(), context);
                                                  // }
                                                } else if (index == 5) {
                                                  // print("clikk22334");
                                                  // homeProvider.clearEnrollerDetails();
                                                  // callNext(const EnrollerPaymentsScreen(), context);
                                                }
                                              },
                                              child: Center(
                                                child: Container(
                                                    padding: const EdgeInsets.all(0),
                                                    alignment: Alignment.center,
                                                    width: width * .20,
                                                    // height: 48,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15)),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height: 55,
                                                          child: Image.asset(
                                                            contriImg[index],
                                                            scale: 2,
                                                          ),
                                                        ),
                                                        Container(
                                                            alignment: Alignment.center,
                                                            width: width,
                                                            height: 35,
                                                            // color:Colors.yellow,
                                                            child: Text(
                                                              contriText[index],
                                                              textAlign: TextAlign.center,
                                                              style: const TextStyle(
                                                                  fontFamily: "PoppinsMedium",
                                                                  fontSize: 11,
                                                                  fontWeight: FontWeight.w600),
                                                              overflow: TextOverflow.fade,
                                                            )),

                                                      ],
                                                    )),
                                              ),
                                            );
                                          });
                                    }),
                              ),


                              Container(
                                // color: myWhite,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(30, 10, 30,0),
                                  child: Container(

                                    // padding: const EdgeInsets.all(8),
                                      height: 0.15*height,
                                      // color: Colors.yellow,
                                      // decoration: const BoxDecoration(
                                      //     color: clFFFFFF,
                                      //     borderRadius: BorderRadius.all(
                                      //       Radius.circular(25),
                                      //     ),
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //         color: Colors.grey,
                                      //         blurRadius: 5.0,
                                      //       ),
                                      //     ]),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: 3,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (BuildContext context, int index) {
                                          return InkWell(
                                            onTap:(){
                                              if(index==1){
                                                alertTermsAndConditions(context);
                                              }else if(index==2){
                                                alertContact(context);
                                              }else if(index==0){
                                                alertTerm(context);

                                              }

                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 12.0,left: 12),
                                              child: Column(
                                                  children: [
                                                    CircleAvatar(
                                                      radius:30,
                                                      backgroundColor: clF8F8F8,
                                                      child: Image.asset(
                                                        PTCImg[index],
                                                        scale: 3,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      PTCText[index],
                                                      style: const TextStyle(
                                                          color: myBlack,
                                                          fontSize: 11,
                                                          fontFamily: "Lato",
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                  ]),
                                            ),
                                          );
                                        },
                                      )
                                  ),
                                ),
                              ),

                              Consumer<HomeProvider>(builder: (context, value, child) {
                                print("aaaaaaaaaaaaaaaa"+value.buildNumber);
                                return Container(
                                  // color: myWhite,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Version:${value.appVersion}.${value.buildNumber}.${value.currentVersion}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 8),)),
                                );
                              }
                              ),
                              Container(
                                // color: myWhite,
                                height: 80,
                              )
                            ])),
                      ),

                      ///old body singlechid ,dont remove it
                      ///

                      ///floating action button
                      floatingActionButton: Consumer<HomeProvider>(builder: (context, value, child) {
                        return ((kIsWeb ||
                            Platform.isAndroid ||
                            value.iosPaymentGateway == 'ON')
                            &&!Platform.isIOS
                        )
                            ? Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 2),
                          child:
                          InkWell(
                            onTap: () {
                              mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
                                if (event.snapshot.value.toString() == 'ON') {
                                  DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                  donationProvider.amountTC.text = "";
                                  donationProvider.nameTC.text = "";
                                  donationProvider.subCommitteeCT.text = "";
                                  donationProvider.phoneTC.text = "";
                                  donationProvider.kpccAmountController.text = "";
                                  donationProvider.onAmountChange('');
                                  donationProvider.clearGenderAndAgedata();
                                  donationProvider.selectedPanjayathChip = null;
                                  donationProvider.chipsetWardList.clear();
                                  donationProvider.selectedWard = null;'1';
                                  donationProvider.minimumbool=true;

                                  callNext(DonatePage(), context);
                                } else {
                                  callNext(const NoPaymentGateway(), context);
                                }
                              });
                            },
                            child:
                            // SizedBox(
                            //   width: width * .900,
                            //   child: SwipeableButtonView(
                            //
                            //     buttonText: 'Participate Now',
                            //   buttontextstyle: const TextStyle(
                            //     fontSize: 21,
                            //       color: myWhite, fontWeight: FontWeight.bold
                            //   ),
                            //   //  buttonColor: Colors.yellow,
                            //     buttonWidget: Container(
                            //       child: const Icon(
                            //         Icons.arrow_forward_ios_rounded,
                            //         color: Colors.grey,
                            //       ),
                            //     ),
                            //    // activeColor:isFinished==false? const Color(0xFF051270):Colors.white.withOpacity(0.8),
                            //
                            //     activeColor:isFinished==false?  cl_34CC04:cl_34CC04,//change button color
                            //     disableColor: Colors.purple,
                            //
                            //     isFinished: isFinished,
                            //     onWaitingProcess: () {
                            //       Future.delayed(const Duration(milliseconds: 10), () {
                            //         setState(() {
                            //           isFinished = true;
                            //         });
                            //       });
                            //     },
                            //     onFinish: () async {
                            //       mRoot.child('0').child('PaymentGateway35').onValue.listen((event) {
                            //         if (event.snapshot.value.toString() == 'ON') {
                            //           DonationProvider donationProvider =
                            //           Provider.of<DonationProvider>(context,
                            //               listen: false);
                            //           donationProvider.amountTC.text = "";
                            //           donationProvider.nameTC.text = "";
                            //           donationProvider.phoneTC.text = "";
                            //           donationProvider.kpccAmountController.text = "";
                            //           donationProvider.onAmountChange('');
                            //           donationProvider.clearGenderAndAgedata();
                            //           donationProvider.selectedPanjayathChip = null;
                            //           donationProvider.chipsetWardList.clear();
                            //           donationProvider.selectedWard = null;
                            //           '1';
                            //
                            //           callNext(DonatePage(), context);
                            //         } else {
                            //           callNext(const NoPaymentGateway(), context);
                            //         }
                            //       });
                            //       setState(() {
                            //         isFinished = false;
                            //       });
                            //     },
                            //   ),
                            // )
                            ///
                            Container(
                              height: 50,
                              width: width * .760,
                              decoration:  BoxDecoration(
                                boxShadow:  [
                                  const BoxShadow(
                                    color:cl3655A2,
                                  ),
                                  BoxShadow(
                                    color: cl000000.withOpacity(0.25),
                                    spreadRadius: -5.0,
                                    // blurStyle: BlurStyle.inner,
                                    blurRadius: 20.0,
                                  ),

                                ],
                                borderRadius: const BorderRadius.all(Radius.circular(35)),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [cl3655A2,cl19A391]),

                              ),
                              child: const Center(
                                  child: Text(
                                    "Participate Now",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "PoppinsMedium",
                                        color: myWhite, fontWeight: FontWeight.w500),
                                  )),
                            ),
                          ),
                        )
                            : const SizedBox();
                      }),
                    ),
                  ),
                ],
              )
                  : Scaffold(
                    backgroundColor: clFFFFFF,
                    body: Container(
                      width:width,
                      child: Stack(
                        children: [


                          SizedBox(
                      width:width,
                            // color:Colors.blue,
                            child: Row(
                              children: [
                                Expanded(
                                    flex:1,
                                    child: Container(
                                  // color:Colors.red,
                                      child:Image.asset("assets/TvLeft4x.png",fit: BoxFit.cover)
                                )),
                                Expanded(
                                  flex:1,
                                  child: Container(
                                    // color:Colors.red,
                                    // width:500,
                                    height: height,
                                    child: SingleChildScrollView(
                                        physics: const ScrollPhysics(),
                                        child: Column(children: [
                                          SizedBox(
                                            height: 445,//height*.58
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: const BorderRadius.only(
                                                      bottomLeft: Radius.circular(20),
                                                      bottomRight: Radius.circular(20)),
                                                  child: Container(
                                                    alignment: Alignment.centerLeft,
                                                    width: width,
                                                    height:380,//380
                                                    // height: 0.42*height,
                                                    decoration:   BoxDecoration(
                                                      color: Colors.grey.withOpacity(0.3),
                                                      image: const DecorationImage(
                                                        image: AssetImage("assets/ksdHomeTpImg.jpeg"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    child: Container(
                                                      margin: EdgeInsets.only(left:width*.05),
                                                      height:150,
                                                      width:170,
                                                      decoration: const BoxDecoration(
                                                        // color:Colors.red,
                                                          image:DecorationImage(
                                                              image:AssetImage("assets/ksdHomeTope.png")
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                ),


                                                Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: InkWell(
                                                    onTap: (){
                                                      mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
                                                        if (event.snapshot.value.toString() == 'ON') {
                                                          DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                                          donationProvider.amountTC.text = "";
                                                          donationProvider.nameTC.text = "";
                                                          donationProvider.phoneTC.text = "";
                                                          donationProvider.subCommitteeCT.text = "";
                                                          donationProvider.kpccAmountController.text = "";
                                                          donationProvider.onAmountChange('');
                                                          donationProvider.clearGenderAndAgedata();
                                                          donationProvider.selectedPanjayathChip = null;
                                                          donationProvider.chipsetWardList.clear();
                                                          donationProvider.selectedWard = null;'1';
                                                          donationProvider.minimumbool=true;

                                                          callNext(DonatePage(), context);
                                                        } else {
                                                          callNext(const NoPaymentGateway(), context);
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      margin: const EdgeInsets.symmetric(horizontal: 20),
                                                      height: 135,
                                                      width: width,
                                                      decoration:  const BoxDecoration(
                                                        // color:Colors.blue,
                                                        image: DecorationImage(
                                                            image: AssetImage("assets/homeAmount_bgrnd.png",),
                                                            fit: BoxFit.fill
                                                        ),

                                                      ),
                                                      child:Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          // Image.asset(
                                                          //   "assets/splash_text.png",
                                                          //   scale: 5.5,
                                                          // ),
                                                          SizedBox(
                                                            height: 0.105*height,
                                                            child: Consumer<HomeProvider>(
                                                                builder: (context, value, child) {
                                                                  return Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text("Collected so far,",
                                                                        style: blackPoppinsM12,),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets.only(left: 0, bottom: 10),
                                                                            child: Image.asset(
                                                                              'assets/rs.png',
                                                                              // height:15,
                                                                              scale: 2,
                                                                              color: myWhite,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(right: 5),
                                                                            child: Text(
                                                                                getAmount(value.totalCollection),
                                                                                style:  GoogleFonts.akshar(textStyle: whiteGoogle38)
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  );
                                                                }),
                                                          ),
                                                        ],
                                                      ),

                                                    ),
                                                  ),
                                                ),

                                                // Positioned(
                                                //   left: 0,
                                                //   bottom: 10,
                                                //   child: Stack(
                                                //     children: [
                                                //       SizedBox(
                                                //         height: 0.251*height,
                                                //         width: width,
                                                //         //color: Colors.purple,
                                                //         // decoration: BoxDecoration(
                                                //         //  //  color: Colors.purple,
                                                //         //   borderRadius: BorderRadius.circular(30),
                                                //         // ),
                                                //         child: CarouselSlider.builder(
                                                //           itemCount: images.length,
                                                //           itemBuilder: (context, index, realIndex) {
                                                //             //final image=value.imgList[index];
                                                //             final image = images[index];
                                                //             return buildImage(image, context);
                                                //           },
                                                //           options: CarouselOptions(
                                                //             clipBehavior: Clip.antiAliasWithSaveLayer,
                                                //            // autoPlayCurve: Curves.linear,
                                                //               height: 0.212*height,
                                                //               viewportFraction: 1,
                                                //               autoPlay: true,
                                                //               //enableInfiniteScroll: false,
                                                //               pageSnapping: true,
                                                //               enlargeStrategy: CenterPageEnlargeStrategy.height,
                                                //               enlargeCenterPage: true,
                                                //               autoPlayInterval: const Duration(seconds: 3),
                                                //               onPageChanged: (index, reason) {
                                                //                 setState(() {
                                                //                   activeIndex = index;
                                                //                 });
                                                //               }),
                                                //         ),
                                                //       ),
                                                //       Positioned(
                                                //           left: 150,
                                                //           bottom: 20,
                                                //           child: buidIndiaCator(images.length, context))
                                                //     ],
                                                //   ),
                                                // ),

                                              ],
                                            ),
                                          ),

                                          // const SizedBox(height: 23,),

                                          //     Container(
                                          //       decoration:const BoxDecoration(
                                          //         color: myWhite,
                                          //        // border:Border.all(color: Colors.white,width: 0.2),
                                          //         ),
                                          //       //  color: myRed,
                                          //       //  height: 50,
                                          //         child: Row(
                                          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //           children: [
                                          //             Padding(
                                          //          padding: const EdgeInsets.only(left: 20.0),
                                          //         child: Text(
                                          //           !Platform.isIOS?"Contribute":"Reports",
                                          //           style: b_myContributiontx,
                                          //         ),
                                          //       ),
                                          //       // SizedBox(
                                          //       //   width: width * .5,
                                          //       // ),
                                          //       Padding(
                                          //         padding: const EdgeInsets.only(right: 12.0),
                                          //         child: InkWell(
                                          //           onTap: (){
                                          //             print("1254");
                                          //
                                          //             alertSupport(context);
                                          //
                                          //           },
                                          //             child: Image.asset("assets/Helpline.png",scale: 3,)),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),

                                          const SizedBox(height: 20,),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: 38,
                                                width: 163,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow:  [
                                                      BoxShadow(
                                                          color: c_Grey.withOpacity(0.15),
                                                          blurRadius: 2,
                                                          spreadRadius: 2
                                                      )
                                                    ],
                                                    borderRadius: BorderRadius.circular(19)
                                                ),
                                                child: InkWell(
                                                  onTap: (){
                                                    alertSupport(context);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      const Text("Support",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: "PoppinsMedium",
                                                          color:cl3655A2,
                                                        ),),
                                                      Row(
                                                        children: [
                                                          const Icon(Icons.phone,size: 17,),
                                                          const SizedBox(width: 10,),
                                                          Image.asset("assets/whatsapp.png",scale:3.6,),
                                                        ],
                                                      )

                                                    ],
                                                  ),
                                                ),
                                              ),

                                              InkWell(
                                                onTap: (){
                                                  homeProvider.getVideo(context);
                                                },
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10.0,right: 2),
                                                      child: Image.asset("assets/youtube.png",scale: 2,),
                                                    ),
                                                    const Text("How to Pay?",
                                                      style: TextStyle(fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: "PoppinsMedium",
                                                        color: cl3655A2,
                                                      ),),
                                                  ],
                                                ),
                                              ),


                                            ],
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(top: 20.0,bottom: 8),
                                            child: Container(
                                              height: 100,
                                              width: width,
                                              decoration: const BoxDecoration(
                                                  color: clFFFFFF,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: cl0x40CACACA,
                                                        blurRadius: 16
                                                    )

                                                  ]

                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:12,bottom: 8,right: 8),
                                                    child: Image.asset("assets/todaysTopper.png",scale: 3.3,),
                                                  ),
                                                  Container(width: 1,color: clD4D4D4,margin: const EdgeInsets.only(top: 12,bottom: 12),),
                                                  // const VerticalDivider(color: clD4D4D4,thickness: 1,endIndent: 12,indent: 12,),
                                                  Flexible(
                                                    fit:FlexFit.tight,
                                                    child: Consumer<DonationProvider>(
                                                        builder: (context,value,child) {
                                                          return Container(
                                                            // color: Colors.yellow,
                                                            // width: width/1.9,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 10.0),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  const SizedBox(height: 2,),
                                                                  Container(
                                                                    width: width/2,
                                                                    // color: Colors.red,
                                                                    child: Text(
                                                                      value.todayTopperName,
                                                                      style: const TextStyle(
                                                                          height: 1.3,
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: "PoppinsMedium",
                                                                          color: cl3655A2),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 2,),
                                                                  value.todayTopperPlace != ""
                                                                      ? Text(
                                                                    value.todayTopperPlace,
                                                                    style: const TextStyle(
                                                                        height: 1.3,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontFamily: "PoppinsMedium",
                                                                        color: cl6B6B6B),
                                                                  )
                                                                      : const SizedBox(),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      value.todayTopperPanchayath=="FAMILY CONTRIBUTION"?const SizedBox():
                                                                      Text(
                                                                        value.todayTopperPanchayath,
                                                                        style: const TextStyle(
                                                                            height: 1.3,
                                                                            fontSize: 12,
                                                                            fontWeight: FontWeight.w400,
                                                                            fontFamily: "PoppinsMedium",
                                                                            color: cl6B6B6B
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          const Padding(
                                                                            padding: EdgeInsets.only(
                                                                                right: 2),
                                                                            child: SizedBox(
                                                                              height: 15,
                                                                              child: Text(
                                                                                "₹",
                                                                                style: TextStyle(color: clblue,fontSize: 16),
                                                                                // scale: 7,
                                                                                // color: myBlack2,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          AutoSizeText(
                                                                            getAmount(value.todayTopperAmount),
                                                                            style: const TextStyle(
                                                                                fontWeight: FontWeight.w700,
                                                                                fontFamily: "PoppinsMedium",
                                                                                fontSize: 18,
                                                                                color: clblue),
                                                                          )
                                                                        ],
                                                                      ),

                                                                      // AutoSizeText.rich(
                                                                      //   TextSpan(children: [
                                                                      //     const TextSpan(
                                                                      //         text: "₹ ",
                                                                      //         style: TextStyle(fontSize: 14,color: cl323A71)),
                                                                      //     TextSpan(
                                                                      //       text: getAmount(value.todayTopperAmount),
                                                                      //       style: const TextStyle(
                                                                      //           fontWeight: FontWeight.w700,
                                                                      //           fontFamily: "PoppinsMedium",
                                                                      //           fontSize: 18,
                                                                      //           color: cl323A71
                                                                      //       ),
                                                                      //     )
                                                                      //   ]),
                                                                      //   textAlign: TextAlign.center,
                                                                      //   minFontSize: 5,
                                                                      //   maxFontSize: 18,
                                                                      //   maxLines: 1,
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(width: 40,),

                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),

                                          amount.isEmpty
                                              ? const SizedBox()
                                              : Container(
                                            height: 125,
                                            alignment: Alignment.center,
                                            child: GridView.builder(
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 2,
                                                    crossAxisSpacing: 8,
                                                    crossAxisCount: 2,
                                                    mainAxisExtent: 50),
                                                padding: const EdgeInsets.all(12),
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: amount.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      donationProvider.kpccAmountController.text = amount[index].toString();
                                                      donationProvider.subCommitteeCT.text = "";
                                                      donationProvider.nameTC.text = "";
                                                      donationProvider.phoneTC.text = "";
                                                      donationProvider.clearGenderAndAgedata();
                                                      donationProvider.selectedPanjayathChip = null;
                                                      donationProvider.chipsetWardList.clear();
                                                      donationProvider.selectedWard = null;
                                                      donationProvider.minimumbool=false;
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => DonatePage()));
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
                                                      child: Container(
                                                          height: 42,
                                                          width: 144,
                                                          decoration:  const BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color:  cl0x40CACACA,
                                                                    spreadRadius: 2,
                                                                    blurRadius: 20
                                                                )
                                                              ],
                                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                                              color: clFFFFFF
                                                          ),
                                                          child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 0,top: 2.0,bottom: 2),
                                                                  child: CircleAvatar(
                                                                    backgroundColor: colors[index],
                                                                    radius: 33,
                                                                    foregroundImage: const AssetImage("assets/CoinGif.gif",),
                                                                    // child: Image.asset("assets/CoinGif.gif",width: 80,),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    const Padding(
                                                                      padding: EdgeInsets.only(top: 5.0),
                                                                      child: Text(
                                                                          "₹ ",
                                                                          style: TextStyle(
                                                                              color: cl264186,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w500)
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        '${amount[index]}',
                                                                        style: const TextStyle(
                                                                            fontFamily: "PoppinsMedium",
                                                                            color: cl264186,
                                                                            fontSize: 20,
                                                                            fontWeight: FontWeight.w700)
                                                                    ),
                                                                    const SizedBox(width: 10,)
                                                                    // RichText(textAlign: TextAlign.start,
                                                                    //   text: TextSpan(children: [
                                                                    //     const TextSpan(
                                                                    //         text: "₹ ",
                                                                    //         style: TextStyle(
                                                                    //             color: myBlack,
                                                                    //             fontSize: 12,
                                                                    //             fontWeight: FontWeight.w500),),
                                                                    //     TextSpan(
                                                                    //         text: '${amount[index]}',
                                                                    //         style: const TextStyle(
                                                                    //             fontFamily: "PoppinsMedium",
                                                                    //             color: cl323A71,
                                                                    //             fontSize: 20,
                                                                    //             fontWeight: FontWeight.w700)),
                                                                    //   ]),
                                                                    // ),
                                                                  ],
                                                                )
                                                              ])),
                                                    ),
                                                  );
                                                }),
                                          ),

                                          Container(
                                            padding: const EdgeInsets.all(0),
                                            // color:myWhite,
                                            child: GridView.builder(
                                                padding: const EdgeInsets.all(25),
                                                physics: const ScrollPhysics(),
                                                shrinkWrap: true,
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 2,
                                                    crossAxisSpacing: 0,
                                                    crossAxisCount: 4,
                                                    mainAxisExtent: 95),
                                                itemCount: contriImg.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Consumer<HomeProvider>(
                                                      builder: (context, value2, child) {
                                                        return InkWell(
                                                          onTap: () async {

                                                            if (index == 0) {
                                                              //Transactions
                                                              if (!kIsWeb) {
                                                                PackageInfo packageInfo =
                                                                await PackageInfo.fromPlatform();
                                                                String packageName = packageInfo.packageName;
                                                                if (packageName != 'com.spine.iumlmunnettammonitor' &&
                                                                    packageName != 'com.spine.dhotiTv') {
                                                                  print("ifconditionwork");
                                                                  homeProvider.searchEt.text = "";
                                                                  homeProvider.currentLimit = 0;
                                                                  homeProvider.fetchReceiptList(50);
                                                                  callNext(ReceiptListPage(from: "home",total: '', ward: '', panchayath: '', district: '', target: ''),
                                                                      context);
                                                                } else {
                                                                  homeProvider.currentLimit = 50;
                                                                  homeProvider.fetchReceiptListForMonitorApp(50);
                                                                  callNext( ReceiptListMonitorScreen(), context);

                                                                  // homeProvider.fetchPaymentReceiptList();
                                                                }
                                                              } else {
                                                                homeProvider.searchEt.text = "";
                                                                homeProvider.currentLimit = 50;
                                                                homeProvider.fetchReceiptList(50);
                                                                callNext(ReceiptListPage(from: "home",total: '', ward: '', panchayath: '', district: '', target: ''),
                                                                    context);
                                                              }
                                                            }
                                                            else if (index == 1) {
                                                              //My History
                                                              homeProvider.fetchHistoryFromFireStore();
                                                              callNext(PaymentHistory(), context);
                                                            }
                                                            if (index == 2) {
                                                              //Report
                                                              homeProvider.selectedDistrict = null;
                                                              homeProvider.selectedPanjayath = null;
                                                              homeProvider.selectedUnit = null;
                                                              homeProvider.panchayathTarget=0.0;
                                                              homeProvider.panchayathPosterPanchayath="";
                                                              homeProvider.panchayathPosterAssembly="";
                                                              homeProvider.panchayathPosterDistrict="";
                                                              homeProvider.panchayathPosterComplete=false;
                                                              homeProvider.panchayathPosterNotCompleteComplete=false;
                                                              homeProvider.fetchDropdown('', '');
                                                              homeProvider.fetchWard('');
                                                              callNext(WardHistory(), context);
                                                            }
                                                            else if (index == 3) {
                                                              //Lead
                                                              homeProvider.topLeadPayments();
                                                              callNext(LeadReport(), context);
                                                            }
                                                            else if (index == 4) {
                                                              //Topper's\nClub
                                                              // callNext( DistrictReport(from: '',), context);
                                                              callNext( const ToppersHomeScreen(), context);
                                                              homeProvider.fetchDistrictWiseReport();
                                                            }
                                                            else if (index == 5){
                                                              //Top\nVolunteers
                                                              homeProvider.getTopEnrollers();
                                                              callNext(const TopEnrollersScreen(), context);
                                                            }
                                                            else if (index == 6) {
                                                              //Volunteer\nRegistration
                                                              print("device click here");
                                                              HomeProvider homeProvider =
                                                              Provider.of<HomeProvider>(context, listen: false);
                                                              await homeProvider.checkEnrollerDeviceID();
                                                              if (value2.enrollerDeviceID) {
                                                                print("deviceid already exixt");
                                                                deviceIdAlreadyExistAlert(context, value2.EnrollerID,value2.EnrollerName);
                                                              } else {
                                                                homeProvider.clearEnrollerData();
                                                                callNext(BeAnEnroller(), context);
                                                              }
                                                            }
                                                            else if (index == 7) {
                                                              //Volunteer\nPayments
                                                              print("clikk22334");
                                                              homeProvider.clearEnrollerDetails();
                                                              callNext(const EnrollerPaymentsScreen(), context);
                                                            }
                                                          },
                                                          child: Center(
                                                            child: Container(
                                                                padding: const EdgeInsets.all(0),
                                                                alignment: Alignment.center,
                                                                width: width * .20,
                                                                // height: 48,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(15)),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                      decoration: const BoxDecoration(
                                                                        shape:BoxShape.circle,
                                                                        gradient: LinearGradient(
                                                                          begin: Alignment(0.00, -1.00),
                                                                          end: Alignment(0, 1),
                                                                          colors: [cl3655A2, cl264186],
                                                                        ),
                                                                      ),
                                                                      height: 55,
                                                                      child: Image.asset(
                                                                        contriImg[index],
                                                                        scale: 3,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        alignment: Alignment.center,
                                                                        width: width,
                                                                        height: 35,
                                                                        // color:Colors.yellow,
                                                                        child: Text(
                                                                          contriText[index],
                                                                          textAlign: TextAlign.center,
                                                                          style: const TextStyle(
                                                                              fontFamily: "PoppinsMedium",
                                                                              fontSize: 11,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: cl3655A2
                                                                          ),
                                                                          overflow: TextOverflow.fade,
                                                                        )),

                                                                  ],
                                                                )),
                                                          ),
                                                        );
                                                      });
                                                }),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 10, 30,0),
                                            child: SizedBox(
                                                height: 0.15*height,
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount: 3,
                                                  scrollDirection: Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return InkWell(
                                                      onTap:(){
                                                        if(index==1){
                                                          alertTermsAndConditions(context);
                                                        }else if(index==2){
                                                          alertContact(context);
                                                        }else if(index==0){
                                                          alertTerm(context);
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right: 12.0,left: 12),
                                                        child: Column(
                                                            children: [
                                                              CircleAvatar(
                                                                radius:30,
                                                                backgroundColor: clF8F8F8,
                                                                child: Image.asset(
                                                                  PTCImg[index],
                                                                  scale: 3,
                                                                  color: cl3655A2,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 8),
                                                              Text(
                                                                PTCText[index],
                                                                style: const TextStyle(
                                                                    color: myBlack,
                                                                    fontSize: 11,
                                                                    fontFamily: "Lato",
                                                                    fontWeight: FontWeight.w500
                                                                ),
                                                              ),
                                                              const SizedBox(height: 5),
                                                            ]),
                                                      ),
                                                    );
                                                  },
                                                )
                                            ),
                                          ),

                                          Consumer<HomeProvider>(builder: (context, value, child) {
                                            print("aaaaaaaaaaaaaaaa"+value.buildNumber);
                                            return Container(
                                              // color: myWhite,
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Version:${value.appVersion}.${value.buildNumber}.${value.currentVersion}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 8),)),
                                            );
                                          }
                                          ),
                                          Container(
                                            // color: myWhite,
                                            height: 80,
                                          )
                                        ])),
                                  ),
                                ),

                                Expanded(
                                    flex:1,
                                    child: Container(
                                  // color:Colors.green,
                                              child:Image.asset("assets/TvRight4x.png",fit: BoxFit.cover,)
                                )),
                              ],
                            ),
                          ),

                          Consumer<HomeProvider>(
                              builder: (context,value,child) {
                                return
                                  value.isLaunched ?
                                  Align(
                                    alignment:Alignment.topRight ,
                                    child:ConfettiWidget(
                                      gravity: .3,
                                      minBlastForce: 5, maxBlastForce: 800,
                                      numberOfParticles: 500,
                                      confettiController: controllerCenter,
                                      blastDirectionality: BlastDirectionality.explosive,
                                      // don't specify a direction, blast randomly
                                      //blastDirection: BorderSide.strokeAlignOutside,
                                      shouldLoop: true, // start again as soon as the animation is finished
                                      colors: const [
                                        Color(0xFFFFDF00),//Golden yellow
                                        Color(0xFFD4AF37),//Metallic gold
                                        Color(0xFFCFB53B),//Old gold
                                        Color(0xFFC5B358),//Old gold
                                        // Colors.green,
                                        // Colors.blue,
                                        // Colors.pink,
                                        // Colors.orange,
                                        // Colors.purple,
                                        // Colors.red,
                                        // Colors.greenAccent,
                                        // Colors.white,
                                        // Colors.lightGreen,
                                        // Colors.lightGreenAccent
                                      ], // manually specify the colors to be used
                                      createParticlePath: value.drawStar, // define a custom shape/path.
                                    ),
                                  )
                                :const SizedBox();
                              }
                          ),

                          Consumer<HomeProvider>(
                              builder: (context,value,child) {
                                return value.isLaunched
                                    ?Align(
                                  alignment:Alignment.bottomLeft,
                                  child: ConfettiWidget(
                                    gravity: .3,
                                    minBlastForce: 5, maxBlastForce: 800,
                                    numberOfParticles: 500,
                                    confettiController: controllerCenter,
                                    blastDirectionality: BlastDirectionality.explosive,
                                    shouldLoop: true,
                                    colors: const [
                                      Color(0xFFFFDF00), //Golden yellow
                                      Color(0xFFD4AF37), //Metallic gold
                                      Color(0xFFCFB53B), //Old gold
                                      Color(0xFFC5B358), //Old gold
                                    ], // manually specify the colors to be used
                                    createParticlePath:
                                    value.drawStar, // define a custom shape/path.
                                  ),
                                ):const SizedBox();
                              }
                          ),
                        ],
                      ),
                    ),

                    ///old body singlechid ,dont remove it
                    ///

                    ///floating action button
                    // floatingActionButton: Consumer<HomeProvider>(builder: (context, value, child) {
                    //   return ((kIsWeb ||
                    //       Platform.isAndroid
                    //       || value.iosPaymentGateway == 'ON')
                    //       &&!Platform.isIOS
                    //   )
                    //       ? Padding(
                    //     padding: const EdgeInsets.only(left: 0.0, right: 2),
                    //     child:
                    //     InkWell(
                    //       onTap: () {
                    //         // homeProvider.testBase();
                    //         mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
                    //           if (event.snapshot.value.toString() == 'ON') {
                    //             DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                    //             donationProvider.amountTC.text = "";
                    //             donationProvider.nameTC.text = "";
                    //             donationProvider.phoneTC.text = "";
                    //             donationProvider.subCommitteeCT.text = "";
                    //             donationProvider.kpccAmountController.text = "";
                    //             donationProvider.onAmountChange('');
                    //             donationProvider.clearGenderAndAgedata();
                    //             donationProvider.selectedPanjayathChip = null;
                    //             donationProvider.chipsetWardList.clear();
                    //             donationProvider.selectedWard = null;'1';
                    //             donationProvider.minimumbool=true;
                    //             callNext(DonatePage(), context);
                    //           } else {
                    //             callNext(const NoPaymentGateway(), context);
                    //           }
                    //         });
                    //       },
                    //       child:
                    //       // SizedBox(
                    //       //   width: width * .900,
                    //       //   child: SwipeableButtonView(
                    //       //
                    //       //     buttonText: 'Participate Now',
                    //       //   buttontextstyle: const TextStyle(
                    //       //     fontSize: 21,
                    //       //       color: myWhite, fontWeight: FontWeight.bold
                    //       //   ),
                    //       //   //  buttonColor: Colors.yellow,
                    //       //     buttonWidget: Container(
                    //       //       child: const Icon(
                    //       //         Icons.arrow_forward_ios_rounded,
                    //       //         color: Colors.grey,
                    //       //       ),
                    //       //     ),
                    //       //    // activeColor:isFinished==false? const Color(0xFF051270):Colors.white.withOpacity(0.8),
                    //       //
                    //       //     activeColor:isFinished==false?  cl_34CC04:cl_34CC04,//change button color
                    //       //     disableColor: Colors.purple,
                    //       //
                    //       //     isFinished: isFinished,
                    //       //     onWaitingProcess: () {
                    //       //       Future.delayed(const Duration(milliseconds: 10), () {
                    //       //         setState(() {
                    //       //           isFinished = true;
                    //       //         });
                    //       //       });
                    //       //     },
                    //       //     onFinish: () async {
                    //       //       mRoot.child('0').child('PaymentGateway35').onValue.listen((event) {
                    //       //         if (event.snapshot.value.toString() == 'ON') {
                    //       //           DonationProvider donationProvider =
                    //       //           Provider.of<DonationProvider>(context,
                    //       //               listen: false);
                    //       //           donationProvider.amountTC.text = "";
                    //       //           donationProvider.nameTC.text = "";
                    //       //           donationProvider.phoneTC.text = "";
                    //       //           donationProvider.kpccAmountController.text = "";
                    //       //           donationProvider.onAmountChange('');
                    //       //           donationProvider.clearGenderAndAgedata();
                    //       //           donationProvider.selectedPanjayathChip = null;
                    //       //           donationProvider.chipsetWardList.clear();
                    //       //           donationProvider.selectedWard = null;
                    //       //           '1';
                    //       //
                    //       //           callNext(DonatePage(), context);
                    //       //         } else {
                    //       //           callNext(const NoPaymentGateway(), context);
                    //       //         }
                    //       //       });
                    //       //       setState(() {
                    //       //         isFinished = false;
                    //       //       });
                    //       //     },
                    //       //   ),
                    //       // )
                    //       ///
                    //       Container(
                    //         height: 50,
                    //         width: width * .760,
                    //         decoration:  BoxDecoration(
                    //           boxShadow:  [
                    //             const BoxShadow(
                    //               color:cl3655A2,
                    //             ),
                    //             BoxShadow(
                    //               color: cl000000.withOpacity(0.25),
                    //               spreadRadius: -5.0,
                    //               // blurStyle: BlurStyle.inner,
                    //               blurRadius: 20.0,
                    //             ),
                    //
                    //           ],
                    //           borderRadius: const BorderRadius.all(Radius.circular(35)),
                    //           gradient: const LinearGradient(
                    //               begin: Alignment.centerLeft,
                    //               end: Alignment.centerRight,
                    //               colors: [cl3655A2,cl19A391]),
                    //
                    //         ),
                    //         child: const Center(
                    //             child: Text(
                    //               "Participate Now",
                    //               style: TextStyle(
                    //                   fontSize: 18,
                    //                   fontFamily: "PoppinsMedium",
                    //                   color: myWhite, fontWeight: FontWeight.w500),
                    //             )),
                    //       ),
                    //     ),
                    //   )
                    //       : const SizedBox();
                    // }),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TpcContainer(double width, String Ctext, String ImgTxt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: width,
        decoration: const BoxDecoration(
          color: knmGradient5,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: knmGradient2,
                child: Image.asset(
                  ImgTxt,
                  height: 18,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Text(
                Ctext,
                style: const TextStyle(
                    color: knmGradient6,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Heebo"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildImage(var image, context) {
    return Consumer<HomeProvider>(
      builder: (context,hoPro,_) {
        return hoPro.carouselData=="ON"? Padding(
          padding: const EdgeInsets.only(left: 10,right:10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              fadeInCurve: Curves.easeInOutBack,
              width:MediaQuery.of(context).size.width,
              imageUrl: image,fit: BoxFit.fill,
              errorWidget: (context,url,error)=>const Icon(Icons.error,color: Colors.red,),
              progressIndicatorBuilder: (context,url,progress)=> const Center(child: CircularProgressIndicator(
                color: primary,
              )),),
          ),
        ): Container(
          padding: const EdgeInsets.only(left: 10,right:10),
          //color:Colors.yellow,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(image, fit:BoxFit.fill),
          ),
        );;
      }
    );



  }

  buidIndiaCator(int count, BuildContext context) {
    int imgCount = count;
    return Consumer<HomeProvider>(
      builder: (context,hom,_) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count:hom.carousilImage.length ,
              effect: const ExpandingDotsEffect(
                  dotWidth: 7,
                  dotHeight: 7,
                  activeDotColor: cl1B9BB2,
                  dotColor: Color(0xffaba17c)),
            ),
          ),
        );
      }
    );
  }

  ///exit function
  Future<bool> showExitPopup() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit?",style: TextStyle(fontFamily: "Poppins"),),
                  const SizedBox(height: 19),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: cl1B9BB2),
                          child: const Text("Yes",style: TextStyle(color: myWhite,fontFamily: "Poppins"),),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text("No",
                            style: TextStyle(color: Colors.black,fontFamily: "Poppins")),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<AlertDialog?> deviceIdAlreadyExistAlert(
      BuildContext context, String id,String name) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: myWhite,
            contentPadding: const EdgeInsets.all(15.0,),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            // insetPadding: EdgeInsets.symmetric(horizontal: 15),
              title: const Center(
                child: Text(
                      "Already you are a volunteer",
                      style: TextStyle(color: myBlack,fontFamily: "Poppins",fontSize: 16),
                    ),
              ),
                content:Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //Name
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width:100,
                              child: Text(
                                  "Name ",style: TextStyle(fontSize: 16,color: myBlack,)
                              ),
                            ),
                            const Text(":",style: TextStyle(fontSize: 16,color: myBlack,)),
                            Flexible(
                              fit:FlexFit.tight,
                              child: Text(
                                name,
                                maxLines: 3,
                                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: myBlack),

                              ),
                            ),
                          ] ,
                        ),

                        const SizedBox(height: 5,),

                        //Volunteer Id
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              const SizedBox(
                                width:100,
                                child: Text(
                                    "Volunteer ID",style: TextStyle(fontSize: 16,color: myBlack,)
                                ),
                              ),
                              const Text(":",style: TextStyle(fontSize: 16,color: myBlack,)),
                              Flexible(
                                fit:FlexFit.tight,
                                child: InkWell(
                                  onTap:(){
                                    Clipboard.setData(new ClipboardData(text: id)).then((_){
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        backgroundColor: myWhite,
                                        content: Text("Copied ID !",style: TextStyle(color:myBlack,fontWeight: FontWeight.bold),),
                                      ));
                                    });
                                  },
                                  child: Text(
                                    id,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: myBlack),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Clipboard.setData(ClipboardData(text:id)).then((_){
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      backgroundColor: myWhite,
                                      content: Text("Copied ID !",style: TextStyle(color:myBlack,fontWeight: FontWeight.bold),),
                                    ));
                                  });

                                },
                                child: const Text("CopyID",style: TextStyle(color: Colors.blue,fontSize: 15,decoration: TextDecoration.underline),),
                                // const Icon(
                                //   Icons.content_copy,
                                //   color: myBlack,
                                //   size: 25,
                                // ),
                              ),
                            ]
                        ),

                        // RichText(
                        //     text: TextSpan(
                        //       children: [
                        //         const TextSpan(
                        //             text:"Volunteer ID : ",style: TextStyle(fontSize: 16,color: myBlack,)
                        //         ),
                        //         TextSpan(
                        //           text:id,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: myBlack),
                        //           recognizer: new TapGestureRecognizer()..onTap = (){
                        //             Clipboard.setData(new ClipboardData(text: id)).then((_){
                        //               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //                 backgroundColor: myWhite,
                        //                 content: Text("Copied ID !",style: TextStyle(color:myBlack),),
                        //               ));
                        //             });
                        //           },
                        //         ),
                        //       ] ,
                        //     )),

                        const SizedBox(height: 5,),

                        //copy id
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     SizedBox(
                        //         width:100),
                        //     InkWell(
                        //       onTap: (){
                        //         Clipboard.setData(ClipboardData(text:id)).then((_){
                        //           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //             backgroundColor: myWhite,
                        //             content: Text("Copied ID !",style: TextStyle(color:myBlack),),
                        //           ));
                        //         });
                        //
                        //       },
                        //       child: const Text("CopyID",style: TextStyle(color: Colors.blue,fontSize: 15,decoration: TextDecoration.underline),),
                        //       // const Icon(
                        //       //   Icons.content_copy,
                        //       //   color: myBlack,
                        //       //   size: 25,
                        //       // ),
                        //     ),
                        //   ],
                        // ),

                      ],
                    ),
                    const SizedBox(height: 10,),
                   Consumer<HomeProvider>(builder: (context, value, child) {
                    return Form(
                      key: _formKey,
                      child: Consumer<HomeProvider>(
                          builder: (context, value3, child) {
                            return InkWell(
                              onTap: () {
                                finish(context);
                              },
                              child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.7,
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
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                            );
                          }),
                    );
                  }
                  )
                  ],
                ),

          );
        });
  }


  OutlineInputBorder border2 = OutlineInputBorder(
      borderSide: BorderSide(color: textfieldTxt.withOpacity(0.7)),
      borderRadius: BorderRadius.circular(10));

}
String getAmount(double totalCollection) {
  final formatter = NumberFormat.currency(locale: 'HI', symbol: '');
  String newText1 = formatter.format(totalCollection);
  String newText =
  formatter.format(totalCollection).substring(0, newText1.length - 3);
  return newText;
}