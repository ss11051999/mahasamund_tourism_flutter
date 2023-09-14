import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mahasamund_tourism/Actions/show_toast_msg.dart';

Future<bool> saveUserToFirebase(
    {required String name, required String phone}) async {
  try {
    Map<String, dynamic> userData = {
      "name": name,
      "phone": phone,
      "date": DateTime.now()
    };

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection("Users").add(userData);

    return true;
  } catch (e) {
    showToastMsg(msg: "ERROR : ${e.toString()}");
    return false;
  }
}
