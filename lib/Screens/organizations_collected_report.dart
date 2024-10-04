import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/constants/my_functions.dart';
import 'package:quaide_millat/providers/donation_provider.dart';

import '../constants/my_colors.dart';
import '../constants/text_style.dart';

class OrganizationsCollectedReport extends StatelessWidget {
  const OrganizationsCollectedReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            finish(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: cl264186,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Friend Organizations\n Collected Report",
          textAlign: TextAlign.center,
          style: wardAppbarTxt,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
    Flexible(
      fit: FlexFit.tight,
      child: Consumer<DonationProvider>(
          builder: (context,value,child) {
            return ListView.builder(
            shrinkWrap: true,
            itemCount: value.organizationCollected.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var item = value.organizationCollected[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius:3, // soften the shadow

                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.name),
                        Text(item.collected),
                      ],
                    ),
                  ),
                ),
              );
            });
          }
      ),
    ),
          ],
        ),
      ),
    );
  }
}
