import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahasamund_tourism/Theme/app_colors.dart';

bSHandleWidget({Color color = AppColors.primary, double height = 5}) {
  return Container(
    height: height,
    width: 100,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

appTextStyle(
    {required double size,
    required FontWeight weight,
    Color? color = AppColors.primary}) {
  return GoogleFonts.mukta(fontSize: size, fontWeight: weight, color: color);
}
