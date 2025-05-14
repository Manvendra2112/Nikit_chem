import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/customUI/CustomBottomSheetController.dart';
import 'package:nikitchem/screens/dashboard/visitscreen/VisitCompletedScreen.dart';
import 'package:nikitchem/screens/dashboard/visitscreen/VisitNotCompletedScreen.dart';
import 'package:nikitchem/support/app_theme.dart';


class CustomBottomsheetScreen extends StatelessWidget {
  CustomBottomsheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery for screen dimensions
    double width = CustomWidget.getWidth(context);
    double height = CustomWidget.getWidth(context);

    return GetBuilder<CustomBottomSheetController>(
      init: CustomBottomSheetController(),
      builder: (controller) {
        return
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            child: Column(children: [

              Padding(

                padding:  EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: CustomWidget.elevatedCustomButton(
                  context, "Successful Visit", (){
                  Get.to(VisitCompletedScreen());

                },fontSize: 16,textColor: Colors.white,
                  bgColor: AppColor.positiveButton,

                  height: 60,
                  borderRadius: 10,



                ),
              ),

              SizedBox(height: 10,),
              Padding(

                padding:  EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: CustomWidget.elevatedCustomButton(
                  context, "Unsuccessful Visit", (){
                  Get.to(VisitNotCompletedScreen());

                },fontSize: 16,textColor: Colors.white,
                  bgColor: AppColor.positiveButton,

                  height: 55*0.9,
                  borderRadius: 10,



                ),
              )

            ],),
          );

      },
    );
  }
}