import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/gradientTextClass.dart';
import '../constants/my_colors.dart';
import '../providers/home_provider.dart';

class TopKmccReport extends StatelessWidget {
  const TopKmccReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return mobile(context);
    }
  }

  Widget mobile(context) {
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: myWhite,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<HomeProvider>(builder: (context, value, child) {
                  return ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.topKmccList.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<Color> border = [];
                        border = homeProvider.getcolors(index);
                        var item = value.topKmccList[index];
                        return InkWell(
                          onTap: (){
                            // value.fetchDistrictWiseAssemblyReport(item.district,context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, bottom: 8),
                            child: Container(
                              width: double.infinity,
                              // height:85,
                              padding: EdgeInsets.symmetric(vertical:10 ),
                              decoration:  BoxDecoration(
                                color: Colors.white,
                                boxShadow: index==0||index==1||index==2?null:[
                                  BoxShadow(
                                      offset: const Offset(0, 4),
                                      color:cl000000.withOpacity(0.08),
                                      blurRadius:4,
                                      spreadRadius:0
                                  )
                                ],
                                // gradient: LinearGradient(colors: [
                                //   Color(0xff1D9000),
                                //   Color(0xff20A200),
                                // ]),
                                image: index==0||index==1||index==2? const DecorationImage(
                                  image:  AssetImage('assets/topbg.png'),fit: BoxFit.fill,
                                ):null,
                                borderRadius: const BorderRadius.all(Radius.circular(15)),

                              ),
                              child: ListTile(
                                leading: Stack(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset("assets/leaderBadge.png",scale: 3,),
                                      ),
                                    ),
                                    Positioned(
                                        top:14,
                                        left: index+1>=100?5:17,
                                        child: SizedBox(width: 25,
                                            // color:Colors.red,
                                            child: Center(
                                                child: Text((index+1).toString(),
                                                  style: const TextStyle(
                                                      color: myWhite,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize:12
                                                  ),)))),
                                  ],
                                ),
                                title: Text(
                                  item.district,
                                  style:  TextStyle(
                                      color: index==0||index==1||index==2?Colors.white:Colors.black,
                                      fontSize: 11.5,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Container(
                                    alignment: Alignment.centerRight,
                                    width: width * .30,
                                    // color: Colors.blue,

                                    // Text("₹"+getAmount(double.parse(item.totalAMount.toString())),style:
                                    // const TextStyle(fontWeight: FontWeight.normal, fontFamily: 'LilitaOne-Regular',color:myWhite,fontSize: 20),),
                                    child: AutoSizeText("₹" + getAmount(double.parse(item.districtAmount.toStringAsFixed(0))),
                                      style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 15.5,
                                          color: index==0||index==1||index==2?Colors.white:Colors.black),)),
                              ),
                            ),
                          ),
                        );
                      });
                }),
                Consumer<HomeProvider>(
                    builder: (context,value2,child) {
                      return Visibility(
                        visible:value2.totalOther>0 ,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, bottom: 10),
                          child: Container(
                            alignment: Alignment.center,
                            height: 65,
                            decoration: BoxDecoration(
                                color: myWhite,
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(color: c_Grey, width: 0.1)),
                            child: ListTile(
                              leading: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF78FFD6),
                                        Color(0xFFAAEED9)
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    )),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset("assets/newAssets/DistrictIcon.png",scale: 4,),
                                ),
                              ),
                              title: Text(
                                "Other",
                                style: const TextStyle(
                                    color: myBlack,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Container(
                                  alignment: Alignment.centerRight,
                                  width: width * .30,
                                  //  color: Colors.blue,
                                  child: GradientText(
                                    "₹" +
                                        value2.totalOther.toStringAsFixed(0).toString(),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF78FFD6),
                                          Color(0xFFAAEED9)
                                        ]),
                                    style: const TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                          ),
                        ),
                      );
                    }
                )
              ],
            ),
          )),
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
