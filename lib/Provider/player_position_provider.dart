import 'package:flutter/material.dart';
import 'package:mahasamund_tourism/Provider/music_player_provider.dart';
import 'package:provider/provider.dart';

class PlayerPositionProvider extends ChangeNotifier {
  PlayerPositionProvider() {
    print("Position -->> Provider Stated");
    MusicPlayerProvider.audioPlayer.currentPosition.listen((pos) {
      print("Position -->> " + pos.inSeconds.toString());
      _position = pos;
      notifyListeners();
    });
  }

  Duration _position = const Duration();
  Duration get getPosition => _position;

  changeAudioPosition(double changeTo) async {
    _position = Duration(seconds: changeTo.toInt());
    notifyListeners();
    await MusicPlayerProvider.audioPlayer.seek(_position);
  }
}
