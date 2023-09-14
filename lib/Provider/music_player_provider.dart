import 'dart:ffi';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:mahasamund_tourism/Data/app_data.dart';
import 'package:mahasamund_tourism/Models/song_model.dart';

class MusicPlayerProvider extends ChangeNotifier {
  MusicPlayerProvider() {
    for (SongModel song in songList) {
      songUrlList.add(Audio.network(song.song));
    }

    audioPlayer.onReadyToPlay.listen((dur) {
      if (dur != null) {
        _duration = dur.duration;
      }
    });

    // audioPlayer.currentPosition.listen((pos) {
    //   _position = pos;
    //
    //   notifyListeners();
    // });

    audioPlayer.isBuffering.listen((buffering) {
      // print("Playing -->> buffering " + buffering.toString());
      _isBuffering = buffering;
      notifyListeners();
    });

    audioPlayer.isPlaying.listen((playing) {
      // print("Playing -->> playing " + playing.toString());
      _isAudioPlaying = playing;
      notifyListeners();
    });

    audioPlayer.playlistAudioFinished.listen((finish) {
      if (finish.index != songList.length) {
        _pageController.jumpToPage(finish.index + 1);
        setIsPlayingList(finish.index + 1);
        notifyListeners();
      }
    });
  }

  final PageController _pageController = PageController(initialPage: 0);
  PageController get getPageController => _pageController;

  Duration _duration = const Duration();
  Duration get getDuration => _duration;
  // Duration _position = const Duration();
  // Duration get getPosition => _position;

  bool _isBuffering = false;
  bool get getIsBuffering => _isBuffering;

  bool _isAudioPlaying = false;
  bool get getIsAudioPlaying => _isAudioPlaying;

  int _curPageIndex = 0;
  int get getCurPageIndex => _curPageIndex;
  set setCurPageIndex(int index) {
    _curPageIndex = index;
    notifyListeners();
  }

  final List<bool> _isPlayingList = List.filled(songList.length, false);
  List<bool> get getIsPlayingList => _isPlayingList;
  setIsPlayingList(int index) {
    print("Initial page -->>> " + index.toString());
    for (int i = 0; i < _isPlayingList.length; i++) {
      if (i == index) {
        _isPlayingList[index] = true;
      } else {
        _isPlayingList[i] = false;
      }
    }
    notifyListeners();
  }

  List<Audio> songUrlList = [];

  static final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  AssetsAudioPlayer get getAudioPlayer => audioPlayer;

  playPauseAudio({required int index}) async {
    if (_isAudioPlaying == false &&
        _isBuffering == false &&
        _isPlayingList[index] == false) {
      /// may be this line is in constructor
      await audioPlayer.open(
        Playlist(audios: songUrlList),
      );
      audioPlayer.playlistPlayAtIndex(index);
    } else if (_isAudioPlaying == false &&
        _isBuffering == true &&
        _isPlayingList[index] == true) {
      ///
      ///
      /// Nothing Happen
    } else if (_isAudioPlaying == true &&
        _isBuffering == false &&
        _isPlayingList[index] == true) {
      audioPlayer.pause();
    } else if (_isAudioPlaying == false &&
        _isBuffering == false &&
        _isPlayingList[index] == true) {
      audioPlayer.play();
    } else if (_isAudioPlaying == true &&
        _isBuffering == false &&
        _isPlayingList[index] == false) {
      audioPlayer.playlistPlayAtIndex(index);
    } else if (_isAudioPlaying == false &&
        _isBuffering == true &&
        _isPlayingList[index] == false) {
      audioPlayer.playlistPlayAtIndex(index);
    }
  }

  // changeAudioPosition(double changeTo) async {
  //   _position = Duration(seconds: changeTo.toInt());
  //   notifyListeners();
  //   await audioPlayer.seek(_position);
  // }

  playNextAudio() {
    audioPlayer.next();
  }

  playPreviousAudio() {
    audioPlayer.previous();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
