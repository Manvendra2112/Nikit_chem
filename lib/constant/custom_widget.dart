import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../support/alert_dialog_manager.dart';
import '../support/app_theme.dart';
import '../support/flutter_font_style.dart';

class CustomWidget {
  static getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static getWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  // showModalBottomSheet(context: context, builder: (BuildContext context) {
  //   return getBottomSheetWidget(context);
  // },isDismissible: false);

  Widget textFormField(
    TextEditingController controller, {
    TextInputAction textInputAction = TextInputAction.next,
    TextInputType? textInputType,
    FocusNode? focusNode,
    bool? readOnly,
    String? hintText,
    List<TextInputFormatter>? textInputFormatter,
    String? label,
    bool isMandatory = false,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: TextFormField(
        focusNode: focusNode,
        readOnly: (readOnly == null) ? false : readOnly,
        keyboardType: textInputType,
        controller: controller,
        obscureText: obscureText,
        inputFormatters: textInputFormatter,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.only(left: 8, right: 8),
          label: RichText(
            text: TextSpan(
                text: label,
                style: const TextStyle(color: Colors.black87),
                children: [
                  TextSpan(
                      text: isMandatory ? " *" : "",
                      style: const TextStyle(color: Colors.red))
                ]),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: AppColor.textFildbgcolor50,
              width: 1.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: AppColor.textFildbgcolor50,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  static Widget textInputFiled(
      TextEditingController? controller, {
        String hintText = "",
        String labelTextNew = "",
        Widget? suffixIconWidget,
        Widget? prefixIconWidget,
        List<TextInputFormatter>? inputFormatters,
        Widget? label,
        bool readOnlyFiled = false,
        bool fillColorFiled = false,
        Color? fillColors,
        Color? cursorColors,
        FocusNode? focusNode,
        bool passwordHide = false,
        ValueChanged? onFieldSubmitTap,
        TextInputType? textInputType,
        int? maxLine,
        int? minLine,
        bool? enabledBox,
        FormFieldValidator<String>? validator,
        void Function()? onTapFunction,
        void Function(String)? onChanged,
        double? topPadding,
        double? borderRadius,
        double? bottomPadding,
        double? leftPadding,
        double? rightPadding,
        TextAlign? textAlign,
        EdgeInsets? contentPadding,
        bool isMandatory = false,
        bool autoFocus = false,
        bool enableBorder = true,
        TextCapitalization? textCapitalization,
        Color? borderColor,
        double borderWidth = 0,
        Color? shadowColor,
        double blurRadius = 0,
        double offsetX = 0,
        double offsetY = 0,
        double? height,
        double? width,
        TextStyle? hintStyle,
      }) {
    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding ?? 0,
        right: rightPadding ?? 0,
        top: topPadding ?? 20,
        bottom: bottomPadding ?? 0,
      ),
      child: Container(
        height: height ?? 55,
        width: width,
        decoration: BoxDecoration(
          boxShadow: shadowColor != null
              ? [
            BoxShadow(
              color: shadowColor,
              blurRadius: blurRadius,
              offset: Offset(offsetX, offsetY),
            ),
          ]
              : null,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        child: TextFormField(
          textAlign: textAlign ?? TextAlign.start,
          onTap: onTapFunction,
          focusNode: focusNode,
          controller: controller,
          enabled: enabledBox,
          obscureText: passwordHide,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitTap,
          readOnly: readOnlyFiled,
          maxLines: passwordHide ? 1 : (maxLine ?? 1), // Fix: Single line for password fields
          minLines: minLine ?? 1,
          autofocus: autoFocus,
          textInputAction: TextInputAction.next,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          keyboardType: textInputType,
          validator: validator,
          cursorColor: cursorColors,
          decoration: InputDecoration(
            fillColor: fillColors,
            filled: fillColorFiled,
            suffixIcon: suffixIconWidget,
            prefixIcon: prefixIconWidget,
            label: labelTextNew.isNotEmpty
                ? label ??
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: labelTextNew,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 15),
                      ),
                      if (isMandatory)
                        const TextSpan(
                          text: " *",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                    ],
                  ),
                )
                : null,
            hintText: hintText,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
            hintStyle: hintStyle ??
                TextStyle(
                  fontSize: 15,
                  color: AppColor.textFildtextcolor,
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: borderColor != null
                  ? BorderSide(color: borderColor, width: borderWidth)
                  : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              borderSide: borderColor != null
                  ? BorderSide(color: borderColor, width: borderWidth)
                  : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              borderSide: borderColor != null
                  ? BorderSide(color: borderColor, width: borderWidth)
                  : BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
              borderSide: borderColor != null
                  ? BorderSide(color: borderColor, width: borderWidth)
                  : BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  static Widget outlineElevatedCustomButton(
      String? buttonName, void Function()? onTapFunction,
      {double? heightButton,
      double? horizontal,
      double? radius,
      bool iconEnable = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal ?? 15),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(color: AppColor.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        height: heightButton ?? 45,
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              // shadowColor: Colors.black,
              //  disabledBackgroundColor: Colors.white.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10))),
          onPressed: onTapFunction,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // if (iconEnable) const Icon(Icons.file_upload_outlined),
              Text(
                buttonName!,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // static getFilePicker(bool multipleFile) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowedExtensions: ['jpg', 'jpeg', 'JPG', 'PNG', 'png', 'JPEG'],
  //     allowMultiple: multipleFile,
  //     type: FileType.custom,
  //     withData: true,
  //   );
  //   return result;
  // }

  static Widget elevatedCustomButton(
      BuildContext context, String text, Function() onPressed,
      {double? width,
      Padding? padding,
      Color bgColor = Colors.transparent, // Default background to black
      ImageProvider? image, // images parameter
      Color textColor = Colors.grey, // Default text color to white
      Color borderColor = AppColor.positiveButton, // Default border color
      double borderRadius = 8,
      FontWeight? weight = FontWeight.w500,
      double fontSize = 14,
      double? height}) {
    // Calculate responsive width, ensuring it doesn't exceed screen width
    final double buttonWidth = getWidth(context) * 0.90;
    final double maxButtonWidth =
        getWidth(context) - 25; // Account for 16px padding on each side
    return SizedBox(
      width: width ?? buttonWidth,
      height: height ?? 48, // Increased height slightly for better touch area
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ), // Controlled padding
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              Container(
                width: 20, // Reduced image size to prevent overflow
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (image != null) const SizedBox(width: 6), // Reduced spacing
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontSize:
                        fontSize, // Slightly smaller font to prevent overflow
                    fontWeight: weight,
                    fontFamily: 'Poppins-Medium'),
                overflow: TextOverflow.ellipsis, // Handle long text gracefully
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getBottomSheetForProfile(
      BuildContext context, Function() onTapCamera, Function() onTapGallery) {
    showModalBottomSheet(
      backgroundColor: Colors.blue.shade100,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  "Choose images from",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                child: Divider(thickness: 1, height: 1, color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onTapCamera,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.blue.shade800,
                            size: 28,
                          ),
                          const Text(
                            "Camera",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: onTapGallery,
                      child: Column(
                        children: [
                          Icon(Icons.image_rounded,
                              color: Colors.blue.shade800, size: 28),
                          const Text(
                            "Gallery",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
            ],
          ),
        );
      },
    );
  }

  // Widget autoComplete(
  //   BuildContext context,
  //   GetxController getxController,
  //   TextEditingController controller,
  //   String hint,
  //   List<dynamic> list, {
  //   bool enable = true,
  //   FocusNode? focusNode,
  //   bool isRequired = false,
  //   EdgeInsets? scrollPadding,
  //   List<TextInputFormatter>? textInputFormatter,
  //   TextInputType textInputType = TextInputType.text,
  //   Function(dynamic d)? onSelectFunction,
  //   Function(dynamic d)? onSubmit,
  //   Function(String s)? onChanged,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
  //     child: SizedBox(
  //       height: 45,
  //       child: TypeAheadFormField(
  //         textFieldConfiguration: TextFieldConfiguration(
  //             focusNode: focusNode,
  //             controller: controller,
  //             enabled: enable,
  //             inputFormatters: (textInputFormatter == null) ? [] : textInputFormatter,
  //             scrollPadding: scrollPadding ?? EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 100.0),
  //             keyboardType: textInputType,
  //             decoration: InputDecoration(
  //               label: RichText(
  //                 text: TextSpan(
  //                     text: hint, style: const TextStyle(color: Colors.black), children: [isRequired ? const TextSpan(text: "*", style: TextStyle(color: Colors.red)) : const TextSpan()]),
  //               ),
  //               contentPadding: const EdgeInsets.only(top: 0, left: 15),
  //               enabledBorder: OutlineInputBorder(
  //                 borderSide: const BorderSide(width: 1, color: AppColor.primary),
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderSide: const BorderSide(width: 1, color: AppColor.secondary),
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //               border: const OutlineInputBorder(
  //                 borderSide: BorderSide(width: 1, color: AppColor.primary),
  //                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //               ),
  //             ),
  //             onChanged: onChanged,
  //             onSubmitted: onSubmit ?? (value) {}),
  //         suggestionsCallback: (pattern) {
  //           return list.where((dynamic option) {
  //             return option.toString().toLowerCase() /*.result!*/ .contains(
  //                   pattern.toString().toLowerCase(),
  //                 );
  //           });
  //         },
  //         itemBuilder: (context, dynamic suggestion) {
  //           return ListTile(
  //             title: Text(
  //               suggestion.toString(),
  //             ),
  //           );
  //         },
  //         onSuggestionSelected: onSelectFunction ??
  //             (dynamic suggestion) {
  //               controller.text = suggestion.toString();
  //               getxController.update();
  //             },
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget getSectionWiseBox(GetxController controller, context, String sectionName, List<Widget> widgetList, bool isExpanded, Function() _onChange) {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
  //     decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
  //     child: Column(
  //       children: [
  //         GestureDetector(
  //           onTap: _onChange,
  //           child: Container(
  //               height: 30,
  //               padding: const EdgeInsets.symmetric(horizontal: 10),
  //               alignment: Alignment.centerLeft,
  //               width: CustomWidget.getWidth(context),
  //               decoration: BoxDecoration(
  //                   color: AppColor.mainColor.shade100,
  //                   border: const Border(top: BorderSide(color: Colors.blue, width: 2)),
  //                   borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         child: Text(
  //                           sectionName,
  //                           style: const TextStyle(color: AppColor.primary, fontSize: 16),
  //                         ),
  //                       ),
  //                       const Icon(Icons.keyboard_arrow_down, color: AppColor.primary, size: 26)
  //                     ],
  //                   ),
  //                 ],
  //               )),
  //         ),
  //         ExpandedSection(
  //           expand: isExpanded,
  //           child: Padding(
  //             padding: const EdgeInsets.all(0.0),
  //             child: Column(
  //               children: widgetList,
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // static Widget modelDropDown(DropDownModel value, List<DropDownModel> itemList, void Function(DropDownModel?)? onChange,
  //     {Function()? onTap, Color? colorDropDown,double? marginTop,String label="",bool isMandatory=false,EdgeInsets? margin}) {
  //   return Stack(
  //     children: [
  //       Container(
  //         height: 48,
  //         margin: margin??EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
  //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
  //         decoration: BoxDecoration(
  //           // color: Colors.white,
  //           border: Border.all(
  //             color: AppColor.primary,
  //           ),
  //           borderRadius: BorderRadius.circular(5),
  //         ),
  //         child: DropdownButtonHideUnderline(
  //           child: DropdownButton<DropDownModel>(
  //             value: value,
  //             onTap: onTap,
  //             isExpanded: true,
  //             icon: const Icon(Icons.keyboard_arrow_down),
  //             items: itemList.map<DropdownMenuItem<DropDownModel>>((DropDownModel items) {
  //               return DropdownMenuItem<DropDownModel>(
  //                 value: items,
  //                 child: Text(items.name??""),
  //               );
  //             }).toList(),
  //             onChanged: onChange,
  //           ),
  //         ),
  //       ),
  //       Positioned(
  //           left: 20,
  //           top: 0,
  //           child: Container(
  //               color:Colors.white,
  //               alignment: Alignment.topCenter,
  //               child: Row(
  //                 children: [
  //                   Text(" $label ",style: TextStyle(fontSize: 12),),
  //                   isMandatory
  //                       ?Text("*",style: TextStyle(fontSize: 12,color: Colors.red),)
  //                       :Text(""),
  //                 ],
  //               )
  //           )
  //       ),
  //     ],
  //   );
  // }

  // static pickDateAndTime(BuildContext context, {required String backDate, required String type, DateTime? firstDate, DateTime? lastDate}) async {
  //   TimeOfDay? time = TimeOfDay.now();
  //   DateTime? picked = DateTime.now();
  //   picked = await showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(),
  //       // Set the initial date
  //           firstDate: firstDate ?? DateTime(2000), // The minimum date
  //           lastDate: lastDate ?? DateTime(2100), // The maximum date
  //           initialDatePickerMode: DatePickerMode.day)
  //       .then((onValue) async {
  //     if (onValue != null) {
  //       time = await showTimePicker(
  //         context: context,
  //         initialTime: TimeOfDay.now(),
  //       );
  //       if (time != null) {
  //         return onValue.copyWith(hour: time!.hour, minute: time!.minute);
  //       } else {
  //         return onValue.copyWith(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  //       }
  //     } else {
  //       return DateTime.now();
  //     }
  //   });
  //
  //   if (time != null) {
  //     return Intl().date("dd-MMM-yyyy hh:mm a").format(picked);
  //   } else {
  //     return Intl().date("dd-MMM-yyyy hh:mm a").format(picked);
  //   }
  // }

  Future<String> selectTime(BuildContext context,
      {bool? isTFhour = false}) async {
    TimeOfDay currentTime = TimeOfDay.now();
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: currentTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget? child_1) {
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(alwaysUse24HourFormat: isTFhour),
              child: child_1!);
        });
    if (isTFhour!) {
      if (timeOfDay != null) {
        return "${timeOfDay.hour.toString().length == 1 ? "0${timeOfDay.hour}" : timeOfDay.hour}:${timeOfDay.minute.toString().length == 1 ? "0${timeOfDay.minute}" : timeOfDay.minute}";
      } else {
        return "${currentTime.hour.toString().length == 1 ? "0${currentTime.hour}" : currentTime.hour}:${currentTime.minute.toString().length == 1 ? "0${currentTime.minute}" : currentTime.minute}";
      }
    }
    if (timeOfDay != null) {
      currentTime = timeOfDay;
      return currentTime.format(context);
    } else {
      return "";
    }
  }

  static Future<DateTimeRange> pickDateRange(BuildContext context,
      {required String backDate,
      DateTime? firstDate,
      DateTime? lastDate}) async {
    DateTimeRange? picked =
        DateTimeRange(start: DateTime.now(), end: DateTime.now());
    picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
          start: DateTime.now(), end: DateTime.now()), // Set the initial date
      firstDate: firstDate ?? DateTime(2000), // The minimum date
      lastDate: lastDate ?? DateTime(2100), // The maximum date
    ).then((onValue) async {
      if (onValue != null) {
        picked = onValue;
        return onValue;
      } else {
        return picked!;
      }
    });
    return picked!;
  }

  // static pickDate(BuildContext context, {required String backDate, DateTime? firstDate, DateTime? lastDate}) async {
  //   DateTime? picked = DateTime.now();
  //   picked = await showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(), // Set the initial date
  //           firstDate: firstDate ?? DateTime(2000), // The minimum date
  //           lastDate: lastDate ?? DateTime(2100), // The maximum date
  //           initialDatePickerMode: DatePickerMode.day)
  //
  //       .then((onValue) async {
  //     if (onValue != null) {
  //       return onValue;
  //     } else {
  //       return DateTime.now();
  //     }
  //   });
  //
  //
  //   return Intl().date("dd-MMM-yyyy ").format(picked);
  //   }

  // static Widget stringTypeDropDown
  //     (String value, List<String> itemList, void Function(String?)? onChange,
  //     FocusNode? focusNode,
  //     {Color? colorDropDown, String label = "", isMandatory = false,
  //       applyFitted = true, BuildContext? context, bool hideLabel = false,
  //       bool hideBorder = false}) {
  //   return Stack(
  //     children: [
  //       Container(
  //         height: 48,
  //         margin: const EdgeInsets.only(
  //           top: 9,
  //         ),
  //         padding: const EdgeInsets.symmetric(horizontal: 12),
  //         decoration: BoxDecoration(
  //           color: colorDropDown ?? Colors.white,
  //           border: Border.all(
  //             color: hideBorder
  //                 ? colorDropDown ?? Colors.white
  //                 : Colors.grey.shade400,
  //           ),
  //           borderRadius: BorderRadius.circular(5),
  //         ),
  //         child: DropdownButtonHideUnderline(
  //           child: DropdownButton(
  //             focusNode: focusNode,
  //             value: value,
  //             isExpanded: true,
  //             icon: const Icon(Icons.keyboard_arrow_down),
  //             items: itemList.map((String? items) {
  //               return DropdownMenuItem(
  //                 value: items,
  //                 child: applyFitted
  //                     ? FittedBox(
  //                         child: SingleChildScrollView(
  //                           child: Row(
  //                             children: [
  //                               Text(
  //                                 items!,
  //                                 maxLines: 1,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       )
  //                     : Text(
  //                         items!,
  //                         maxLines: 1,
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //               );
  //             }).toList(),
  //             onChanged: onChange,
  //           ),
  //         ),
  //       ),
  //       if (!hideLabel)
  //         Positioned(
  //             left: 20,
  //             top: 0,
  //             child: Container(
  //                 color: Colors.white,
  //                 alignment: Alignment.topCenter,
  //                 child: Row(
  //                   children: [
  //                     Text(
  //                       " $label ",
  //                       style: const TextStyle(fontSize: 12),
  //                     ),
  //                     isMandatory
  //                         ? const Text(
  //                             "*",
  //                             style: TextStyle(fontSize: 12, color: Colors.red),
  //                           )
  //                         : const Text(""),
  //                   ],
  //                 ))),
  //     ],
  //   );
  // }

  getCustomDataTable(
      BuildContext context,
      List<String> headerValue,
      List<String> actionList,
      List<String> headerkeys,
      List<Map<String, dynamic>> data,
      Function(int index) actionView) {
    return DataTable(
      headingRowHeight: 30,
      columnSpacing: 5,
      dataRowHeight: 50,
      horizontalMargin: 4,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          color: Colors.white),
      headingRowColor:
          WidgetStateColor.resolveWith((states) => AppColor.textFildtextcolor),
      columns: List.generate((headerkeys.length * 2) - 1, (index) {
        if (index % 2 == 0) {
          print((index + 1) / 2);
          int i = ((index) / 2).toInt();
          //Column Name List
          return DataColumn(label: dataColumnWidget(headerkeys[i]));
        } else {
          return DataColumn(label: verWhiteDiv());
        }
      }),
      rows: List.generate(data.length, (index_1) {
        Map<String, dynamic> rowData = data[index_1];
        return DataRow(
          cells: List.generate((headerkeys.length * 2) - 1, (index) {
            if (index % 2 == 0) {
              print((index) / 2);
              int i = ((index) / 2).toInt();

              //Key for data fetch
              String cellkey = headerValue[i];
              if (cellkey == "Action") {
                return DataCell(actionView(index_1));
              } else {
                return DataCell(Container(
                    width: 160,
                    child: Text(
                      rowData[cellkey] ?? "",
                      style: const TextStyle(
                          color: Colors.black, overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    )));
              }
            } else {
              return DataCell(verBlackDiv());
            }
          }),
        );
      }),
    );
  }

  getCustomDataTableType2(
      BuildContext context,
      List<String> headerValue,
      List<String> actionList,
      List<String> headerkeys,
      List<Map<String, dynamic>> data) {
    print(">>>>>>>>" + headerValue.toString());
    print(">>>>>>>>2" + headerkeys.toString());
    return DataTable(
      headingRowHeight: 0,
      columnSpacing: 5,
      dataRowHeight: 50,
      horizontalMargin: 4,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          color: Colors.white),
      headingRowColor:
          MaterialStateColor.resolveWith((states) => AppColor.darkGreen),
      columns: [
        DataColumn(label: Text("")),
        DataColumn(label: verWhiteDiv()),
        DataColumn(label: Text("")),
      ],
      rows: List.generate(headerValue.length, (index) {
        Map<String, dynamic> rowData = data[0];

        return DataRow(cells: [
          DataCell(Row(
            children: [
              Expanded(
                  child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      color: AppColor.textFildbgcolor50,
                      child: Text(
                        headerValue[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
            ],
          )),
          DataCell(verBlackDiv()),
          DataCell(Row(
            children: [
              Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      alignment: Alignment.center,
                      child: Text(
                        rowData[headerValue[index]],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ))),
            ],
          )),
        ]);
      }),
    );
  }

  static Widget verBlackDiv() {
    return Container(height: double.maxFinite, width: 0.7, color: Colors.grey);
  }

  static Widget verWhiteDiv() {
    return Container(height: 30, width: 1, color: Colors.white);
  }

  static Widget dataColumnWidget(String title, {double? widthSize = null}) {
    return SizedBox(
      width: widthSize,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  static getFilterRow(Widget first, Widget second) {
    return Row(
      children: [
        Expanded(child: first),
        Expanded(flex: 2, child: second),
      ],
    );
  }

  static getCustomTextField(
      TextEditingController controller,
      FocusNode? focus,
      String label,
      bool isMantory,
      String? unit,
      List<TextInputFormatter> inputFormatters,
      Function(String value) onChange,
      {bool? readOnly = false,
      bool labelOnTop = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: FittedBox(
              child: Text(
            "$label${isMantory ? "*" : ""}",
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
            maxLines: 1,
          )),
        ),
        Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
              color: Colors.white),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: readOnly! ? Colors.grey.shade200 : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: controller,
                  onChanged: onChange,
                  keyboardType: TextInputType.number,
                  inputFormatters: inputFormatters,
                  readOnly: readOnly,
                  maxLines: 1,
                  focusNode: labelOnTop ? focus : null,
                  // autofocus: !labelOnTop,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 2),
                    hintText: "0.00",

                    // labelText:labelOnTop?null:label,
                  ),
                ),
              )),
              if (unit != null)
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8)),
                      border: const BorderDirectional(
                          start: BorderSide(color: Colors.black)),
                      color: Colors.grey.shade200),
                  child: Text(
                    "$unit",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }

  // image picker
  static Future<File?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  // 2. Reusable function for a dropdown (e.g., for gender selection)

  static Widget stringTypeDropDown(
    String value,
    List<String> itemList,
    void Function(String?)? onChange,
    FocusNode? focusNode, {
    Color? colorDropDown,
    String label = "",
    bool isMandatory = false,
    bool applyFitted = true,
    bool hideLabel = false,

    bool hideBorder = false,
    double? height,
    bool enabledBox = true, // Added enabledBox parameter
  }) {
    // Create a separate FocusNode for RawKeyboardListener
    final keyboardFocusNode = FocusNode();

    // Change: If the value is not in the itemList (e.g., empty string), set it to null
    String? dropdownValue = itemList.contains(value) ? value : null;

    return RawKeyboardListener(
      focusNode: keyboardFocusNode,
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent && enabledBox) {
          if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            int currentIndex = itemList.indexOf(value);
            if (currentIndex < itemList.length - 1) {
              String newValue = itemList[currentIndex + 1];
              onChange?.call(newValue);
            }
          } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            int currentIndex = itemList.indexOf(value);
            if (currentIndex > 0) {
              String newValue = itemList[currentIndex - 1];
              onChange?.call(newValue);
            }
          }
        }
      },
      child: Stack(
        children: [
          Container(
            height: height ?? 53,
            margin: const EdgeInsets.only(top: 9),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: enabledBox
                  ? (colorDropDown ?? Colors.white)
                  : Colors.grey.withOpacity(0.3), // Greyed-out when disabled
              border: Border.all(
                color: hideBorder ? Colors.transparent : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                focusNode: focusNode,
                value: dropdownValue,
                borderRadius: BorderRadius.circular(10),
                hint: Text(
                  'Select',
                  style: TextStyle(
                    fontSize: 14,
                    color: enabledBox
                        ? AppColor.textFildtextcolor
                        : Colors.grey, // Grey hint when disabled
                  ),
                ),
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: enabledBox
                      ? AppColor.textFildtextcolor
                      : Colors.grey, // Grey icon when disabled
                ),
                items: itemList.map((String? items) {
                  return DropdownMenuItem(
                    value: items,
                    child: applyFitted
                        ? FittedBox(
                            child: SingleChildScrollView(
                              child: Row(
                                children: [
                                  Text(
                                    items!,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: enabledBox
                                          ? AppColor.textFildtextcolor
                                          : Colors
                                              .grey, // Grey text when disabled
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Text(
                            items!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: enabledBox
                                  ? AppColor.textFildtextcolor
                                  : Colors.grey,
                            ),
                          ),
                  );
                }).toList(),
                onChanged: enabledBox
                    ? onChange
                    : null, // Disable onChanged when not enabled
              ),
            ),
          ),
          // if (!hideLabel)
          //   Positioned(
          //     left: 20,
          //     top: 0,
          //     child: Container(
          //       color: Colors.white,
          //       alignment: Alignment.topCenter,
          //       child: Row(
          //         children: [
          //           Text(
          //             " $label ",
          //             style: const TextStyle(fontSize: 12),
          //           ),
          //           if (isMandatory)
          //             const Text(
          //               '',
          //               style: TextStyle(fontSize: 12, color: Colors.white),
          //             ),
          //         ],
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }



  //
  // // Placeholder for textInputFiled (assumed to exist and support enabledBox)
  // static Widget textInputFiled(
  //   TextEditingController controller, {
  //   double borderWidth = 1,
  //   double topPadding = 0,
  //   Color? fillColors,
  //   FocusNode? focusNode,
  //   String? hintText,
  //   bool fillColorFiled = false,
  //   TextInputType? textInputType,
  //   bool enabledBox = true,
  //   int? maxLine,
  //   int? minLine,
  //   double? height,
  //   double? leftPadding,
  //   double? rightPadding,
  //   double borderRadius = 10,
  // }) {
  //   // Implementation assumed to exist and support enabledBox
  //   return TextField(
  //     controller: controller,
  //     focusNode: focusNode,
  //     keyboardType: textInputType,
  //     maxLines: maxLine ?? 1,
  //     minLines: minLine ?? 1,
  //     enabled: enabledBox,
  //     decoration: InputDecoration(
  //       hintText: hintText,
  //       filled: fillColorFiled,
  //       fillColor: enabledBox ? fillColors : Colors.grey.withOpacity(0.3),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(borderRadius),
  //         borderSide: BorderSide(width: borderWidth),
  //       ),
  //       contentPadding: EdgeInsets.fromLTRB(
  //         leftPadding ?? 12,
  //         topPadding,
  //         rightPadding ?? 12,
  //         topPadding,
  //       ),
  //     ),
  //     style: TextStyle(
  //       color: enabledBox ? AppColor.textFildtextcolor : Colors.grey,
  //     ),
  //   );
  // }

  // 3. Reusable function to show a date picker
  static Future<DateTime?> showDatePickerDialog(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    return pickedDate;
  }

  // Reusable Toggle Button
  static Widget toggleButton(
      String label, bool isSelected, Function(bool) onToggle) {
    return GestureDetector(
      onTap: () => onToggle(!isSelected),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.green : Colors.white,
                border: Border.all(color: Colors.grey),
              ),
            ),
            SizedBox(width: 8),
            Text(label, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  static Widget imageUploadItem(File image, int index, Function(int) onRemove) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                Image.file(image, width: 100, height: 100, fit: BoxFit.cover),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => onRemove(index),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget addMoreButton(Function() onAdd) {
    return GestureDetector(
      onTap: onAdd,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.black),
          ),
          SizedBox(height: 4),
          Text('Add More', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  // for black color circular container
  static Widget circularIconButton({
    required IconData icon,
    VoidCallback? onTap,
    double size = 40,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.7),
      ),
    );
  }

  // for input an image
  static Widget takeImage(String url, double height, double width) {
    return Image(
      image: AssetImage(url),
      height: height,
      width: width,
    );
  }

  // new custom elevated button for social login;
  static Widget socialButton(
    BuildContext context, {
    required String text,
    required String imagePath,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.white,
    Color borderColor = Colors.black,
    double borderOpacity = 0.7,
    double borderWidth = 1,
    Color shadowColor = Colors.black,
    double shadowOpacity = 0.25,
    double shadowBlurRadius = 4,
    double shadowOffsetY = 2,
    double? width,
    double? height,
    TextStyle? textStyle,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: width ?? screenWidth * 0.7,
      height: height ?? screenHeight * 0.06,
      decoration: BoxDecoration(
        color: backgroundColor,
        // border: Border.all(
        //   color: borderColor.withOpacity(borderOpacity),
        //   width: borderWidth,
        // ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(shadowOpacity),
            blurRadius: shadowBlurRadius,
            offset: Offset(0, shadowOffsetY),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: textStyle ??
                    FTextStyle.custom(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black)),
            SizedBox(width: screenWidth * 0.02),
            Container(
              width: screenWidth * 0.06,
              height: screenWidth * 0.06,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildSuccessPopup({
    required String imagePath,
    required String message,
    bool showButton = true,
    double spacing = 60,
  }) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imagePath,
                width: 80,
                height: 80,
              ),
              SizedBox(height: spacing),
              Text(
                message,
                style: FTextStyle.custom(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (showButton)
                SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => Get.back(), // Close popup
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Text(
                      'Done',
                      style: FTextStyle.custom(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<Map<String, String>?> pickPdf(BuildContext context) async {
    try {
      // Check Android version to determine if permission is needed
      bool needsStoragePermission = false;
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        final sdkInt = androidInfo.version.sdkInt;
        // Storage permission needed only for Android 10 (API 29) and below
        needsStoragePermission = sdkInt <= 29;
      }

      if (needsStoragePermission) {
        PermissionStatus status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
          if (status.isDenied) {
            // Show dialog to retry or open settings
            bool? retry = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Permission Required"),
                content: Text(
                    "Storage permission is required to pick a PDF. Please grant permission to continue."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("Try Again"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await openAppSettings();
                      Navigator.of(context).pop(false);
                    },
                    child: Text("Open Settings"),
                  ),
                ],
              ),
            );

            if (retry == true) {
              status = await Permission.storage.request();
              if (status.isDenied) {
                return {
                  'error':
                      'Storage permission denied. Please grant permission to pick a PDF.'
                };
              }
            } else {
              return {
                'error':
                    'Storage permission denied. Please grant permission to pick a PDF.'
              };
            }
          }
          if (status.isPermanentlyDenied) {
            // Show dialog to open settings
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Permission Required"),
                content: Text(
                    "Storage permission is permanently denied. Please enable it in your app settings to pick a PDF."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await openAppSettings();
                      Navigator.of(context).pop();
                    },
                    child: Text("Open Settings"),
                  ),
                ],
              ),
            );

            // Check permission again after returning from settings
            status = await Permission.storage.status;
            if (!status.isGranted) {
              return {
                'error':
                    'Storage permission not granted. Please enable it in settings to pick a PDF.'
              };
            }
          }
        }
      }

      // Permission granted or not needed, proceed to pick PDF
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        String fileName = filePath.split('/').last;
        return {'path': filePath, 'name': fileName};
      }
      return null;
    } catch (e) {
      return {'error': 'Failed to pick PDF: $e'};
    }
  }
}
