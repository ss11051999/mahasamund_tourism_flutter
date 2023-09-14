import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mahasamund_tourism/Actions/show_toast_msg.dart';
import 'package:mahasamund_tourism/Data/app_data.dart';
import 'package:mahasamund_tourism/Models/song_model.dart';

Future<void> fetchAudioData() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> audioDataSnap = await firestore
        .collection("Audio_Data")
        .orderBy("id", descending: false)
        .get();

    List<SongModel> audioDataList = [];

    for (QueryDocumentSnapshot snap in audioDataSnap.docs) {
      SongModel song = SongModel(
        image: snap.get("image"),
        song: snap.get("audio"),
        title: snap.get("title"),
        desc: snap.get("desc"),
      );
      audioDataList.add(song);
    }

    songList = audioDataList;
  } catch (e) {
    showToastMsg(msg: "ERROR : ${e.toString()}");
  }
}
