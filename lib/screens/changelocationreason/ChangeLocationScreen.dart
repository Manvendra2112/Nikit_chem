import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/changelocationreason/ChangeLocationController.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

class ChangeLocationScreen extends StatelessWidget {
  ChangeLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangeLocationController>(
        init: ChangeLocationController(),
        builder: (controller) {
          return Scaffold(

            backgroundColor: AppColor.white,
              body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                    child: Image.asset(
                      ImageAssets.backbutton,
                      width: 50,
                      height: 30,
                    ),
                  )),

              SizedBox(height: 20,),
              Padding(
                padding:  EdgeInsets.only(left: 20),
                child: Text(
                  "Reason to Change the Location",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins-Medium"),
                ),
              ),


              CustomWidget.textInputFiled(
                enabledBox: true,
                borderWidth: 1,
                topPadding: 30,
                leftPadding: 20,
                rightPadding: 20,
                maxLine: 7,
                minLine: 7,
                height: 230 * 0.9,
                textInputType: TextInputType.multiline,
                controller.reasonController,
                fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                focusNode: controller.remarksFocus,
                hintText: "Type here...",
                fillColorFiled: true,
                enableBorder: true,
                contentPadding: EdgeInsets.only(left: 30, top: 40),
                hintStyle: TextStyle(color: AppColor.blackheading,
                    fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "Poppins-Medium"),
                borderRadius:20.0,

              ),

              Spacer(),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: CustomWidget.elevatedCustomButton(
                  context,
                  "Submit",
                  () {
                    //  Get.to(DashboardScreen());
                  },
                  fontSize: 20,
                  textColor: Colors.white,
                  bgColor: AppColor.positiveButton,
                  width: 390*0.9,

                  height: 60,
                  weight: FontWeight.w500,
                  borderRadius: 10,
                ),
              )
            ],
          ));
        });
  }
}
