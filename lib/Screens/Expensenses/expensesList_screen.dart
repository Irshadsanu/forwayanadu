import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quaide_millat/Screens/Expensenses/add_expenses_screen.dart';
import 'package:quaide_millat/Screens/Expensenses/detailed_expenses_screen.dart';
import 'package:quaide_millat/providers/home_provider.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';
import '../../constants/text_style.dart';
import '../home_screen.dart';

class ExpensesListScreen extends StatelessWidget {
  const ExpensesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       callNext(AddExpensesScreen(), context);
        //     },
        //     child: Icon(Icons.add)),
        appBar:  PreferredSize(
          preferredSize: const Size.fromHeight(84),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text('Expense List',style: wardAppbarTxt),
            centerTitle: true,
            leadingWidth: 55,
            toolbarHeight: height*0.12,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: InkWell(
                  onTap: (){
                    callNextReplacement(const HomeScreenNew(), context);
                  },
                  child: CircleAvatar(
                      radius: 18,
                      backgroundColor: cl000008.withOpacity(0.05),
                      child: const Icon(Icons.arrow_back_ios_outlined,color: myBlack,))),
            ),

          ),
        ),
        body: Column(
          children: [
            Consumer<HomeProvider>(
              builder: (context,val,child) {
                return Container(
                  height: 75,
                  width: width,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical:4),
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [cl394871,cl0FA3AA]),
                    image: DecorationImage(image: AssetImage("assets/expensetotalbg.png"),fit: BoxFit.fill),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text("₹",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),),
                          ),
                          FittedBox(
                            child: Text(getAmount(val.expenseTotal).toString(),
                              style: GoogleFonts.balooChettan2(fontSize: 26.67,fontWeight: FontWeight.w700,color: myWhite),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      const Text("Total Spent Amount",
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,fontFamily: "Poppins",color: Colors.white),),
                    ],
                  ),

                );
              }
            ),
            SizedBox(height: 12,),
            Consumer<HomeProvider>(
              builder: (context,val,child) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: val.expensesList.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var item= val.expensesList[index];
                        return Container(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  print('Images: ${item.images}');
                                  if(item.images.isNotEmpty){
                                    print("ldldlklk");
                                  }else{
                                    print("sklieuu");
                                  }
                                  print(item.images.length.toString()+"dggf");
                                  callNext(DetailedExpensesScreen(item: item,), context);
                                },
                                child: Container(
                                  margin:const EdgeInsets.only(left: 12,right:12,top: 8,bottom: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: cl000000.withOpacity(0.25),
                                        spreadRadius: -5.0,
                                        // blurStyle: BlurStyle.inner,
                                        blurRadius: 20.0,
                                      ),
                                    ]
                                      ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0,right: 5),
                                    child: Column(
                                      children: [
                                        ListTile(
                                            title:  Text(item.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15,
                                                  color: Colors.black
                                              ),),
                                            subtitle: Text(item.description,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: "Poppins",
                                                  fontSize: 12,
                                                  color: cl6F6F6F),),
                                            trailing: Container(
                                              width: 115,
                                              // height: 180,
                                              // color: Colors.red,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.end,
                                                   children: [
                                                     const Text("₹",
                                                         style: TextStyle(
                                                             color: cl002A69,
                                                             fontSize: 14,
                                                             fontWeight: FontWeight.w500)
                                                     ),
                                                     FittedBox(
                                                       child: Text(getAmount(double.parse(item.amount)),
                                                         style: const TextStyle(
                                                           color: cl002A69,
                                                           fontSize: 12.91,
                                                           fontFamily: "Poppins",
                                                           fontWeight: FontWeight.w700
                                                         ),
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                                  Text(item.date,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins",
                                                    fontSize: 7.38,
                                                    color: myBlack
                                                  ),),
                                                  // SizedBox(height: 8,),
                                                  InkWell(
                                                    onTap: (){
                                                      callNext(DetailedExpensesScreen(item: item,), context);
                                                    },
                                                    child: Container(
                                                      width: 102,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(40),
                                                    
                                                        gradient: const LinearGradient(
                                                            begin: Alignment.centerLeft,
                                                            end: Alignment.centerRight,
                                                            colors: [cl0EA3A9,cl3686C5]
                                                        ),
                                                        image: const DecorationImage(image: AssetImage("assets/Vector2.png"),alignment: Alignment.bottomCenter),
                                                      ),
                                                      child: const Center(
                                                        child: Text("View More",
                                                        style: TextStyle( color:Colors.white,fontSize: 8.88,fontFamily: "Poppins",fontWeight: FontWeight.w500),),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                        ),
                                        SizedBox(height: 5,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5,)
                            ],
                          ),
                        );
                      }),
                );
              }
            )

          ],
        ),
      ),
    );
  }
}
