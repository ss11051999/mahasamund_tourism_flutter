import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mahasamund_tourism/Data/app_data.dart';
import 'package:mahasamund_tourism/Provider/music_player_provider.dart';
import 'package:mahasamund_tourism/Widgets/player_widget.dart';
import 'package:provider/provider.dart';

class PlayerBottomSheet extends StatefulWidget {
  const PlayerBottomSheet({super.key});

  static late AnimationController controller;

  @override
  State<PlayerBottomSheet> createState() => _PlayerBottomSheetState();
}

class _PlayerBottomSheetState extends State<PlayerBottomSheet>
    with TickerProviderStateMixin {
  double get maxHeight => MediaQuery.of(context).size.height / 1.3;

  @override
  void initState() {
    PlayerBottomSheet.controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    super.initState();
  }

  @override
  void dispose() {
    PlayerBottomSheet.controller.dispose();
    super.dispose();
  }

  double? lerp(double min, double max) {
    return lerpDouble(min, max, PlayerBottomSheet.controller.value);
  }

  // void toggle() {
  //   final bool isCompleted = _controller.status == AnimationStatus.completed;
  //   _controller.fling(velocity: isCompleted ? -1 : 1);
  // }

  void verticalDragUpdate(DragUpdateDetails details) {
    PlayerBottomSheet.controller.value -= details.primaryDelta! / maxHeight;
  }

  void verticalDragEnd(DragEndDetails details) {
    if (PlayerBottomSheet.controller.isAnimating ||
        PlayerBottomSheet.controller.status == AnimationStatus.completed)
      return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;

    if (flingVelocity < 0) {
      PlayerBottomSheet.controller.fling(
        velocity: math.max(1, -flingVelocity),
      );
    } else if (flingVelocity > 0) {
      PlayerBottomSheet.controller.fling(
        velocity: math.min(-1, -flingVelocity),
      );
    } else {
      PlayerBottomSheet.controller
          .fling(velocity: PlayerBottomSheet.controller.value < 0.5 ? -1 : 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: PlayerBottomSheet.controller,
      builder: (context, child) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: lerp(100, maxHeight),
          child: GestureDetector(
            // onTap: toggle,
            onVerticalDragUpdate: verticalDragUpdate,
            onVerticalDragEnd: verticalDragEnd,
            child: PageView(
              controller:
                  Provider.of<MusicPlayerProvider>(context, listen: false)
                      .getPageController,
              onPageChanged: (index) {
                Provider.of<MusicPlayerProvider>(context, listen: false)
                    .setCurPageIndex = index;
                Provider.of<MusicPlayerProvider>(context, listen: false)
                    .setIsPlayingList(index);
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ...List.generate(
                  songList.length,
                  (index) {
                    return PlayerWidget(
                      controller: PlayerBottomSheet.controller,
                      index: index,
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
