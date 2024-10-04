import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';


import 'package:provider/provider.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../constants/alerts.dart';
import '../providers/donation_provider.dart';

const desktopUserAgent =
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36";
const user_agent =     'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
class OtherPaymentOptionScreen extends StatefulWidget {
  String? apiurl,orderId,from;

  OtherPaymentOptionScreen({Key? key,required this.apiurl,required this.orderId,
    required this.from,


  }) : super(key: key);

  @override
  State<OtherPaymentOptionScreen> createState() => _OtherPaymentOptionScreenState();

}


class _OtherPaymentOptionScreenState extends State<OtherPaymentOptionScreen> {
  WebViewPlusController? _controller;
  bool isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  // InAppWebViewController? _webViewController;
  // InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider = Provider.of<DonationProvider>(
        context, listen: false);

    print('code works here here ');
    // donationProvider.getBankResponseHDFC(context, widget.paymentId!);
    donationProvider.listenForPayment(donationProvider.transactionID.text.toString(), context);




    // final settings = InAppWebViewGroupOptions(
    //     crossPlatform: InAppWebViewOptions(
    //       userAgent: desktopUserAgent,/// pass your user agent
    //       allowFileAccessFromFileURLs: true,
    //       allowUniversalAccessFromFileURLs: true,
    //       useOnDownloadStart: true,
    //       mediaPlaybackRequiresUserGesture: true,
    //     ));
    //
    // final contextMenu = ContextMenu(
    //   options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
    // );


    print("alltime run");

    return WillPopScope(
      onWillPop: () async {
        // _controller!.webViewController.goBack();

        return false;
      },
      child: SafeArea(
          child: Stack(
            children: [

              // widget.from=="QR"?InAppWebView(
              //
              //   initialUrlRequest: URLRequest(url: Uri.parse(widget.apiurl!)),
              //   initialOptions: settings,
              //   contextMenu: contextMenu,
              //   onWebViewCreated: (InAppWebViewController controller) {
              //     _webViewController = controller;
              //     setState(() {
              //       // print("hereewise111"+widget.apiurl!);
              //       isLoading=false;
              //       // print("hereewise2222"+widget.apiurl!);
              //     });
              //   },
              //
              //
              //
              // ):
              WebViewPlus(
                initialUrl:widget.apiurl! ,

                userAgent: 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',

                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (NavigationRequest request)
                {
                  print(request.url.toString()+"sjdhfbhf");
                  if (request.url.contains("pay?"))
                  {
                    // print('blocking navigation to $request}');
                    // print('blocking navigation to ${request.isForMainFrame.toString()}');
                    // print('blocking navigation to ${request.url.toString()}');

                    if(true){
                      print("fazil");
                      // url="$url&tn=ab $orderId";
                      String originalString=request.url+"&tn="+"kmp"+donationProvider.transactionID.text.toString();

                      if(Platform.isIOS){
                        // String modifiedString = originalString.replaceFirst("upi://pay?", "tez://upi/pay?");
                        // donationProvider.launchUrlUPI(context, Uri.parse(modifiedString));
                        alertGateway(context,originalString);
                        // String modifiedString = originalString.replaceFirst("upi://pay?", "tez://upi/pay?");

                      }else{

                      donationProvider.launchUrlUPI(context, Uri.parse(originalString));
                      }

                    }


                    // donationProvider.launchUrlUPI(context, Uri.parse(request.url));
                    return NavigationDecision.prevent;
                  }

                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageFinished: (s){
                  setState(() {
                    // print("hereewise111"+widget.apiurl!);
                    isLoading=false;
                    // print("hereewise2222"+widget.apiurl!);
                  });
                },
                debuggingEnabled: false,
                // onWebViewCreated: (controller) {
                //   print("hereewise2222");
                //   print("hereewise2222"+widget.apiurl!);
                //   _controller=controller;
                //   controller.loadUrl(widget.apiurl!);
                //
                // },


              ),
              isLoading ? const Center( child: CircularProgressIndicator(),) : Container(),
            ],
          )
      ),
    );
  }
}
