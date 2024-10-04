import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quaide_millat/providers/home_provider_reciept.dart';
import 'package:quaide_millat/providers/main_provider.dart';
import 'package:quaide_millat/testing%20page.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:url_strategy/url_strategy.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import '../providers/web_provider.dart';
import 'package:provider/provider.dart';
import 'Screens/Expensenses/add_expenses_screen.dart';
import 'Screens/splash_screen.dart';
import 'Screens/update.dart';
import 'Screens/upload_portal_login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String? paymentID;

  if(!kIsWeb) {
    await Firebase.initializeApp();
  }else {
    await Firebase.initializeApp(

        options:const FirebaseOptions(
            apiKey: "AIzaSyCs7BhC1uDY85dBoeYymLA53dNR-ea3MLg",
            authDomain: "iumlelection-a724a.firebaseapp.com",
            databaseURL: "https://iumlelection-a724a-default-rtdb.firebaseio.com",
            projectId: "iumlelection-a724a",
            storageBucket: "iumlelection-a724a.appspot.com",
            messagingSenderId: "1059304543440",
            appId: "1:1059304543440:web:4b36c088df880b7e2ebad5",
            measurementId: "G-P64ZW48MZR"
        )

    );

  }
  if(!kIsWeb){
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    bool weWantFatalErrorRecording = true;
    FlutterError.onError = (errorDetails) {
      if(weWantFatalErrorRecording){
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      } else {
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    // String strDeviceID= await DeviceInfo().fun_initPlatformState();
    String? strDeviceID= "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }
    FirebaseCrashlytics.instance.setUserIdentifier(strDeviceID!);
    FirebaseDatabase database;
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    runZonedGuarded(() {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) =>
          runApp( MyApp(paymentID: '',)));
      // runApp( MyApp(paymentID: '',));
    },
        FirebaseCrashlytics.instance.recordError);

  }else{
    setPathUrlStrategy();
    String? refNum = Uri.base.queryParameters["id"];
    if(refNum==null){

      paymentID="General";

    }else{

      paymentID=refNum;

    }

    print("dssedsqwer"+paymentID.toString());


    runApp( MyApp(paymentID: paymentID!,));
  }


}

class MyApp extends StatelessWidget {
  String paymentID="";
   MyApp({Key? key,required this.paymentID}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>DonationProvider(),),
        ChangeNotifierProvider(create: (context)=>HomeProvider(),),
        ChangeNotifierProvider(create: (context)=>HomeProviderReceiptApp(),),
        ChangeNotifierProvider(create: (context)=>WebProvider(),),
        ChangeNotifierProvider(create: (context)=>MainProvider(),),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
        title: 'For Wayanad',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue,),
        // home: TestPage(),
        home: UploadLogIn(),
        // home: AdminLoginScreen(),
        // home: UploadExcel(),
        // home:  StoppScreen(),
        // home:  SplashScreen(paymentID:paymentID,),
        // home:  AddExpensesScreen(),
        // home: Update(text: '', button: 'UPDATE', ADDRESS: '',),
        // home:   InagurationScreen(),
        // home:   InagurationTvScreen(),
        // home:   HomeScreenNew(),
        // home: const   Intern(),
        // home: TvMonitorScreem(),

      ),
    );
  }
}


