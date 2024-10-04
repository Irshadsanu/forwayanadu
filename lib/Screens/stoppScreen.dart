import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/constants/my_functions.dart';
import 'package:quaide_millat/providers/home_provider.dart';

import '../constants/my_colors.dart';
import 'end_screen.dart';

class StoppScreen extends StatelessWidget {
  const StoppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/stopp.jpg'), fit: BoxFit.cover)),
            child: Column(
              children: [],
            ),
          ),
          Consumer<HomeProvider>(
            builder: (context,value,child) {
              return Positioned(
                left: width * .67,
                top: height * 0.35,
                child:  InkWell(
                  onTap: (){

                callNext(EndScreen(), context);
                  },
                  child: Container(
                    width: 200, // Adjust the size of the circle here
                    height: 200, // Adjust the size of the circle here
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF0093D6), // Light Blue
                          Color(0xFF073F85) // Dark Blue
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'STOP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24, // Adjust the font size here
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          )
        ],
      ),
      floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/spine.png", scale: 3),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset("assets/neurobots.png", scale: 3),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }
}
