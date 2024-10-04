import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/Screens/assembly_report.dart';
import 'package:quaide_millat/Screens/district_report.dart';
import 'package:quaide_millat/Screens/topKmccReport.dart';
import 'package:quaide_millat/Screens/topMuncipalityReport.dart';
import 'package:quaide_millat/Screens/topWardReport.dart';
import 'package:quaide_millat/Screens/top_assembly_report.dart';
import 'package:quaide_millat/Screens/top_panchayath_report.dart';
import 'package:quaide_millat/constants/text_style.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/home_provider.dart';

class ToppersHomeScreen extends StatefulWidget {
  const ToppersHomeScreen({Key? key}) : super(key: key);

  @override
  State<ToppersHomeScreen> createState() => _ToppersHomeScreenState();
}

class _ToppersHomeScreenState extends State<ToppersHomeScreen>with SingleTickerProviderStateMixin {

  late TabController _tabController;


  List mainScreens = [
    const TopKmccReport(),
    DistrictReport(from: ''),
    const TopAssemblyReport(),
    const TopPanchayathReport(),
    const TopMuncipalityReport(),
    const TopWardReport(),
  ];

  ValueNotifier<int> screenValue = ValueNotifier(0);

  PageController _pageController = PageController();
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _tabController = TabController(length: 5, vsync: this);
      print(_tabController.index.toString()+"dlolold");
    });
  }


  @override
  Widget build (BuildContext context){
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);

    if(kIsWeb){
      return mob(context);
    }else
    {return mob(context);}
  }

  Widget mob (BuildContext context){
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return PopScope(
      onPopInvoked: (wekld){
        homeProvider.clearAllReport();
        print("skdjnewkn");

      },
      child: Scaffold(
        backgroundColor: myWhite,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: AppBar(
              leading: InkWell(
                  onTap: () {
                    finish(context);
                    homeProvider.clearAllReport();
                    // callNextReplacement(const HomeScreenNew(), context);
                  },
                  child: CircleAvatar(
                      radius: 14,
                      backgroundColor: cl000008.withOpacity(0.05),
                      child: const Icon(Icons.arrow_back_ios_outlined,color: myBlack,)
                  )
              ),
              toolbarHeight: MediaQuery.of(context).size.height*0.12,
              backgroundColor: Colors.white,
              elevation: 0,
              leadingWidth: 55,
              centerTitle: true,
              title:   Text(
                "Top Reports",
                style: wardAppbarTxt
              ),
              bottom:PreferredSize(
                  preferredSize: const Size.fromHeight(45),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 2, 5, 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ValueListenableBuilder(
                          valueListenable: screenValue,
                          builder: (context, int newValue, child) {
                            return GNav(
                              iconSize: 16,
                              tabBorderRadius: 8,
                              backgroundColor: myWhite,
                              // backgroundColor: Colors.red,
                              // color: Colors.white,
                              selectedIndex: newValue,
                              // activeColor: Colors.white,
                              tabBackgroundColor: cl1B9BB2,
                              tabBorder: Border.all(color: clDEDEDE,width: 0.5),
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              tabMargin: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              gap: 1,
                              tabs: [

                                GButton(
                                  leading: SizedBox(
                                    height: 35,
                                    width: 96,
                                    child: Center(
                                      child: Text("KMCC",
                                        textAlign:TextAlign.center,
                                        style: TextStyle(
                                            color: newValue==0? myWhite:myBlack,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontFamily: "Poppins"
                                        ),),
                                    ),
                                  ),
                                  icon: Icons.military_tech,
                                  iconSize: newValue==0?18:25,
                                  onPressed: () {
                                    screenValue.value = 0;
                                  },
                                ),
                                GButton(
                                  leading: SizedBox(
                                    height: 35,
                                    width: 96,
                                    child: Center(
                                      child: Text("District",
                                        textAlign:TextAlign.center,
                                        style: TextStyle(
                                            color: newValue==1? myWhite:myBlack,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontFamily: "Poppins"
                                        ),),
                                    ),
                                  ),
                                  icon: Icons.military_tech,
                                  iconSize: newValue==1?18:25,
                                  onPressed: () {
                                    screenValue.value = 1;
                                    homeProvider.fetchDistrictWiseReport();
                                  },
                                ),
                                GButton(
                                  leading:  SizedBox(
                                    height: 35,
                                    width: 96,
                                    child: Center(
                                      child: Text("Assembly",
                                        textAlign:TextAlign.center,
                                        style: TextStyle(
                                            color: newValue==2? myWhite:myBlack,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontFamily: "Poppins"
                                        ),),
                                    ),
                                  ),
                                  icon: Icons.military_tech,
                                  iconSize: newValue==2?18:25,
                                  onPressed: () {
                                    print('ODENOFNR');
                                    screenValue.value = 2;
                                    homeProvider.fetchTopAssemblyReport();

                                  },
                                ),
                                GButton(
                                  leading: SizedBox(
                                    height: 35,
                                    width: 96,
                                    child:  Center(
                                      child: Text("Panchayath",
                                        textAlign:TextAlign.center,
                                        style: TextStyle( color:newValue==3?
                                        myWhite:myBlack,fontWeight: FontWeight.w600,fontSize: 14,
                                            fontFamily: "Poppins"
                                        ),),
                                    ),
                                  ),
                                  icon: Icons.military_tech,
                                  iconSize: newValue==0?18:25,
                                  onPressed: () {
                                    homeProvider.fetchTopPanchayathReport();
                                    screenValue.value = 3;
                                  },
                                ),
                                GButton(
                                  leading: SizedBox(
                                    height: 35,
                                    width: 96,
                                    child:  Center(
                                      child: Text("Municipality",
                                        textAlign:TextAlign.center,
                                        style: TextStyle( color:newValue==4?
                                        myWhite:myBlack,fontWeight: FontWeight.w600,fontSize: 14,
                                            fontFamily: "Poppins"
                                        ),),
                                    ),
                                  ),
                                  icon: Icons.military_tech,
                                  iconSize: newValue==0?18:25,
                                  onPressed: () {
                                    homeProvider.fetchTopPanchayathReport();
                                    screenValue.value = 4;
                                  },
                                ),
                                GButton(
                                  leading: SizedBox(
                                    height: 35,
                                    width: 96,
                                    child:  Center(
                                      child: Text("Unit",
                                        textAlign:TextAlign.center,
                                        style: TextStyle( color:newValue==5?
                                        myWhite:myBlack,fontWeight: FontWeight.w600,fontSize: 14,
                                            fontFamily: "Poppins"
                                        ),),
                                    ),
                                  ),
                                  icon: Icons.military_tech,
                                  iconSize: newValue==0?18:25,
                                  onPressed: () {
                                    homeProvider.fetchTopWardReport();
                                    screenValue.value = 5;
                                  },
                                ),
                              ],
                            );
                          }),
                    ),
                  )),
            ),
          ),

          body:  ValueListenableBuilder(
              valueListenable: screenValue,
              builder: (context, int value, child) {
                return mainScreens[value];
              }),
        // bottomNavigationBar: Container(
        //   margin: const EdgeInsets.fromLTRB(5, 2, 5, 10),
        //   decoration: const BoxDecoration(
        //       color:Colors.white,
        //       borderRadius: BorderRadius.only(
        //           topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        //   child: ValueListenableBuilder(
        //       valueListenable: screenValue,
        //       builder: (context, int newValue, child) {
        //         return GNav(iconSize: 16,
        //           tabBorderRadius: 12,
        //           // backgroundColor: Colors.red,
        //           // color: Colors.white,
        //           selectedIndex: newValue,
        //           // activeColor: Colors.white,
        //           tabBackgroundColor: clBDFFEF,
        //
        //           // tabShadow: const [
        //           //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
        //           padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           gap: 1,
        //           tabs: [
        //
        //             GButton(
        //               // shadow: const [
        //               //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
        //
        //               leading: Column(
        //                 children: [
        //                   Container(
        //                       // color: clF9F9F9,
        //                     // height:newValue==0?35:40 ,
        //                     alignment: Alignment.center,
        //                     // width: newValue==0?35:40,
        //                     child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
        //                   ),
        //                   const Center(
        //                     child: Text("Unit",
        //                       textAlign:TextAlign.center,
        //                       style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
        //                   )
        //                 ],
        //               ),
        //               icon: Icons.military_tech,
        //               iconSize: newValue==0?18:25,
        //               onPressed: () {
        //                 screenValue.value = 0;
        //               },
        //             ),
        //             GButton(
        //               // shadow: const [
        //               //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
        //
        //               leading: Column(
        //                 children: [
        //                   Container(
        //                       // color: clF9F9F9,
        //                     // height:newValue==0?35:40 ,
        //                     alignment: Alignment.center,
        //                     // width: newValue==0?35:40,
        //                     child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
        //                   ),
        //                   const Center(
        //                     child: Text("Municipality",
        //                       textAlign:TextAlign.center,
        //                       style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
        //                   )
        //                 ],
        //               ),
        //               icon: Icons.military_tech,
        //               iconSize: newValue==0?18:25,
        //               onPressed: () {
        //                 screenValue.value = 1;
        //                 homeProvider.fetchTopPanchayathReport();
        //               },
        //             ),
        //             GButton(
        //               // shadow: const [
        //               //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
        //
        //               leading: Column(
        //                 children: [
        //                   Container(
        //                       // color: clF9F9F9,
        //                     // height:newValue==0?35:40 ,
        //                     alignment: Alignment.center,
        //                     // width: newValue==0?35:40,
        //                     child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
        //                   ),
        //                   const Center(
        //                     child: Text("Panchayath",
        //                       textAlign:TextAlign.center,
        //                       style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
        //                   )
        //                 ],
        //               ),
        //               icon: Icons.military_tech,
        //               iconSize: newValue==0?18:25,
        //               onPressed: () {
        //                 screenValue.value = 2;
        //                 homeProvider.fetchTopPanchayathReport();
        //
        //               },
        //             ),
        //             GButton(
        //               // shadow: const [
        //               //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
        //
        //               leading: Column(
        //                 children: [
        //                   Container(
        //                       // color: clF9F9F9,
        //                     // height:newValue==0?35:40 ,
        //                     alignment: Alignment.center,
        //                     // width: newValue==0?35:40,
        //                     child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
        //                   ),
        //                   const Center(
        //                     child: Text("Assembly",
        //                       textAlign:TextAlign.center,
        //                       style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
        //                   )
        //                 ],
        //               ),
        //               icon: Icons.military_tech,
        //               iconSize: newValue==0?18:25,
        //               onPressed: () {
        //                 homeProvider.fetchTopAssemblyReport();
        //                 screenValue.value = 3;
        //               },
        //             ),
        //             // GButton(
        //             //   // shadow: const [
        //             //   //   BoxShadow(color: clD8D8D8,),BoxShadow(color: Colors.white,blurRadius: 12,spreadRadius: -12)],
        //             //
        //             //   leading: Column(
        //             //     children: [
        //             //       Container(
        //             //           // color: clF9F9F9,
        //             //         // height:newValue==0?35:40 ,
        //             //         alignment: Alignment.center,
        //             //         // width: newValue==0?35:40,
        //             //         child: Image.asset("assets/panchayath_report.png", scale:newValue==0?4:4,fit: BoxFit.fill,),
        //             //       ),
        //             //       const Center(
        //             //         child: Text("District",
        //             //           textAlign:TextAlign.center,
        //             //           style: TextStyle(color: myBlack,fontWeight: FontWeight.bold,fontSize: 11),),
        //             //       )
        //             //     ],
        //             //   ),
        //             //   icon: Icons.military_tech,
        //             //   iconSize: newValue==0?18:25,
        //             //   onPressed: () {
        //             //     screenValue.value = 4;
        //             //     homeProvider.fetchDistrictWiseReport();
        //             //   },
        //             // ),
        //
        //
        //
        //           ],
        //         );
        //       }),
        // ),
        // body: ValueListenableBuilder(
        //     valueListenable: screenValue,
        //     builder: (context, int value, child) {
        //       return mainScreens[value];
        //     }),
      ),
    );
  }
}
