import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/constants/my_functions.dart';
import 'package:quaide_millat/providers/home_provider.dart';

import '../../constants/my_colors.dart';
import '../../constants/text_style.dart';

class AddExpensesScreen extends StatelessWidget {
   AddExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    return  SafeArea(
      child: Scaffold(
        appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(84),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text('Add Expenses',style: wardAppbarTxt),
            centerTitle: true,
            leadingWidth: 55,
            toolbarHeight: height*0.12,

          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 15,),
            Consumer<HomeProvider>(
              builder: (context,val,__) {
                return TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: val.expenseNameCT,
                  style: const TextStyle(color: myBlack,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Poppins"),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      hintText: 'Name',
                      hintStyle: const TextStyle(color: myBlack,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Poppins"),
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
                );
              }
            ),
            SizedBox(height: 15,),
            Consumer<HomeProvider>(
                builder: (context,val,__) {
                  return TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: val.expenseDescriptionCT,
                    maxLines: null,
                    style: const TextStyle(color: myBlack,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Poppins"),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        hintText: 'Description',
                        hintStyle: const TextStyle(color: myBlack,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Poppins"),
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
                  );
                }
            ),
            SizedBox(height: 15,),

            Consumer<HomeProvider>(
                builder: (context,val,__) {
                  return TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: val.expenseAmountCT,
                    style: const TextStyle(color: myBlack,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Poppins"),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        hintText: 'Amount',
                        hintStyle: const TextStyle(color: myBlack,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Poppins"),
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
                  );
                }
            ),
            SizedBox(height: 15,),

            Consumer<HomeProvider>(
                builder: (context,val,__) {
                  return TextFormField(
                    onTap: (){
                      val.selectExpenseDate(context);
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: val.expenseDateCT,
                    style: const TextStyle(color: myBlack,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Poppins"),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        hintText: 'Date',
                        hintStyle: const TextStyle(color: myBlack,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Poppins"),
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
                  );
                }
            ),
            SizedBox(height: 15,),


          ],
        ),
        floatingActionButton:  InkWell(
          onTap: (){
            homeProvider.addExpenses();
            finish(context);
          },
          child: Container(
            height: 50,
            width: 150,
            decoration:  BoxDecoration(
              boxShadow:  [
                const BoxShadow(
                  color:cl1E9201,
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
                  colors: [cl0EA3A9,cl3686C5]),

            ),
            child:  const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Save",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Poppins",
                          color: myWhite, fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
  final OutlineInputBorder borderKnm=OutlineInputBorder(
    borderSide: const BorderSide(
        color:clD4D4D4 , width: 1.0),
    borderRadius: BorderRadius.circular(50),
  );

}
