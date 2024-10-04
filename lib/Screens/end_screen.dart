import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/providers/home_provider.dart';

import '../constants/my_colors.dart';

class EndScreen extends StatefulWidget {
  const EndScreen({Key? key}) : super(key: key);

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.stopeBoolTrue();
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Container(
      width:width ,
      height: height,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('IUML KASARAGOD ആസ്ഥാന മന്ദിര ഫണ്ട് \n'
                        'സമാഹരണ ക്യാമ്പിൻ ചരിത്ര വിജയമാക്കിയ \nഎല്ലാവർക്കും '
                        'നന്ദി',style: TextStyle(fontSize: 18,decoration: TextDecoration.none,color: myGradient6),),
                  ),
                ),
                SizedBox(height: height*.3,),
                Padding(
                  padding:  EdgeInsets.only(left:width*.12),
                  child: Image.asset('assets/logo.png',scale: 2,),
                )
              ],
            ),

            Consumer<HomeProvider>(
              builder: (context,value,child) {
                return Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: AnimatedAlign(
                    alignment: value.stopeBool ? Alignment.bottomRight : Alignment.topRight,
                    duration: const Duration(seconds: 60),
                    curve: Curves.fastOutSlowIn,
                    child:Stack(
                      children: [
                        Image.asset('assets/splashbgBottom.png',scale: 3,),
                        Image.asset('assets/splashCenterImage.png',scale: 8,),
                      ],
                    ),
                  ),
                );
              }
            ),

          ],
        ),
      ),
    );

  }
}
