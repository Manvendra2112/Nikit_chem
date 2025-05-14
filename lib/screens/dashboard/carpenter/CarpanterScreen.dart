import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/beatplan/BeatPlanController.dart';
import 'package:nikitchem/screens/dashboard/carpenter/CarpenterController.dart';
import 'package:nikitchem/screens/dashboard/carpenter/EditCarpenterDetailScreen.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../support/imageassets.dart';

class CarpanterScreen extends StatelessWidget {
  CarpanterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarpenterController>(

        init: CarpenterController(),
        builder: (controller){

          return Scaffold(
            backgroundColor: Colors.white,
              body: ListView(children: [

            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 72,

                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Image.asset(
                          ImageAssets.backbutton,
                          width: 20,
                          height: 20,
                        ),
                      )),
                  Container(
                    height: 72,

                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Text("Carpenters",maxLines:2,style: TextStyle(
                        fontSize: 22,color: AppColor.headingtext,
                        fontFamily: "Poppins-SemiBold",fontWeight: FontWeight.w600),),
                  ),
                ]
            ),
            buildSearchField(),
            SizedBox(height: 10,),
            Container(
              margin:  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: DottedBorder(

                borderType: BorderType.RRect,

                radius:  Radius.circular(10),
                dashPattern:  [6, 4], // Dotted pattern: 6px dash, 4px gap
                color: AppColor.positiveButton,
                strokeWidth: 1.5,
                child: InkWell(

                  onTap: (){

                    Get.to(EditCarpenterDetailScreen());
                  },
                  child: Container(
                    width: double.infinity,

                    padding:  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child:  Text(
                      '+ Add Carpenter',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.positiveButton)),
              width: 410*0.9,
              //90%of the screen
              height: 99*0.9,
              //15% of screen

              child:

              Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                        color: AppColor.bgColor20.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset(
                        ImageAssets.dealericon,
                        width: 11,
                        height: 10,
                      ),
                    ),
                  ),

                  Spacer(),
                  Text("Dealer : Sharma Hardware",maxLines:2,style:
                  TextStyle(fontFamily:"Poppins-Medium",fontSize: 10 ),),

                  SizedBox(width: 5,),
                  CustomWidget.elevatedCustomButton(

                    context, controller.isExpand?"Hide Details":"View Details", (){

                    controller.toggleExpansionTile();
                    controller. update();
                    openContainerExpand(context);

                  },
                    width: 110,
                    height: 39,
                    fontSize: 12,
                    weight: FontWeight.w500,
                    textColor: Colors.white,
                    borderRadius: 10,

                    padding: Padding(padding: EdgeInsets.all(2)),
                    bgColor: AppColor.positiveButton,


                  ),






                ],
              ),


            ),
            Visibility(
              visible: controller.isExpand,
              child: openContainerExpand(context),
            ),

          ],));
        });
  }


  Widget openContainerExpand(BuildContext context)
  {

    return

      Container(
        decoration: BoxDecoration(border: Border.all(color: AppColor.positiveButton)


        ),
        margin:  EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding:  EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Column(
          children: [
            buildTextView(ImageAssets.dealericon,"Carpenter Name:","Sushil Kumar"),
            SizedBox(height: 5,),
            buildTextView(ImageAssets.dealericon,"Contact No:","91+ 9676876464"),
            SizedBox(height: 5,),
            buildTextView(ImageAssets.dealericon,"Address:" ,"K-2 Achim Vihar, New Delhi"),

            SizedBox(height: 20,),
            Container(

              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.bgColor20.withOpacity(0.2),
              ),
              width: 390 * 0.9,
              //90%of the screen
              height: 60 * 0.9,

              child: Row(
                children: [
                  Image.asset(
                    ImageAssets.locationadd,
                    width: 18,
                    height: 20,
                  ),
                  SizedBox(width: 10),
                  Text("Ambala, Punjab"),
                  Spacer(),
                  CustomWidget.elevatedCustomButton(
                    context,
                    "View Details",
                        () {},
                    width: 117 * 0.9,
                    height: 36 * 0.9,
                    bgColor: AppColor.white,
                    textColor: AppColor.blackheading,
                    fontSize: 8,
                    borderRadius: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            CustomWidget.elevatedCustomButton(
              context, "Edit Details", (){

              //open bottom sheet



            },fontSize: 20,textColor: Colors.white,
              bgColor: AppColor.positiveButton,
              width: 390*0.9,
              height: 50*0.9,
              borderRadius: 10,



            ),




          ],
        ),
      )

    ;
  }

  Widget buildSearchField() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 2),
      decoration: BoxDecoration(
        color: AppColor.textFildbgcolor50.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10), // Grey border
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search Carpenters",
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColor.blackheading,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.fromLTRB(20, 12, 12, 12),
            child: Image.asset(
              ImageAssets.search,
              width: 17,
              height: 17,
            ),
          ),
          border: InputBorder.none,
          // Remove default TextField border
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
  Widget buildTextView(String asset,String label, String value) {
    return Column(
      children: [
        Row(
          children: [

            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                  color: AppColor.bgColor20.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  asset,
                  width: 11,
                  height: 10,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Container(
              width: 110,
              child: Text(label,
                  style: TextStyle(
                      fontFamily: "Metropolis-Regular",
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              width: 5,
            ),
            Text(value,maxLines: 2,
                style: TextStyle(
                    fontFamily: "Metropolis-Regular",
                    fontSize: 10,
                    fontWeight: FontWeight.w400)),
          ],
        )
      ],
    );
  }
}
