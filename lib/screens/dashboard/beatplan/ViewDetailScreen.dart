import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/customUI/CustomBottomSheetScreen.dart';
import 'package:nikitchem/screens/dashboard/beatplan/ViewDetailController.dart';

import '../../../support/app_theme.dart';
import '../../../support/imageassets.dart';

class ViewDetailScreen extends StatelessWidget {
   ViewDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewDetailController>(
        init: ViewDetailController(),

        builder: (controller){
          return Scaffold(

              body:

              Column(children: [

SizedBox(height: 30,),
                Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                    child: textImage(ImageAssets.backbutton, "Sharma Hardware")),
                SizedBox(height: 20,),
                openContainerExpand(context)
              ],)


          );


        });
  }
   Widget buildTextView(String asset,String label, String value) {
     return




       Column(
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
   Widget openContainerExpand(BuildContext context)
   {

     return


         Container(
width: 390*0.9,
height: 340*0.9,
           padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
           margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
           decoration: BoxDecoration(


               borderRadius:
               BorderRadius.circular(10),
               border: Border.all(color: AppColor.positiveButton)




           ),

           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [

               buildTextView(ImageAssets.dealericon,"Carpenter Name:","Sushil Kumar"),
               SizedBox(height: 5,),
               buildTextView(ImageAssets.dealericon,"Contact No:","91+ 9676876464"),
               SizedBox(height: 5,),
               buildTextView(ImageAssets.dealericon,"Address:" ,"K-2 Achim Vihar, New Delhi"),
               SizedBox(height: 5,),
               buildTextView(ImageAssets.dealericon,"Status:" ,"Pending"),
SizedBox(height: 20),
               Container(
               //  margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                 padding: EdgeInsets.fromLTRB(10, 3, 3, 10),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   color: AppColor.bgColor20.withOpacity(0.2),
                 ),
                 width: 390 * 0.9,
                 //90%of the screen
                 height: 60 * 0.9,

                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Image.asset(
                       ImageAssets.circleimage,
                       width: 20,
                       height: 22,
                     ),
                     SizedBox(width: 10),
                     Text("No. Of Carpenter - 05",style: TextStyle(fontFamily: "",fontSize: 12,
                         fontWeight: FontWeight.w500),),
Spacer(),
                     Container(
                       margin: EdgeInsets.only(right: 5),
                       child: CustomWidget.elevatedCustomButton(
                         context,
                         "View Details",
                             () {},
                         width: 120 * 0.9,
                         height: 35 * 0.9,
                       borderColor: Colors.transparent,
                         bgColor: AppColor.white, weight: FontWeight.w500,
                         textColor: AppColor.blackheading,
                         fontSize: 10,
                         borderRadius: 10,
                       ),
                     ),
                   ],
                 ),
               ),

               Padding(

                 padding:  EdgeInsets.fromLTRB(0, 10, 0, 5),
                 child: CustomWidget.elevatedCustomButton(
                   context, "Arrive", (){
                   //Get.to(HomeScreen());
                   showModalBottomSheet(
                     context: context,
                     isScrollControlled: true,
                     builder: (context) =>
                         Container(
                           height: MediaQuery
                               .of(context)
                               .size
                               .height * 0.2,
                           decoration: BoxDecoration(
                               color: AppColor.white,
                               borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(40),
                                   topRight: Radius.circular(40))),
                           padding: EdgeInsets.only(
                               top: 10, right: 15, left: 15, bottom: 0),
                           child: CustomBottomsheetScreen(),
                         ),
                   );


                 },fontSize: 12,textColor: Colors.white,
                   bgColor: AppColor.positiveButton,
                   width: 340*0.9,
                   height: 49*0.9,
                   borderRadius: 10,
                   weight: FontWeight.w500,




                 ),
               )



             ],
           ),
         );


   }

   Widget textImage(String asset,String text)
   {
     return Row(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [

         InkWell(onTap: (){Get.back();


           },

             child: Image.asset(asset,width: 20,height: 20,)),
         Expanded( //Added expanded so it takes remaining space and center itself
           child: Center(
             child: Text(
               text,
               style: TextStyle(
                 color: Colors.black,fontWeight: FontWeight.w500,
                 fontSize: 20.0,fontFamily: "Poppins-SemiBold",
                 decoration: TextDecoration.none,
               ),
             ),
           ),)

       ],);

   }
}
