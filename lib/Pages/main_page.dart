import 'package:flutter/material.dart';
import 'package:mahasamund_tourism/Actions/show_exit_toast.dart';
import 'package:mahasamund_tourism/Bottom_Sheet/player_bottom_sheet.dart';
import 'package:mahasamund_tourism/Data/app_data.dart';
import 'package:mahasamund_tourism/Provider/music_player_provider.dart';
import 'package:mahasamund_tourism/Theme/app_colors.dart';
import 'package:mahasamund_tourism/Theme/app_values.dart';
import 'package:mahasamund_tourism/Widgets/item_card_widget.dart';
import 'package:mahasamund_tourism/Widgets/small_widgets.dart';
import 'package:provider/provider.dart';

import '../Actions/show_toast_msg.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (PlayerBottomSheet.controller.value == 1) {
          PlayerBottomSheet.controller.fling(velocity: -1);
          return false;
        }

        return showExitToast();
      },
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/background_light.png"),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(bSRadius),
                        bottomLeft: Radius.circular(bSRadius),
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/images/app_logo.png",
                              scale: 3,
                            ),
                            Image.asset(
                              "assets/images/cg_logo.png",
                              scale: 3,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "यहाँ कुछ ख़ास है",
                              style: appTextStyle(
                                  size: 20,
                                  weight: FontWeight.w700,
                                  color: AppColors.primary),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "महासमुंद के प्रमुख जगह चुने",
                              style: appTextStyle(
                                  size: 20,
                                  weight: FontWeight.w700,
                                  color: AppColors.primary),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ...List.generate(
                              (songList.length / 2).round(),
                              (i) {
                                int index = i * 2;

                                int fIndex = index == 0 ? 0 : index;
                                int sIndex = index == 0 ? 1 : index + 1;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: ItemCardWidget(
                                          songDetails: songList[fIndex],
                                          index: fIndex,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Flexible(
                                        child: ItemCardWidget(
                                          songDetails: songList[sIndex],
                                          index: sIndex,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 150,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const PlayerBottomSheet()
          ],
        ),
      ),
    );
  }
}
