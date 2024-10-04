import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../providers/donation_provider.dart';

const desktopUserAgent =
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36";
const user_agent =     'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
class EazyPayGateWayScreen extends StatefulWidget {
  String? apiurl,orderId,from;
  EazyPayGateWayScreen({Key? key,required this.apiurl,required this.orderId,required this.from}) : super(key: key);

  @override
  State<EazyPayGateWayScreen> createState() => _EazyPayGateWayScreenState();

}


class _EazyPayGateWayScreenState extends State<EazyPayGateWayScreen> {
  WebViewPlusController? _controller;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider = Provider.of<DonationProvider>(
        context, listen: false);

    // donationProvider.getBankResponseHDFC(context, widget.paymentId!);
    donationProvider.listenForPayment(widget.orderId!,context);



    final settings = InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          userAgent: desktopUserAgent,/// pass your user agent
          allowFileAccessFromFileURLs: true,
          allowUniversalAccessFromFileURLs: true,
          useOnDownloadStart: true,
          mediaPlaybackRequiresUserGesture: true,
        ));

    final contextMenu = ContextMenu(
      options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
    );


    print("alltime run");

    return WillPopScope(
      onWillPop: () async {
        // _controller!.webViewController.goBack();

        return false;
      },
      child: SafeArea(
          child: Stack(
            children: [

              widget.from=="QR"?InAppWebView(

                initialUrlRequest: URLRequest(url: Uri.parse(widget.apiurl!)),
                initialOptions: settings,
                contextMenu: contextMenu,
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                  setState(() {
                    // print("hereewise111"+widget.apiurl!);
                    isLoading=false;
                    // print("hereewise2222"+widget.apiurl!);
                  });
                },



              ):
              WebViewPlus(
                initialUrl:widget.apiurl! ,

                userAgent: 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',

                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (NavigationRequest request)
                {
                  if (true)
                  {
                    print('blocking navigation to $request}');
                 launchUrlUPI(context, Uri.parse(request.url));
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
Future<void> launchUrlUPI(BuildContext context, Uri _url) async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  } else {}
}