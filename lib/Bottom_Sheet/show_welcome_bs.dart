import 'package:flutter/material.dart';
import 'package:mahasamund_tourism/Actions/navigator.dart';
import 'package:mahasamund_tourism/Actions/show_toast_msg.dart';
import 'package:mahasamund_tourism/Apis/save_user_to_firebase.dart';
import 'package:mahasamund_tourism/Data/app_data.dart';
import 'package:mahasamund_tourism/Pages/main_page.dart';
import 'package:mahasamund_tourism/Provider/music_player_provider.dart';
import 'package:mahasamund_tourism/Provider/player_position_provider.dart';
import 'package:mahasamund_tourism/Theme/app_colors.dart';
import 'package:mahasamund_tourism/Theme/app_values.dart';
import 'package:mahasamund_tourism/Widgets/app_main_button.dart';
import 'package:mahasamund_tourism/Widgets/app_text_field.dart';
import 'package:mahasamund_tourism/Widgets/small_widgets.dart';
import 'package:provider/provider.dart';

showWelcomeBS(BuildContext context, {required GlobalKey<ScaffoldState> key}) {
  final Size size = MediaQuery.of(context).size;

  PageController pageController = PageController();

  key.currentState!.showBottomSheet(
    enableDrag: false,
    backgroundColor: AppColors.transparent,
    (context) {
      return Container(
        width: size.width,
        height: MediaQuery.of(context).size.height / 2 + 50,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(bSRadius),
              topLeft: Radius.circular(bSRadius)),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/background_light.png",
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            bSHandleWidget(),
            Flexible(
              child: PageView(
                controller: pageController,
                children: [
                  WelcomePage(controller: pageController),
                  const LoginPage()
                ],
              ),
            )
          ],
        ),
      );
    },
    // backgroundColor: AppColors.secondary,
  );
}

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key, required this.controller});

  PageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          "assets/images/namaste_text.png",
          scale: 4,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Text(
            "आपका स्वागत है, महासमुंद के उत्कृष्ट संग्रहालय में! आइए, हमारे साथ सफर करें और इस सजीव इतिहास के संस्मरणों का आनंद लें।",
            textAlign: TextAlign.center,
            style: appTextStyle(
                size: 22, weight: FontWeight.w700, color: AppColors.primary),
          ),
        ),
        const Spacer(),
        AppMainButton(
          onPressed: () {
            controller.animateToPage(1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut);
          },
          child: const Text("शुरू करे"),
        ),
        const Spacer()
      ],
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _tecName = TextEditingController();
  final TextEditingController _tecPhone = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          "assets/images/jay_johar_text.png",
          scale: 3.5,
        ),
        const Spacer(
          flex: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: AppTextField(
            controller: _tecName,
            hint: "आपका नाम",
            inputType: TextInputType.name,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: AppTextField(
            controller: _tecPhone,
            hint: "मोबाइल नंबर",
            maxLength: 10,
            inputType: TextInputType.phone,
          ),
        ),
        const Spacer(
          flex: 3,
        ),
        AppMainButton(
          onPressed: () {
            if (songList.isEmpty) {
              showToastMsg(
                  msg: "कुछ समस्या आ रही है। कृपया बाद में दोबारा प्रयास करें");
              return;
            }

            if (_isLoading == true) {
              return;
            }

            if (_tecName.text.isEmpty || _tecPhone.text.isEmpty) {
              showToastMsg(msg: "सभी फ़ील्ड आवश्यक हैं");
              return;
            } else if (_tecPhone.text.length != 10) {
              showToastMsg(msg: "कृपया वैध नंबर दर्ज करें");
              return;
            }

            setState(() {
              _isLoading = true;
            });
            saveUserToFirebase(
                    name: _tecName.text.trim(), phone: _tecPhone.text)
                .then((isSaved) {
              setState(() {
                _isLoading = false;
              });
              if (isSaved == true) {
                goOnlyNextPage(
                  context: context,
                  page: MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (context) => MusicPlayerProvider()),
                      ChangeNotifierProvider(
                          create: (context) => PlayerPositionProvider())
                    ],
                    child: MainPage(),
                  ),
                );
              }
            });
          },
          child: _isLoading == true
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: AppColors.secondary,
                    strokeWidth: 3,
                  ),
                )
              : const Text("शुरू करे"),
        ),
        TextButton(
          onPressed: () {
            if (songList.isEmpty) {
              showToastMsg(
                  msg: "कुछ समस्या आ रही है। कृपया बाद में दोबारा प्रयास करें");
              return;
            }

            goOnlyNextPage(
              context: context,
              page: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (context) => MusicPlayerProvider()),
                  ChangeNotifierProvider(
                      create: (context) => PlayerPositionProvider())
                ],
                child: MainPage(),
              ),
            );
          },
          child: Text(
            "Skip",
            style: appTextStyle(
                size: 18, weight: FontWeight.w700, color: AppColors.primary),
          ),
        ),
        const Spacer(
          flex: 2,
        )
      ],
    );
  }
}
