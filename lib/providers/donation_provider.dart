
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cashfree_pg/cashfree_pg.dart';
// import 'package:crop_image/crop_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:universal_html/html.dart' as web_file;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Screens/crop_image_screen.dart';
import '../Screens/donation_success.dart';
import '../Screens/eazypay_gateway_screen.dart';
import '../Screens/eazypayplus.dart';
import '../Screens/home_screen.dart';
import '../Screens/new_payment_gateway_Screen.dart';
import '../Screens/reciept_page.dart';
import '../Views/ageModel.dart';
import '../Views/bank_model.dart';
import '../Views/cash_free_model.dart';
import '../Views/panjayath_model.dart';
import '../Views/payment_option_model.dart';
import '../Views/receipt_list_model.dart';
import '../Views/reportModel.dart';
import '../Views/time_stamp_model.dart';
import '../Views/todayTopperModel.dart';
import '../Views/upi_model.dart';
import '../Views/ward_model.dart';
import '../constants/alerts.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/text_style.dart';
import '../service/device_info.dart';
import '../service/time_service.dart';
import '../service/wards_service.dart';
import 'home_provider.dart';



class DonationProvider extends ChangeNotifier {
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static const platformChanel = MethodChannel('payuGateway');


  /// for donation page
  TextEditingController amountTC = TextEditingController();

  TextEditingController dhotiCounterController = TextEditingController();

  ///for donate page KNM APP
  TextEditingController kpccAmountController = TextEditingController();
  TextEditingController nameTC = TextEditingController();
  TextEditingController phoneTC = TextEditingController();
  TextEditingController wardTC = TextEditingController();
  TextEditingController assemblyCt = TextEditingController();
  TextEditingController selectWardTC = TextEditingController();
  TextEditingController subCommitteeCT = TextEditingController();

  List<AgeModel> ageSelectionList=[];
  List<AgeModel> genderList=[];
  List<String> subcommitteeList=[];






  WardModel? selectedWard;
  bool done = false;
  List<WardModel> wards = [];
  List<WardModel> newWards = [];
  List<WardModel> allWards = [];
  List<WardModel> hideWards = [];
  Map<dynamic,dynamic> newWardsMap = {};
  Map<dynamic,dynamic> hideWardsMap = {};
  List<PaymentOptModel> paymentOptions = [];
  String mid = "HewFhH22025932253187";
  String upiAddress = "9048004320@paytm";
  String strAmountButton = "";
  String displayAmount = "";
  List<PanjayathModel> panjayathList=[];
  List<DistrictDropListModel> districtList=[];
  List<AssemblyDropListModel> assemblyList=[];
  List<AssemblyDropListModel> jsonAssemblyList=[];
  List<AssemblyDropListModel> baseAssemblyList=[];
  List<AssemblyDropListModel> baseHideAssemblyList=[];
  // List<AssemblyDropListModel> chipsetAssemblyList=[];
  List<AssemblyModel> booths=[];
  List<AssemblyModel> newBooths=[];
  List<AssemblyModel> allBooths=[];
  List<WardModel> chipsetWardList=[];
  List<WardModel> chipsetBoothList=[];
  PanjayathModel? selectedPanjayathChip;
  DistrictDropListModel? selectAssemblyChip;
  AssemblyModel? selectedAssemblyChip;
  List<String> paymentGateWays = [];
  String WImageByte ="ffff";
  int dhothiCounter = 0;
  int dhothiAmount = 0;
  bool shownameBool=false;
  String names='';

  int knmAmount=0;

  ///for receipt page
  DateTime donationTime = DateTime.now();
  String donorName = '';
  String donorNumber = '';
  String donorCommitty = '';
  String donorPlace = '';
  String donorID = '';
  String donorStatus = '';
  String donorAmount = '';
  String enrollerAdded = '';
  String donorApp = '';
  String? onOfButton = '';
  String donorReceiptPrinted = '';
  Uint8List? fileBytes;
  // var controller = CropController(
  //   aspectRatio: 1,
  //   defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  // );

  ///forWhatsapp status
  final ImagePicker picker = ImagePicker();
  File? statusImage;
  var whatsappStatus;
  String? gender;

  bool monthlyAmountAlert=false;




  ///payment gateway cashFree
  String stage = "TEST";
  String orderNote = "HADDIYA";
  String orderCurrency = "INR";
  String appId = "138690c1d12c4584a31312d667096831";
  String customerEmail = "sample@gmail.com";
  String notifyUrl = "https://spinecodes.in/";
  String paymentBankCode = "https://spinecodes.in/";
  String alertShowed="";
  bool isAlertShowed=false;
  List<dynamic> upiApps = [];

  ///bank cashFree
  List<BankModel> banks = [];
  List<BankModel> filteredBanks = [];

  ///card cashFree
  String cardHolderName = "";
  String cardNumber = "";
  String cvvCode = "";
  String expiryDate = "";

  ///upi cashFree
  TextEditingController upiIdEt = TextEditingController();


  ///bank details
  String acNo="";
  String ifsc="";
  String acName="";
  String acUpiId="";


  ///for receiptList
  TextEditingController name = TextEditingController();
  TextEditingController transactionID = TextEditingController();
  TextEditingController pinWardTC = TextEditingController();

  String  phonePinWard='OFF';
  String  paymentButton='';
  TextStyle styleOfAmountAlert = poppinsalertwhite; // White
  bool minimumbool=true;


  List<String>organisationList=[];
  TextEditingController organisationTC = TextEditingController();


  TextEditingController familyNameTC = TextEditingController();


  DonationProvider() {
    fetchSubCommityList();
    committyViewONOFF();
    fetchDatabaseWard();
    fetchDatabaseHideWard();
    fetchWard();
    fetchAllWards();
    // paymentOptions.add(PaymentOptModel("1", "assets/paytm.png", "Paytm"));
    // paymentOptions.add(PaymentOptModel("2", "assets/upi_logo.png", "Upi"));
    getUPIApps();
    fetchPaymentGateways();
    getSharedPrefName();
    lockReceiptChangeWard();
    // fetchAccountDetails();
    fetchPinWard();
    lockIosGooglePayButton();
    lockIosPhonePayButton();
    lockGooglePayIosButton();
    lockPhonePayIosButton();
    GooglePayButtonIos();
    IosPhonePayButtonNew();
    iosPaytmPayButtonNew();
    // getOrganisation();
  }


  // void otherPaymentButton() {
  //   mRoot.child("OTHER PEYMENT BUTTON").onValue.listen((DatabaseEvent event) {
  //     Map<dynamic, dynamic> map = event.snapshot.value as Map;
  //     paymentButton = map['VALUE'].toString();
  //     notifyListeners();
  //   });
  // }



  void setTextColor(TextStyle textStyle){
    styleOfAmountAlert = textStyle;
    notifyListeners();
  }









  void addAges(){
    ageSelectionList.add(AgeModel('Below 25', false));
    ageSelectionList.add(AgeModel('25-35', false));
    ageSelectionList.add(AgeModel('35-50', false));
    ageSelectionList.add(AgeModel('Above 50', false));

    genderList.add(AgeModel('Male', false));
    genderList.add(AgeModel('Female', false));
    genderList.add(AgeModel('Other', false));
    notifyListeners();
  }


  void onCountChange(String text) {

    notifyListeners();
  }
  void onComplete(double amt) {
    if(amt>=138){

    }else{

    }

    notifyListeners();
  }

  String  iosGooglePayButton='OFF';
  GooglePayButtonIos(){
    mRoot.child('0').child('iosgooglepayButtonNew').onValue.listen((event) {
      if(event.snapshot.exists){
        print(event.snapshot.value.toString()+' DWHJBEDHBDa');
        iosGooglePayButton=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }

  bool isLoadingPaymentPage=false;

  void loading(){
    print("IOs Payment ON");
    isLoadingPaymentPage=true;
    notifyListeners();
  }
  void loadingOff(){
    print("IOs Payment OFF");

    isLoadingPaymentPage=false;
    notifyListeners();
  }

  String  iosPhonePayButtonNew='OFF';
  IosPhonePayButtonNew(){
    mRoot.child('0').child('iosPhonepayButtonNew').onValue.listen((event) {
      if(event.snapshot.exists){
        iosPhonePayButtonNew=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }


  String iosPaytmPayButton="OFF";
  iosPaytmPayButtonNew(){
    mRoot.child('0').child('iosPayTmButtonNew').onValue.listen((event) {
      if(event.snapshot.exists){
        iosPaytmPayButton=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }

  void funPaytm(BuildContext context) async {
    String orderID = mRoot
        .push()
        .key
        .toString();


    String callBackUrl = "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=" +
        orderID;
    var url = 'https://us-central1-candidatec.cloudfunctions.net/widgets/users';

    var body = json.encode({
      "OrderID": orderID,
      "Value": amountTC.text.replaceAll(',', ''),
      "callbackUrl": callBackUrl,
      "User": "122",

    });

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );
      var responseData = json.decode(response.body);


      String txnToken = responseData['body']['txnToken'].toString();

      var paytmResponse = AllInOneSdk.startTransaction(
          mid,
          orderID,
          "1.00",
          txnToken,
          callBackUrl,
          true,
          true);
      paytmResponse.then((value) {
        ///success
        upDatePayment("SUCCESS", value.toString(), context, orderID, 'Paytm','',"");
      }).catchError((onError) {
        upDatePayment("FAILED", onError.toString(), context, orderID, 'Paytm','',"");

        ///failed

      });
    } catch (e) {
    }
  }

  // addNumber(){
  //   HashMap<String, Object> map = HashMap();
  //  map["PhoneNumber2"] = '+919744678000';
  //   mRoot.child("0").update(map);
  // }
  var outputDayNode = DateFormat('d/MM/yyy');
  upDatePayment(String status, String response, BuildContext context, String orderID, String app, String upiIdP,String appver) async {
    callNextReplacement(DonationSuccess(), context);
    // var outputDayNode = DateFormat('yyyy_M_d');
    String name = nameTC.text;
    DateTime now =DateTime.now();
    String timeString="";
    timeString=DateFormat('d/MM/yyy').format(now);
    // TimeStampModel? timeStampModel=await TimeService().getTime();
    //
    // if(timeStampModel!=null){
    //   now = timeStampModel.datetime.toLocal();
    //   timeString = outputDayNode.format(now).toString();
    // }
    //
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String packageVersion = packageInfo.version;



    String amount=kpccAmountController.text.toString().replaceAll(',', '');


    String district = '';
    String assembly = '';
    String panchayath = '';
    String wardName = '';
    String wardNumber = '';


    HashMap<String, Object> map = HashMap();

    map["Receipt Status"]="Viewed";
    map["Amount"] = amount;
    map["Responds"] = response;
    map["Name"] = name;
    map["PhoneNumber"] = phoneTC.text;
    map["SubCommitty"] = subCommitteeCT.text;
    map["Time"] = now.millisecondsSinceEpoch.toString();
    map["Payment_Date"] = timeString;
    map["ID"] = orderID;

    if (status == "SUCCESS") {
      map["Status"] = "Success";
      map["Receipt Status"]="notViewed";
    } else {
      map["Status"] = "Failed";
    }

    if (selectedWard != null) {
      district = selectedWard!.district;
      assembly = selectedWard!.assembly;
      panchayath = selectedWard!.panchayath;
      wardName = selectedWard!.wardName;
      wardNumber = selectedWard!.wardNumber;
    } else{
      district = 'GENERAL';
      assembly = 'GENERAL';
      panchayath = 'GENERAL';
      wardName = 'GENERAL';
      wardNumber = 'GENERAL';
    }

    map["district"] = district;
    map["assembly"] = assembly;
    map["panchayath"] = panchayath;
    map["wardName"] = wardName;
    map["wardNumber"] = wardNumber;
    map["Ward"] = wardName;
    map["PaymentApp"] = app;

    if(Platform.isIOS){
      map["Platform"] = "IOS";
    }else if(Platform.isAndroid){
      map["Platform"] = "ANDROID";
    }
    else{
      map["Platform"] = "NIL";
    }

    map["UpiID"] = "";
    map["RefNo"] = "App";
    map["PaymentUpi"] = upiIdP;
    map["PrintStatus"] = 'Not Printed';
    map["AppVersion"] = appver;
    // String? strDeviceID = "";

    // if(Platform.isAndroid){
    //   strDeviceID= await DeviceInfo().fun_initPlatformState();
    //
    // }else if(Platform.isIOS){
    //   try {
    //     strDeviceID = await UniqueIdentifier.serial;
    //   } on PlatformException {
    //     strDeviceID = 'Failed to get Unique Identifier';
    //   }
    //
    // }else{
    //   print("");
    // }

    String? strDeviceID= "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }
    map["DeviceId"] = strDeviceID!;

    if(shownameBool){
      map['NameShowStatus']='NO';
    }else{
      map['NameShowStatus']='YES';
    }
    String dayNode = 'Y${now.year}/M${now.month}/D${now.day}/H${now.hour}';

    mRoot.child("Payment").child(dayNode).child("HourEntry").child(orderID).set(map);

    db.collection("MonitorNode").doc(orderID).set(map);
    String ref = 'Payment/$dayNode/HourEntry/$orderID';
    mRoot.child("PaymentDetails").child(orderID).child("OrderRef").set(ref);
    if (!kIsWeb) {

      // mRoot.child("UserPayments").child(strDeviceID).child(orderID).child("OrderRef").set(ref);

    }


    if (status == "SUCCESS") {
      print("successsss1111");




      HashMap<String, Object> dataMap =map;

      dataMap["Amount"] = double.parse(amount);
      dataMap['Time']=now.millisecondsSinceEpoch;
      dataMap['LastForDigits']=orderID.substring(orderID.length-4,orderID.length);
      dataMap['Receipt Status']="notViewed";
      db.collection('Payments').doc(orderID).set(dataMap);
      db.collection('Attempts').doc(orderID).update({"Status":"Success"});



    }

    getDonationDetailsForReceipt(orderID);


    // amountTC.clear();
    // nameTC.clear();
    // phoneTC.clear();
    // wardTC.clear();
    // selectedWard = null;
    notifyListeners();
  }

  // void delete(){
  //   mRoot.child('UserPayments').remove();
  // }

  // stopDhoti(){
  //   HashMap<String, Object> stopMap = HashMap();
  //   stopMap["AppVersion"]='';
  //   mRoot.child('0').update(stopMap);
  // }



  fetchWard() async {
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());

    Map <dynamic, dynamic> map = jsonResponse as Map;
    wards.clear();
    map.forEach((key, value) {
      wards.add(WardModel(
          value['district'].toString(), value['assembly'].toString(),value['panchayath'].toString(),
          value['wardname'].toString(), value['wardname'].toString()));

    });
  }
  Future<void> fetchAllWards() async {
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());


    mRoot.child('NewWards').onValue.listen((databaseEvent) {

      Map <dynamic, dynamic> map = jsonResponse as Map;
      wards.clear();
      map.forEach((key, value) {
        wards.add(WardModel(
            value['district'].toString(),value['assembly'].toString(), value['panchayath'].toString(),
            value['wardname'].toString(), value['wardname'].toString()));

      });

      newWards.clear();
      if (databaseEvent.snapshot.value != null) {
        newWardsMap= databaseEvent.snapshot.value as Map;
        Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

        map.forEach((key, value) {
          newWards.add(WardModel(
              value['district'].toString(), value['assembly'].toString(),value['panchayath'].toString(),
              value['wardname'].toString(), value['wardnumber'].toString()));
        });
        print(newWards.length.toString()+"qqwwdedj44");

        notifyListeners();
      }
      allWards=wards+newWards;
      notifyListeners();

      print("dfs2222");
      // mRoot.child('hidewards').onValue.listen((databaseEvent) {
      //   print("cfyfyg");
      //   hideWards.clear();
      //   if (databaseEvent.snapshot.value != null) {
      //     print("wiseeeeee");
      //     hideWardsMap= databaseEvent.snapshot.value as Map;
      //     Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;
      //     print("wiseeeeee");
      //     print(map.toString()+"sdfcsnh");
      //
      //     map.forEach((key, value) {
      //       print(key.toString()+"sdfdf222");
      //       hideWards.add(WardModel(
      //           value['district'].toString(), value['assembly'].toString(),value['panchayath'].toString(),
      //           value['wardname'].toString(), value['wardnumber'].toString()));
      //       notifyListeners();
      //
      //     });
      //     print(hideWards.length.toString()+"sdsdqwe");
      //
      //     allWards=wards+newWards;
      //
      //     print(hideWards.length.toString()+"sdsdqwewwwww666");
      //     print(wards.length.toString()+"sdsdqwewwwww111");
      //     print(newWards.length.toString()+"sdsdqwewwwww555");
      //     print(allWards.length.toString()+"sdsdqwewwwww55522");
      //
      //     allWards.removeWhere((item1) => hideWards.any((item2) => (item1.wardName == item2.wardName && item1.panchayath == item2.panchayath && item1.assembly == item2.assembly && item1.district == item2.district )));
      //
      //
      //     notifyListeners();
      //   }else{
      //     allWards=wards+newWards;
      //
      //   }
      //
      // });





    });






  }


  // fetchAllBooth() async {
  //   print("warddddloop22");
  //
  //   var jsonText = await rootBundle.loadString('assets/KPCC_JSON.json');
  //   var jsonResponse = json.decode(jsonText.toString());
  //
  //
  //   mRoot.child('NewWards').onValue.listen((databaseEvent) {
  //
  //     Map <dynamic, dynamic> map = jsonResponse as Map;
  //     booths.clear();
  //     map.forEach((key, value) {
  //       booths.add(AssemblyModel(value['District'].toString(), value['Assembly'].toString()));
  //
  //     });
  //
  //     newBooths.clear();
  //     if (databaseEvent.snapshot.value != null) {
  //       newWardsMap= databaseEvent.snapshot.value as Map;
  //       Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;
  //
  //       map.forEach((key, value) {
  //         newBooths.add(AssemblyModel(value['District'].toString(), value['Assembly'].toString(),));
  //       });
  //
  //       notifyListeners();
  //     }
  //
  //     allBooths=booths+newBooths;
  //
  //   });
  //
  //
  //
  // }

  void onSelectWard(WardModel? ward) {
    selectedWard = ward;

    if (ward != null) {
      wardTC.text = ward.wardName;
      notifyListeners();
    }
    notifyListeners();

  }
  // void onSelectAssembly(AssemblyDropListModel? assembly) {
  //   selectedAssembly = assembly;
  //
  //   if (assembly != null) {
  //     assemblyCt.text = assembly.assembly;
  //     notifyListeners();
  //   }
  //   notifyListeners();
  //
  // }

  void fetchDatabaseWard() {
    mRoot.child('NewWards').onValue.listen((databaseEvent) {
      newWards.clear();
      if (databaseEvent.snapshot.value != null) {
        newWardsMap= databaseEvent.snapshot.value as Map;
        Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

        map.forEach((key, value) {
          newWards.add(WardModel(
              value['district'].toString(), value['panchayath'].toString(),value['assembly'].toString(),
              value['wardname'].toString(), value['wardnumber'].toString()));
        });

        notifyListeners();
      }
    });


  }
  void fetchDatabaseHideWard() {
    mRoot.child('hidewards').onValue.listen((databaseEvent) {
      newWards.clear();
      if (databaseEvent.snapshot.value != null) {
        hideWardsMap= databaseEvent.snapshot.value as Map;
        Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

        map.forEach((key, value) {
          hideWards.add(WardModel(
              value['district'].toString(), value['panchayath'].toString(),value['assembly'].toString(),
              value['wardname'].toString(), value['wardnumber'].toString()));
        });

        notifyListeners();
      }
    });


  }

  // void fetchDonationDetails(String orderID) {
  //   print("fetch worksssss");
  //   donationTime = DateTime.now();
  //   donorName = '';
  //   donorNumber = '';
  //   donorPlace = '';
  //   donorStatus = '';
  //   donorReceiptPrinted = 'notPrinted';
  //   donorID = orderID;
  //   mRoot.child('PaymentDetails').child(orderID).once().then((dataSnapshot) {
  //
  //     if (dataSnapshot.snapshot.value != null) {
  //       Map<dynamic, dynamic> map = dataSnapshot.snapshot.value as Map;
  //       mRoot.child(map['OrderRef']).onValue.listen((event) {
  //         if (event.snapshot.value != null) {
  //           Map<dynamic, dynamic> detailsMap = event.snapshot.value as Map;
  //           donationTime = DateTime.now();
  //           donorName = '';
  //           donorNumber = '';
  //           donorPlace = '';
  //           donorID = '';
  //           donorReceiptPrinted = 'notPrinted';
  //
  //           donationTime = DateTime.fromMillisecondsSinceEpoch(int.parse(detailsMap['Time'].toString()));
  //           donorName = detailsMap['Name'].toString();
  //           donorNumber = detailsMap['PhoneNumber'].toString();
  //           donorPlace = detailsMap['Ward'].toString();
  //           donorID = orderID;
  //           donorStatus = detailsMap['Status'].toString();
  //           donorAmount = detailsMap['Amount'].toString();
  //           donorApp = detailsMap['PaymentApp'].toString();
  //           if(detailsMap['Print Status']!=null){
  //             donorReceiptPrinted=detailsMap['Print Status'].toString();
  //           }
  //
  //           print("app name"+donorApp);
  //
  //           notifyListeners();
  //         }
  //       });
  //     }
  //   });
  // }

  getDonationDetailsForReceipt(String paymentID){
    print("AAAAAAAAAAAAAAAAAAAAAAA11");
    donationTime = DateTime.now();
    donorName = '';
    donorNumber = '';
    donorPlace = '';
    donorStatus = '';
    donorCommitty='';
    donorReceiptPrinted = 'notPrinted';
    donorID = paymentID;
    enrollerAdded='';
    db.collection("MonitorNode").doc(paymentID).get().then((value){
      if(value.exists){
        Map<dynamic,dynamic> maappp=value.data() as Map;
        donationTime=DateTime.fromMillisecondsSinceEpoch(int.parse(value.get("Time").toString()));
        donorName=value.get("Name").toString();
        donorNumber=value.get("PhoneNumber").toString();
        if(maappp.containsKey("SubCommitty")){
          donorCommitty=maappp["SubCommitty"].toString();
        }
        donorPlace=value.get("Ward").toString();
        donorID = paymentID;
        donorStatus = value.get("Status").toString();
        ///ameen commented

        // donorStatus="Success";
        print(maappp["EnrollerId"].toString()+' OFRMOFMR');
        enrollerAdded=maappp["EnrollerId"]??"";
        print(enrollerAdded+' IENFRO '+paymentID);
        donorAmount = double.parse(value.get("Amount").toString()).toStringAsFixed(0);
        donorApp = value.get("PaymentApp").toString();
        notifyListeners();
      }
    });
  }


  createImage(String from, String donorName,ScreenshotController screenshotController) async {
    String imgName=DateTime.now().millisecondsSinceEpoch.toString();
    // ScreenshotController screenshotController = ScreenshotController();
    await screenshotController
        .capture().then((Uint8List? image) async {
      if (image != null) {
        printStatus(donationTime.millisecondsSinceEpoch.toString(),donorID);
        if(!kIsWeb){
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/$imgName.png').create();
          await imagePath.writeAsBytes(image);


          if (from == 'Print') {
            print('kasmdlams');
            print(imagePath);
            OpenFile.open(imagePath.path);
          } else {
            print('shater');

            // Share.shareFiles([imagePath.path],);
            await Share.shareXFiles([XFile(imagePath.path)]);
          }
        }
        else{
          ByteData bytes=ByteData.view(image.buffer);

          var blob = web_file.Blob([bytes], 'image/png', 'native');

          var anchorElement = web_file.AnchorElement(
            href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
          )..setAttribute("download", "data.png")..click();
        }

      }


      // Handle captured image
    });
  }

  Future getImageFromCamera(BuildContext context) async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera, imageQuality: 15);
    if (pickedFile != null) {
      statusImage = File(pickedFile.path);
      fileBytes = await statusImage!.readAsBytes();

      // controller= controller = CropController(
      //   aspectRatio: 1,
      //   defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
      // );
      // callNext(const CropPage(title: "Crop Image"), context);
    } else {
      print('No image selected.');
    }
    if (pickedFile!.path.isEmpty) retrieveLostData();
    notifyListeners();
  }


  Future getImageFromGallery(BuildContext context) async {

    if(!kIsWeb) {

      print("Reached 01");
      final pickedFile =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
      print("Reached 02");
      if (pickedFile != null) {
        statusImage = File(pickedFile.path);
        fileBytes = await statusImage!.readAsBytes();
        print("Reached 03");
        // controller = CropController(
        //   aspectRatio: 1,
        //   defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
        // );

        print("Reached 1");
        // callNext(const CropPage(title: "Crop Image"), context);
      } else {
      }
      if (pickedFile!.path.isEmpty) retrieveLostData();
    }else{
      getImageWeb(context);

    }
    notifyListeners();
  }


  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      statusImage = File(response.file!.path);
      fileBytes = await statusImage!.readAsBytes();
      notifyListeners();
    }
  }

  Future<void> shareImageStatus(ScreenshotController screenshotControllerStatus) async {
    print("HHHHHHHHHHHHHH"+screenshotControllerStatus.toString());

    await screenshotControllerStatus.capture().then((Uint8List? image) async {
      print("HHHHHHHHHHHHHH555"+ image.toString());

      if (image != null) {

        printStatus(donationTime.millisecondsSinceEpoch.toString(),donorID);
        if(!kIsWeb){
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/image.png').create();
          await imagePath.writeAsBytes(image);
          print("sfwsdfgfdsg"+imagePath.toString());
          /// Share Plugin
          // await Share.shareFiles([imagePath.path]);
          await Share.shareXFiles([XFile(imagePath.path)]);
        }else{
          ByteData bytes=ByteData.view(image.buffer);

          var blob = web_file.Blob([bytes], 'image/png', 'native');

          var anchorElement = web_file.AnchorElement(
            href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
          )..setAttribute("download", "data.png")..click();
        }

      }

      // Handle captured image
    });
  }

  Future<void> shareImageForPoster(ScreenshotController screenshotControllerStatus) async {
    print("HHHHHHHHHHHHHH"+screenshotControllerStatus.toString());

    await screenshotControllerStatus.capture().then((Uint8List? image) async {
      print("HHHHHHHHHHHHHH555"+ image.toString());

      if (image != null) {

        // printStatus(donationTime.millisecondsSinceEpoch.toString(),donorID);
        if(!kIsWeb){
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/image.png').create();
          await imagePath.writeAsBytes(image);
          print("sfwsdfgfdsg"+imagePath.toString());
          /// Share Plugin
          // await Share.shareFiles([imagePath.path]);
          await Share.shareXFiles([XFile(imagePath.path)]);
        }else{
          ByteData bytes=ByteData.view(image.buffer);

          var blob = web_file.Blob([bytes], 'image/png', 'native');

          var anchorElement = web_file.AnchorElement(
            href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
          )..setAttribute("download", "data.png")..click();
        }

      }

      // Handle captured image
    });
  }
  // Future<void> onTap(ApplicationMeta app,BuildContext context) async {
  //   String orderID=mRoot.push().key.toString();
  //   String _url=getUpiURL(upiAddress, 'Ashhar', '5812',DateTime.now().millisecondsSinceEpoch.toString(), orderID, "Check", "1", "INR", "https://spinecodes.in/");
  //   var result = await launch(_url);
  //   debugPrint(result.toString());
  //   if (result ==true) {
  //     print("Done");
  //   } else if (result ==false){
  //     print("Fail");
  //   }
  //
  //   // String orderID=mRoot.push().key.toString();
  //   //
  //   //
  //   // final transactionRef = Random.secure().nextInt(1 << 32).toString();
  //   //
  //   // final a = await UpiPay.initiateTransaction(
  //   //   amount: amountTC.text.replaceAll(',', ''),
  //   //   app: app.upiApplication,
  //   //   receiverName: 'Ashhar',
  //   //   receiverUpiAddress: upiAddress,
  //   //   transactionRef: transactionRef,
  //   //   transactionNote: 'UPI Payment',
  //   //
  //   //   // merchantCode: '7372',
  //   // );
  //   // if(a.status.toString()=='UpiTransactionStatus.success'){
  //   //   upDatePayment('Success', "", context, orderID,'UPI');
  //   //
  //   // }else{
  //   //   upDatePayment('Failed', "", context, orderID,'UPI');
  //   //
  //   // }
  //
  //
  //
  //
  //
  //
  // }


  String getUpiURL(String payeeAddress, String payeeName, String payeeMCC,
      String trxnID, String trxnRefId,
      String trxnNote, String payeeAmount, String currencyCode, String refUrl) {
    String UPI = "upi://pay?pa=" + payeeAddress + "&pn=" + payeeName
        + "&mc=" + payeeMCC + "&tid=" + trxnID + "&tr=" + trxnRefId
        + "&tn=" + trxnNote + "&am=" + payeeAmount + "&cu=" + currencyCode
        + "&url=" + refUrl + '/' + trxnID;
    return UPI.replaceAll(" ", "+");
  }


  Future<String> cashFree(String orderId, String amount) async {
    // var client = http.Client();
    // var body = json.encode({
    //   'orderId': orderId,
    //   'orderAmount': amount,
    //   "orderCurrency": "INR"
    // });
    //
    // var response = await client.post(
    //     Uri.parse('https://test.cashfree.com/api/v2/cftoken/order'),
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'x-client-id': '138690c1d12c4584a31312d667096831',
    //       'x-client-secret': '5f9e892b82c15b6074622a948d172f467f565cbf'
    //     },
    //     body: body
    // );
    // var jsonMap = json.decode(response.body);
    //
    // var token = Cashfreemodel
    //     .fromJson(jsonMap)
    //     .cftoken;

    // return token;

    var client=http.Client();
    var url = 'https://us-central1-haddiyya-1b794.cloudfunctions.net/widgets/users';
    var body = json.encode({
      "OrderID":orderId,
      "orderAmount": amount,
    });
    final response = await client.post(Uri.parse(url), body: body,
      headers: {'Content-type': "application/json"},
    );
    var responseData = json.decode(response.body);
    var token =Cashfreemodel.fromJson(responseData).cftoken;
    return token;

  }
  getUPIApps() {
    if(!kIsWeb){
      CashfreePGSDK.getUPIApps().then((value) {
        if(value != null && value.isNotEmpty) {
          upiApps=value;
          notifyListeners();


        }
      });
    }

  }

  Future<void> seamlessUPIIntent(item,BuildContext context) async {
    String orderId = transactionID.text;

    String tokenData = await cashFree(orderId,amountTC.text.replaceAll(',', ''));

    String name=nameTC.text!=''?nameTC.text:'No Name';
    String phone=phoneTC.text!=''?phoneTC.text:'0000000000';


    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": amountTC.text.replaceAll(',', ''),
      "customerName": name,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": phone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,
      // For seamless UPI Intent
      "appName": item['id']
    };

    CashfreePGSDK.doUPIPayment(inputParams)
        .then((value) {
      print(value!['txStatus']);
      upDatePayment(value['txStatus'], value.toString(), context, orderId, item['displayName'].toString()+" CashFree",''," ");
    });
  }

  Future<void> seamlessNetbankingPayment(BuildContext context,String bankCode) async {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String tokenData = await cashFree(orderId,amountTC.text.replaceAll(',', ''));

    String name=nameTC.text!=''?nameTC.text:'No Name';
    String phone=phoneTC.text!=''?phoneTC.text:'0000000000';

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": amountTC.text.replaceAll(',', ''),
      "customerName": name,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": phone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,

      // EXTRA THINGS THAT NEEDS TO BE ADDED
      "paymentOption": "nb",
      "paymentCode": bankCode, // Find Code here https://docs.cashfree.com/docs/net-banking
    };



    CashfreePGSDK.doPayment(inputParams)
        .then((value) {
      Map<dynamic,dynamic> detailsMap=value as Map;
      if(detailsMap['txStatus']!='CANCELLED'){
        upDatePayment(value['txStatus'], value.toString(), context, orderId, "Net Banking CashFree",'',"");
      }
    }
    );
  }

  getBanks() async {
    var jsonText = await rootBundle.loadString('assets/bank_list.json');
    var jsonResponse = json.decode(jsonText.toString());
    List tmpWards =jsonResponse;
    banks.clear();
    for (var element in tmpWards) {
      banks.add(BankModel(element['Code'], element['Bank']));
      filteredBanks.add(BankModel(element['Code'], element['Bank']));
      notifyListeners();
    }
    notifyListeners();


  }

  void payAmountButton(String text){
    strAmountButton=text;
    notifyListeners();
  }

  void hideKeyboard(){
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // notifyListeners();

  }

  void onCardInputChange(CreditCardModel data) {
    cardHolderName=data.cardHolderName;
    expiryDate=data.expiryDate;
    cardNumber=data.cardNumber;
    cvvCode=data.cvvCode;
    notifyListeners();
  }
  Future<void> seamlessCardPayment(BuildContext context) async {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String tokenData = await cashFree(orderId,amountTC.text.replaceAll(',', ''));

    String name=nameTC.text!=''?nameTC.text:'No Name';
    String phone=phoneTC.text!=''?phoneTC.text:'0000000000';
    String monthExp=expiryDate.substring(0,expiryDate.indexOf("/"));
    String yearExp="20"+expiryDate.substring(expiryDate.indexOf("/")+1,expiryDate.length);

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": amountTC.text.replaceAll(',', ''),
      "customerName": name,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": phone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,

      "paymentOption": "card",
      "card_number": cardNumber.replaceAll(' ', ''),
      "card_expiryMonth": monthExp,
      "card_expiryYear": yearExp,
      "card_holder": cardHolderName,
      "card_cvv": cvvCode
    };

    CashfreePGSDK.doPayment(inputParams)
        .then((value) {
      Map<dynamic,dynamic> detailsMap=value as Map;
      if(detailsMap['txStatus']!='CANCELLED'){
        upDatePayment(value['txStatus'], value.toString(), context, orderId, "Card CashFree",'',"");

      }
    }
    );
  }
  Future<void> getSharedPref() async {
    SharedPreferences userPreference = await SharedPreferences.getInstance();
    if (userPreference.getString("AlertShowed") != null ) {
      isAlertShowed=true;
    } else {
      isAlertShowed=false;
    }
  }

  void onFilterBank(String value) {
    filteredBanks = banks
        .where((element) => element.bank.toLowerCase()
        .contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }



  Future<void> seamlessUPIPayment(BuildContext context,String upiID) async {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String tokenData = await cashFree(orderId,amountTC.text.replaceAll(',', ''));

    String name=nameTC.text!=''?nameTC.text:'No Name';
    String phone=phoneTC.text!=''?phoneTC.text:'0000000000';

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": amountTC.text.replaceAll(',', ''),
      "customerName": name,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": phone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,

      // EXTRA THINGS THAT NEEDS TO BE ADDED
      "paymentOption": "upi",
      "upi_vpa": upiID
    };

    CashfreePGSDK.doPayment(inputParams)
        .then((value) {
      Map<dynamic,dynamic> detailsMap=value as Map;
      if(detailsMap['txStatus']!='CANCELLED'){
        upDatePayment(value['txStatus'], value.toString(), context, orderId, "UpiLinking CashFree",'',"");
      }
    }
    );

  }
  void fetchPaymentGateways() {
    mRoot.child("PaymentGateways").onValue.listen((event) {
      paymentGateWays.clear();
      if(event.snapshot.exists){
        Map<dynamic,dynamic> map =event.snapshot.value as Map;
        map.forEach((key, value) {
          paymentGateWays.add(value.toString());
          notifyListeners();
        });
      }
      notifyListeners();

    });
  }

  // Future<void> payUPaymentGateWay(BuildContext context,String amount,String name,String phone) async {
  //   finish(context);
  //   String txnID=DateTime.now().millisecondsSinceEpoch.toString();
  //   var arguments={'amount':amount,'phone':phone,'name':name,'txnID':txnID};
  //
  //   if(Platform.isAndroid){
  //     String status=await platformChanel.invokeMethod('openPayu',arguments);
  //
  //
  //     if(status!=null){
  //       upDatePayment(status, "no response", context, txnID, "HDFC",'');
  //     }
  //   }
  //
  // }


  Future<void> upiIntent(BuildContext context,String amount,String name,String phone,String app,String appver) async {

    print('what is name   :  '+nameTC.text+amount);

    String txnID=transactionID.text;
    UpiModel upiModel= await getUpiUri(app, amount.replaceAll(',', ''),txnID);
    var arguments={'Uri':upiModel.uri,};

    if(Platform.isAndroid){
      String status=await platformChanel.invokeMethod(app,arguments);
      // status = "Success";

      if(status!='NoApp'){

        if(status!='FAILED'){
          print("code isss here");
          upDatePayment("SUCCESS", status, context, txnID, app,upiModel.upiId,appver);
        }else{
          print("code isss here22222");
          upDatePayment("FAILED", "no response", context, txnID, app,upiModel.upiId,appver);

          ///ameen commented
          // upDatePayment("SUCCESS", status, context, txnID, app,upiModel.upiId,appver);
        }

      }else{
        String url='';
        if(app=='BHIM'){
          url='https://play.google.com/store/apps/details?id=in.org.npci.upiapp&hl=en_IN&gl=US';
        }else if(app=='GPay'){
          url='https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user&hl=en_IN&gl=US';
        }else if(app=='Paytm'){
          url='https://play.google.com/store/apps/details?id=net.one97.paytm&hl=en_IN&gl=US';
        }else if(app=='PhonePe'){
          url='https://play.google.com/store/apps/details?id=com.phonepe.app&hl=en_IN&gl=US';
        }
        _launchURL(url);
      }
    }

  }
  shareQrToApp() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/upiqrcode.jpeg');
      final Uint8List list = bytes.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/upiqrcode.jpeg').create();
      file.writeAsBytesSync(list);
      var arguments={'path':'upiqrcode.jpeg','app':'com.google.android.apps.nbu.paisa.user'};

      await platformChanel.invokeMethod('ShareQr',arguments);


    } catch (e) {
    }
  }

  Future<void> sendMessage() async {
    String apiKey = "apikey=" "8YMRueR+cPI-m0xemFHppCTknkiCUGj80K4G1veO9N";
    String c;
    c="Redeem Process is success...! , you have received "" Point as Cash , and you have "" Points remaining\n" "Thank you\n" "...HOTEL DELICIA...";
    String message = "&message=" + c;
    String sender = "&sender=" "DELCIA";
    String numbers = "&numbers=" "918086589166";
    String data = apiKey + numbers + message + sender;

    var postUri = Uri.parse("https://api.textlocal.in/send/?");
    var request =  http.MultipartRequest("POST", postUri);
    List<int> bytes = utf8.encode(data);
    request.files.add( http.MultipartFile.fromBytes('file',bytes));
    Map<String, String> headers = {
      'Content-Length':utf8.encode(data).length.toString()
    };
    request.headers.addAll(headers);


    request.send().then((response) {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Uploaded!");
        }
      }

    });


  }

  void copyToClipBoard(BuildContext context,text) {

    Clipboard.setData(ClipboardData(text:text));
    final snackBar = SnackBar(
        backgroundColor:myBlack ,
        duration: const Duration(milliseconds: 2000),
        content: Text("Copied to clipboard", textAlign: TextAlign.center,softWrap: true,
          style: snackbarStyle,
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  void changeWhatsappImage(var cropper) async{
    whatsappStatus=cropper;
    WImageByte = "true";
    notifyListeners();
  }

  Future<void> shareQr() async {
    final bytes = await rootBundle.load('assets/upiqrcode.jpeg');
    final list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/image.jpg').create();
    file.writeAsBytesSync(list);
    // Share.shareFiles([(file.path)], text: '');
    await Share.shareXFiles([XFile(file.path)]);

  }

  Future<void> getImageWeb(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      fileBytes = result.files.first.bytes;
      // callNext(const CropPage(title: "Crop Image"), context);

      notifyListeners();

      // Upload file
    }
  }
  Future<void> getSharedPrefName() async {
    SharedPreferences userPreference = await SharedPreferences.getInstance();
    if (userPreference.getString("ReceiptName") != null ) {
      name.text=userPreference.getString("ReceiptName")!;
    }
  }

  void selectPinWard(WardModel wardName){
    pinWardTC.text=wardName.wardName;
    selectedWard=wardName;
    notifyListeners();
  }


  void addPinWard(BuildContext context,String timeStamp,String transactionID,String amount, PaymentDetails item){
    HashMap<String, Object> wardData = HashMap();
    wardData["Ward"]=pinWardTC.text;
    wardData["wardName"]=pinWardTC.text;
    wardData["district"]=selectedWard!.district;
    wardData["assembly"]=selectedWard!.assembly;
    wardData["panchayath"]=selectedWard!.panchayath;
    wardData["wardNumber"]=selectedWard!.wardNumber;
    db.collection("Payments").doc(transactionID).get().then((value) {
      if (value.exists) {
        db.collection('Payments').doc(transactionID).set(wardData,SetOptions(merge: true));
        db.collection("MonitorNode").doc(transactionID).set(wardData, SetOptions(merge: true));

        print('${selectedWard!.district}_${selectedWard!.panchayath}_${selectedWard!.wardName}'.toString()+"yggyusysyg");
        db.collection('WardTotalAmount').doc('${selectedWard!.district}_${selectedWard!.panchayath}_${selectedWard!.wardName}').set({"Amount": FieldValue.increment(double.parse(amount)),"TRANSACTION_COUNT": FieldValue.increment(1)},SetOptions(merge: true));
        notifyListeners();
        print('${item.district}_${item.panchayath}_${item.wardName}'.toString()+"yttyfty");

        db.collection('WardTotalAmount').doc('${item.district}_${item.panchayath}_${item.wardName}').set({"Amount": FieldValue.increment(-double.parse(amount)),"TRANSACTION_COUNT": FieldValue.increment(-1)},SetOptions(merge: true));
        notifyListeners();
      }
    });

    if(selectedWard!.panchayath!=item.panchayath) {
      db.collection('PANCHAYATH_TOTAL').doc(
          '${selectedWard!.district}_${selectedWard!.assembly}_${selectedWard!
              .panchayath}').set(
          {"AMOUNT": FieldValue.increment(double.parse(amount)),"TRANSACTION_COUNT": FieldValue.increment(1),},
          SetOptions(merge: true));
      db.collection('PANCHAYATH_TOTAL').doc(
          '${item.district}_${item.assembly}_${item.panchayath}').set(
          {"AMOUNT": FieldValue.increment(-double.parse(amount)),"TRANSACTION_COUNT": FieldValue.increment(-1),},
          SetOptions(merge: true));
      notifyListeners();

      if (selectedWard!.assembly != item.assembly) {
        db.collection('ASSEMBLY_TOTAL').doc(
            '${selectedWard!.district}_${selectedWard!.assembly}').set(
            {"AMOUNT": FieldValue.increment(double.parse(amount)),"TRANSACTION_COUNT": FieldValue.increment(1),},
            SetOptions(merge: true));
        db.collection('ASSEMBLY_TOTAL').doc(
            '${item.district}_${item.assembly}').set(
            {"AMOUNT": FieldValue.increment(-double.parse(amount)),"TRANSACTION_COUNT": FieldValue.increment(-1),},
            SetOptions(merge: true));
        notifyListeners();

        if (selectedWard!.district != item.district) {
          db.collection('DISTRICTS_TOTAL').doc(selectedWard!.district).set(
              {"AMOUNT": FieldValue.increment(double.parse(amount)),"TRANSACTION_COUNT": FieldValue.increment(1),},
              SetOptions(merge: true));
          db.collection('DISTRICTS_TOTAL').doc(item.district).set(
              {"AMOUNT": FieldValue.increment(-double.parse(amount)),"TRANSACTION_COUNT": FieldValue.increment(-1),},
              SetOptions(merge: true));
          notifyListeners();
        }
      }
    }



    notifyListeners();

    HomeProvider homeProvider =
    Provider.of<HomeProvider>(context, listen: false);
    homeProvider.fetchHistoryFromFireStore();

//     homeProvider.searchPayments(
//         transactionID, context);
// finish(context);
//     notifyListeners();
  }
// void addPinBooth(BuildContext context,String timeStamp,String transactionID,String amount, PaymentDetails item){
//
//
//
//
//   HashMap<String, Object> wardData = HashMap();
//     wardData["district"]=selectedWard!.district;
//     wardData["assembly"]=selectedWard!.assembly;
//     wardData["block"]=selectedWard!.block;
//     wardData["mandalam"]=selectedWard!.mandalam;
//     // wardData["booth"]=pinWardTC.text;
//     wardData["booth"]=selectedWard!.booth;
//
//
//
//
//   db.collection("Payments").doc(transactionID).get().then((value){
//     if(value.exists){
//       db.collection('Payments').doc(transactionID).update(wardData);
//       db.collection("MonitorNode").doc(transactionID).update(wardData);
//
//       db.collection('WardTotalAmount').doc('${selectedWard!.district}_${selectedWard!.assembly}_${selectedWard!.booth}').update({"Amount": FieldValue.increment(double.parse(amount))});
//
//       db.collection('WardTotalAmount').doc('${item.district}_${item.assembly}_${item.booth}').update({"Amount": FieldValue.increment(-double.parse(amount))});
//       notifyListeners();
//
//     }
//
//   });
//
//     HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
//     homeProvider.fetchHistoryFromFireStore();
//
//
// }

  // void addPinAssembly(BuildContext context,String timeStamp,String transactionID,String amount, PaymentDetails item){
  //
  //   HashMap<String, Object> assemblyData = HashMap();
  //   assemblyData["district"]=selectedAssembly!.district;
  //   assemblyData["assembly"]=selectedAssembly!.assembly;
  //   assemblyData["state"]=selectedAssembly!.state;
  //
  //   db.collection("Payments").doc(transactionID).get().then((value){
  //     if(value.exists){
  //       db.collection('Payments').doc(transactionID).set(assemblyData,SetOptions(merge: true));
  //       db.collection("MonitorNode").doc(transactionID).set(assemblyData,SetOptions(merge: true));
  //
  //       db.collection('ASSEMBLY_TOTAL').doc('${selectedAssembly!.state}_${selectedAssembly!.district}_${selectedAssembly!.assembly}')
  //           .set({"Amount": FieldValue.increment(double.parse(amount))},SetOptions(merge: true));
  //
  //       db.collection('ASSEMBLY_TOTAL').doc('${item.state}_${item.district}_${item.assembly}')
  //           .set({"Amount": FieldValue.increment(-double.parse(amount))},SetOptions(merge: true));
  //       notifyListeners();
  //     }
  //   });
  //
  //
  //   if(selectedAssembly!.district!=item.district) {
  //     db.collection('DISTRICTS_TOTAL').doc(selectedAssembly!.state+"_"+selectedAssembly!.district).set({
  //       "AMOUNT": FieldValue.increment(double.parse(amount)),
  //       "TRANSACTION_COUNT": FieldValue.increment(1)
  //     },SetOptions(merge: true));
  //     db.collection('DISTRICTS_TOTAL').doc(item.state+"_"+item.district).set({
  //       "AMOUNT": FieldValue.increment(-double.parse(amount)),
  //       "TRANSACTION_COUNT": FieldValue.increment(-1)
  //     },SetOptions(merge: true));
  //     if(selectedAssembly!.state!=item.state) {
  //       db.collection('STATE_TOTAL').doc(selectedAssembly!.state).set({
  //         "AMOUNT": FieldValue.increment(double.parse(amount)),
  //         "TRANSACTION_COUNT": FieldValue.increment(1)
  //       }, SetOptions(merge: true));
  //
  //       db.collection('STATE_TOTAL').doc(item.state).set({
  //         "AMOUNT": FieldValue.increment(-double.parse(amount)),
  //         "TRANSACTION_COUNT": FieldValue.increment(-1)
  //       }, SetOptions(merge: true));
  //     }
  //   }
  //
  //   HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
  //   homeProvider.fetchHistoryFromFireStore();
  //
  // }



  void receiptStatus(transactionID){

    HashMap<String, Object> receiptData = HashMap();
    receiptData["Receipt Status"]="Viewed";
    receiptData["Name"]=name.text;
    mRoot.child('PaymentDetails').child(transactionID).once().then((dataSnapshot) {
      if (dataSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> map = dataSnapshot.snapshot.value as Map;
        mRoot.child(map['OrderRef']).update(receiptData);
      }
    });
    db.collection('Payments').doc(transactionID).update(receiptData);
    notifyListeners();
  }

  void receiptSuccessStatus(transactionID){


    HashMap<String, Object> receiptData = HashMap();
    receiptData["Receipt Status"]="Viewed";
    mRoot.child('PaymentDetails').child(transactionID).once().then((dataSnapshot) {
      if (dataSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> map = dataSnapshot.snapshot.value as Map;
        mRoot.child(map['OrderRef']).update(receiptData);
      }
    });
    db.collection('Payments').doc(transactionID).update(receiptData);
    notifyListeners();
  }


  void printStatus(String timeStamp,transactionID){
    HashMap<String, Object> receiptData = HashMap();
    receiptData["Print Status"]="Printed";

    mRoot.child('PaymentDetails').child(transactionID).once().then((dataSnapshot) {

      if (dataSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> map = dataSnapshot.snapshot.value as Map;

        mRoot.child(map['OrderRef']).update(receiptData);
      }
    });
    db.collection('Payments').doc(transactionID).update(receiptData);

    notifyListeners();
  }


  void printStatusforPoster(String timeStamp,transactionID){
    HashMap<String, Object> receiptData = HashMap();
    receiptData["Print Status"]="Printed";

    mRoot.child('PaymentDetails').child(transactionID).once().then((dataSnapshot) {

      if (dataSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> map = dataSnapshot.snapshot.value as Map;

        mRoot.child(map['OrderRef']).update(receiptData);
      }
    });
    db.collection('Payments').doc(transactionID).update(receiptData);

    notifyListeners();
  }

  // void fetchAccountDetails(){
  //   mRoot.child("0").child("AccountDetials").onValue.listen((event) {
  //     if(event.snapshot.value!=null){
  //       Map<dynamic, dynamic> map = event.snapshot.value as Map;
  //       acNo=map["AccountNumber"];
  //       ifsc=map["ifsc"];
  //       acName=map["AccountName"];
  //       acUpiId=map["UpiId"];
  //       notifyListeners();
  //     }
  //     notifyListeners();
  //   });
  // }

  Future<UpiModel> getUpiUri(String app,String amount,String txnID) async {
    double amt=0;

    try{
      amt=double.parse(amount);

    }catch(e){}

    if(amt<2000){
      app=app+'2000';
    }

    var snapshot = await mRoot.child("0").child("AccountDetials").child('PaymentGateway').child(app).once();
    Map<dynamic, dynamic> map = snapshot.snapshot.value as Map;
    String upiId=map['UpiId'];
    String upiName=map['UpiName'];
    String upiAdd=map['UpiAdd'];
    // UpiModel upiModel=UpiModel(upiId, 'upi://pay?pa=$upiId&pn=$upiName&am=$amount&cu=INR&mc=8651&m&purpose=00&tn=kx ${txnID}$upiAdd');
    UpiModel upiModel=UpiModel(upiId, 'upi://pay?pa=$upiId&pn=$upiName&am=$amount&cu=INR&mc=8651&tr=${txnID}&tn=km${txnID}$upiAdd');
    return upiModel ;
  }

  void onAmountChange(String text) {
    displayAmount=text;
    notifyListeners();
  }

  Future<void> fetchPanjayath() async {

    panjayathList=await WardsService(newWardsMap,hideWardsMap).getAllPanjayath();
  }

  void moveToIndex0( DistrictDropListModel element) {
    districtList.remove(element);
    districtList.insert(0, element);
  }

  Future<void> fetchDistrict() async {

    districtList=await WardsService(newWardsMap,hideAssemblyMap).getAllDistrict();

    for(var ee in districtList){
      if(ee.state=='KERALA'){
        moveToIndex0(ee);
      }
    }

  }
  // Future<void> fetchAssembly() async {
  //   assemblyList=await WardsService(newWardsMap).getAllAssembly();
  // }

  void fetchUnitChipset(PanjayathModel selection,BuildContext context) async {

    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    notifyListeners();

    selectedPanjayathChip=selection;
    chipsetWardList.clear();
    WardsService(newWardsMap,hideWardsMap).getUnitChip(selection.district, selection.panjayath).then((value) {
      chipsetWardList=value;
      notifyListeners();

    });
    notifyListeners();
  }



  Map<dynamic,dynamic> hideAssemblyMap = {};
  fetchAssembly() async {
    assemblyList.clear();
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());
    mRoot.child('NewAssembly').onValue.listen((databaseEvent) {


      ///json data
      Map <dynamic, dynamic> map = jsonResponse as Map;
      jsonAssemblyList.clear();
      map.forEach((key, value) {
        jsonAssemblyList.add(AssemblyDropListModel(value['State'].toString(), value['District'].toString(),
          value['Assembly'].toString(),));
      });


      ///new assembly list
      baseAssemblyList.clear();
      if (databaseEvent.snapshot.value != null) {
        newWardsMap= databaseEvent.snapshot.value as Map;


        Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

        map.forEach((key, value) {


          baseAssemblyList.add(AssemblyDropListModel(value['State'].toString(), value['District'].toString(),
            value['Assembly'].toString(),));
          notifyListeners();


        });
        notifyListeners();
      }


      ///hide assembly list
      mRoot.child('hideAssembly').onValue.listen((event) {

        baseHideAssemblyList.clear();
        if (event.snapshot.value != null) {
          hideAssemblyMap= event.snapshot.value as Map;
          Map<dynamic, dynamic> map = event.snapshot.value as Map;
          map.forEach((key, value) {
            baseHideAssemblyList.add(AssemblyDropListModel(value['State'].toString(), value['District'].toString(),
              value['Assembly'].toString(),));
            notifyListeners();
          });
          print("hiii "+baseAssemblyList.length.toString());

          assemblyList=jsonAssemblyList+baseAssemblyList;

          assemblyList.removeWhere((item1) => baseHideAssemblyList.any((item2) => (item1.state == item2.state && item1.district == item2.district && item1.assembly == item2.assembly)));
          print(assemblyList.length.toString()+"jdfnjkeewkkkk");

          notifyListeners();
        }else{
          print("hiii welccomeee"+baseAssemblyList.length.toString());
          assemblyList=jsonAssemblyList+baseAssemblyList;
          notifyListeners();
          print(assemblyList.length.toString()+"cmmcmcmcc");

        }

      });
      print(assemblyList.length.toString()+"jdfnjkeew222");
    });
  }


  // void fetchAssemblyChipset(DistrictDropListModel selection,BuildContext context) async {
  //
  //   FocusScopeNode currentFocus = FocusScope.of(context);
  //   if (!currentFocus.hasPrimaryFocus) {
  //     currentFocus.unfocus();
  //   }
  //
  //   notifyListeners();
  //
  //   selectAssemblyChip=selection;
  //   chipsetAssemblyList.clear();
  //   print(newWardsMap.toString()+"ddjjjjj");
  //   print(hideWardsMap.toString()+"eouyuyryry");
  //   WardsService(newWardsMap,hideWardsMap).getAssemblyChip(selection.state, selection.district).then((value) {
  //     chipsetAssemblyList=value;
  //     notifyListeners();
  //
  //   });
  //   notifyListeners();
  // }
  // void fetchBoothChipset(AssemblyModel selection,BuildContext context) async {
  //
  //
  //   FocusScopeNode currentFocus = FocusScope.of(context);
  //   if (!currentFocus.hasPrimaryFocus) {
  //     currentFocus.unfocus();
  //   }
  //
  //   notifyListeners();
  //
  //   selectedAssemblyChip=selection;
  //   chipsetBoothList.clear();
  //   WardsService(newWardsMap).getBoothChip(selection.district, selection.assembly).then((value) {
  //     chipsetBoothList=value;
  //     notifyListeners();
  //
  //   });
  //   notifyListeners();
  // }

  void fetchPinWard() {
    mRoot.child('0').child('PinWardPH').onValue.listen((event) {
      if(event.snapshot.exists){
        phonePinWard=event.snapshot.value.toString();
        notifyListeners();
      }

    });
  }

  void attempt(String orderID,String appver) async {

    String timeString ="";

    DateTime now =DateTime.now();
    timeString=DateFormat('d/MM/yyy').format(now);
    // TimeStampModel? timeStampModel=await TimeService().getTime();
    //
    // print('${timeStampModel?.datetime.year.toString()}${"kjkkkl"}');
    // if(timeStampModel!=null){
    //   now = timeStampModel.datetime.toLocal();
    //   timeString = outputDayNode.format(now).toString();
    //   print(timeString+"mmjjjj");
    // }





    String amount=kpccAmountController.text.toString().replaceAll(',', '');


    String district = '';
    String assembly = '';
    String panchayath = '';
    String wardName = '';
    String wardNumber = '';

    HashMap<String, Object> map = HashMap();


    map["Amount"] = amount;
    map["Name"] = nameTC.text;
    map["PhoneNumber"] = phoneTC.text;
    map["SubCommitty"] = subCommitteeCT.text;
    map["Payment_Date"] = timeString;
    map["Time"] = now
        .millisecondsSinceEpoch
        .toString();
    map["ID"] = orderID;


    if (selectedWard != null) {
      district = selectedWard!.district;
      assembly = selectedWard!.assembly;
      panchayath = selectedWard!.panchayath;
      wardName = selectedWard!.wardName;
      wardNumber = selectedWard!.wardNumber;
    } else {
      district = 'GENERAL';
      assembly = 'GENERAL';
      panchayath = 'GENERAL';
      wardName = 'GENERAL';
      wardNumber = 'GENERAL';
    }

    map["district"] = district;
    map["assembly"] = assembly;
    map["panchayath"] = panchayath;
    map["wardName"] = wardName;
    map["wardNumber"] = wardNumber;
    map["Ward"] = wardName;

    if(shownameBool){
      map['NameShowStatus']='NO';
    }else{
      map['NameShowStatus']='YES';
    }
    // map["Ward"] = 'General';

    if(Platform.isIOS){
      map["Platform"] = "IOS";
    }else if(Platform.isAndroid){
      map["Platform"] = "ANDROID";
    } else{
      map["Platform"] = "NIL";
    }

    map["UpiID"] = "";
    map["RefNo"] = "App";

    map["PrintStatus"] = 'Not Printed';
    map["AppVersion"] = appver;

    // String? strDeviceID = "";
    // if(Platform.isAndroid){
    //   strDeviceID= await DeviceInfo().fun_initPlatformState();
    //
    // }else if(Platform.isIOS){
    //   try {
    //     strDeviceID = await UniqueIdentifier.serial;
    //   } on PlatformException {
    //     strDeviceID = 'Failed to get Unique Identifier';
    //   }
    //
    // }else{
    //   print("");
    // }

    String? strDeviceID= "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }
    map["DeviceId"] = strDeviceID!;

    HashMap<String, Object> dataMap =map;
    double amt= 0.0;

    try{
      amt=double.parse(amount);

    }catch(e){}
    dataMap["Amount"] = amt;




    db.collection('Attempts').doc(orderID).set(dataMap);

    var encResponds =  await http.post(Uri.parse('https://iumlicici-wyynhb4exq-uc.a.run.app/attempt2'),


      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',

      },
      body:jsonEncode(dataMap),
    );

    notifyListeners();
  }



  attempt3(String orderID,String appver) async {







    String amount=kpccAmountController.text.toString().replaceAll(',', '');


    String district = '';
    String assembly = '';
    String panchayath = '';
    String wardName = '';
    String wardNumber = '';

    HashMap<String, Object> map = HashMap();


    map["Amount"] = amount;
    map["Name"] = nameTC.text;
    map["PhoneNumber"] = phoneTC.text;
    map["SubCommitty"] = subCommitteeCT.text;

    map["Time"] = DateTime.now().millisecondsSinceEpoch.toString();
    map["ID"] = orderID;


    if (selectedWard != null) {
      district = selectedWard!.district;
      assembly = selectedWard!.assembly;
      panchayath = selectedWard!.panchayath;
      wardName = selectedWard!.wardName;
      wardNumber = selectedWard!.wardNumber;
    } else {
      district = 'GENERAL';
      assembly = 'GENERAL';
      panchayath = 'GENERAL';
      wardName = 'GENERAL';
      wardNumber = 'GENERAL';
    }

    map["district"] = district;
    map["assembly"] = assembly;
    map["panchayath"] = panchayath;
    map["wardName"] = wardName;
    map["wardNumber"] = wardNumber;
    map["Ward"] = wardName;

    if(shownameBool){
      map['NameShowStatus']='NO';
    }else{
      map['NameShowStatus']='YES';
    }


    if(Platform.isIOS){
      map["Platform"] = "IOS";
    }else if(Platform.isAndroid){
      map["Platform"] = "ANDROID";
    } else{
      map["Platform"] = "NIL";
    }

    map["UpiID"] = "";
    map["RefNo"] = "App";

    map["PrintStatus"] = 'Not Printed';
    map["AppVersion"] = appver;





    HashMap<String, Object> dataMap =map;
    double amt= 0.0;

    try{
      amt=double.parse(amount);

    }catch(e){

    }
    dataMap["Amount"] = amt;


    print("djbkj");

    db.collection('Attempts4').doc(orderID).set(dataMap);


    var encResponds =  await http.post(Uri.parse('https://iumlicici-wyynhb4exq-uc.a.run.app/attempt3'),


      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',

      },
      body:jsonEncode(dataMap),
    );






    notifyListeners();
  }



  Future<void> loopWardsToWardTotalAmount() async {
    print('looooooooooooping');
    var jsonText = await rootBundle.loadString('assets/KPCC_JSON.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    jsonMap.forEach((key, value) async {
      HashMap<String, Object> fireStore = HashMap();
      fireStore['district']=value['district'].toString();
      fireStore['panchayath']=value['panchayath'].toString();
      fireStore['wardname']=value['wardname'].toString();
      fireStore['Amount']=0;
      await db.collection('WardTotalAmount').doc('${value['district'].toString()}_${value['panchayath'].toString()}_${value['wardname'].toString()}').set(fireStore).then((value) {
        print(1);
      });

    });
  }

  void showNameStatus(){
    if(shownameBool){
      shownameBool=false;
    }else{
      shownameBool=true;
    }
    notifyListeners();
  }

  void selectAge(int index,String name){
    if(ageSelectionList[index].selectionStatus){
      ageSelectionList[index].selectionStatus=false;
    }else{
      ageSelectionList[index].selectionStatus=true;
    }
    for(var element in ageSelectionList){
      if(element.name!=name){
        element.selectionStatus=false;
      }
    }
    notifyListeners();

  }
  void minimumAmountTrueOrFalse(String amt){

    double checkamt = 0.0;
    if(!(amt == "")) {
      checkamt = double.parse(amt.toString());
    }
    if(checkamt>=1){
      minimumbool=false;
    }
    if(checkamt<1){
      minimumbool=true;
    }
    notifyListeners();
  }

  void selectGender(int index,String name){
    if(genderList[index].selectionStatus){
      genderList[index].selectionStatus=false;
    }else{
      genderList[index].selectionStatus=true;
    }

    for(var element in genderList){
      if(element.name!=name){
        element.selectionStatus=false;
      }
    }
    notifyListeners();
  }

  void clearGenderAndAgedata(){
    for(var element in ageSelectionList){
      element.selectionStatus=false;
    }
    for(var element in genderList){
      element.selectionStatus=false;
    }
    shownameBool=false;
    notifyListeners();
  }


  void getDirectReceipt(String paymentid,BuildContext context){
    db.collection("Payments").doc(paymentid).get().then((value) async {
      if(value.exists){
        await getDonationDetailsForReceipt(paymentid);

        callNextReplacement(ReceiptPage(nameStatus: 'YES',), context);

      }else{
        // callNextReplacement(HomeScreenNew(), context);

      }

    });
  }

  // void getOrganisation() {
  //   organisationList.clear();
  //   mRoot.child("ORGANISATION").once().then((value) {
  //     if (value.snapshot.exists) {
  //       Map<dynamic, dynamic> map = value.snapshot.value as Map;
  //       map.forEach((key, value) {
  //         organisationList.add(value.toString());
  //       });
  //     }
  //     notifyListeners();
  //   });
  // }


  void listenForPayment(String order_id,BuildContext paymentContext,){

    print("listencodehereeee111"+order_id);

    db.collection("MonitorNode").where("ID",isEqualTo: order_id).snapshots().listen(
            (event) {

          if(event.docs.isNotEmpty){
            print("listencodehereeee22");

            Map<dynamic, dynamic> map = event.docs.first.data();

            print("listencodehereeee555");
            if(map["Status"] !=null ) {
              print("listencodehe88888888");
              getDonationDetailsForReceipt(order_id);
              callNextReplacement(DonationSuccess(), paymentContext);

            }
            notifyListeners();
          }
          notifyListeners();



        });
    print("listencodehereeee33");
    print("msfpaperrevolutioncoderheree33");




  }
  Future<void> launchUrlUPI(BuildContext context, Uri _url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    } else {


    }
  }
  void updateFamilyName(String donorId){
    db.collection('MonitorNode').doc(donorId).set({"FamilyName":familyNameTC.text},SetOptions(merge: true));
    db.collection('Payments').doc(donorId).set({"FamilyName":familyNameTC.text},SetOptions(merge: true));
    notifyListeners();
  }


// void getLength(){
//   db.collection('WardTotalAmount').get().then((value) {
//     print("length"+value.docs.length.toString());
//   });
// }



  createQrImage(String from, String donorName,ScreenshotController screenshotController) async {
    String imgName=DateTime.now().millisecondsSinceEpoch.toString();
    // ScreenshotController screenshotController = ScreenshotController();
    await screenshotController
        .capture().then((Uint8List? image) async {
      if (image != null) {

        if(!kIsWeb){
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/$imgName.png').create();
          await imagePath.writeAsBytes(image);


          if (from == 'Print') {
            OpenFile.open(imagePath.path);
          } else {
            // Share.shareFiles([imagePath.path],);
             Share.shareXFiles([XFile(imagePath.path)]);
          }
        }
        else{
          ByteData bytes=ByteData.view(image.buffer);

          var blob = web_file.Blob([bytes], 'image/png', 'native');

          var anchorElement = web_file.AnchorElement(
            href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
          )..setAttribute("download", "data.png")..click();
        }

      }


      // Handle captured image
    });
  }

  double todayTopperAmount = 0;
  String todayTopperName = "No payments yet";
  String todayTopperPlace = "";
  String todayTopperPanchayath = "";
  void getTodayTopper(){
    DateTime today = DateTime.now();
    String todayDate = "";
    String nameShow = "";
    todayDate = outputDayNode.format(today).toString();
    db.collection('Payments').where("Payment_Date", isEqualTo: todayDate)
        .orderBy('Amount', descending: true).limit(1).snapshots()
        .listen((event) {
      if(event.docs.isNotEmpty){
        todayTopperAmount = double.parse(event.docs.first.get("Amount").toString());
        nameShow =event.docs.first.get("NameShowStatus").toString();
        if(nameShow=="YES"){
          todayTopperName =event.docs.first.get("Name").toString();
        }else{
          todayTopperName ="Confidential Donor";
        }
        if(event.docs.first.get("assembly").toString()!="GENERAL"){
          todayTopperPlace =event.docs.first.get("panchayath").toString();
          todayTopperPanchayath = event.docs.first.get("district").toString();
        }else{
          todayTopperPlace = "";
          todayTopperPanchayath = "";
        }
        notifyListeners();
      }else{
        todayTopperAmount = 0;
        todayTopperName ="No payments yet";
        notifyListeners();
      }

    });
  }

  String  androidGooglePayButton='OFF';
  lockIosGooglePayButton(){
    mRoot.child('0').child('androidGooglePayButton').onValue.listen((event) {
      if(event.snapshot.exists){
        androidGooglePayButton=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }
  String  androidPhonePayButton='OFF';
  lockIosPhonePayButton(){
    mRoot.child('0').child('androidPhonePayButton').onValue.listen((event) {
      if(event.snapshot.exists){
        androidPhonePayButton=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }
  String androidPaytmPayButton="OFF";
  lockAndroidPaytmPayButton(){
    mRoot.child('0').child('androidPaytmPayButton').onValue.listen((event) {
      if(event.snapshot.exists){
        androidPaytmPayButton=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }


  String  iosGPayButton='OFF';
  lockGooglePayIosButton(){
    mRoot.child('0').child('GooglePayIosButton').onValue.listen((event) {
      if(event.snapshot.exists){
        iosGPayButton=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }
  String  iosPhonePayButton='OFF';
  lockPhonePayIosButton(){
    mRoot.child('0').child('PhonePayIosButton').onValue.listen((event) {
      if(event.snapshot.exists){
        iosPhonePayButton=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }


  void fetchSubCommityList(){
    subcommitteeList.clear();
    db.collection('SUB_COMMITTIES').doc('SUB_COMMITTIES').snapshots().listen((event) {
      if(event.exists){
        Map<dynamic,dynamic> map = event.data() as Map;
        if(map!=null){
          map.forEach((key, value) {
            subcommitteeList.add(value.toString());

          });
          subcommitteeList=subcommitteeList.toSet().toList();
          notifyListeners();
        }
      }
    });
  }

  List<OrganizationCollectedModel> organizationCollected=[];
  Future<void> fetchOrganiznCollectedCount(String panchayath,String ward) async {
    organizationCollected.clear();
    print(ward+' RIFRF  '+panchayath);
    await  db.collection('SUB_COMMITTIES').doc('SUB_COMMITTIES').snapshots().listen((event) {
      if(event.exists){
        organizationCollected.clear();
        Map<dynamic,dynamic> map = event.data() as Map;
        if(map!=null){
          map.forEach((key, value) {
            double collectedAmonut=0.0;
            db.collection('Payments')
                .where('SubCommitty',isEqualTo: value)
                .where('panchayath',isEqualTo: panchayath)
                .where('wardName',isEqualTo: ward).get().then((value1){
              if(value1.docs.isNotEmpty){
                for(var eee in value1.docs){
                  Map<dynamic,dynamic> mapp =  eee.data() as Map;
                  collectedAmonut=collectedAmonut+double.parse(mapp['Amount'].toString());

                }
                print(collectedAmonut.toStringAsFixed(0)+'  '+value.toString()+' YYYYIFRFIRFIBF');
                organizationCollected.add(OrganizationCollectedModel(value, collectedAmonut.toStringAsFixed(0)));
                notifyListeners();
              }else{
                organizationCollected.add(OrganizationCollectedModel(value,'0'));
                notifyListeners();
              }
            });
          });
        }
      }
    });
  }
  String  committyONOFF='OFF';
  committyViewONOFF(){
    mRoot.child('0').child('committyView').onValue.listen((event) {
      if(event.snapshot.exists){
        committyONOFF=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }

  String? ownGPayLink;
  String? ownPhonePayLink;
  String? ownPatmLink;
  String? ownQrLink;
  bool apiCallNewLoader=false;
  Future<void> apiCallNew(BuildContext context,String tid,String name,String phone,String amount,String from) async {
    loading();
    ownGPayLink="";
    ownPhonePayLink="";
    ownPatmLink="";
    ownQrLink="";

    apiCallNewLoader=true;
    notifyListeners();


    var params =  {
      "tid": tid,
      "name":name,
      "amount": amount,
      "phone": phone
    };
    print("reeeeeee2222");
    final dio = Dio(
        BaseOptions(

          baseUrl: "https://iumlksd-wyynhb4exq-uc.a.run.app/start",
          responseType: ResponseType.json,
          contentType: ContentType.json.toString(),
        ));




    var response= await dio.post("https://iumlksd-wyynhb4exq-uc.a.run.app/start",

        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data:jsonEncode(params));
    print("reeeeeee444");

    // callNext(NewPaymentGatewayScreen(id: ownQrLink.toString(), gpayLink:ownGPayLink!, phonePeLink: ownPhonePayLink!, payTmLink:ownPatmLink!,), context);

    if(response.statusCode==200){
      print(response.toString()+"assd111wqewe1111111");
      print(response.data["status"].toString()+"skdfnkjsuu22222");

      if(response.data["status"].toString()=="true"){



        print(response.toString()+"assd111wqewe");
        print(response.data["data"]["upi_intent"]["gpay_link"].toString()+" rggggygyg");
        ownGPayLink=response.data["data"]["upi_intent"]["gpay_link"].toString();
        ownPhonePayLink=response.data["data"]["upi_intent"]["phonepe_link"].toString();
        ownPatmLink=response.data["data"]["upi_intent"]["paytm_link"].toString();
        ownQrLink=response.data["data"]["upi_intent"]["bhim_link"].toString();

        print(ownGPayLink!+"sdkfnsdkjfn111");
loadingOff();
        callNext(NewPaymentGatewayScreen(id: ownQrLink.toString(), gpayLink:ownGPayLink!, phonePeLink: ownPhonePayLink!, payTmLink:ownPatmLink!,), context);
        apiCallNewLoader=false;
        notifyListeners();

      }else{
        print(response.data["msg"].toString()+"wkjernwjefffe");
        HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
        failureUpDatePaymentToMonitorNode("FAILED", "", context, tid, "FAILED", "FAILED", homeProvider.appVersion.toString());

      }













    }else{

      print(response.toString()+"aswqewe");

    }
  }
  Future<void> apiCallNewIos(BuildContext context,String tid,String name,String phone,String amount,String from) async {

    loading();

    ownGPayLink="";
    ownPhonePayLink="";
    ownPatmLink="";
    ownQrLink="";

    apiCallNewLoader=true;
    notifyListeners();


    var params =  {
      "tid": tid,
      "name":name,
      "amount": amount,
      "phone": phone
    };
    print("reeeeeee2222");
    final dio = Dio(
        BaseOptions(

          baseUrl: "https://iumlksd-wyynhb4exq-uc.a.run.app/startIOSIntent",
          responseType: ResponseType.json,
          contentType: ContentType.json.toString(),
        ));




    var response= await dio.post("https://iumlksd-wyynhb4exq-uc.a.run.app/startIOSIntent",

        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data:jsonEncode(params));
    print("reeeeeee444");


    if(response.statusCode==200){
      print(response.toString()+"assd111wqewe1111111");
      print(response.data["status"].toString()+"skdfnkjsuu22222");

      if(response.data["status"].toString()=="true"){



        print(response.toString()+"assd111wqewe");
        print(response.data["data"]["upi_intent"]["gpay_link"].toString()+" rggggygyg");
        ownGPayLink=response.data["data"]["upi_intent"]["gpay_link"].toString();
        ownPhonePayLink=response.data["data"]["upi_intent"]["phonepe_link"].toString();
        ownPatmLink=response.data["data"]["upi_intent"]["paytm_link"].toString();
        print("ownGPayLinkFAZIL");
        print(ownGPayLink);
        print("ownGPayLinkFAZIL");
        final dio = Dio(
            BaseOptions(

              baseUrl: "https://iumlksd-wyynhb4exq-uc.a.run.app/startIOSQr",
              responseType: ResponseType.json,
              contentType: ContentType.json.toString(),
            ));
        var responsenew= await dio.post("https://iumlksd-wyynhb4exq-uc.a.run.app/startIOSQr",

            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }),
            data:jsonEncode(params));

        if(responsenew.statusCode==200){
          ownQrLink=responsenew.data["data"]["upi_intent"]["bhim_link"].toString();

          print("ownQrLinkFAZIL");
          print(ownQrLink);
          print("ownQrLinkFAZIL");

        }




        print(ownGPayLink!+"sdkfnsdkjfn111");
        loadingOff();

        callNext(NewPaymentGatewayScreen(id: ownQrLink.toString(), gpayLink:ownGPayLink!, phonePeLink: ownPhonePayLink!, payTmLink:ownPatmLink!,), context);
        apiCallNewLoader=false;
        notifyListeners();

      }else{
        print(response.data["msg"].toString()+"wkjernwjefffe");
        HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
        failureUpDatePaymentToMonitorNode("FAILED", "", context, tid, "FAILED", "FAILED", homeProvider.appVersion.toString());

      }













    }else{

      print(response.toString()+"aswqewe");

    }
  }
  failureUpDatePaymentToMonitorNode(String status, String response, BuildContext context, String orderID, String app, String upiIdP,String appver) async {

    // var outputDayNode = DateFormat('yyyy_M_d');
    String name = nameTC.text;
    DateTime now =DateTime.now();
    String timeString="";
    timeString=DateFormat('d/MM/yyy').format(now);
    // TimeStampModel? timeStampModel=await TimeService().getTime();
    //
    // if(timeStampModel!=null){
    //   now = timeStampModel.datetime.toLocal();
    //   timeString = outputDayNode.format(now).toString();
    // }
    //
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String packageVersion = packageInfo.version;



    String amount=kpccAmountController.text.toString().replaceAll(',', '');


    String district = '';
    String assembly = '';
    String panchayath = '';
    String wardName = '';
    String wardNumber = '';


    HashMap<String, Object> map = HashMap();

    map["Receipt Status"]="Viewed";
    map["Amount"] = amount;
    map["Responds"] = response;
    map["Name"] = name;
    map["PhoneNumber"] = phoneTC.text;
    map["Time"] = now.millisecondsSinceEpoch.toString();
    map["Payment_Date"] = timeString;
    map["ID"] = orderID;

    if (status == "SUCCESS") {
      map["Status"] = "Success";
      map["Receipt Status"]="notViewed";
    } else {
      map["Status"] = "Failed";
    }

    if (selectedWard != null) {
      district = selectedWard!.district;
      assembly = selectedWard!.assembly;
      panchayath = selectedWard!.panchayath;
      wardName = selectedWard!.wardName;
      wardNumber = selectedWard!.wardNumber;
    } else{
      district = 'GENERAL';
      assembly = 'GENERAL';
      panchayath = 'GENERAL';
      wardName = 'GENERAL';
      wardNumber = 'GENERAL';
    }

    map["district"] = district;
    map["assembly"] = assembly;
    map["panchayath"] = panchayath;
    map["wardName"] = wardName;
    map["wardNumber"] = wardNumber;
    map["Ward"] = wardName;
    map["PaymentApp"] = app;
    map["PaymentUpi"] = upiIdP;
    map["LOGOUT"] = "YES";

    if(Platform.isIOS){
      map["Platform"] = "IOS";
    }else if(Platform.isAndroid){
      map["Platform"] = "ANDROID";
    }
    else{
      map["Platform"] = "NIL";
    }

    map["UpiID"] = "";
    map["RefNo"] = "App";
    map["PaymentUpi"] = upiIdP;
    map["PrintStatus"] = 'Not Printed';
    map["AppVersion"] = appver;
    String? strDeviceID = "";

    if(Platform.isAndroid){
      strDeviceID= await DeviceInfo().fun_initPlatformState();

    }else if(Platform.isIOS){
      try {
        strDeviceID = await UniqueIdentifier.serial;
      } on PlatformException {
        strDeviceID = 'Failed to get Unique Identifier';
      }

    }else{
      print("");
    }
    map["DeviceId"] = strDeviceID!;

    if(shownameBool){
      map['NameShowStatus']='NO';
    }else{
      map['NameShowStatus']='YES';
    }

    db.collection("MonitorNode").doc(orderID).set(map);



    notifyListeners();
  }


  String  receiptChangeWard='OFF';

  lockReceiptChangeWard(){
    mRoot.child('0').child('RecieptChangeWard').onValue.listen((event) {
      if(event.snapshot.exists){
        receiptChangeWard=event.snapshot.value.toString();
        print(receiptChangeWard+'aamsdmaismdamsd');
        notifyListeners();
      }
    });

  }


  void createImageNew(ScreenshotController screenshotController,String campName,String campaignId,int campaignContentCount) async {
    await screenshotController
        .capture().then((Uint8List? image) async {
      if (image != null) {
        ByteData bytes = ByteData.view(image.buffer);

        var blob = web_file.Blob([bytes], 'image/png', 'native');
        String path = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString();
        var anchorElement = web_file.AnchorElement(
          href: web_file.Url.createObjectUrlFromBlob(blob).toString(),);
        anchorElement.download = path;
        anchorElement.click();
      }
      print("download");

      // Handle captured image
    });


  }

  Future<bool> intiateIntent(String transactionID,String amount) async {


    // transactionID=DateTime.now().millisecondsSinceEpoch.toString();

    print("print111111111111");
    // String stringValue =   "HDFC000020873058|$transactionID|8699|P2M|PAY|TXNID|IUML@HDFCBANK|INDIAN UNION MUSLIM LEAGUE|$amount|||||||||NA|NA";
    // String stringValue =   " HDFC000000006028|$transactionID|6012|P2M|PAY|TXNID|rahmaniyya@hdfcbank||$amount|||||||||NA|NA";
    String stringValue =   " HDFC000000006028|$transactionID|6012|P2M|PAY|rahmaniyya@hdfcbank||$amount|||||||||NA|NA";
    print("print2222");
    // var arguments={'PROCESS':"ENCRYPT",'STRING':stringValue};
    // String decrypted=await platformChanel.invokeMethod('CRYPTO',arguments);
    // final ioc = new HttpClient();
    // ioc.badCertificateCallback =1  qA
    //     (X509Certificate cert, String host, int port) => true;
    // final http = new IOClient(ioc);
    var encResponds =  await http.post(
      // Uri.parse('https://mind-wyynhb4exq-uc.a.run.app/inituat2'),
      Uri.parse('https://mind-wyynhb4exq-uc.a.run.app/inituat'),
      // Uri.parse('https://app-crypto2-221006172803.azurewebsites.net/init'),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Access-Control-Allow-Origin':'*',
        // 'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
        // 'Access-Control-Allow-Headers': 'Content-Type, X-Auth-Token, Origin, Authorization',
      },
      body: jsonEncode(<String, String>{
        "code":"HDFC000000000782|$transactionID|6012|P2M|PAY|INDIAN UNION MUSLIM LEAGUE|iumlksd@hdfcbank|test|$amount|||||||||NA|NA",
        "type":"023bf9a9-cc55-4d7a-972b-007c4cdfd65a",
        "pgMerchantId":"HDFC000000000782"}),
    );
    print("print5555");

    // var responds =  await http.post(
    //   // Uri.parse('https://testupi.mindgate.in:8443/hupi/mePayInetentReq'),
    // Uri.parse('https://upitest.hdfcbank.com/upi/mePayInetentReq'),
    //
    // headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'requestMsg': encResponds.body,
    //   'pgMerchantId':'HDFC000021042611',
    //
    //   }),
    // );



    // String decr=await platformChanel.invokeMethod('CRYPTO',{'PROCESS':"DECRYPT",'STRING':responds.body});

    // print("TTTTTTTTTTTT");

    //
    if(encResponds.statusCode==200){

      log(encResponds.body.toString()+"ooolllooo");




    }else{
      print(encResponds.body.toString());
      log("TTTTTTTTTTTT"+encResponds.body.toString()+"kkkkkkkk");
    }



    return encResponds.body.contains("SUCCESS");



  }

  double topperAmount = 0;
  String topperName = "No payments yet";
  String topperPlace = "";
  String topperDistrict = "";
  List<ToppersModel> toppersList =[];
  void getTopper(){
    String nameShow = "";
    DateTime today = DateTime.now();
    String todayDate = "";
    todayDate = outputDayNode.format(today).toString();
    db.collection('Payments')
        .where("Payment_Date", isEqualTo: todayDate)
        .orderBy('Amount', descending: true)
        .limit(3)
        .snapshots()
        .listen((event) {
      if(event.docs.isNotEmpty) {
        toppersList.clear();
        for (var e in event.docs) {
          topperAmount = double.parse(e.get("Amount").toString());
          nameShow = e.get("NameShowStatus").toString();
          if (nameShow == "YES") {
            topperName = e.get("Name").toString();
          } else {
            topperName = "Confidential Donor";
          }
          // if(event.docs.first.get("assembly").toString()!="GENERAL"){
          //   todayTopperPlace =event.docs.first.get("panchayath").toString();
          //   todayTopperDistrict = event.docs.first.get("district").toString();
          // }else{
          //   todayTopperPlace = "";
          //   todayTopperDistrict = "";
          // }

          print(topperName.toString() + "pfoppo");
          toppersList.add(ToppersModel(
              e.get("district").toString(),
              e.get("assembly").toString(),
              e.get("panchayath").toString(),
              topperName, topperAmount));
          notifyListeners();
          print(toppersList.length.toString() + "eoprpoop");
        }
      }else{
        topperAmount = 0;
        topperName ="No payments yet";
        toppersList.add(ToppersModel(
            '',
            '',
            '',
            todayTopperName, topperAmount));
        notifyListeners();
      }

    });
  }

  Future<void> eazypayGateway(String name,String paymentId,String phone,String amount,BuildContext context) async {




    var encResponds =  await http.post(Uri.parse('https://iumlicici-wyynhb4exq-uc.a.run.app/initiate'),
      // var encResponds =  await http.post(Uri.parse('https://beehiveicicirun-wyynhb4exq-uc.a.run.app/'),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',

      },
      body: jsonEncode(<String, String>{

        "reference":paymentId,
        "amount":amount,
        "name":name,
        "phone":phone,
      }),
    );
    // if(from==""){
    //   easyPayLoader=false;
    //   notifyListeners();
    // }else{
    //   easyPayQrLoader=false;
    //   notifyListeners();
    // }

    if(encResponds.statusCode==200){
      print("kkkjjjffaa");
      String urlPay=encResponds.body.toString();

      log("djhghejdgejhd"+urlPay.toString());

      Navigator.push(context, MaterialPageRoute(builder: (context) => EazyPayGateWayScreen(apiurl: urlPay, orderId: paymentId, from: '',)),
      );
      // callNext(OtherPaymentOptionScreen(apiurl: urlPay, orderId:paymentId, paymentType:paymentType, projectID:projectID, projectName:projectName, equipmentID: equipmentID, equipmentCount: equipmentCount, equipmentName: equipmentName, equipmentPrice: equipmentPrice, from: from,), context);


      // callNext(OtherPaymentOptionScreen(apiurl: urlPay, orderId:tid,from: from,), context);





    }else{
      print(encResponds.body.toString());
      log("TTTTTTTTTTTT"+encResponds.body.toString()+"kkkkkkkk");
    }




  }

  Future<void> icicPaymentIntegration(
      BuildContext context,
      String amount,
      String name,
      String phone,String orderId) async {


    notifyListeners();



    // final uri = Uri.parse('https://forwayanadplusrun-395736832032.us-central1.run.app/order');
    final uri = Uri.parse('https://forwayanadplusrun-wyynhb4exq-uc.a.run.app/order');
    // final uri = Uri.parse('https://icicpluswhiteguard-wyynhb4exq-uc.a.run.app/order');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "TxnRefNo": orderId,
      'Amount': (int.parse('1')*100).toString(),
      "CurrencyCode": "INR",
      "OrderInfo": orderId,
      "Email": "test@gmail.com",
      'Phone': phone,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    var response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    print(response.body.toString() + "asdcxxxxx");

    if (response.statusCode == 200) {
      print("succescode");
      String respo = response.body.toString();
      log(response.body.toString() + " Ressspobodddyy");

      // Handle the URL response directly
      String url = response.body;
      log(url + 'qqqqqqqqqqqq');
      log(url.toString() + "helloooo");

      if (kIsWeb) {

      } else {

        notifyListeners();
        if (Platform.isIOS) {
          // alertGateway(context,"owmdkxw");
          // print("wsebhdnwjka");
          callNext(OtherPaymentOptionScreen(
            apiurl: url,
            orderId: orderId, from: '',

          ), context);

        } else {
          callNext(OtherPaymentOptionScreen(
            apiurl: url,
            orderId: orderId, from: '',

          ), context);

        }

      }
    } else {
      print(response.toString() + "aswqewe");
    }
  }

}

void _launchURL(String _url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}


