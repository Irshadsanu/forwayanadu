import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/Views/house_model.dart';
import 'package:quaide_millat/providers/home_provider.dart';

import '../constants/alerts.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import 'home_screen.dart';

class HouseDonationList extends StatelessWidget {
  const HouseDonationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(84),
          child: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            toolbarHeight: height * 0.12,
            // shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
            title: Text('House Contribution', style: wardAppbarTxt),
            leadingWidth: 55,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: InkWell(
                  onTap: () {
                    callNextReplacement(const HomeScreenNew(), context);
                  },
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: cl000008.withOpacity(0.05),
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: myBlack,
                      ))),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Top contributors",
                style: TextStyle(
                    fontFamily: "Poppins", fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
                child: Consumer<HomeProvider>(builder: (context, homPro, _) {
              return ListView.separated(
                itemCount: homPro.houseList.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 60),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 6,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  HouseModel item = homPro.houseList[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      left: 8,
                    ),
                    child: SizedBox(
                      width: width,
                      height: 180,
                      // color: Colors.red,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:  EdgeInsets.only( right: width/11,bottom: 22),

                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: item.image != ""
                                    ? BoxDecoration(
                                    // color: Colors.red,
                                    color: myWhite,

                                    image: DecorationImage(
                                            image: NetworkImage(
                                              item.image,
                                            ),
                                            fit: BoxFit.fill)
                                        // borderRadius: BorderRadius.circular(20),
                                        )
                                    : const BoxDecoration(
                                        color: myWhite,
                                        // image: DecorationImage(image: AssetImage("assets/ksdReceiptImg.jpg",),fit: BoxFit.fill)
                                        // borderRadius: BorderRadius.circular(20),
                                      ),
                                // child: Row(
                                //
                                //   children: [
                                //   Image.asset("assets/ksdReceiptImg.jpg")
                                // ],),
                              ),
                            ),
                          ),
                          Image.asset(
                            "assets/Home card (1).png",
                            height: 190,
                            fit: BoxFit.fill,
                          ),
                          Padding(

                              // top: 70,
                              padding:  EdgeInsets.only(top: 54, left: width/2.5),
                              child: Container(
                                  width: width/6,
                                  height: 53,
                                  // color: Colors.red,
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                      child: Text(
                                    item.houseCount.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                        color: myWhite),
                                  )))),
                          Padding(
                              padding:  EdgeInsets.only(top: 108, left:width/5),
                              child: Container(
                                width: width / 2.5,
                                height: 50,
                                alignment: Alignment.centerLeft,
                                // color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      item.name,maxFontSize: 12,
                                       minFontSize:10 ,
                                       maxLines: 2  ,
                                      wrapWords: true,group: AutoSizeGroup(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(height: 1,
                                          fontWeight: FontWeight.bold,
                                          // fontSize: 9,
                                          color: myWhite),
                                    ),
                                    Text(
                                      " ${item.district}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          height: 1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9,
                                          color: myWhite),
                                    ),
                                    Text(
                                      "${item.unit} ",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          height: 1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9,
                                          color: myWhite),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              );
            }))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InkWell(
          onTap: () {
            alertHomeSupport(context);
          },
          child: Container(
            height: 50,
            width: width * .83,
            decoration: BoxDecoration(
              boxShadow: [
                const BoxShadow(
                  color: cl1E9201,
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
                  colors: [cl0EA3A9, cl3686C5]),
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/CoinGif.gif"),
                const Text(
                  "Join Now",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Poppins",
                      color: myWhite,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
