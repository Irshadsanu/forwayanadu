import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../providers/home_provider.dart';
import '../providers/web_provider.dart';
import 'admin_home_screen.dart';

class AdminLoginScreen extends StatelessWidget {
   AdminLoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: _formKey ,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<HomeProvider>(
                    builder: (context,value,child) {
                      return TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(


                          border: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        validator: (txt){
                          if(txt!.isEmpty||txt!=value.adminPassword){
                            return 'Please Enter Valid Password';
                          }else{
                            return null;
                          }
                        },
                      );
                    }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(myWhite),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(secondary),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side:  BorderSide(
                            color: primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30)),
                    ),
                    onPressed: () async {
                      final FormState? form = _formKey.currentState;
                      if (form!.validate()) {
                        HomeProvider homeProvider =
                        Provider.of<HomeProvider>(context, listen: false);
                        callNextReplacement(AdminHomeScreen(), context);
                        homeProvider.fetchDistrictsforAdmin();


                      }
                    },
                    child: Text(
                      'Log in',
                      style: white16,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
