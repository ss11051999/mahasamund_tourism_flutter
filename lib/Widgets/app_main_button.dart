import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahasamund_tourism/Theme/app_colors.dart';

class AppMainButton extends StatelessWidget {
  AppMainButton({super.key, required this.child, required this.onPressed});

  Widget child;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 30,
          shadowColor: AppColors.white,
          foregroundColor: AppColors.secondary,
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle:
              GoogleFonts.mukta(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        child: child,
      ),
    );
  }
}
