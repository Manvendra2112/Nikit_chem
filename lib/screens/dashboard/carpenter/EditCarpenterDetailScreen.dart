import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/carpenter/EditCarpenterDetailController.dart';
import 'package:nikitchem/support/app_theme.dart';

import '../../../support/imageassets.dart';

class EditCarpenterDetailScreen extends StatelessWidget {
   EditCarpenterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditCarpenterDetailController>(
        init:EditCarpenterDetailController() ,

        builder:
    (controller){

          return Scaffold(body: Column(


            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          margin: EdgeInsets.fromLTRB(25, 0, 15, 0),
                          child: Image.asset(
                            ImageAssets.backbutton,
                            width: 20,
                            height: 20,
                          ),
                        )),
                    Container(
                      height: 72,

                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text("Edit Carpenter’s Details",maxLines:2,style: TextStyle(
                          fontSize: 22,color: AppColor.headingtext,
                          fontFamily: "Poppins-SemiBold",fontWeight: FontWeight.w600),),
                    ),
                  ]
              ),
            SizedBox(height: 20,),

            Padding(
              padding:  EdgeInsets.fromLTRB(25, 5, 25, 0),
              child: Text("Edit Name*",style: TextStyle(fontSize: 14,
                  fontFamily: "Cabin-Regular"),),
            ),

            Padding(
              padding:  EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: CustomWidget.textInputFiled(
                  borderWidth:1,
                  topPadding: 0,
                  controller.nameContr,
                  fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                  focusNode: controller.nameFocus,
                  hintText: "Enter Carpenter Name",
                  fillColorFiled: true

              ),
            ),

              SizedBox(height: 10),
            Padding(
              padding:  EdgeInsets.fromLTRB(25, 5, 25, 0),
              child: Text("Edit Phone Number*",style: TextStyle(fontSize: 14,
                  fontFamily: "Cabin-Regular"),),
            ),

            Padding(
              padding:  EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: CustomWidget.textInputFiled(
                  borderWidth:1,
                  topPadding: 0,
                  controller.phoneContr,
                  fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                  focusNode: controller.phoneFocus,
                  hintText: "91+ Phone Number",
                  fillColorFiled: true

              ),
            ),

SizedBox(height: 10),
            Padding(
              padding:  EdgeInsets.fromLTRB(25, 5, 25, 0),
              child: Text("Edit Add Address*",style: TextStyle(fontSize: 14,
                  fontFamily: "Cabin-Regular"),),
            ),

            Padding(
              padding:  EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: CustomWidget.textInputFiled(
                  borderWidth:1,
                  topPadding: 0,
                  controller.addressContr,
                  fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                  focusNode: controller.addressFocus,
                  hintText: "Enter Shop Address",
                  fillColorFiled: true

              ),
            ),

              SizedBox(height: 10),
              Padding(
                padding:  EdgeInsets.fromLTRB(25, 5, 25, 0),
                child: Text("Edit Assign Dealer *",style: TextStyle(fontSize: 14,
                    fontFamily: "Cabin-Regular"),),
              ),

              Padding(
                padding:  EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: CustomWidget.stringTypeDropDown(
                    controller.selectedDealer,
label: "Select the Dealer",
                    controller.dealerOptions, (value) {
                  controller.selectedDealer = value!;
                  controller.update();

                }, controller.dealerFocus,

                    isMandatory: false, hideBorder: false, hideLabel: true),
              ),

              Padding(
                padding:EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: Text("Remarks",
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),





              CustomWidget.textInputFiled(
                enabledBox: true,
                borderWidth:1,
                topPadding: 5,
                leftPadding: 20,
                rightPadding: 20,
                maxLine: 6,
                minLine: 5,
                height: 120*0.9,

                textInputType: TextInputType.multiline,
                controller.remarksContr,
                fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                focusNode: controller.remarksFocus,
                hintText: "Enter Remarks",
                fillColorFiled: true
                ,borderRadius: 20,


              ),
              Padding(

                padding:  EdgeInsets.fromLTRB(25, 10, 25, 5),
                child: CustomWidget.elevatedCustomButton(
                  context, "Submit", (){
                  // Get.to(Submit());

                },fontSize: 20,textColor: Colors.white,
                  bgColor: AppColor.positiveButton,
                  width: 390*0.9,
                  height: 60*0.9,
                  borderRadius: 10,



                ),
              )


          ],) );


    });
  }
}
