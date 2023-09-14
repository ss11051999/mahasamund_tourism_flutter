import 'package:flutter/material.dart';
import 'package:mahasamund_tourism/Bottom_Sheet/show_welcome_bs.dart';
import 'package:mahasamund_tourism/Theme/app_colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isBSOpened = false;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      showWelcomeBS(context, key: scaffoldKey);
      setState(() {
        isBSOpened = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.primary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.ease,
            top: isBSOpened == false ? size.height / 2 - 125 : 50,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.ease,
              height: isBSOpened == false ? 300 : 250,
              width: isBSOpened == false ? 300 : 250,
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
