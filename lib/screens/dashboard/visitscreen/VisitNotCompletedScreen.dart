import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/visitscreen/VisitCompletedController.dart';
import 'package:nikitchem/screens/dashboard/visitscreen/VisitNotCompletedController.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'package:intl/intl.dart';
class VisitNotCompletedScreen extends StatelessWidget {
  VisitNotCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VisitNotCompletedController>(
        init: VisitNotCompletedController(),
        builder: (controller){
return Scaffold(body: Column(


  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

  SizedBox(height: 50,),
    InkWell(
        onTap: () {
          Get.back();
        },
        child: Container(

          alignment: Alignment.topLeft,
          margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Image.asset(
            ImageAssets.backbutton,
            width: 20,
            height: 20,
          ),
        )),



           Container(
             alignment: Alignment.center,
             margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
             child: Text("Unsuccessful Visit",maxLines:2,style: TextStyle(
                fontSize: 18,color: AppColor.headingtext,
                fontFamily: "Poppins-Medium",fontWeight: FontWeight.w500),),
           ),


SizedBox(height: 20),


  Container(
    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
    child: Row(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        SizedBox(
          width: 5,
        ),
        Container(

        alignment: Alignment.center,
          child: Text("Shop Name :",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
        ),
        SizedBox(
          width: 5,
        ),
        Text("Sharma Flowers",
            maxLines: 2,
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 15,
                fontWeight: FontWeight.w500)),
      ],
    ),
  ),
SizedBox(height: 20,),
  Container(
    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
    child: Text("Are They Using Our Products ?",

        style: TextStyle(
            fontFamily: "Poppins-Medium",
            fontSize: 16,
            fontWeight: FontWeight.w500)),
  ),


  Container(

    alignment: Alignment.topLeft,
    
    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
    child: Row(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio<bool>(
          value: true,
          groupValue: controller.isUsingProduct,
          onChanged: (value) => controller.toggleProductUsage(value!),
          activeColor: AppColor.positiveButton,
        ),
        const Text('Yes'),
        Radio<bool>(
          value: false,
          groupValue: controller.isUsingProduct,
          onChanged: (value) => controller.toggleProductUsage(value!),
          activeColor: AppColor.positiveButton,
        ),
         Text('No'),
      ],
    ),
  ),

  SizedBox(height: 20,),
  Container(
    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
    child: Text("How much they are using ?",

        style: TextStyle(
            fontFamily: "Poppins-Medium",
            fontSize: 16,
            fontWeight: FontWeight.w500)),
  ),


   SizedBox(height: 8),

        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // Apply border radius to the Container
          ),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),

          child: TextField(

            onChanged: (value) => controller.setQuantity(value),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(

              hintText: 'Enter Quantity',

fillColor: AppColor.textFildtextcolor.withOpacity(0.2),

              
              // Remove border
              enabledBorder: InputBorder.none, // Remove border when enabled
              focusedBorder: InputBorder.none,
            // border: Radius.circular(Radius.circular(10)),
              filled: true,
              contentPadding:  EdgeInsets.symmetric(horizontal: 10, vertical: 15),

            ),


          ),
        ),

  /*     SizedBox(width: 8),
      Expanded(
        flex: 1,
        child: DropdownButtonFormField<String>(
          value: controller.selectedPeriod,
          items: controller.periods.map((String period) {
            return DropdownMenuItem<String>(
              value: period,
              child: Text(period),
            );
          }).toList(),
          onChanged: (value) => controller.setPeriod(value!),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:  EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          ),
        ),
      ),*/

   SizedBox(height: 20),

  Container(
    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Text("Next Expected Order Date ?",
    
        style: TextStyle(
            fontFamily: "Poppins-Medium",
            fontSize: 16,
            fontWeight: FontWeight.w500)),
  ),



  GestureDetector(
    onTap: () async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        controller.setExpectedOrderDate(picked);
      }
    },
    child: Container(
      padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin:  EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: AppColor.textFildtextcolor.withOpacity(0.2),
      //  border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            controller.expectedOrderDate == null
                ? 'Enter Expected Order Date'
                : DateFormat('yyyy-MM-dd').format(controller.expectedOrderDate!),
            style: TextStyle(
              color: controller.expectedOrderDate == null ? Colors.grey : Colors.black,
            ),
          ),
Spacer(),
          Image.asset(ImageAssets.line,width: 20,height: 20,),
         Image.asset(ImageAssets.datecalander,width: 15,height: 15,)
        ],
      ),
    ),
  ),

Spacer(),

    Padding(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 5),
      child: CustomWidget.elevatedCustomButton(
        context,
        "Submit",
            () {
          // Get.to(Submit());
        },
        fontSize: 20,
        textColor: Colors.white,
        bgColor: AppColor.positiveButton,
        width: 390 * 0.9,
        height: 55 * 0.9,
        borderRadius: 10,
      ),
    )

],));


        });
  }
}
