import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../support/imageassets.dart';

class CustomBackWidget extends StatelessWidget {
   CustomBackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),

      color: Colors.white,
      child: textImage( "Today’s Beat Plan")

    );
  }

  Widget textImage(String text)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

      /*  InkWell(
            onTap: (){
              Get.back();
            },
            child: Image.asset(asset,width: 20,height: 20,)),*/
    //Added expanded so it takes remaining space and center itself
 Center(
    child: Text(
    text,
    style: TextStyle(
    color: Colors.black,fontWeight: FontWeight.w500,
  fontSize: 20.0,fontFamily: "Poppins-SemiBold",
  decoration: TextDecoration.none,
  ),
  ),
  ),

    ],);

  }
}