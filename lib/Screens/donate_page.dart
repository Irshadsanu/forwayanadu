import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quaide_millat/Screens/mindgate_payment_screen.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import '../Views/reportModel.dart';
import '../Views/ward_model.dart';
import '../constants/shake_effect.dart';
import 'package:provider/provider.dart';
import '../Views/panjayath_model.dart';
import '../constants/custmom_chip.dart';
import '../service/currency_formater.dart';
import 'bank_payment_page.dart';
import 'cashfree/payment_gateway.dart';
import 'home.dart';
import 'home_screen.dart';
import 'new_payment_gateway_Screen.dart';
import 'no_paymet_gatway.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class DonatePage extends StatelessWidget {
  DonatePage({Key? key}) : super(key: key);


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  final ShakeXController _shakeXController=ShakeXController();
  final ShakeXController _shakeXControlleramount=ShakeXController();



  @override
  Widget build(BuildContext context) {



    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    // homeProvider.checkInternet(context);
    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }
  Widget body(BuildContext context){
    HomeProvider homeProvider = Provider.of<HomeProvider>(
        context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    if(kIsWeb&&queryData.orientation != Orientation.portrait){
      width=width/3;
    }
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);

    final List<int> amount = [
      138,
      200,
      500,
      1000,
      2000,
      5000,
    ];


    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar:  PreferredSize(
            preferredSize: const Size.fromHeight(82),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              // elevation: 5,
              toolbarHeight: height*0.12,
              title: Text('Participate Now',style: wardAppbarTxt),
              centerTitle: true,
              leadingWidth: 55,
              leading: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: InkWell(
                    onTap: (){
                      callNextReplacement(const HomeScreenNew(), context);
                    },
                    child: CircleAvatar(
                      radius: 15,
                        backgroundColor: cl000008.withOpacity(0.05),
                        child: const Icon(Icons.arrow_back_ios_outlined,color: myBlack,))),
              ),
              // flexibleSpace: Container(
              //   height: height*0.12,
              //   decoration: const BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17))
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 9.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         const SizedBox(width: 33),
              //         InkWell(
              //             onTap: (){
              //               callNextReplacement(const HomeScreenNew(), context);
              //             },
              //             child: const Icon(Icons.arrow_back_ios_outlined,color: cl264186,)),
              //         const SizedBox(width: 22),
              //
              //         Text('Participate Now',style: wardAppbarTxt),
              //         // Row(
              //         //   children: [
              //         //     Padding(
              //         //       padding: const EdgeInsets.only(left: 15.0,right: 2),
              //         //       child: Image.asset("assets/youtube.png",scale: 2,),
              //         //     ),
              //         //     const Text("How to Pay?",
              //         //       style: TextStyle(fontSize: 12,
              //         //         fontWeight: FontWeight.w400,
              //         //         fontFamily: "PoppinsMedium",
              //         //       ),),
              //         //   ],
              //         // ),
              //
              //       ],),
              //   ),
              // ),

            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // const SizedBox(height: 30,),
                        //
                        // const Text("Participate",
                        //   style: TextStyle(
                        //     color: cl3655A2,
                        //     fontSize: 14,
                        //     fontFamily: "PoppinsMedium",
                        //   ),),

                        Consumer<DonationProvider>(
                            builder: (context,value,child) {
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  // const SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 26,),
                                      Row(
                                        children: [
                                          IntrinsicWidth(
                                            child: TextFormField(
                                              autofocus: true,
                                              style: GoogleFonts.inter(
                                                  textStyle: whiteGoogleBold30  ),

                                              controller: value.kpccAmountController,
                                              showCursor: true,
                                              textInputAction: TextInputAction.next,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly,
                                                // CurrencyInputFormatter(
                                                // ),
                                                LengthLimitingTextInputFormatter(6)
                                              ],
                                              textAlign: TextAlign.center,
                                              decoration:   InputDecoration(
                                                prefixIcon:const Padding(
                                                  padding: EdgeInsets.only(top: 5.0),
                                                  child: Icon(Icons.currency_rupee_outlined,color: cl3686C5,size:40,),
                                                ),
                                                // suffixIcon: Consumer<DonationProvider>(
                                                //     builder: (context,value2,child) {
                                                //       return value2.minimumbool?const SizedBox():const Icon(Icons.check_circle_outline_outlined,color: myGreen,size: 40,);
                                                //     }
                                                // ),
                                                hintText: 'Amount',
                                                border: InputBorder.none,
                                                hintStyle: donationHint,
                                                contentPadding:  const EdgeInsets.symmetric( horizontal: 10.0),
                                              ),

                                              onChanged:(text){
                                                if (text.isNotEmpty) {
                                                  final int amount = int.parse(text);
                                                  if (amount > 100000) {
                                                    value.kpccAmountController.clear();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(content: Text('Maximum amount: ₹1,00,000')),
                                                    );
                                                  }
                                                }

                                                donationProvider.minimumAmountTrueOrFalse(text.toString());

                                                // if(double.parse(text.toString()==""?"0.0":text.toString())<138){
                                                //
                                                //
                                                //   donationProvider.setTextColor(poppinsalertred);
                                                //   print("ewfew");
                                                //
                                                //   _shakeXControlleramount.shake();
                                                //   if(!kIsWeb){
                                                //     Vibrate.vibrate();
                                                //   }
                                                //
                                                // }else{
                                                //   donationProvider.setTextColor(poppinsalertwhite);
                                                // }


                                              },
                                              onEditingComplete:(){


                                              },


                                              // validator: (person) => person == ''|| int.parse(person!)==0
                                              //     ? 'Please Enter Amount'
                                              //     : null,
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  const SizedBox(width: 10,),

                                ],
                              );
                            }
                        ),
                        // Consumer<DonationProvider>(
                        //   builder: (context,value,child) {
                        //     return value.kpccAmountController.text.isEmpty?ShakeX(
                        //       controller: _shakeXControlleramount,
                        //       text: 'Enter Amount',
                        //       style:value.styleOfAmountAlert,
                        //       child: SizedBox(
                        //         height: 10,
                        //           width: 10,
                        //       ),
                        //     ):SizedBox();
                        //   }
                        // )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 23.0,right: 23),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,bottom: 7),
                            child: Text("Name",
                              style: donateText,),
                          ),
                          Consumer<DonationProvider>(
                              builder: (context, value, child) {
                                return Container(
                                  // height: height*0.07,
                                  // width: width*0.8,
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r"[0-9a-zA-Z\s.\u0D00-\u0D7F]"))

                                    ],
                                    onTap: (){
                                      if(value.kpccAmountController.text.isNotEmpty) {
                                        value.kpccAmountController.text = num.parse(value.kpccAmountController.text).toInt().toString();
                                      }

                                    },
                                    textInputAction: TextInputAction.next,
                                    controller: value.nameTC,
                                    style: const TextStyle(color: myBlack,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Poppins"),
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                        // hintText: 'Name',
                                        // hintStyle: whitePoppins,
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(0.3),
                                        border:  borderKnm,
                                        enabledBorder:borderKnm,
                                        focusedBorder:borderKnm

                                    ),


                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return "Please Enter a Name";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                );
                              }),
                          Consumer<DonationProvider>(
                              builder: (context,value1,child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Consumer<DonationProvider>(
                                        builder: (context,value,child) {
                                          return Checkbox(
                                            activeColor: cl0EA3A9,
                                            shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.95)),
                                            checkColor: Colors.white,
                                            value: value.shownameBool,
                                            side:const BorderSide(color: cl9D9D9D, width: 0.5),
                                            onChanged: (bool? value) {
                                              donationProvider.showNameStatus();
                                            },
                                          );
                                        }
                                    ),
                                    Text('Hide Name',style: blackPoppinsBlackR12,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text("(Participate without revealing your name)",style: hideNameStyle,),
                                    ),

                                  ],
                                );
                              }
                          ),
                          // SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,bottom: 7),
                            child: Text("Mobile",
                              style: donateText,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Consumer<DonationProvider>(
                                builder: (context, value, child) {
                                  return Container(
                                    // height: height*0.07,
                                    // width: width*0.8,
                                    child: TextFormField(
                                      onTap: (){
                                        if(value.kpccAmountController.text.isNotEmpty) {
                                          value.kpccAmountController.text = num.parse(value.kpccAmountController.text).toInt().toString();
                                        }
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                        LengthLimitingTextInputFormatter(10)],
                                      controller: value.phoneTC,
                                      style: const TextStyle(color: myBlack,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Poppins"),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                        // hintText: 'Mobile Number',
                                        // hintStyle: whitePoppins,
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(0.2),
                                        border: borderKnm,
                                        enabledBorder: borderKnm,
                                        focusedBorder: borderKnm,
                                      ),
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return "Please Enter Mobile Number";
                                        } else if (!RegExp(
                                            r'^[0-9]+$')
                                            .hasMatch(value)|| value.length!=10) {
                                          return "Enter Correct Mobile Number";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  );
                                }),
                          ),
                          // SizedBox(height:15,),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 12.0,bottom: 8),
                          //   child: Text("Select Organisation",
                          //     style: donateText,),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 10),
                          //   child: Consumer<DonationProvider>(
                          //       builder: (context,value,child) {
                          //         return Container(
                          //           // height: height*0.07,
                          //           // width: width*0.8,
                          //           child: Autocomplete<String>(
                          //             optionsBuilder: (TextEditingValue textEditingValue) {
                          //
                          //               return (value.organisationList).toList();
                          //             },
                          //             displayStringForOption: (String option) => option,
                          //             fieldViewBuilder: (
                          //                 BuildContext context,
                          //                 TextEditingController fieldTextEditingController,
                          //                 FocusNode fieldFocusNode,
                          //                 VoidCallback onFieldSubmitted
                          //                 ) {
                          //
                          //               return TextFormField(
                          //
                          //                 scrollPadding: const EdgeInsets.only(bottom: 500),
                          //                 decoration:  InputDecoration(
                          //                   contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          //
                          //                   // labelText:'Select Assembly/organization',
                          //                   // labelStyle: whitePoppins,
                          //                   filled: true,
                          //                   fillColor: Colors.white.withOpacity(0.4),
                          //                   border: borderKnm,
                          //                   enabledBorder: borderKnm,
                          //                   focusedBorder: borderKnm,
                          //                 ),
                          //                 controller: fieldTextEditingController,
                          //                 focusNode: fieldFocusNode,
                          //                 style: const TextStyle(fontWeight: FontWeight.bold,color: myBlack,fontSize: 18),
                          //                 // validator: (text) => value.assemblyList.map((e) => e.assembly.contains(text)) ? "Please Select Your Assembly" : null,
                          //                 validator: (value2) {
                          //                   if (value2!.trim().isEmpty) {
                          //                     return "Please Select Your Organisation";
                          //                   } else {
                          //                     return null;
                          //                   }
                          //                 },
                          //               );
                          //
                          //             },
                          //             onSelected: (String selection) {
                          //               value.organisationTC.text = selection;
                          //             },
                          //             optionsViewBuilder: (
                          //                 BuildContext context,
                          //                 AutocompleteOnSelected<String> onSelected,
                          //                 Iterable<String> options
                          //                 ) {
                          //               return Align(
                          //                 alignment: Alignment.topLeft,
                          //                 child: Material(
                          //                   child: Container(
                          //                     width: width-30,
                          //                     height: 300,
                          //                     color: Colors.white,
                          //                     child: ListView.builder(
                          //                       padding: const EdgeInsets.all(10.0),
                          //                       itemCount: options.length,
                          //                       itemBuilder: (BuildContext context, int index) {
                          //                         final String option = options.elementAt(index);
                          //
                          //                         return GestureDetector(
                          //                           onTap: () {
                          //                             onSelected(option);
                          //                           },
                          //                           child:  Container(
                          //                             color: Colors.white,
                          //                             height: 50,
                          //                             width: width-30,
                          //                             child: Column(
                          //                                 crossAxisAlignment:
                          //                                 CrossAxisAlignment.start,
                          //                                 children: [
                          //
                          //                                   Text(option,style: const TextStyle(
                          //                                       fontSize: 12
                          //                                   ),),
                          //                                   const SizedBox(height: 10)
                          //                                 ]),
                          //                           ),
                          //                         );
                          //                       },
                          //                     ),
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //           ),
                          //         );
                          //       }
                          //   ),
                          // ),
                          ////
                          // Consumer<DonationProvider>(
                          //     builder: (context,value,child) {
                          //       return
                          //         value.committyONOFF=="ON"?
                          //         Padding(
                          //           padding: const EdgeInsets.only(left: 12.0,bottom: 7,top: 20),
                          //           //FRONTAL ORGANIZATION
                          //           child: Text("Select Front Organization",
                          //             style: donateText,),
                          //         ):const SizedBox();
                          //     }
                          // ),
                          // Consumer<DonationProvider>(
                          //     builder: (context,value,child) {
                          //       return
                          //         value.committyONOFF=="ON"?
                          //         Container(
                          //           height: height*0.08,
                          //           width: width*0.9,
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(10.0),
                          //           ),
                          //           child: Consumer<DonationProvider>(
                          //               builder: (context,value,child) {
                          //                 return Autocomplete<String>(
                          //                   optionsBuilder: (TextEditingValue textEditingValue) {
                          //                     return (value.subcommitteeList)
                          //                         .where((String item) => item
                          //                         .toLowerCase()
                          //                         .contains(textEditingValue.text.toLowerCase()))
                          //                         .toList();
                          //                   },
                          //                   displayStringForOption: (String option) => option,
                          //                   fieldViewBuilder: (BuildContext context,
                          //                       TextEditingController fieldTextEditingController,
                          //                       FocusNode fieldFocusNode,
                          //                       VoidCallback onFieldSubmitted) {
                          //                     WidgetsBinding.instance?.addPostFrameCallback((_) {
                          //                       fieldTextEditingController.text = value.subCommitteeCT.text;
                          //                     });
                          //
                          //                     return TextFormField(
                          //                       style:  const TextStyle(
                          //                           fontWeight: FontWeight.bold),
                          //
                          //
                          //                       decoration:  InputDecoration(
                          //                         labelStyle:  const TextStyle(
                          //                             fontWeight: FontWeight.bold),
                          //                         border: borderKnm,
                          //                         enabledBorder: borderKnm,
                          //                         focusedBorder: borderKnm,
                          //                         counterStyle:  const TextStyle(
                          //                             fontWeight: FontWeight.bold),
                          //                         fillColor: Colors.white.withOpacity(0.4),
                          //                         contentPadding: const EdgeInsets.symmetric(
                          //                             vertical: 10.0, horizontal: 10.0),
                          //                         // labelText: 'Select Committee',
                          //                         // errorBorder: OutlineInputBorder(
                          //                         //     borderSide:
                          //                         //     BorderSide(color: Colors.red, width: .5))
                          //                       ),
                          //                       // validator: (text) =>
                          //                       // text == '' || !value.subcommitteeList.contains(text)
                          //                       //     ? 'Select Sub committee'
                          //                       //     : null,
                          //                       onChanged: (txt) {
                          //                         if(txt==''){
                          //                           value.subCommitteeCT.text="";
                          //                         }
                          //                       },
                          //                       controller: fieldTextEditingController,
                          //                       focusNode: fieldFocusNode,
                          //
                          //                     );
                          //                   },
                          //
                          //                   onSelected: (String selection) {
                          //
                          //                     value.subCommitteeCT.text=selection;
                          //                   },
                          //                   optionsViewBuilder: (BuildContext context,
                          //                       AutocompleteOnSelected<String> onSelected,
                          //                       Iterable<String> options) {
                          //                     return Align(
                          //                       alignment: Alignment.topLeft,
                          //                       child: Material(
                          //                         child: Container(
                          //                           width: width - 20,
                          //                           height: height*0.3,
                          //                           color: Colors.white,
                          //                           child: ListView.builder(
                          //                             padding: const EdgeInsets.all(10.0),
                          //                             itemCount: options.length,
                          //                             itemBuilder: (BuildContext context, int index) {
                          //                               final String option = options.elementAt(index);
                          //
                          //                               return GestureDetector(
                          //                                 onTap: () {
                          //                                   onSelected(option);
                          //                                 },
                          //                                 child: Container(
                          //                                   color: Colors.white,
                          //                                   height: 50,
                          //                                   width:
                          //                                   MediaQuery.of(context).size.width / 3 - 30,
                          //                                   child: Column(
                          //                                       crossAxisAlignment:
                          //                                       CrossAxisAlignment.start,
                          //                                       children: [
                          //                                         Text(option,
                          //                                             style: const TextStyle(
                          //                                                 fontWeight: FontWeight.bold)),
                          //                                         const SizedBox(height: 10)
                          //                                       ]),
                          //                                 ),
                          //                               );
                          //                             },
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     );
                          //                   },
                          //                 );
                          //               }
                          //           ),
                          //         ):const SizedBox();
                          //     }
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,bottom: 7,top: 10),
                            child: Text(
                              "Select Panchayath/Municipality",
                              style: donateText,),
                          ),
                          ///select panchayath
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Consumer<DonationProvider>(
                                builder: (context,value,child) {
                                  return Container(
                                    // height: height*0.07,
                                    // width: width*0.8,
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

                                        return TextFormField(

                                          scrollPadding: const EdgeInsets.only(bottom: 500),
                                          decoration:  InputDecoration(
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),

                                            // labelText:'Select Assembly/organization',
                                            // labelStyle: whitePoppins,
                                            filled: true,
                                            fillColor: Colors.white.withOpacity(0.4),
                                            border: borderKnm,
                                            enabledBorder: borderKnm,
                                            focusedBorder: borderKnm,
                                          ),
                                          controller: fieldTextEditingController,
                                          focusNode: fieldFocusNode,
                                          style: const TextStyle(color: myBlack,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Poppins"),
                                          // validator: (text) => value.assemblyList.map((e) => e.assembly.contains(text)) ? "Please Select Your Assembly" : null,
                                          validator: (value2) {
                                            if (value2!.trim().isEmpty || !value.panjayathList.map((item) => item.panjayath).contains(value2)) {
                                              return "Please Select Your panchayath";
                                            } else {
                                              return null;
                                            }
                                          },
                                        );

                                      },
                                      onSelected: (PanjayathModel selection) {
                                        print(selection.assembly.toString()+"wwwwiefjmf");


                                        // donationProvider.onSelectAssembly(selection);


                                        donationProvider.fetchUnitChipset(selection,context);

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
                                              height: 400,
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
                                                            Text(option.panjayath,
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight.bold)),
                                                            Text(option.district,style: const TextStyle(
                                                                fontSize: 12
                                                            ),),
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
                                  );
                                }
                            ),
                          ),


                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 10),
                          //   child: Consumer<DonationProvider>(
                          //       builder: (context,value,child) {
                          //         return Container(
                          //           // height: height*0.07,
                          //           // width: width*0.8,
                          //           child: Autocomplete<DistrictDropListModel>(
                          //             optionsBuilder: (TextEditingValue textEditingValue) {
                          //
                          //               return (value.districtList)
                          //
                          //                   .where((DistrictDropListModel wardd) => wardd.district.toLowerCase()
                          //                   .contains(textEditingValue.text.toLowerCase()))
                          //                   .toList();
                          //             },
                          //             displayStringForOption: (DistrictDropListModel option) => option.district,
                          //             fieldViewBuilder: (
                          //                 BuildContext context,
                          //                 TextEditingController fieldTextEditingController,
                          //                 FocusNode fieldFocusNode,
                          //                 VoidCallback onFieldSubmitted
                          //                 ) {
                          //
                          //               return TextFormField(
                          //
                          //                 scrollPadding: const EdgeInsets.only(bottom: 500),
                          //                 decoration:  InputDecoration(
                          //                   contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          //
                          //                   // labelText:'Select Assembly/organization',
                          //                   // labelStyle: whitePoppins,
                          //                   filled: true,
                          //                   fillColor: Colors.white.withOpacity(0.2),
                          //                   border: borderKnm,
                          //                   enabledBorder: borderKnm,
                          //                   focusedBorder: borderKnm,
                          //                 ),
                          //                 controller: fieldTextEditingController,
                          //                 focusNode: fieldFocusNode,
                          //                 style: const TextStyle(color: myBlack,fontWeight: FontWeight.w500,fontSize: 16,fontFamily: "Poppins"),
                          //                 // validator: (text) => value.assemblyList.map((e) => e.assembly.contains(text)) ? "Please Select Your Assembly" : null,
                          //                 validator: (value2) {
                          //                   if (value2!.trim().isEmpty || !value.districtList.map((item) => item.district).contains(value2)) {
                          //                     return "Please Select Your District";
                          //                   } else {
                          //                     return null;
                          //                   }
                          //                 },
                          //               );
                          //
                          //             },
                          //             onSelected: (DistrictDropListModel selection) {
                          //               print(selection.district.toString()+"wwwwiefjmf");
                          //
                          //
                          //               // donationProvider.onSelectAssembly(selection);
                          //
                          //
                          //               donationProvider.fetchAssemblyChipset(selection,context);
                          //
                          //             },
                          //             optionsViewBuilder: (
                          //                 BuildContext context,
                          //                 AutocompleteOnSelected<DistrictDropListModel> onSelected,
                          //                 Iterable<DistrictDropListModel> options
                          //                 ) {
                          //               return Align(
                          //                 alignment: Alignment.topLeft,
                          //                 child: Material(
                          //                   child: Container(
                          //                     width: width-30,
                          //                     height: 400,
                          //                     color: Colors.white,
                          //                     child: ListView.builder(
                          //                       padding: const EdgeInsets.all(10.0),
                          //                       itemCount: options.length,
                          //                       itemBuilder: (BuildContext context, int index) {
                          //                         final DistrictDropListModel option = options.elementAt(index);
                          //
                          //                         return GestureDetector(
                          //                           onTap: () {
                          //                             onSelected(option);
                          //                           },
                          //                           child:  Container(
                          //                             color: Colors.white,
                          //                             height: 50,
                          //                             width: width-30,
                          //                             child: Column(
                          //                                 crossAxisAlignment:
                          //                                 CrossAxisAlignment.start,
                          //                                 children: [
                          //                                   Text(option.district,
                          //                                       style: const TextStyle(
                          //                                           fontWeight: FontWeight.bold)),
                          //                                   Text(option.state,style: const TextStyle(
                          //                                       fontSize: 12
                          //                                   ),),
                          //                                   const SizedBox(height: 10)
                          //                                 ]),
                          //                           ),
                          //                         );
                          //                       },
                          //                     ),
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //           ),
                          //         );
                          //       }
                          //   ),
                          // ),


                          const SizedBox(height: 5,),

                          // Align(alignment: Alignment.centerLeft,
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 33.0),
                          //       child: Text('Select Unit',style: blackPoppinsBlackR14,),
                          //     )),



                          Consumer<DonationProvider>(
                              builder: (context,value,child) {
                                return value.chipsetWardList.isEmpty
                                    ?  Padding(
                                  padding: const EdgeInsets.fromLTRB(0,10,10,20),
                                  child:Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:  [
                                      const SizedBox(height:10),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.arrow_right,size: 25,color: Colors.black),
                                          SizedBox(
                                            width: width*.7,
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 3),
                                              child: Text('പഞ്ചായത്ത്‌ സെലക്ട് ചെയ്യുക.',
                                                  style: TextStyle(color: cl4F4F4F,fontSize: 14,fontFamily: "Poppins",)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height:10),
                                      Row(
                                        //mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.arrow_right,size: 25,color: Colors.black),
                                          SizedBox(
                                            width: width*.7,
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 3.0),
                                              child: Text('ശേഷം താഴെ വരുന്ന ലിസ്റ്റിൽ നിന്നും Unit തിരഞ്ഞെടുക്കുക.',
                                                  style: TextStyle(color: cl4F4F4F,fontSize: 14,fontFamily: "Poppins")),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height:10),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.arrow_right,size: 25,color: Colors.black),
                                          SizedBox(
                                            width: width*.7,
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 3.0),
                                              child: Text('ശേഷം  Pay Now ബട്ടൺ ക്ലിക്ക് ചെയ്യുക.',
                                                  style: TextStyle(color: cl4F4F4F,fontSize: 14,fontFamily: "Poppins")),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),

                                )
                                    :const SizedBox();
                              }
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left:20),
                    child: Consumer<DonationProvider>(
                        builder: (context,value,child){
                          return value.chipsetWardList.isNotEmpty
                              ?
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0,left: 10,right: 2),
                            child: ShakeX(
                              controller: _shakeXController,
                              text: 'Select Unit',
                              style: poppins12,

                              child: Column(

                                children: [
                                  const SizedBox(height: 20,),

                                  ChipList(
                                    style:  const TextStyle(
                                        fontSize:10,fontWeight: FontWeight.bold
                                    ),
                                    listOfChipNames:value.chipsetWardList,
                                    listOfChipIndicesCurrentlySeclected: const [0],
                                    currentSelected: value.selectedWard,

                                    shouldWrap: true,
                                    supportsMultiSelect: false,
                                    runSpacing:7,
                                    spacing:8,
                                    callback: (item){
                                      print(item!.assembly.toString()+"fjrfior");
                                      donationProvider.onSelectWard(item);
                                    },
                                  ),
                                  const SizedBox(height: 40,)
                                ],
                              ),
                            ),
                          )
                              :const SizedBox();

                        }
                    ),
                  ),
                  const SizedBox(height: 90,),
                ],
              ),
            ),
          ),
        ));

  }

  Widget mobile (BuildContext context){
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return WillPopScope(
      onWillPop: ()async{
        return true;
      },
      //callNextReplacement(const HomeScreen(), context),
      child: Container(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          floatingActionButton: Consumer<DonationProvider>(
              builder: (context,value,child) {
                return Consumer<HomeProvider>(
                    builder: (context,value2,child) {
                      return InkWell(
                        onTap: () async {
                          print("esfef"+value.kpccAmountController.text);
                          HomeProvider homeProvider =
                          Provider.of<HomeProvider>(context, listen: false);

                          DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                          if(value.kpccAmountController.text.isNotEmpty) {

                            value.kpccAmountController.text = num.parse(value.kpccAmountController.text).toInt().toString();
                          }
                          PackageInfo packageInfo = await PackageInfo.fromPlatform();
                          String packageName = packageInfo.packageName;

                          final FormState? form = _formKey.currentState;


                          if(value.selectedWard!=null){
                            if(form!.validate()){
                              if(value.minimumbool==false){
                                if(kIsWeb){

                                }else{

                                  mRoot.child('0').child('PaymentGateway36').onValue.listen((event) {
                                    if(event.snapshot.value.toString().isNotEmpty){
                                      DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                      donationProvider.transactionID.text = DateTime.now().microsecondsSinceEpoch.toString()+generateRandomString(2);
                                      print("atteemptclickheh");
                                      donationProvider.attempt(donationProvider.transactionID.text,homeProvider.appVersion.toString());
                                      if(Platform.isIOS){
                                        // if(value2.eazyPayGateOptionIos=="OFF"&&value2.mindGatePaymentNewIos=="ON") {
                                        //   callNext(MindGatePaymentScreen(
                                        //     id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider
                                        //         .transactionID
                                        //         .text}&mode=04&tn=km${homeProvider.appVersion.toString()}%20${donationProvider
                                        //         .transactionID
                                        //         .text}&am=${donationProvider
                                        //         .kpccAmountController.text
                                        //         .toString()}&cu=INR",),
                                        //       context);
                                        // }else if(value2.eazyPayGateOptionIos=="ON"&&value2.mindGatePaymentNewIos=="ON"){

                                          callNext(PaymentGateway(), context);
                                        // }else if(value2.eazyPayGateOptionIos=="ON"&&value2.mindGatePaymentNewIos=="OFF"){
                                        //   String amount=donationProvider.kpccAmountController.text.toString();
                                        //   String name=donationProvider.nameTC.text;
                                        //   String phone=donationProvider.phoneTC.text;
                                        //   String id=donationProvider.transactionID.text;
                                        //   donationProvider.eazypayGateway(name,id,phone,amount,context);
                                        // }



                                      }else if(Platform.isAndroid){


                                        if(value2.mindGatePaymentNew=="ON"&&value2.intentOptionNew=="OFF"&&value2.eazyPayGateOption=="OFF"){
                                          callNext(MindGatePaymentScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=km${homeProvider.appVersion.toString()}%20${donationProvider.transactionID.text}&am=${donationProvider.kpccAmountController.text.toString()}&cu=INR",), context);

                                        }else if(value2.mindGatePaymentNew=="OFF"&&value2.intentOptionNew=="ON"&&value2.eazyPayGateOption=="OFF"){
                                          callNext(PaymentGateway(), context);
                                        }else if(value2.mindGatePaymentNew=="ON"&&value2.intentOptionNew=="ON"&&value2.eazyPayGateOption=="ON"){
                                          callNext(PaymentGateway(), context);

                                        }else if(value2.mindGatePaymentNew=="ON"&&value2.intentOptionNew=="OFF"&&value2.eazyPayGateOption=="ON"){
                                          callNext(PaymentGateway(), context);

                                        }else if(value2.mindGatePaymentNew=="OFF"&&value2.intentOptionNew=="ON"&&value2.eazyPayGateOption=="ON"){
                                          callNext(PaymentGateway(), context);

                                        }else if(value2.mindGatePaymentNew=="ON"&&value2.intentOptionNew=="ON"&&value2.eazyPayGateOption=="OFF"){
                                          callNext(PaymentGateway(), context);

                                        }else if(value2.mindGatePaymentNew=="OFF"&&value2.intentOptionNew=="OFF"&&value2.eazyPayGateOption=="ON"){
                                          String amount=donationProvider.kpccAmountController.text.toString();
                                          String name=donationProvider.nameTC.text;
                                          String phone=donationProvider.phoneTC.text;
                                          String id=donationProvider.transactionID.text;
                                          donationProvider.eazypayGateway(name,id,phone,amount,context);
                                        }





                                      }

                                    }else{
                                      callNext(const NoPaymentGateway(), context);
                                    }
                                  });
                                }


                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor:Colors.red,
                                        content: Text("Please Enter Amount")));
                              }
                            }

                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor:Colors.red,
                                    content: Text("Please Select Unit")));

                          }
                        },
                        child: Container(
                          height: 50,
                          width: width * .82,
                          decoration:  BoxDecoration(
                            boxShadow:  [
                              const BoxShadow(
                                color:cl323A71,
                              ),
                              BoxShadow(
                                color: cl000000.withOpacity(0.25),
                                spreadRadius: -5.0,
                                // blurStyle: BlurStyle.inner,
                                blurRadius: 20.0,
                              ),

                            ],
                            borderRadius: const BorderRadius.all(Radius.circular(35)),
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [cl0EA3A9,cl3686C5]),

                          ),
                          child:value.isLoadingPaymentPage ?
                          const Center(child: CircularProgressIndicator(color: myWhite,)): Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              Image.asset("assets/CoinGif.gif"),
                              const GradientText(
                                'Pay Now',
                                style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontFamily: "Poppins"),
                                gradient: LinearGradient(colors: [
                                  Colors.white,
                                  Colors.white,
                                ]),
                              ),
                              // SizedBox(width: MediaQuery.of(context).size.width*0.1,
                              //     child: Image.asset("assets/Contribute Arrow.png",)),


                              // Icon(Icons.arrow_forward_ios,color: knmGolden,)

                            ],
                          ),
                        ),
                      );
                    }
                );
              }
          ),

          body: Consumer<DonationProvider>(
              builder: (context,value,child) {
                return GestureDetector(
                    onTap: () {
                      // if(value.dhotiCounterController.text.isEmpty) {
                      //   value.dhotiCounterController.text = '1';
                      //   value.dhothiAmount=600;
                      // }
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: body(context)
                );
              }
          ),
        ),
      ),
    );
  }
  Widget web (BuildContext context){
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return WillPopScope(
      onWillPop: ()async{
        return true;
        //callNextReplacement(const HomeScreen(), context),
      },

      child: Stack(children:[
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
            child:queryData.orientation==Orientation.portrait
                ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(width: width/3,),
                SizedBox(
                  width: width,
                  child: Scaffold(
                    // backgroundColor: Colors.white,
                    resizeToAvoidBottomInset: true,
                    floatingActionButton: Consumer<DonationProvider>(
                        builder: (context,value,child) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child:
                            InkWell(
                              onTap: () {
                                // print("esfef");
                                // HomeProvider homeProvider =
                                // Provider.of<HomeProvider>(context, listen: false);
                                //
                                // DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                // if(value.kpccAmountController.text.isNotEmpty) {
                                //
                                //   value.kpccAmountController.text = num.parse(value.kpccAmountController.text).toInt().toString();
                                // }
                                //
                                //
                                //
                                // final FormState? form = _formKey.currentState;
                                // if(form!.validate()){
                                //   if(double.parse(value.kpccAmountController.text.toString())>=138){
                                //     if(value.selectedWard==null){
                                //       _shakeXController.shake();
                                //       if(!kIsWeb){
                                //         Vibrate.vibrate();
                                //       }
                                //     } else {
                                //       callNext(PaymentGateway(), context);
                                //
                                //       if(kIsWeb){
                                //
                                //       }else{
                                //         mRoot.child('0').child('PaymentGateway34').onValue.listen((event) {
                                //           if(event.snapshot.value.toString()=='ON'){
                                //             DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                //             donationProvider.transactionID.text = DateTime.now().microsecondsSinceEpoch.toString();
                                //             print("atteemptclickheh");
                                //             donationProvider.attempt(donationProvider.transactionID.text,homeProvider.appVersion.toString());
                                //             callNext(PaymentGateway(), context);
                                //           }else{
                                //             callNext(const NoPaymentGateway(), context);
                                //           }
                                //         });
                                //       }
                                //     }
                                //
                                //   }else{
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(
                                //             backgroundColor:Colors.red,
                                //             content: Text("Minimum amount is 138")));
                                //   }
                                //m
                                // }else{
                                //   if(!kIsWeb){
                                //     Vibrate.vibrate();
                                //   }
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       const SnackBar(content: Text("Please Enter Amount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)));
                                //
                                // }
                                // }

                                // callNext(PaymentGateway(), context);
                                // if(value.selectedPanjayathChip!=null){


                                // }else{
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       const SnackBar(content: Text("please select panchayath!!!")));
                                // }


                              },
                              child: Container(
                                height: 50,
                                width: width * .750,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                                  // gradient: LinearGradient(
                                  //     begin: Alignment.centerLeft,
                                  //     end: Alignment.centerRight,
                                  //     colors: [myLightBlue, myDarkBlue])
                                ),
                                child:
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Icon(
                                      Icons.add_circle,
                                      color: myWhite,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5,),
                                    // value.displayAmount!=""
                                    //     ? Text(
                                    //   'Dhothi Amount ₹ '+value.displayAmount +' Now',
                                    //   style: white16,
                                    // ):
                                    GradientText(
                                      'Pay Now',
                                      style: TextStyle(fontSize:22,fontWeight:FontWeight.bold ),
                                      gradient: LinearGradient(colors: [
                                        Colors.white,
                                        Colors.white,
                                      ]),
                                    ),
                                    // SizedBox(width: MediaQuery.of(context).size.width*0.1,
                                    //     child: Image.asset("assets/Contribute Arrow.png",)),


                                    // Icon(Icons.arrow_forward_ios,color: knmGolden,)

                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    ),

                    body: Consumer<DonationProvider>(
                        builder: (context,value,child) {
                          return GestureDetector(
                              onTap: () {
                                // if(value.dhotiCounterController.text.isEmpty) {
                                //   value.dhotiCounterController.text = '1';
                                //   value.dhothiAmount=600;
                                // }
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              child: body(context)
                          );
                        }
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
                SizedBox(
                  width: width/3,
                  child: Scaffold(
                    // backgroundColor: Colors.white,
                    resizeToAvoidBottomInset: true,
                    floatingActionButton: Consumer<DonationProvider>(
                        builder: (context,value,child) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child:
                            InkWell(
                              onTap: () {
                                // print("esfef");
                                // HomeProvider homeProvider =
                                // Provider.of<HomeProvider>(context, listen: false);
                                //
                                // DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                // if(value.kpccAmountController.text.isNotEmpty) {
                                //
                                //   value.kpccAmountController.text = num.parse(value.kpccAmountController.text).toInt().toString();
                                // }
                                //
                                //
                                //
                                // final FormState? form = _formKey.currentState;
                                // if(form!.validate()){
                                //   if(double.parse(value.kpccAmountController.text.toString())>=138){
                                //     if(value.selectedWard==null){
                                //       _shakeXController.shake();
                                //       if(!kIsWeb){
                                //         Vibrate.vibrate();
                                //       }
                                //     } else {
                                //       callNext(PaymentGateway(), context);
                                //
                                //       if(kIsWeb){
                                //
                                //       }else{
                                //         mRoot.child('0').child('PaymentGateway34').onValue.listen((event) {
                                //           if(event.snapshot.value.toString()=='ON'){
                                //             DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                //             donationProvider.transactionID.text = DateTime.now().microsecondsSinceEpoch.toString();
                                //             print("atteemptclickheh");
                                //             donationProvider.attempt(donationProvider.transactionID.text,homeProvider.appVersion.toString());
                                //             callNext(PaymentGateway(), context);
                                //           }else{
                                //             callNext(const NoPaymentGateway(), context);
                                //           }
                                //         });
                                //       }
                                //     }
                                //
                                //   }else{
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(
                                //             backgroundColor:Colors.red,
                                //             content: Text("Minimum amount is 138")));
                                //   }
                                //
                                // }else{
                                //   if(!kIsWeb){
                                //     Vibrate.vibrate();
                                //   }
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       const SnackBar(content: Text("Please Enter Amount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)));
                                //
                                // }
                                // }

                                // callNext(PaymentGateway(), context);
                                // if(value.selectedPanjayathChip!=null){


                                // }else{
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       const SnackBar(content: Text("please select panchayath!!!")));
                                // }


                              },
                              child: Container(
                                height: 50,
                                width: width * .750,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                                  // gradient: LinearGradient(
                                  //     begin: Alignment.centerLeft,
                                  //     end: Alignment.centerRight,
                                  //     colors: [myLightBlue, myDarkBlue])
                                ),
                                child:
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Icon(
                                      Icons.add_circle,
                                      color: myWhite,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5,),
                                    // value.displayAmount!=""
                                    //     ? Text(
                                    //   'Dhothi Amount ₹ '+value.displayAmount +' Now',
                                    //   style: white16,
                                    // ):
                                    GradientText(
                                      'Pay Now',
                                      style: TextStyle(fontSize:22,fontWeight:FontWeight.bold ),
                                      gradient: LinearGradient(colors: [
                                        Colors.white,
                                        Colors.white,
                                      ]),
                                    ),
                                    // SizedBox(width: MediaQuery.of(context).size.width*0.1,
                                    //     child: Image.asset("assets/Contribute Arrow.png",)),


                                    // Icon(Icons.arrow_forward_ios,color: knmGolden,)

                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    ),

                    body: Consumer<DonationProvider>(
                        builder: (context,value,child) {
                          return GestureDetector(
                              onTap: () {
                                // if(value.dhotiCounterController.text.isEmpty) {
                                //   value.dhotiCounterController.text = '1';
                                //   value.dhothiAmount=600;
                                // }
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              child: body(context)
                          );
                        }
                    ),
                  ),
                ),
                // SizedBox(width: width/3,),
              ],
            )),

      ]),
    );

  }
  TextStyle textsty=const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white);
  TextStyle textsty2=const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black);

  void showPaymentDialog(BuildContext context) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    Widget setupAlertDialoadContainer() {
      return SizedBox(
        height: 100.0, // Change as per your requirement
        width: 100.0, // Change as per your requirement
        child: Consumer<DonationProvider>(
            builder: (context,value,child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: value.paymentOptions.length,
                itemBuilder: (BuildContext context, int index) {
                  return  InkWell(
                    onTap: () async {
                      finish(context);
                      if(value.paymentOptions[index].id=="1"){
                        donationProvider.funPaytm(context);

                      }
                      if(value.paymentOptions[index].id=="2"){
                        // donationProvider.cashFree();
                        // showBottomSheet(context);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: myWhite,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Image.asset(
                                value.paymentOptions[index].asset,
                                scale: 8,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
        ),
      );
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: setupAlertDialoadContainer(),
          );
        });
  }
  // void showBottomSheet(BuildContext context) {
  //   DonationProvider donationProvider =
  //   Provider.of<DonationProvider>(context, listen: false);
  //   var size = MediaQuery.of(context).size;
  //   var height = size.height;
  //   var width = size.width;
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     barrierColor: myBlack.withOpacity(0.2),
  //     elevation: 10,
  //     useRootNavigator: true,
  //     backgroundColor: Colors.transparent,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(20.0),
  //           topRight: Radius.circular(20.0),
  //         )),
  //     builder: (_) {
  //       return DraggableScrollableSheet(
  //         maxChildSize: 0.8,
  //         expand: false,
  //         builder: (_, controller) {
  //
  //           return Column(
  //             children: [
  //
  //               Expanded(
  //                 child: Container(
  //                   padding: const EdgeInsets.only(top: 20),
  //                   decoration: const BoxDecoration(
  //                       color: myWhite,
  //
  //                       borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(20.0),
  //                         topRight: Radius.circular(20.0),
  //                       )
  //                   ),
  //                   child: Consumer<DonationProvider>(
  //                       builder: (context,value,child) {
  //                         return GridView.builder(
  //                           shrinkWrap: true,
  //                             gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
  //                                 maxCrossAxisExtent: width/4,
  //                                 childAspectRatio: 2 / 2,
  //                                 crossAxisSpacing: 20,
  //                                 mainAxisSpacing: 20),
  //                             itemCount: value.apps!.length,
  //                             itemBuilder: (BuildContext ctx, index) {
  //                               return InkWell(
  //
  //                                 onTap: Platform.isAndroid ? () async => await donationProvider.onTap(value.apps![index],context) : null,
  //                                 child: Container(
  //                                   alignment: Alignment.center,
  //                                   child: Column(
  //                                     children: [
  //                                       value.apps![index].iconImage(48),
  //                                       Text(value.apps![index].upiApplication.appName),
  //                                     ],
  //                                   ),
  //                                   decoration: BoxDecoration(
  //                                       color: Colors.white,
  //                                       borderRadius: BorderRadius.circular(15)),
  //                                 ),
  //                               );
  //                             });
  //                       }
  //                   ),
  //                 ),
  //               ),
  //
  //             ],
  //           );
  //
  //         },
  //       );
  //     },
  //   );
  // }
  final OutlineInputBorder border=OutlineInputBorder(
    borderSide: const BorderSide(
        color:Color(0xFFF4FCFE) , width: 1.0),
    borderRadius: BorderRadius.circular(8),
  );

  final OutlineInputBorder borderKnm=OutlineInputBorder(
    borderSide: const BorderSide(
        color:clD4D4D4 , width: 1.0),
    borderRadius: BorderRadius.circular(50),
  );

  void showBottomSheet(BuildContext context) {
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        context: context,
        builder: (BuildContext bc) {
          return Consumer<DonationProvider>(
              builder: (context,value,child) {
                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: value.paymentGateWays.length,
                    itemBuilder: (_, index) {
                      var item=value.paymentGateWays[index];
                      return InkWell(
                        onTap: (){
                          if(item=='Cashfree'){
                            callNextReplacement(PaymentGateway(), context);
                          }
                          // else if(item=='PayU'){
                          //   finish(context);
                          //   showLoaderDialog(context);
                          //   String amount=donationProvider.amountTC.text;
                          //   String name=donationProvider.nameTC.text!=""?donationProvider.nameTC.text:"User";
                          //   String phone=donationProvider.phoneTC.text!=""?donationProvider.phoneTC.text:"9048004320";
                          //   donationProvider.payUPaymentGateWay(context, amount, name, phone);
                          // }
                        },
                        child: SizedBox(
                          height: 50,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(item),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
          );
        });
    // ImageSource
  }

}


class FirstDisabledFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
String generateRandomString(int length) {
  final random = Random();
  const availableChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  final randomString = List.generate(length,
          (index) => availableChars[random.nextInt(availableChars.length)]).join();

  return randomString;
}

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;


  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
