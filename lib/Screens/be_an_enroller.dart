import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Views/panjayath_model.dart';
import '../Views/reportModel.dart';
import '../constants/gradientTextClass.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/donation_provider.dart';
import '../providers/home_provider.dart';
import 'home_screen.dart';

class BeAnEnroller extends StatelessWidget {
  BeAnEnroller({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);

    String whoIsAVolunteerText =
        "IUML MUNNETTAM ക്യാമ്പയിനിനെ പിന്തുണക്കാനും ഫണ്ട് സ്വരൂപിക്കാനും പരിശ്രമിക്കുന്ന വ്യക്തികളാണ് വോളണ്ടീയർമാർ."
        "ആപ്പില്‍,വോളണ്ടീയർമാർക്ക് രജിസ്റ്റര്‍ ചെയ്യാന്‍ അവരുടെ മൊബൈൽ നമ്പർ മാത്രം ഉപയോഗിച്ചാല്‍ മതി ."
        "വോളണ്ടീയർമാർക്ക് ഫണ്ട് സ്വരൂപണത്തില്‍ മറ്റ് വോളണ്ടീയർമാരുമായി മത്സരിക്കാന്‍ സാധിക്കും ."
        "'My History' പേജിലെ 'Map Volunteer' എന്ന ഓപ്ഷനിലൂടെ സംഭാവന ചെയ്യുന്നയാള്‍ക്ക് വോളണ്ടിയറെ Add ചെയ്യാവുന്നതാണ്.ഇതുവഴി വോളണ്ടിയര്‍മാര്‍ സ്വരൂപിച്ച സംഭാവനകള്‍ ട്രാക്ക് ചെയ്യാനും ക്യാമ്പയിനിന്റെ പുരോഗതി നിരീക്ഷിക്കാനും സാധിക്കും ."
        "ക്യാമ്പയിനില്‍ പങ്കെടുക്കാന്‍ വോളണ്ടിയര്‍ ആകേണ്ടതില്ല .";

    return WillPopScope(
      onWillPop: () async {
        callNextReplacement(HomeScreenNew(), context);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
            preferredSize: Size.fromHeight(84),
        child: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: height*0.12,
          // shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(17),bottomLeft: Radius.circular(17)) ),
          title: Text('Volunteer Registration',style: wardAppbarTxt),
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
        ),
      ),
            body: Consumer<HomeProvider>(
                builder: (context, value5, child) {
              return SingleChildScrollView(
                  child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     whoIsAVolunteerText.trim(),
                        //     style: const TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 12,
                        //       fontFamily: 'PoppinsMedium',
                        //     ),
                        //     textAlign: TextAlign.justify,
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               const Padding(
                                 padding: EdgeInsets.only(left: 12.0),
                                 child: GradientText(
                                   "Register",
                                   style: TextStyle(
                                       fontFamily: 'Poppins',
                                       fontSize: 16,
                                       // color: cl3686C5,
                                       fontWeight:FontWeight.w600
                                     ),
                                   gradient: LinearGradient(colors: [cl0EA3A9,cl3686C5]),
                                 ),
                               ),
                              const Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Text("As a Volunteer",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: cl4F4F4F,
                                    fontWeight:FontWeight.w600
                                ),),
                              ),

                              const SizedBox(height: 30,),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0,bottom: 8),
                                child: Text("Name",
                                  style: donateText,),
                              ),
                              SizedBox(
                                height: 68,
                                child: TextFormField(
                                  controller: value5.entrollerNameCT,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                                  ],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontFamily: "Poppins",
                                      fontSize: 14),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 17),
                                    enabledBorder: border2,
                                    focusedBorder: border2,
                                    border: border2,
                                  ),
                                  validator: (text) =>
                                      text!.trim().isEmpty
                                          ? "Name cannot be blank"
                                          : null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0,bottom: 8),
                                child: Text("Mobile Number",
                                  style: donateText,),
                              ),
                              SizedBox(
                                height: 68,
                                child: TextFormField(
                                    controller: value5.entrollerPhoneCT,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontSize: 14),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 17),
                                      enabledBorder: border2,
                                      focusedBorder: border2,
                                      border: border2,
                                    ),
                                    validator: (text) {
                                      if (text!.isEmpty) {
                                        return "Phone Number cannot be blank";
                                      } else if (text.length != 10) {
                                        return "Phone Number Must be 10 letter";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0,bottom: 8),
                                child: Text("Select Panchayath",
                                  style: donateText,),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 10),
                              //   child: SizedBox(
                              //     height: 68,
                              //     child: TextFormField(
                              //         controller: value5.entrollerPlaceCT,
                              //         keyboardType: TextInputType.text,
                              //         decoration: InputDecoration(
                              //           // labelText: "Place",
                              //           contentPadding: const EdgeInsets.symmetric(
                              //               horizontal: 17),
                              //           enabledBorder: border2,
                              //           focusedBorder: border2,
                              //           border: border2,
                              //         ),
                              //         validator: (text) {
                              //           if (text!.isEmpty) {
                              //             return 'Enter your Place';
                              //           } else {
                              //             return null;
                              //           }
                              //         }),
                              //   ),
                              // ),
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
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                                border: border2,
                                                enabledBorder: border2,
                                                focusedBorder: border2,
                                              ),
                                              controller: fieldTextEditingController,
                                              focusNode: fieldFocusNode,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontFamily: "Poppins",
                                                  fontSize: 14),
                                              validator: (value2) {
                                                if (value2!.trim().isEmpty || !value.panjayathList.map((item) => item.panjayath).contains(value2)) {
                                                  return "Please Select Your panchayath";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onChanged: (text){
                                                homeProvider.enrollerDistrictCT.text="";
                                                homeProvider.enrollerAssemblyCT.text="";
                                                homeProvider.enrollerPanchayathCT.text="";

                                              },
                                            );

                                          },
                                          onSelected: (PanjayathModel selection) {
                                            print(selection.assembly.toString()+"wwwwiefjmf");
                                            homeProvider.onSelectVolunteerPanchayath(selection);
                                            // donationProvider.onSelectAssembly(selection);

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
                            ],
                          ),
                        ),
                      ]),
                ),
              ));
            }),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25,bottom: 20),
            child: Consumer<HomeProvider>(
                builder: (context, value3, child) {
                  return InkWell(
                    onTap: () async {
                      final FormState? form = _formKey.currentState;
                      if (form!.validate()) {
                        HomeProvider homeProvider =
                        Provider.of<HomeProvider>(context,
                            listen: false);
                        await homeProvider.enrollerExistCheck(
                            value3.entrollerPhoneCT.text.toString());
                        print("asdfgwose" +
                            value3.checkEnrollerExist.toString());

                        if (value3.checkEnrollerExist) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Volunteer Already Exist"),
                            duration: Duration(milliseconds: 3000),
                          ));
                        } else {
                          finish(context);
                          confirmationAlert(
                              context,
                              value3.entrollerNameCT.text.toString(),
                              value3.entrollerPhoneCT.text.toString(),
                              value3.enrollerPanchayathCT.text.toString());
                        }
                      }
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(23)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [cl0EA3A9,cl3686C5])
                        ),
                        child: const Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  );
                }),
          ),

        ),
      ),
    );
  }


  Future<AlertDialog?> confirmationAlert(
      BuildContext context, String name, String phone, String place) {    MediaQueryData queryData;
  queryData = MediaQuery.of(context);
  var width = queryData.size.width;
  var height = queryData.size.height;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<HomeProvider>(builder: (context, value6, child) {
          return AlertDialog(
            title: const Center(
              child: Text(
                "Confirmation",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            backgroundColor: myWhite,
            contentPadding: const EdgeInsets.only(
              top: 15.0,
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            content: Consumer<HomeProvider>(builder: (context, value2, child) {
              return SizedBox(
                // width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8),
                      child: Text(
                        "*" + "Volunteer details cannot be changed once they are saved",
                        style: TextStyle(
                            color: myRed,
                            fontSize: 12,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 120,
                              child: Text("Volunteer ID ",style: gray12white,)),
                          Text(": ",style: gray12white,),
                          SizedBox(
                              width:width/2.8,
                              child: Text(phone,style: gray16White,)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 120,
                              child: Text("Volunteer Name ",style: gray12white,)),
                          Text(": ",style: gray12white,),
                          SizedBox(
                              width:width/2.8,
                              child: Text(name,style: gray16White,)),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 120,
                              child: Text("Volunteer Place ",style: gray12white,)),
                          Text(": ",style: gray12white,),
                          SizedBox(
                              width:width/2.8,
                              child: Text(place,style: gray16White,)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            finish(context);
                          },
                          child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35)),
                                  // color: Color(0xff050066),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [cl0EA3A9,cl3686C5])),
                              child: const Center(
                                child: Text(
                                 "Cancel",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            HomeProvider homeProvider =
                                Provider.of<HomeProvider>(context, listen: false);
                            homeProvider.addEnrollers(context);
                           finish(context);
                          },
                          child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35)),
                                  // color: Color(0xff050066),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [cl0EA3A9,cl3686C5])),
                              child: const Center(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            }),
          );
        });
      },
    );
  }

  OutlineInputBorder border2 = OutlineInputBorder(
      borderSide: BorderSide(color: textfieldTxt.withOpacity(0.1)),
      borderRadius: BorderRadius.circular(30));
}
