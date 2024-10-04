import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import '../providers/home_provider_reciept.dart';
import '../providers/main_provider.dart';
import '../providers/web_provider.dart';

class InagurationScreen extends StatefulWidget {
  InagurationScreen({Key? key}) : super(key: key);

  @override
  State<InagurationScreen> createState() => _InagurationScreenState();
}

class _InagurationScreenState extends State<InagurationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isAnimated = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _animation = Tween<double>(begin: 0.01, end: 2.3).animate(_controller);
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    homeProvider.checkIsOn();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0,top: 10),
            child: IconButton(
              icon: const Icon(Icons.power_settings_new_sharp, color: Colors.black,size: 40,),
              tooltip: 'Setting Icon',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    elevation: 20,
                    content: const Text("Do you want to OFF ?",
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                            color: person)),
                    actions: <Widget>[
                      Row(
                        children: [
                          Consumer<HomeProvider>(
                              builder: (context, value, child) {
                                return TextButton(
                                  onPressed: () {


                                    final DatabaseReference mRoot =
                                    FirebaseDatabase.instance.ref();

                                    mRoot.child("inaguration").set("OFF");
                                    value.setLaunchStatus("LAUNCH", false,context);
                                    value.controllerCenter.stop();

                                    runApp(MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider(
                                          create: (context) => DonationProvider(),
                                        ),
                                        ChangeNotifierProvider(
                                          create: (context) => HomeProvider(),
                                        ),
                                        ChangeNotifierProvider(
                                          create: (context) =>
                                              HomeProviderReceiptApp(),
                                        ),
                                        ChangeNotifierProvider(
                                          create: (context) => WebProvider(),
                                        ),
                                        ChangeNotifierProvider(
                                          create: (context) => MainProvider(),
                                        ),
                                      ],
                                      child: MaterialApp(
                                        debugShowCheckedModeBanner: false,
                                        home: InagurationScreen(),
                                      ),
                                    ));

                                    finish(context);
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 110,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            appBarReceipt,
                                            appBarReceipt,
                                            appBarReceipt
                                          ],
                                          begin: Alignment.topCenter,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x26000000),
                                            blurRadius: 2.0, // soften the shadow
                                            spreadRadius: 1.0, //extend the shadow
                                          ),
                                        ]),
                                    child: Center(
                                        child: const Text("yes",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700))),
                                  ),
                                );
                              }),
                          TextButton(
                              onPressed: () {
                                finish(context);
                              },
                              child: Container(
                                height: 45,
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x26000000),
                                      blurRadius: 2.0, // soften the shadow
                                      spreadRadius: 1.0, //extend the shadow
                                    ),
                                  ],
                                ),
                                child: const Center(
                                    child: Text("No",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700))),
                              ))
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // appBar: AppBar(
      //   toolbarHeight: 70,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Container(
      //       height: 81,
      //       width: 183,
      //       child: Center(child: Text('VAQ', style: wardAppbarTxt))),
      //   // flexibleSpace: Container(
      //   //   height: height*0.12,
      //   //   decoration: const BoxDecoration(
      //   //     color: Colors.white,
      //   //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17))
      //   //   ),
      //   //   child: Padding(
      //   //     padding: const EdgeInsets.only(top: 9.0),
      //   //     child: Row(
      //   //       mainAxisAlignment: MainAxisAlignment.start,
      //   //       children: [
      //   //         SizedBox(width: 33),
      //   //       InkWell(
      //   //         onTap: (){
      //   //           callNextReplacement(const HomeScreenNew(), context);
      //   //         },
      //   //           child: const Icon(Icons.arrow_back_ios_outlined,color: iconBlack,)),
      //   //         SizedBox(width: 55),
      //   //
      //   //          Container(
      //   //            height: 81,
      //   //            width: 183,
      //   //            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/appbarbgrd.png"))),
      //   //              child: Center(child: Text('Participate Now',style: wardAppbarTxt))),
      //   //
      //   //     ],),
      //   //   ),
      //   // ),
      //
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.power_settings_new_sharp, color: Colors.black,size: 40,),
      //       tooltip: 'Setting Icon',
      //       onPressed: () {
      //         showDialog(
      //           context: context,
      //           builder: (context) => AlertDialog(
      //             elevation: 20,
      //             content: const Text("Do you want to OFF ?",
      //                 style: TextStyle(
      //                     fontSize: 17,
      //                     fontFamily: "Montserrat",
      //                     fontWeight: FontWeight.w700,
      //                     color: person)),
      //             actions: <Widget>[
      //               Row(
      //                 children: [
      //                   Consumer<HomeProvider>(
      //                       builder: (context, value, child) {
      //                         return TextButton(
      //                           onPressed: () {
      //                             final DatabaseReference mRoot =
      //                             FirebaseDatabase.instance.ref();
      //
      //                             mRoot.child("inaguration").set("OFF");
      //                             value.setLaunchStatus("LAUNCH", false);
      //                             value.controllerCenter.stop();
      //
      //                             runApp(MultiProvider(
      //                               providers: [
      //                                 ChangeNotifierProvider(
      //                                   create: (context) => DonationProvider(),
      //                                 ),
      //                                 ChangeNotifierProvider(
      //                                   create: (context) => HomeProvider(),
      //                                 ),
      //                                 ChangeNotifierProvider(
      //                                   create: (context) =>
      //                                       HomeProviderReceiptApp(),
      //                                 ),
      //                                 ChangeNotifierProvider(
      //                                   create: (context) => WebProvider(),
      //                                 ),
      //                                 ChangeNotifierProvider(
      //                                   create: (context) => MainProvider(),
      //                                 ),
      //                               ],
      //                               child: MaterialApp(
      //                                 debugShowCheckedModeBanner: false,
      //                                 home: InagurationScreen(),
      //                               ),
      //                             ));
      //
      //                             finish(context);
      //                           },
      //                           child: Container(
      //                             height: 45,
      //                             width: 110,
      //                             decoration: BoxDecoration(
      //                                 gradient: const LinearGradient(
      //                                   colors: [
      //                                     appBarReceipt,
      //                                     appBarReceipt,
      //                                     appBarReceipt
      //                                   ],
      //                                   begin: Alignment.topCenter,
      //                                 ),
      //                                 borderRadius: BorderRadius.circular(8),
      //                                 boxShadow: const [
      //                                   BoxShadow(
      //                                     color: Color(0x26000000),
      //                                     blurRadius: 2.0, // soften the shadow
      //                                     spreadRadius: 1.0, //extend the shadow
      //                                   ),
      //                                 ]),
      //                             child: Center(
      //                                 child: const Text("yes",
      //                                     style: TextStyle(
      //                                         color: Colors.white,
      //                                         fontSize: 17,
      //                                         fontWeight: FontWeight.w700))),
      //                           ),
      //                         );
      //                       }),
      //                   TextButton(
      //                       onPressed: () {
      //                         finish(context);
      //                       },
      //                       child: Container(
      //                         height: 45,
      //                         width: 110,
      //                         decoration: BoxDecoration(
      //                           borderRadius: BorderRadius.circular(8),
      //                           color: Colors.white,
      //                           boxShadow: const [
      //                             BoxShadow(
      //                               color: Color(0x26000000),
      //                               blurRadius: 2.0, // soften the shadow
      //                               spreadRadius: 1.0, //extend the shadow
      //                             ),
      //                           ],
      //                         ),
      //                         child: const Center(
      //                             child: Text("No",
      //                                 style: TextStyle(
      //                                     color: Colors.black,
      //                                     fontSize: 17,
      //                                     fontWeight: FontWeight.w700))),
      //                       ))
      //                 ],
      //               )
      //             ],
      //           ),
      //         );
      //       },
      //     ),
      //
      //   ],
      // ),
      body: Center(
        child: Stack(
          children: [
            Consumer<HomeProvider>(
              builder: (context,value,child) {
                return SizedBox(
                  height: height,
                  width: width,
                  // color: Colors.red,
                  child:
                  value.isLaunched?
                  Image.asset("assets/App Launhing.jpg",fit: BoxFit.cover,)
                  :SizedBox(),
                );
              }
            ),

            Consumer<HomeProvider>(builder: (context, value, child) {
              return value.isLaunched
                  ? Align(
                alignment: Alignment.bottomLeft,
                child: ConfettiWidget(
                  gravity: .3,
                  minBlastForce: 5, maxBlastForce: 800,
                  numberOfParticles: 300,
                  confettiController: value.controllerCenter,
                  blastDirectionality: BlastDirectionality.explosive,
                  // don't specify a direction, blast randomly
                  //blastDirection: BorderSide.strokeAlignOutside,
                  shouldLoop:
                  true, // start again as soon as the animation is finished
                  colors: const [
                    Color(0xFFFFDF00), //Golden yellow
                    Color(0xFFD4AF37), //Metallic gold
                    Color(0xFFCFB53B), //Old gold
                    Color(0xFFC5B358), //Old gold
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
                  createParticlePath:
                  value.drawStar, // define a custom shape/path.
                ),
              )
                  : SizedBox();
            }),

            Align(
              alignment: Alignment.center,
              child: Consumer<HomeProvider>(builder: (context, value, child) {
                return value.isLaunched
                    ?
                // SlideTransition(
                //   position: _offsetAnimation,
                //   child:  Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Image.asset("assets/myl_march_logo.png",scale: 3)
                //   ),
                // )
                Column(
                  children: [
                    // AppBar(
                    //   toolbarHeight: 70,
                    //   backgroundColor: Colors.transparent,
                    //   elevation: 0,
                    //   centerTitle: true,
                    //   // title: Container(
                    //   //     height: 81,
                    //   //     width: 183,
                    //   //     child: Center(child: Text('VAQ', style: wardAppbarTxt))),
                    //   // // flexibleSpace: Container(
                    //   //   height: height*0.12,
                    //   //   decoration: const BoxDecoration(
                    //   //     color: Colors.white,
                    //   //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17))
                    //   //   ),
                    //   //   child: Padding(
                    //   //     padding: const EdgeInsets.only(top: 9.0),
                    //   //     child: Row(
                    //   //       mainAxisAlignment: MainAxisAlignment.start,
                    //   //       children: [
                    //   //         SizedBox(width: 33),
                    //   //       InkWell(
                    //   //         onTap: (){
                    //   //           callNextReplacement(const HomeScreenNew(), context);
                    //   //         },
                    //   //           child: const Icon(Icons.arrow_back_ios_outlined,color: iconBlack,)),
                    //   //         SizedBox(width: 55),
                    //   //
                    //   //          Container(
                    //   //            height: 81,
                    //   //            width: 183,
                    //   //            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/appbarbgrd.png"))),
                    //   //              child: Center(child: Text('Participate Now',style: wardAppbarTxt))),
                    //   //
                    //   //     ],),
                    //   //   ),
                    //   // ),
                    //
                    //   actions: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(right:100),
                    //       child: IconButton(
                    //         icon: const Icon(Icons.power_settings_new_sharp, color: Colors.black,size: 40,),
                    //         tooltip: 'Setting Icon',
                    //         onPressed: () {
                    //           showDialog(
                    //             context: context,
                    //             builder: (context) => AlertDialog(
                    //               elevation: 20,
                    //               content: const Text("Do you want to OFF ?",
                    //                   style: TextStyle(
                    //                       fontSize: 17,
                    //                       fontFamily: "Montserrat",
                    //                       fontWeight: FontWeight.w700,
                    //                       color: person)),
                    //               actions: <Widget>[
                    //                 Row(
                    //                   children: [
                    //                     Consumer<HomeProvider>(
                    //                         builder: (context, value, child) {
                    //                           return TextButton(
                    //                             onPressed: () {
                    //                               final DatabaseReference mRoot =
                    //                               FirebaseDatabase.instance.ref();
                    //
                    //                               mRoot.child("inaguration").set("OFF");
                    //                               value.setLaunchStatus("LAUNCH", false);
                    //                               value.controllerCenter.stop();
                    //
                    //                               runApp(MultiProvider(
                    //                                 providers: [
                    //                                   ChangeNotifierProvider(
                    //                                     create: (context) => DonationProvider(),
                    //                                   ),
                    //                                   ChangeNotifierProvider(
                    //                                     create: (context) => HomeProvider(),
                    //                                   ),
                    //                                   ChangeNotifierProvider(
                    //                                     create: (context) =>
                    //                                         HomeProviderReceiptApp(),
                    //                                   ),
                    //                                   ChangeNotifierProvider(
                    //                                     create: (context) => WebProvider(),
                    //                                   ),
                    //                                   ChangeNotifierProvider(
                    //                                     create: (context) => MainProvider(),
                    //                                   ),
                    //                                 ],
                    //                                 child: MaterialApp(
                    //                                   debugShowCheckedModeBanner: false,
                    //                                   home: InagurationScreen(),
                    //                                 ),
                    //                               ));
                    //
                    //                               finish(context);
                    //                             },
                    //                             child: Container(
                    //                               height: 45,
                    //                               width: 110,
                    //                               decoration: BoxDecoration(
                    //                                   gradient: const LinearGradient(
                    //                                     colors: [
                    //                                       appBarReceipt,
                    //                                       appBarReceipt,
                    //                                       appBarReceipt
                    //                                     ],
                    //                                     begin: Alignment.topCenter,
                    //                                   ),
                    //                                   borderRadius: BorderRadius.circular(8),
                    //                                   boxShadow: const [
                    //                                     BoxShadow(
                    //                                       color: Color(0x26000000),
                    //                                       blurRadius: 2.0, // soften the shadow
                    //                                       spreadRadius: 1.0, //extend the shadow
                    //                                     ),
                    //                                   ]),
                    //                               child: Center(
                    //                                   child: const Text("yes",
                    //                                       style: TextStyle(
                    //                                           color: Colors.white,
                    //                                           fontSize: 17,
                    //                                           fontWeight: FontWeight.w700))),
                    //                             ),
                    //                           );
                    //                         }),
                    //                     TextButton(
                    //                         onPressed: () {
                    //                           finish(context);
                    //                         },
                    //                         child: Container(
                    //                           height: 45,
                    //                           width: 110,
                    //                           decoration: BoxDecoration(
                    //                             borderRadius: BorderRadius.circular(8),
                    //                             color: Colors.white,
                    //                             boxShadow: const [
                    //                               BoxShadow(
                    //                                 color: Color(0x26000000),
                    //                                 blurRadius: 2.0, // soften the shadow
                    //                                 spreadRadius: 1.0, //extend the shadow
                    //                               ),
                    //                             ],
                    //                           ),
                    //                           child: const Center(
                    //                               child: Text("No",
                    //                                   style: TextStyle(
                    //                                       color: Colors.black,
                    //                                       fontSize: 17,
                    //                                       fontWeight: FontWeight.w700))),
                    //                         ))
                    //                   ],
                    //                 )
                    //               ],
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     ),
                    //
                    //   ],
                    // ),
                    // ScaleTransition(
                    //   scale: _animation,
                    //   child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Image.asset("assets/dckAssets/dckLogo3x.png",
                    //           scale: 2)),
                    // ),
                  ],
                )
                // Image.asset(
                //   "assets/final.gif",scale: 1.8,repeat: ImageRepeat.noRepeat,
                // )
                    : SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: height*.55,
                          width:width*.40,
                          child: Image.asset("assets/AmdkLaunchLeft.png"),
                        ),
                        // Image.asset(""),

                        InkWell(
                          onTap: () {

                            final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
                            mRoot.child("inaguration").set("ON");
                            value.setLaunchStatus("LAUNCHED", true,context);
                            value.controllerCenter.play();
                            final player=AudioCache();
                            player.play('music.mp3');
                            // final player = AudioCache();
                            // player.play('music.mp3');
                            _controller.forward();
                          },
                          child: Container(
                            height: 350,
                            width: 350,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE1E8F0),
                              shape: BoxShape.circle,
                            ),

                            child: Center(
                              child: Container(
                                height: 265.0,
                                width: 265,
                                decoration: const BoxDecoration(
                                  color: myWhite,
                                  shape: BoxShape.circle,
                                ),

                                child: Center(
                                  child: Container(
                                    height: 185.0,
                                    width: 185,
                                    // padding: const EdgeInsets.only(left: 49.42, right: 50.42),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: [Color(0xFF0093D6), Color(0xFF073F85)],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(308),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        value.launchStatus == "LAUNCH"
                                            ? 'Launch'
                                            : "Launched",

                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 34,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            Consumer<HomeProvider>(
              builder: (context,value,child) {
                return
                  value.isLaunched?
                  SizedBox()
                      : Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Powered By',
                            style: TextStyle(
                              color: myBlack,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w800,
                              height: 0.09,
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/spine.png",scale: 3),
                              SizedBox(width: 10,),
                              Image.asset("assets/neurobots.png",scale: 3),
                            ],
                          ),
                          const SizedBox(height: 20,),
                        ],
                      )
                  );
              }
            ),

            Consumer<HomeProvider>(builder: (context, value, child) {
              return value.isLaunched
                  ? Align(
                alignment: Alignment.topRight,
                child: ConfettiWidget(
                  gravity: .3,
                  minBlastForce: 5, maxBlastForce: 800,
                  numberOfParticles: 300,
                  confettiController: value.controllerCenter,
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
              )
                  : const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
