import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quaide_millat/Screens/reciept_list_page.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../Views/panjayath_model.dart';
import '../Views/reportModel.dart';
import '../Views/unit_model.dart';
import '../providers/donation_provider.dart';
import 'home_screen.dart';

class WardHistory extends StatefulWidget {
  WardHistory({Key? key}) : super(key: key);

  @override
  State<WardHistory> createState() => _WardHistoryState();
}

class _WardHistoryState extends State<WardHistory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();


  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget body(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    if(kIsWeb&&queryData.orientation != Orientation.portrait){
      width=width/3;
    }
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    DonationProvider donationProvider=Provider.of<DonationProvider>(context,listen: false);
    return Consumer<HomeProvider>(builder: (context, value, child) {
      return SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 22,),

                    // SizedBox(
                    //   width: double.infinity,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal:22),
                    //     child: Autocomplete<String>(
                    //       optionsBuilder:
                    //           (TextEditingValue textEditingValue) {
                    //         return (value.stateList)
                    //             .where((String state) => state.toLowerCase()
                    //             .startsWith(textEditingValue.text.toLowerCase())).toList();
                    //       },
                    //       displayStringForOption: (String option) => option,
                    //       fieldViewBuilder: (BuildContext context,
                    //           TextEditingController
                    //           fieldTextEditingController,
                    //           FocusNode fieldFocusNode,
                    //           VoidCallback onFieldSubmitted) {
                    //         return TextField(
                    //           textAlign: TextAlign.center,
                    //           decoration: InputDecoration(
                    //             contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    //             hintStyle: grayB12,
                    //             hintText: "Select State",
                    //             focusedBorder: border,
                    //             enabledBorder: border,
                    //             errorBorder: border,
                    //             disabledBorder: border,
                    //           ),
                    //           controller: fieldTextEditingController,
                    //           focusNode: fieldFocusNode,
                    //           style: const TextStyle(
                    //               fontWeight: FontWeight.w700,fontSize: 15,fontFamily: "Poppins"),
                    //         );
                    //       },
                    //       onSelected: (String selection) {
                    //
                    //         print("dzfjh");
                    //         // homeProvider.fetchDropdown('State', selection);
                    //         homeProvider.fetchReportDistrict(selection);
                    //
                    //       },
                    //       optionsViewBuilder: (BuildContext context,
                    //           AutocompleteOnSelected<String> onSelected,
                    //           Iterable<String> options) {
                    //         return Align(
                    //           alignment: Alignment.topLeft,
                    //           child: Material(
                    //             child: Container(
                    //               width: width - 30,
                    //               height: 200,
                    //               color: Colors.white,
                    //               child: ListView.builder(
                    //                 padding: const EdgeInsets.all(10.0),
                    //                 itemCount: options.length,
                    //                 itemBuilder:
                    //                     (BuildContext context, int index) {
                    //                   final String option =
                    //                   options.elementAt(index);
                    //
                    //                   return GestureDetector(
                    //                     onTap: () {
                    //                       onSelected(option);
                    //                     },
                    //                     child: Container(
                    //                       color: Colors.white,
                    //                       height: 50,
                    //                       width: width - 30,
                    //                       child: Column(
                    //                           crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                           children: [
                    //                             Text(option,
                    //                                 style: const TextStyle(
                    //                                     fontWeight:
                    //                                     FontWeight.bold)),
                    //                             const SizedBox(height: 10)
                    //                           ]),
                    //                     ),
                    //                   );
                    //                 },
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //     // Autocomplete<AssemblyModel>(
                    //     //   optionsBuilder: (TextEditingValue textEditingValue) {
                    //     //     return (value.stateList)
                    //     //         .where((AssemblyModel wardd) => wardd.assembly.toLowerCase()
                    //     //         .contains(textEditingValue.text.toLowerCase()))
                    //     //         .toList();
                    //     //   },
                    //     //   displayStringForOption: (AssemblyModel option) => option.assembly,
                    //     //   fieldViewBuilder: (
                    //     //       BuildContext context,
                    //     //       TextEditingController fieldTextEditingController,
                    //     //       FocusNode fieldFocusNode,
                    //     //       VoidCallback onFieldSubmitted
                    //     //       ) {
                    //     //     WidgetsBinding.instance.addPostFrameCallback((_) {
                    //     //       if( value.selectedAssembly==null&&value.assemblyTc.text==''){
                    //     //         var initialValue = '';
                    //     //
                    //     //         fieldTextEditingController.text = initialValue;
                    //     //       }
                    //     //
                    //     //     });
                    //     //     return TextField(
                    //     //       textAlign: TextAlign.center,
                    //     //       decoration:  InputDecoration(
                    //     //         contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    //     //         hintStyle: grayB12,
                    //     //         hintText:'Select State',
                    //     //         focusedBorder: border,
                    //     //         enabledBorder: border,
                    //     //         errorBorder: border,
                    //     //         disabledBorder: border,
                    //     //       ),
                    //     //       onChanged: (value){
                    //     //         // homeProvider.onTextChanged(value,'Assembly');
                    //     //       },
                    //     //       controller: fieldTextEditingController,
                    //     //       focusNode: fieldFocusNode,
                    //     //       style: const TextStyle(fontWeight: FontWeight.bold),
                    //     //     );
                    //     //   },
                    //     //   onSelected: (AssemblyModel selection) {
                    //     //     homeProvider.fetchDropdown('Assembly', selection);
                    //     //   },
                    //     //   optionsViewBuilder: (
                    //     //       BuildContext context,
                    //     //       AutocompleteOnSelected<AssemblyModel> onSelected,
                    //     //       Iterable<AssemblyModel> options
                    //     //       ) {
                    //     //     return Align(
                    //     //       alignment: Alignment.topLeft,
                    //     //       child: Material(
                    //     //         child: Container(
                    //     //           width: width-30,
                    //     //           height: 200,
                    //     //           color: Colors.white,
                    //     //           child: ListView.builder(
                    //     //             padding: const EdgeInsets.all(10.0),
                    //     //             itemCount: options.length,
                    //     //             itemBuilder: (BuildContext context, int index) {
                    //     //               final AssemblyModel option = options.elementAt(index);
                    //     //
                    //     //               return GestureDetector(
                    //     //                 onTap: () {
                    //     //                   onSelected(option);
                    //     //                 },
                    //     //                 child:  Container(
                    //     //                   color: Colors.white,
                    //     //                   height: 50,
                    //     //                   width: width-30,
                    //     //                   child: Column(
                    //     //                       crossAxisAlignment:
                    //     //                       CrossAxisAlignment.start,
                    //     //                       children: [
                    //     //
                    //     //                         Text(option.assembly, style: const TextStyle(fontWeight: FontWeight.bold)),
                    //     //                         const SizedBox(height: 10)
                    //     //
                    //     //                       ]),
                    //     //                 ),
                    //     //               );
                    //     //             },
                    //     //           ),
                    //     //         ),
                    //     //       ),
                    //     //     );
                    //     //   },
                    //     // ),
                    //
                    //   ),
                    // ),

                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:22),
                        child: Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return (value.districtList)
                                .where((String wardd) => wardd.toLowerCase()
                                .contains(textEditingValue.text.toLowerCase())).where((element) =>!element.contains("KMCC")).toList();
                          },
                          displayStringForOption: (String option) => option,
                          fieldViewBuilder: (
                              BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted
                              ) {

                            return TextField(
                              textAlign: TextAlign.center,
                              decoration:  InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                hintStyle: grayB12,
                                hintText:'Select District',
                                focusedBorder: border,
                                enabledBorder: border,
                                errorBorder: border,
                                disabledBorder:border,
                              ),
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: "Poppins"),
                            );
                          },
                          onSelected: (String selection) {
                            homeProvider.fetchDropdown('District', selection);
                          },
                          optionsViewBuilder: (
                              BuildContext context,
                              AutocompleteOnSelected<String> onSelected,
                              Iterable<String> options
                              ) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  width: width-30,
                                  height: 200,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(10.0),
                                    itemCount: options.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final String option = options.elementAt(index);

                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child:  Container(
                                          color: Colors.white,
                                          height: 50,
                                          width: width-30,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(option,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 10)
                                              ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                      ),
                    ),
                    SizedBox(height: 18,),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:22),
                        child: Autocomplete<AssemblyModel>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return (value.assemblyList)
                                .where((AssemblyModel wardd) => wardd.assembly.toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                                .toList();
                          },
                          displayStringForOption: (AssemblyModel option) => option.assembly,
                          fieldViewBuilder: (
                              BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted
                              ) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if( value.selectedAssembly==null&&value.assemblyTc.text==''){
                                var initialValue = '';

                                fieldTextEditingController.text = initialValue;
                              }

                            });
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration:  InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                hintStyle: grayB12,
                                hintText:'Select Assembly',
                                focusedBorder: border,
                                enabledBorder: border,
                                errorBorder: border,
                                disabledBorder: border,
                              ),
                              onChanged: (value){
                                // homeProvider.onTextChanged(value,'Assembly');
                              },
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Poppins',),
                            );
                          },
                          onSelected: (AssemblyModel selection) {
                            homeProvider.fetchDropdown('Assembly', selection);
                          },
                          optionsViewBuilder: (
                              BuildContext context,
                              AutocompleteOnSelected<AssemblyModel> onSelected,
                              Iterable<AssemblyModel> options
                              ) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  width: width-30,
                                  height: 200,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(10.0),
                                    itemCount: options.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final AssemblyModel option = options.elementAt(index);

                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child:  Container(
                                          color: Colors.white,
                                          height: 50,
                                          width: width-30,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [

                                                Text(option.assembly, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 10)

                                              ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:22,vertical: 18),
                        child: Autocomplete<PanjayathModel>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return (value.panjayathList)
                                .where((PanjayathModel wardd) => wardd.panjayath.toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                                .toList();
                          },
                          displayStringForOption: (PanjayathModel option) => option.panjayath,
                          fieldViewBuilder: (
                              BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted
                              ) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if( value.selectedPanjayath==null&&value.panjayathTc.text==''){
                                var initialValue = '';

                                fieldTextEditingController.text = initialValue;
                              }

                            });
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration:  InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                hintStyle: grayB12,
                                hintText:'Select Panchayath',
                                focusedBorder: border,
                                enabledBorder: border,
                                errorBorder: border,
                                disabledBorder: border,
                              ),
                              onChanged: (value){
                                // homeProvider.onTextChanged(value,'Panjayath');
                              },
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Poppins',),
                            );
                          },
                          onSelected: (PanjayathModel selection) {
                            homeProvider.fetchDropdown('Panjayath', selection);
                          },
                          optionsViewBuilder: (
                              BuildContext context,
                              AutocompleteOnSelected<PanjayathModel> onSelected,
                              Iterable<PanjayathModel> options
                              ) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  width: width-30,
                                  height: 200,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(10.0),
                                    itemCount: options.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final PanjayathModel option = options.elementAt(index);
                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child:  Container(
                                          color: Colors.white,
                                          height: 50,
                                          width: width-30,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [

                                                Text(option.panjayath, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 10)

                                              ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:22),
                        child: Autocomplete<UnitModel>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return (value.unitList)
                                .where((UnitModel wardd) => wardd.unit.toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                                .toList();
                          },
                          displayStringForOption: (UnitModel option) => option.unit,
                          fieldViewBuilder: (
                              BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted
                              ) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if( value.selectedUnit==null&&value.unitTc.text==''){
                                var initialValue = '';

                                fieldTextEditingController.text = initialValue;
                              }

                            });
                            return TextField(
                              textAlign: TextAlign.center,
                              decoration:  InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 15),
                                hintStyle: grayB12,
                                hintText:'Select Unit',
                                focusedBorder: border,
                                enabledBorder: border,
                                errorBorder: border,
                                disabledBorder:border,
                              ),
                              onChanged: (value){



                              },
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Poppins',),
                            );
                          },
                          onSelected: (UnitModel selection) {
                            homeProvider.fetchDropdown('Unit', selection);
                          },
                          optionsViewBuilder: (
                              BuildContext context,
                              AutocompleteOnSelected<UnitModel> onSelected,
                              Iterable<UnitModel> options
                              ) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  width: width-30,
                                  height: 200,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(10.0),
                                    itemCount: options.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final UnitModel option = options.elementAt(index);

                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child:  Container(
                                          color: Colors.white,
                                          height: 50,
                                          width: width-30,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(option.unit, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 10)
                                              ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),


                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 10,),

            Consumer<HomeProvider>(
                builder: (context,value22,child) {
                  print(value22.panchayathTarget.toString()+"codee rrhe");
                  return Container(
                    width: width,
                    height: 60,
                    margin: const EdgeInsets.only(left: 20,right: 20),
                    decoration:  const BoxDecoration(
                      // gradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //     end: Alignment.bottomRight,
                      //     colors: [
                      //   cl0EA3A9,cl3686C5
                      // ]),
                      image: DecorationImage(image: AssetImage("assets/bgCard.png"),fit: BoxFit.fill),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Collected: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/indian_rupee.png",
                                  scale: 45,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 3),
                                SizedBox(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 100.0,
                                      maxWidth: 200.0,
                                      minHeight: 30.0,
                                      maxHeight: 30.0,
                                    ),
                                    child: AutoSizeText(
                                      value.filter ? getAmount(double.parse(value.filterCollection.toStringAsFixed(0)))
                                          : getAmount(double.parse(value.totalCollection.toStringAsFixed(0))),
                                      style: greenB16,
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          ],
                        ),



                        ///2024 asif commented

                        // Consumer<HomeProvider>(
                        //     builder: (context,val,child) {
                        //       return  val.panchayathPosterComplete?ElevatedButton(
                        //           onPressed: () {
                        //             DonationProvider donationProvider =
                        //             Provider.of<DonationProvider>(
                        //                 context,
                        //                 listen: false);
                        //             donationProvider.whatsappStatus =
                        //             null;
                        //
                        //             callNextReplacement(PanchayathPosterPageScreen(district: val.panchayathPosterDistrict, assembly: val.panchayathPosterAssembly, panchayath: val.panchayathPosterPanchayath), context);
                        //
                        //
                        //
                        //
                        //           },
                        //           style: ElevatedButton.styleFrom(
                        //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        //             backgroundColor: const Color(0xff02A710),
                        //             primary: Colors.transparent,
                        //             onSurface: Colors.transparent,
                        //             shadowColor: Colors.transparent,
                        //             minimumSize: const Size(136, 30),
                        //           ),
                        //           child: const Text(
                        //             "Download Panchayath Quota Poster",
                        //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        //           )):val.panchayathPosterNotCompleteComplete?ElevatedButton(
                        //           onPressed: () {
                        //
                        //           },
                        //           style: ElevatedButton.styleFrom(
                        //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        //             backgroundColor: Colors.red,
                        //             primary: Colors.transparent,
                        //             onSurface: Colors.transparent,
                        //             shadowColor: Colors.transparent,
                        //             minimumSize: const Size(136, 30),
                        //           ),
                        //           child: const Text(
                        //             "Panchayath Quota not Completed yet",
                        //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        //           )):SizedBox();
                        //     }
                        // )





                        ///2024 asif commented

                      ],
                    ),
                  );
                }
            ),

            ListView.builder(
                shrinkWrap: true,
                itemCount: value.wardTotalList.length,

                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var item = value.wardTotalList[index];
                  return InkWell(
                    onTap: (){
                      if( item.assembly.isNotEmpty) {
                        print("click hhhheee");
                        value.paymentDetailsList.clear();
                        value.currentWardLimit = 50;
                        value.fromWard = item;

                        homeProvider.wardReceiptListWithoutLimit(item);
                        // donationProvider.fetchOrganiznCollectedCount(item.panchayath,item.wardname);
                        callNext(ReceiptListPage(from: "WardPage",ward: item.wardname,total: item.amount.toString(), panchayath: item.panchayath, district:item.district, target: item.target), context);

                      }else{
                        final snackBar = SnackBar(
                            backgroundColor:Colors.blue ,
                            duration: const Duration(milliseconds: 3000),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 5,),
                                Text("Please pick a valid Unit", textAlign: TextAlign.center,softWrap: true,
                                  style: snackbarStyle,
                                ),
                              ],
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 22,),
                      elevation: 3,
                      child: Container(
                        // height: 107,
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        // margin: const EdgeInsets.symmetric(horizontal: 22,vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              fit:FlexFit.tight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.wardname,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 13,
                                          color:cl0EA3A9,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    Text(
                                      item.panchayath,
                                      style: black12,
                                    ),
                                    Text(
                                      item.district,
                                      style: black12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SizedBox(
                                  height: 28,
                                  // width: 120,
                                  // color: Colors.red,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '₹',
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        style: black55,
                                      ),

                                      SizedBox(
                                        height: 27,
                                        // width: 95,
                                        //color: Colors.black,
                                        child: Row(
                                          children: [
                                            Text(getAmount(item.amount),
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 18,
                                                  color:cl0EA3A9,
                                                  fontWeight: FontWeight.w700
                                              ),
                                            ),
                                            // item.amount>=num.parse(item.target)?SizedBox(width: 5,):SizedBox(),
                                            // item.amount>=num.parse(item.target)?Image.asset(
                                            //   "assets/image 1.png",
                                            //   height: 18,
                                            //   width: 18,
                                            // ):SizedBox(),
                                          ],
                                        ),
                                      ),

                                    ],
                                  )

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      );
    });
  }

  Widget mobile(BuildContext context) {
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return PopScope(
      onPopInvoked: (adsjh){
    homeProvider.clearAllReport();

      },
      // onWillPop: () async {
      //   return true;
      // },
      child: SafeArea(
        child: Scaffold(
          backgroundColor:myWhite,
          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(84),
          //   child: AppBar(
          //     backgroundColor: Colors.white,
          //     centerTitle: true,
          //     automaticallyImplyLeading: false,
          //     toolbarHeight: height*0.12,
          //     // shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
          //     title: Text('Report',style: wardAppbarTxt),
          //     leadingWidth: 55,
          //     leading: Padding(
          //       padding: const EdgeInsets.only(left: 12.0),
          //       child: InkWell(
          //           onTap: (){
          //             homeProvider.clearAllReport();
          //
          //             callNextReplacement(const HomeScreenNew(), context);
          //           },
          //           child: CircleAvatar(
          //               radius: 15,
          //               backgroundColor: cl000008.withOpacity(0.05),
          //               child: const Icon(Icons.arrow_back_ios_outlined,color: myBlack,))),
          //     ),
          //   ),
          // ),
          body: body(context),
        ),
      ),
    );
  }

  Widget web(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration( image: DecorationImage(
          image: AssetImage("assets/KPCCWebBackground.jpg",),
          fit:BoxFit.fill
      )),
      child: Stack(
        children: [
          // Row(
          //   children: [
          //     Container(
          //       height: height,
          //       width: width,
          //       decoration: const BoxDecoration(
          //           image: DecorationImage(
          //               image: AssetImage('assets/KnmWebBackground1.jpg'),fit: BoxFit.cover
          //           )
          //       ),
          //       child: Row(
          //         children: [
          //           SizedBox(
          //               height: height,
          //               width: width / 3,
          //               child: Image.asset("assets/Group 2.png",scale: 4,)),
          //           SizedBox(
          //             height: height,
          //             width: width / 3,
          //           ),
          //           SizedBox(
          //               height: height,
          //               width: width / 3,
          //               child: Image.asset("assets/Group 3.png",scale: 6,)),
          //         ],
          //       ),
          //     ),
          //
          //
          //   ],
          // ),
          Center(
              child: queryData.orientation == Orientation.portrait
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(width: width/3,),
                  SizedBox(
                    width: width,
                    child: SafeArea(
                      child: Scaffold(
                        backgroundColor:myWhite,
                        appBar: AppBar(
                          // backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          toolbarHeight: height*0.13,
                          centerTitle: true,
                          title:Text('Report',style: wardAppbarTxt,),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 12.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       // Image.asset("assets/History.png",scale: 3 ,),
                          //       // SizedBox(width: width*0.01,),
                          //
                          //     ],
                          //   ),
                          // ),
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
                          // actions: [
                          //   Column(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Image.asset("assets/help2.png",color: myWhite,scale: 4,),
                          //       Text("help",style: TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 10))
                          //     ],
                          //   ),
                          //   SizedBox(width: 14,)
                          // ],

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
                        body: body(context),
                      ),
                    ),
                  ),
                  // SizedBox(width: width/3,),
                ],
              )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(width: width/3,),
                  SizedBox(
                    width: width / 3,
                    child: SafeArea(
                      child: Scaffold(
                        backgroundColor:myWhite,
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          toolbarHeight: height*0.13,
                          centerTitle: true,
                          title:Text('Report',style: wardAppbarTxt,),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 12.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       // Image.asset("assets/History.png",scale: 3 ,),
                          //       // SizedBox(width: width*0.01,),
                          //
                          //     ],
                          //   ),
                          // ),
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
                          // actions: [
                          //   Column(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Image.asset("assets/help2.png",color: myWhite,scale: 4,),
                          //       Text("help",style: TextStyle(color: myWhite,fontWeight: FontWeight.bold,fontSize: 10))
                          //     ],
                          //   ),
                          //   SizedBox(width: 14,)
                          // ],

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
                        body: body(context),
                      ),
                    ),
                  ),
                  // SizedBox(width: width/3,),
                ],
              ))
        ],
      ),
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

final OutlineInputBorder border=OutlineInputBorder(
  borderSide: const BorderSide(
      color:clD4D4D4 , width: 1.0),
  borderRadius: BorderRadius.circular(28),
);