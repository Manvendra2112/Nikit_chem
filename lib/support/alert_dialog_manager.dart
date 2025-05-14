
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
import 'package:nikitchem/screens/login/LoginScreen.dart';


  import '../constant/custom_widget.dart';
  import '../splash screen/splashScreen.dart';
  import 'PreferenceManager.dart';
  import 'app_theme.dart';

  class AlertDialogManager {
    isErrorAndSuccessAlertDialogMessage(BuildContext context, String title, String msg, {void Function()? onTapFunction}) {
      Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // (title.toString().toUpperCase() == "ERROR" || title.toString().toUpperCase() == "ALERT" || title.toString().toUpperCase() == "Exception".toString().toUpperCase())
                //     ? Image.asset("assets/error.png", height: 60, width: 60)
                //     : Image.asset("assets/success.png", height: 60, width: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(title.toString().toUpperCase(), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
                Text(msg, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: AppColor.positiveButton)
                      ),
                    ),
                    onPressed: onTapFunction,
                    child:  Text(title.toString().toUpperCase() == "ALERT"?"Go":"OK", style: const TextStyle(color: AppColor.positiveButton)),
                  ),
                ),
              ],
            ),
          ),barrierDismissible: false
      );
    }

    void saveAlertDialog(var context, String msg, {void Function()? onTapFunction}) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                msg,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: CustomWidget.getWidth(context) / 3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: AppColor.negativeButton)
                        ),
                      ),
                      onPressed:(){
                        Get.back();
                      } ,
                      child: const Text("Cancel", style: TextStyle(color: AppColor.negativeButton)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: CustomWidget.getWidth(context) / 4,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: AppColor.positiveButton)
                        ),
                      ),
                      onPressed: onTapFunction,
                      child: const Text("Buy", style: TextStyle(color: AppColor.positiveButton)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    void logoutDialog(BuildContext context) {
      Get.dialog(AlertDialog(
        semanticLabel: "Logout",
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Logout",
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
        ),
        titlePadding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
        contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        content: const Text(
          "Do you really want to logout ?",
          style: TextStyle(fontSize: 16, wordSpacing: 2, letterSpacing: 1),
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side:
                      const BorderSide(color: AppColor.negativeButton, width: 1.6)))),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: AppColor.negativeButton),
              )),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: const
                      BorderSide(color: AppColor.positiveButton)))),
              onPressed: () {

                PreferenceManager.instance.logout();
                Get.offAll(LoginScreen());

              },
              child: const Text(" OK ",style: TextStyle(color: AppColor.positiveButton),)),
          const SizedBox(
            width: 10,
          )
        ],
      ));
    }





    void  cancelBookingDialog(BuildContext context,String msg,Function() onTap) {
      Get.dialog(AlertDialog(
        semanticLabel: "Logout",
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        backgroundColor: Colors.white,
        title:  Text(
          msg,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        titlePadding: const EdgeInsets.only( top: 20, bottom: 10),
        contentPadding: const EdgeInsets.only(  bottom: 10),
        // content: const Text(
        //   "Do you really want to logout ?",
        //   style: TextStyle(fontSize: 16, wordSpacing: 2, letterSpacing: 1),
        // ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [

          CustomWidget.elevatedCustomButton(context, "Yes", onTap,width: Get.width/4,bgColor: AppColor.negativeButton.withOpacity(0.3),borderColor:AppColor.negativeButton.withOpacity(0.3) ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: const BorderSide(color: Colors.black)))),
              onPressed: (){
                Get.back();
              },
              child: const Text("No",style: TextStyle(color: Colors.black),)),
        ],
      ));
    }

    deleteAccountConformation(BuildContext context,String msg, {VoidCallback? onTapFunction}) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Delete Account", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                    ),
                    Divider(thickness: 1, height: 1, color: AppColor.mainColor.shade100),
                    const SizedBox(height: 18),
                    Text(msg, style:  TextStyle(fontSize: 15,color: Colors.grey.shade600), textAlign: TextAlign.center,),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(color:AppColor.white )
                                  )),
                              onPressed:  (){
                                Get.back();
                              },
                              child: const Text("cancel", style: TextStyle(color: AppColor.textFildtextcolor,fontWeight: FontWeight.bold))),
                        ),
                        const SizedBox(width: 8,),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.textFildbgcolor50,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(color:AppColor.textFildbgcolor50 )
                                  )),
                              onPressed:onTapFunction,
                              child: const Text("Delete", style: TextStyle(color: Colors.white))),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        },
      );
    }

    static getSnackBarMsg(String title, String msg, bool dialogTyoe, BuildContext context) {
      // return Get.snackbar(
      //  title,
      // msg,
      //   colorText: Colors.white,
      //   backgroundColor:dialogTyoe ? Colors.green.shade600 : Colors.red.shade400,
      //   snackPosition: SnackPosition.TOP,
      //   borderColor: Colors.white,
      //   borderRadius: 10.0,
      //   borderWidth: 1,
      // );

      // FocusManager.instance.primaryFocus!.unfocus();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              msg,
              style: const TextStyle(color: Colors.white),
            ),
            behavior: SnackBarBehavior.floating,
            // margin: EdgeInsets.only(bottom:
            //       MediaQuery.of(context).viewInsets.bottom +
            //        MediaQuery.of(context).size.height - 100, right: 20, left: 20),

            margin: const EdgeInsets.only(bottom:
            /*MediaQuery.of(context).viewInsets.bottom +*/20, left: 20, right: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            // dismissDirection: DismissDirection.none,
            closeIconColor: Colors.white,
            showCloseIcon: true,
            backgroundColor: dialogTyoe ? Colors.green.shade600 : Colors.red.shade400),
      );
    }


    sendMessageAlert(context,String tittle,String msg,){
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(tittle, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                    ),
                    Divider(thickness: 1, height: 1, color: AppColor.mainColor.shade100),
                    const SizedBox(height: 18),
                    Text(msg, style:  TextStyle(fontSize: 15,color: Colors.grey.shade600), textAlign: TextAlign.center,),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.textFildbgcolor50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(color:AppColor.textFildbgcolor50 )
                                )),
                            onPressed:  (){
                              Get.back();
                            },
                            child: const Text("Ok", style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold))),],
                    )
                  ],
                ),
              )
            ],
          );
        },
      );
    }
  }
