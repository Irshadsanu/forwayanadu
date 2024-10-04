import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/home_provider.dart';
import 'home_screen.dart';

class TopEnrollersScreen extends StatelessWidget {
  const TopEnrollersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return PopScope(
      onPopInvoked: (ekd){
        homeProvider.clearAllReport();

      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: myWhite,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(84),
            child: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: height*0.12,
              // shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
              title: Text('Top Volunteers',style: wardAppbarTxt),
              centerTitle: true,
              leadingWidth: 55,
              leading: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: InkWell(
                    onTap: (){
                      homeProvider.clearAllReport();

                      callNextReplacement(const HomeScreenNew(), context);
                    },
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: cl000008.withOpacity(0.05),
                        child: const Icon(Icons.arrow_back_ios_outlined,color: myBlack,))),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Consumer<HomeProvider>(
                  builder: (context,value,child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.topEnrollersModel.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var item = value.topEnrollersModel[index];
                          return
                          Padding(
                            padding: const EdgeInsets.only(left:20,right:20,top: 5,bottom: 5),
                            child: Stack(
                              children: [
                                Container(
                                  // height: 104,
                                  width: double.infinity,
                                  decoration:  BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    // gradient: LinearGradient(colors: [
                                    //   Color(0xff1D9000),
                                    //   Color(0xff20A200),
                                    // ]),
                                      color: myWhite,
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

                                  ),

                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(width: 5,),
                                      Stack(
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
                                              top:16,
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          // color: Colors.red,
                                          //  width: 20,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10,),
                                              SizedBox(width:115,
                                                child: Text(
                                                  item.name.toString(),
                                                  style:  TextStyle(
                                                      fontSize: width*0.036,
                                                      color: index==0||index==1||index==2?myWhite:myBlack,
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width:115,
                                                child: Text(
                                                  item.place,
                                                  style:  TextStyle(
                                                      fontSize: width*0.028,
                                                      color: index==0||index==1||index==2?myWhite:myBlack,
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:115,
                                                child: Text(
                                                  'ID: '+item.phone.substring(0, item.phone.length - 4) + getStar(4),
                                                  style:  TextStyle(
                                                      fontSize: width*0.028,
                                                      color: index==0||index==1||index==2?myWhite:myBlack,
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10,),

                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(),
                                      Container(
                                          alignment: Alignment.centerRight,
                                          width: width*.25,
                                          // color: Colors.orange,
                                          child: FittedBox(
                                            child: Row(
                                              children: [
                                                 Text("₹",style: TextStyle(
                                                     color: index==0||index==1||index==2?myWhite:myBlack,
                                                     fontWeight: FontWeight.w700,
                                                     fontSize: 18
                                                 ),),
                                                Text(getAmount(double.parse(item.totalAMount.toStringAsFixed(0))),
                                                  style:  TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 18,
                                                      color: index==0||index==1||index==2?myWhite:myBlack,
                                                      fontFamily: "Poppins"
                                                  ),),
                                              ],
                                            ),
                                          )
                                      )

                                    ],
                                  ),

                                ),
                              ],
                            ),
                          );
                        });
                  }
                ),
              ],
            ),
          ),


        ),
      ),
    );
  }

  Widget web(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration( image: DecorationImage(
          image: AssetImage("assets/KPCCWebBackground.jpg",),
          fit:BoxFit.fill
      )),
      child: Stack(
        children: [
          Center(
            child: queryData.orientation == Orientation.portrait
                ?Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(height*0.12),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        toolbarHeight: height*0.13,
                        centerTitle: true,
                        title: Text('Top Enrollers',style: wardAppbarTxt,),
                        automaticallyImplyLeading: false,
                        leading:  InkWell(
                          onTap: (){
                            callNextReplacement(HomeScreenNew(),context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        flexibleSpace: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [myDarkBlue,myLightBlue3]
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25)
                            ),
                          ),
                        ),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Consumer<HomeProvider>(
                            builder: (context,value,child) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.topEnrollersModel.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    var item = value.topEnrollersModel[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: InkWell(
                                        onTap: (){

                                        },
                                        child: Container(
                                          height: 100,

                                          child: Card(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                            elevation:2,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // Container(
                                                //   height: 50,
                                                //   width: 20,
                                                //   // margin: const EdgeInsets.all(10),
                                                //   // padding: const EdgeInsets.all(5),
                                                //   decoration: BoxDecoration(
                                                //     color: myWhite,
                                                //     borderRadius: BorderRadius.circular(25),
                                                //   ),
                                                //   // child: Image.asset(
                                                //   //   'assets/dsitrict_logo.png',
                                                //   //   fit: BoxFit.contain,
                                                //   // ),
                                                // ),
                                                Container(
                                                  width:220,
                                                  decoration: const BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment.topLeft,
                                                          end: Alignment.bottomRight,
                                                          colors: [myDarkBlue,myLightBlue2]
                                                      ),

                                                    borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(40),
                                                      bottomRight: Radius.circular(40),
                                                    )

                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 10.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(

                                                          'Name : '+item.name,
                                                          style: gray16White,
                                                        ),
                                                        Text(

                                                            'Place: '+item.place,
                                                            style: gray12white,
                                                          ),

                                                          Text(

                                                            'ID: '+item.phone,
                                                            style: gray12white,
                                                          ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        height: 25,
                                                        width: 120,
                                                        // color: Colors.red,
                                                        child:
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              '₹',
                                                              overflow: TextOverflow.fade,
                                                              maxLines: 1,
                                                              style: greenB18,
                                                            ),
                                                            SizedBox(
                                                              height: 25,
                                                              width: 95,
                                                              //color: Colors.black,
                                                              child: Text(
                                                                item.totalAMount.toString(),
                                                                overflow: TextOverflow.fade,
                                                                maxLines: 1,
                                                                style: greenB18,
                                                              ),
                                                            ),
                                                          ],
                                                        )

                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          ),
                        ],
                      ),
                    ),


                  ),
                ),
              ],
            )
                :Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width/3,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(height*0.12),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        toolbarHeight: height*0.13,
                        centerTitle: true,
                        title: Text('Top Enrollers',style: wardAppbarTxt,),
                        automaticallyImplyLeading: false,
                        leading:  InkWell(
                          onTap: (){
                            callNextReplacement(HomeScreenNew(),context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        flexibleSpace: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [myDarkBlue,myLightBlue3]
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25)
                            ),
                          ),
                        ),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Consumer<HomeProvider>(
                              builder: (context,value,child) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.topEnrollersModel.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      var item = value.topEnrollersModel[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: InkWell(
                                          onTap: (){

                                          },
                                          child: Container(
                                            height: 100,

                                            child: Card(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              elevation:2,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // Container(
                                                  //   height: 50,
                                                  //   width: 20,
                                                  //   // margin: const EdgeInsets.all(10),
                                                  //   // padding: const EdgeInsets.all(5),
                                                  //   decoration: BoxDecoration(
                                                  //     color: myWhite,
                                                  //     borderRadius: BorderRadius.circular(25),
                                                  //   ),
                                                  //   // child: Image.asset(
                                                  //   //   'assets/dsitrict_logo.png',
                                                  //   //   fit: BoxFit.contain,
                                                  //   // ),
                                                  // ),
                                                  Container(
                                                    width:220,
                                                    decoration: const BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment.topLeft,
                                                            end: Alignment.bottomRight,
                                                            colors: [myDarkBlue,myLightBlue2]
                                                        ),

                                                        borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(40),
                                                          bottomRight: Radius.circular(40),
                                                        )

                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(

                                                            'Name : '+item.name,
                                                            style: gray16White,
                                                          ),
                                                          Text(

                                                            'Place: '+item.place,
                                                            style: gray12white,
                                                          ),

                                                          Text(

                                                            'ID: '+item.phone,
                                                            style: gray12white,
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                          height: 25,
                                                          width: 120,
                                                          // color: Colors.red,
                                                          child:
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                '₹',
                                                                overflow: TextOverflow.fade,
                                                                maxLines: 1,
                                                                style: greenB18,
                                                              ),
                                                              SizedBox(
                                                                height: 25,
                                                                width: 95,
                                                                //color: Colors.black,
                                                                child: Text(
                                                                  item.totalAMount.toString(),
                                                                  overflow: TextOverflow.fade,
                                                                  maxLines: 1,
                                                                  style: greenB18,
                                                                ),
                                                              ),
                                                            ],
                                                          )

                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                          ),
                        ],
                      ),
                    ),


                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
String getStar(int length) {
  String star = '';
  for (int i = 0; i < length; i++) {
    star = star + '*';
  }
  return star;
}