import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:mahasamund_tourism/Data/app_data.dart';
import 'package:mahasamund_tourism/Provider/music_player_provider.dart';
import 'package:mahasamund_tourism/Provider/player_position_provider.dart';
import 'package:mahasamund_tourism/Widgets/small_widgets.dart';
import 'package:provider/provider.dart';

import '../Theme/app_colors.dart';
import '../Theme/app_values.dart';

class PlayerWidget extends StatefulWidget {
  PlayerWidget({
    super.key,
    required this.controller,
    required this.index,
  });

  AnimationController controller;

  int index;

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  double? lerp(double min, double max) {
    return lerpDouble(min, max, widget.controller.value);
  }

  final FlipCardController _flipController = FlipCardController();

  @override
  void dispose() {
    _flipController.state!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (_flipController.state != null) {
      if (widget.controller.value == 0 &&
          _flipController.state!.isFront == false) {
        _flipController.toggleCard();
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(bSRadius),
          topLeft: Radius.circular(bSRadius),
        ),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/images/background.png",
          ),
        ),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child:
            Consumer<MusicPlayerProvider>(builder: (context, proPlayer, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: lerp(10, 20),
              ),
              bSHandleWidget(color: AppColors.secondary, height: lerp(0, 5)!),
              SizedBox(
                height: lerp(10, 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: SizedBox(
                        height: lerp(60, 350),
                        width: lerp(60, size.width),
                        child: FlipCard(
                          controller: _flipController,
                          front: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.bottomCenter,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: songList[widget.index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  bottom: 10,
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: lerp(0, 25)!,
                                          vertical: lerp(0, 2)!),
                                      decoration: BoxDecoration(
                                        color: AppColors.secondary,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "पढ़ें",
                                        style: appTextStyle(
                                            size: lerp(0, 16)!,
                                            weight: FontWeight.w600),
                                      )))
                            ],
                          ),
                          back: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Text(
                                songList[widget.index].desc,
                                style: appTextStyle(
                                  size: 18,
                                  weight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: lerp(1, 0)!,
                    child: SizedBox(
                      width: lerp(size.width - 190, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            songList[widget.index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: appTextStyle(
                                size: lerp(23, 0)!,
                                weight: FontWeight.w700,
                                color: AppColors.secondary),
                          ),
                          Text(
                            "अधिक जानकारी के लिए बटन दबाये",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: appTextStyle(
                                size: lerp(13, 0)!,
                                weight: FontWeight.w700,
                                color: AppColors.secondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: lerp(1, 0)!,
                    child: GestureDetector(
                      onTap: () {
                        proPlayer.playPauseAudio(index: widget.index);
                        proPlayer.setIsPlayingList(widget.index);
                      },
                      child: Container(
                        height: lerp(50, 0),
                        width: lerp(50, 0),
                        margin: EdgeInsets.only(
                            right: lerp(20, 0)!, left: lerp(20, 0)!),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.secondary, shape: BoxShape.circle),
                        child: Icon(
                          proPlayer.getIsPlayingList[widget.index] == true &&
                                  proPlayer.getIsAudioPlaying == true
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: AppColors.primary,
                          size: lerp(40, 0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Opacity(
                opacity: lerp(0, 1)!,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            songList[widget.index].title,
                            maxLines: 1,
                            style: appTextStyle(
                                size: 28,
                                weight: FontWeight.w700,
                                color: AppColors.secondary),
                          ),
                        ),
                      ),
                    ),
                    Consumer<PlayerPositionProvider>(
                      builder: (context, proPosition, child) {
                        return Column(
                          children: [
                            Slider(
                                activeColor: AppColors.secondary,
                                inactiveColor: AppColors.secondaryLight,
                                value: proPosition.getPosition.inSeconds
                                    .toDouble(),
                                min: 0,

                                /// One Add For Error Safety
                                max: (proPlayer.getDuration.inSeconds + 1)
                                    .toDouble(),
                                onChanged: (val) {
                                  proPosition.changeAudioPosition(val);

                                  print(
                                    "changed -->> " + val.toString(),
                                  );
                                }),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    format(proPosition.getPosition),
                                    style: appTextStyle(
                                        size: 16,
                                        weight: FontWeight.w600,
                                        color: AppColors.secondaryLight),
                                  ),
                                  Text(
                                    format(proPlayer.getDuration),
                                    style: appTextStyle(
                                        size: 16,
                                        weight: FontWeight.w600,
                                        color: AppColors.secondaryLight),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        IconButton(
                          onPressed: proPlayer.getCurPageIndex == 0
                              ? null
                              : () {
                                  proPlayer.getPageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeOut);
                                  proPlayer.playPreviousAudio();
                                },
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            size: 45,
                            color: proPlayer.getCurPageIndex == 0
                                ? AppColors.grey
                                : AppColors.secondaryLight,
                          ),
                        ),
                        const Spacer(),
                        Material(
                          elevation: 5,
                          shadowColor: AppColors.white,
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(50),
                          child: InkWell(
                            onTap: () {
                              proPlayer.playPauseAudio(index: widget.index);
                              proPlayer.setIsPlayingList(widget.index);
                            },
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Icon(
                                proPlayer.getIsPlayingList[widget.index] ==
                                            true &&
                                        proPlayer.getIsAudioPlaying == true
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                size: 50,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed:
                              proPlayer.getCurPageIndex == songList.length - 1
                                  ? null
                                  : () {
                                      proPlayer.getPageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 400),
                                          curve: Curves.easeOut);
                                      proPlayer.playNextAudio();
                                    },
                          icon: Icon(
                            Icons.skip_next_rounded,
                            size: 45,
                            color:
                                proPlayer.getCurPageIndex == songList.length - 1
                                    ? AppColors.grey
                                    : AppColors.secondaryLight,
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
}
