import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/Screens/kmcc_history.dart';
import 'package:quaide_millat/Screens/ward_history.dart';
import 'package:quaide_millat/constants/text_style.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/home_provider.dart';

class WardHistoryHome extends StatefulWidget {
  const WardHistoryHome({Key? key}) : super(key: key);

  @override
  State<WardHistoryHome> createState() => _WardHistoryHomeState();
}

class _WardHistoryHomeState extends State<WardHistoryHome>with SingleTickerProviderStateMixin {

  late TabController _tabController;


  List mainScreens = [
   WardHistory(),
    KmccHistory()
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
    }else {
      return mob(context);}
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
                "Report",
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
                                    child: Text("INDIA",
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
                                },
                              ),
                              GButton(
                                leading: SizedBox(
                                  height: 35,
                                  width: 96,
                                  child: Center(
                                    child: Text("KMCC",
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
                                  homeProvider.fetchWard("KMCC");

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
      ),
    );
  }
}
