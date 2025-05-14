import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/dealerdetail/DealerScreen.dart';
import 'package:nikitchem/screens/dashboard/dealerdetail/editdealer/EditDealerController.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

class EditDealerScreen extends StatelessWidget {
  const EditDealerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditDealerController>(
        init:EditDealerController() ,

        builder:
            (controller){

          return Scaffold(body: Column(


            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              SizedBox(height: 20,),
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(

                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Image.asset(
                      ImageAssets.backbutton,
                      width: 30,
                      height: 30,
                    ),
                  )),



              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(25, 0, 25, 5),
                child: Text("Edit Dealers",maxLines:2,style: TextStyle(
                    fontSize: 18,color: AppColor.headingtext,
                    fontFamily: "Poppins-Medium",fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 20,),

              Padding(
                padding:  EdgeInsets.fromLTRB(25, 5, 25, 5),
                child: Text("Dealer Name*",style: TextStyle(fontSize: 14,
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
                    hintText: "Enter Dealer Name",
                    fillColorFiled: true

                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding:  EdgeInsets.fromLTRB(25, 5, 25, 5),
                child: Text("Phone Number*",style: TextStyle(fontSize: 14,
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
                padding:  EdgeInsets.fromLTRB(25, 5, 25, 5),
                child: Text("Shop Address*",style: TextStyle(fontSize: 14,
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
                padding:  EdgeInsets.fromLTRB(25, 5, 25, 5),
                child: Text("Area or Landmark",style: TextStyle(fontSize: 14,
                    fontFamily: "Cabin-Regular"),),
              ),

              Padding(
                padding:  EdgeInsets.fromLTRB(20, 7, 20, 0),
                child: CustomWidget.textInputFiled(
                    borderWidth:1,
                    topPadding: 0,
                    controller.landmarkContr,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.landmarkFocus,
                    hintText: "Enter Landmark or Area",
                    fillColorFiled: true

                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.positiveButton)),

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
                          ImageAssets.manblackicon,
                          width: 11,
                          height: 10,
                        ),
                      ),
                    ),

SizedBox(width: 5,),
                    Text("Carpenter List",maxLines:2,style:
                    TextStyle(fontFamily:"Poppins-Medium",fontSize: 12,fontWeight: FontWeight.w500 ),),

                    Spacer(),
                    CustomWidget.elevatedCustomButton(

                      context, "View All", (){





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
              Spacer(),
              Padding(

                padding:  EdgeInsets.fromLTRB(25, 10, 25, 5),
                child: CustomWidget.elevatedCustomButton(
                  context, "Submit", (){
                 // Get.to(DealerScreen());
                  Get.to(DealerScreen());

                },fontSize: 18,textColor: Colors.white,
                  bgColor: AppColor.positiveButton,

                  height: 60*0.9,
                  borderRadius: 10,



                ),
              )


            ],) );


        });
  }
}