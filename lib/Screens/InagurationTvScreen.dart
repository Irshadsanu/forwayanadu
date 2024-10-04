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

class InagurationTvScreen extends StatefulWidget {
  InagurationTvScreen({Key? key}) : super(key: key);


  @override
  State<InagurationTvScreen> createState() => _InagurationTvScreenState();
}

class _InagurationTvScreenState extends State<InagurationTvScreen>
    // with SingleTickerProviderStateMixin
{
  // late AnimationController _controllerTv;
  // late Animation<double> _animation;
  // bool _isAnimated = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controllerTv = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 105),
    // );
    // _animation = Tween<double>(begin: 0.01, end: 2.3).animate(_controllerTv);
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);


    ///ba

      homeProvider.inagurationTriggerKKD(context);

    // homeProvider.getProject();
    // donationProvider.fetchEquipment();

    // if(homeProvider.isLaunched){
    //   _controllerTv.forward();
    // }
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

      body:MediaQuery.of(context).orientation == Orientation.landscape?
      Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/App Launhing.jpg",),
                    fit: BoxFit.cover
                  )
              ),
            ),

            Consumer<HomeProvider>(
                builder: (context,value,child) {

                  return value.isLaunched
                      ?Align(
                    alignment:Alignment.topLeft ,
                    child: ConfettiWidget(
                      gravity: .3,
                      minBlastForce: 5, maxBlastForce: 1000,
                      numberOfParticles: 500,
                      confettiController: value.controllerCenter,
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: true, // start again as soon as the animation is finished
                      colors: const [
                        Color(0xFFFFDF00),//Golden yellow
                        Color(0xFFD4AF37),//Metallic gold
                        Color(0xFFCFB53B),//Old gold
                        Color(0xFFC5B358),//Old gold
                      ], // manually specify the colors to be used
                      createParticlePath: value.drawStar, // define a custom shape/path.
                    ),
                  ):SizedBox();
                }
            ),

            Positioned(top: MediaQuery.of(context).size.height*0.35,
              left: MediaQuery.of(context).size.width*0.49,
              child: Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return value.isLaunched
                        ?
                    // SlideTransition(
                    //   position: _offsetAnimation,
                    //   child:  Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Image.asset("assets/myl_march_logo.png",scale: 3)
                    //   ),
                    // )
                    ///pop up image
                    SizedBox(height: height*0.3,
                      // child: ScaleTransition(
                      //   scale: _animation,
                      //   child:  Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Image.asset("assets/phoneKmf.png",scale: 1)
                      //   ),
                      // ),
                    )
                    // Image.asset(
                    //   "assets/final.gif",scale: 1.8,repeat: ImageRepeat.noRepeat,
                    // )
                        :SizedBox();
                  }
              ),
            ),

            Consumer<HomeProvider>(
                builder: (context,value,child) {
                  return value.isLaunched
                      ?Align(
                    alignment:Alignment.topRight ,
                    child: ConfettiWidget(
                      gravity: .3,
                      minBlastForce: 5, maxBlastForce: 1000,
                      numberOfParticles: 500,
                      confettiController: value.controllerCenter,
                      blastDirectionality: BlastDirectionality.explosive,
                      // don't specify a direction, blast randomly
                      //blastDirection: BorderSide.strokeAlignOutside,
                      shouldLoop: true, // start again as soon as the animation is finished
                      colors: const [
                        Color(0xFFFFDF00),//Golden yellow
                        Color(0xFFD4AF37),//Metallic gold
                        Color(0xFFCFB53B),//Old gold
                        Color(0xFFC5B358),//Old gold
                      ],
                      createParticlePath: value.drawStar, // define a custom shape/path.
                    ),
                  ):const SizedBox();
                }
            ),
          ],
        ),
      ):SizedBox(),
    );
  }



}

