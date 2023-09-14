import 'package:flutter/material.dart';
import 'package:mahasamund_tourism/Widgets/small_widgets.dart';

import '../Theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  AppTextField(
      {super.key,
      required this.hint,
      required this.inputType,
      required this.controller,
      this.maxLength});

  String hint;
  TextEditingController controller;
  TextInputType inputType;
  int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      maxLength: maxLength,
      style: appTextStyle(
          size: 22, weight: FontWeight.w700, color: AppColors.primary),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        hintText: hint,
        hintStyle: appTextStyle(
            size: 22, weight: FontWeight.w700, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.darkTransparent,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
    );
  }
}
