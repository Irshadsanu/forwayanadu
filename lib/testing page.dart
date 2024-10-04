import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/providers/donation_provider.dart';
import 'package:quaide_millat/providers/web_provider.dart';

import 'constants/my_colors.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myLightOrangeNewUI,
      body: Center(
        child: InkWell(
          onTap: () async {
            WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);
            DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);

            // webProvider.testWeb();
            webProvider.loopTotalDistrict();
            // webProvider.loopTotalAssembly();
            // webProvider.loopTotalWard();
            // webProvider.loopTotalPanchyath();
            // webProvider.ff();
            // webProvider.loopTotalWard();
          //

          },
          child: Container(
            height: 100,
            width: 150,
            color: Colors.pink,
            child: const Center(child: Text("Click here to loop",style: TextStyle(color: Colors.white,fontSize: 15),)),
          ),
        ),
      ),
    );
  }
}
