import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'package:nikitchem/support/app_theme.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isPasswordVisible;
  final VoidCallback togglePasswordVisibility;
  final double width;

  const PasswordField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.text,
        obscureText: !isPasswordVisible, // Toggle visibility
        maxLines: 1, // Single-line to prevent multiline error
        textInputAction: TextInputAction.done,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9!@#$%^&*]')), // Allow letters, numbers, special chars
          LengthLimitingTextInputFormatter(20), // Max 20 characters
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }
          if (value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          if (!RegExp(r'[!@#$%^&*]').hasMatch(value)) {
            return 'Password must contain at least one special character (!@#%^&*)';
          }
          return null;
        },
        decoration: InputDecoration(

          hintText: "Enter Password",
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColor.textFildtextcolor,
            fontSize: 14,
            fontFamily: "Poppins-Medium",
          ),
          filled: true,
          fillColor: AppColor.textFildtextcolor.withOpacity(0.2),
          //border: InputBorder.none,
          //enabledBorder: InputBorder.none,
          //focusedBorder: InputBorder.none,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Border radius 10
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Border radius 10
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Border radius 10
            borderSide: BorderSide.none,
          ),

          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          suffixIcon: InkWell(
            onTap: togglePasswordVisibility,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                isPasswordVisible ? ImageAssets.eye : ImageAssets.eye,
                width: 20, // Adjusted for visibility
                height: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}