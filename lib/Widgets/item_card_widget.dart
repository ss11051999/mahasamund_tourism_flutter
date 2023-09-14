import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mahasamund_tourism/Bottom_Sheet/player_bottom_sheet.dart';
import 'package:mahasamund_tourism/Models/song_model.dart';
import 'package:mahasamund_tourism/Provider/music_player_provider.dart';
import 'package:mahasamund_tourism/Widgets/small_widgets.dart';
import 'package:provider/provider.dart';

import '../Theme/app_colors.dart';

class ItemCardWidget extends StatelessWidget {
  ItemCardWidget({super.key, required this.songDetails, required this.index});

  SongModel songDetails;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 2, color: AppColors.secondaryDark),
      ),
      child: Consumer<MusicPlayerProvider>(
        builder: (context, proPlayer, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: songDetails.image,
                      fit: BoxFit.cover,
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 45,
                      left: 10,
                      top: 12,
                      bottom: 2,
                    ),
                    child: Text(
                      songDetails.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: appTextStyle(size: 19, weight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                      bottom: 15,
                      top: 2,
                    ),
                    child: Text(
                      songDetails.desc,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: appTextStyle(
                          size: 12,
                          weight: FontWeight.w700,
                          color: AppColors.secondaryDark),
                    ),
                  )
                ],
              ),
              if (proPlayer.getIsPlayingList[index] == true)
                Positioned(
                  top: 0,
                  bottom: 80,
                  child: Lottie.asset(
                    "assets/anim/w64MSS0SVd.json",
                    animate: proPlayer.getIsAudioPlaying,
                    width: 110,
                    height: 80,
                  ),
                ),
              Positioned(
                right: -5,
                top: 100,
                child: MaterialButton(
                  onPressed: () {
                    proPlayer.playPauseAudio(index: index);

                    if (proPlayer.getIsPlayingList[index] == false) {
                      proPlayer.setIsPlayingList(index);
                      proPlayer.getPageController.jumpToPage(index);

                      if (PlayerBottomSheet.controller.value == 0) {
                        PlayerBottomSheet.controller.fling(velocity: 1);
                      }
                    }
                  },
                  color: AppColors.secondary,
                  shape: const CircleBorder(
                    side: BorderSide(width: 6, color: AppColors.primary),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Icon(
                    proPlayer.getIsPlayingList[index] == true &&
                            proPlayer.getIsAudioPlaying == true
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: AppColors.primary,
                    size: 45,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
