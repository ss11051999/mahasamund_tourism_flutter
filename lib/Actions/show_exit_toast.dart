import 'package:mahasamund_tourism/Actions/show_toast_msg.dart';

int _counter = 0;

Future<bool> showExitToast() async {
  if (_counter == 1) {
    return true; // Allow app exit
  } else {
    _counter++;
    showToastMsg(msg: "Press back again to exit");
    Future.delayed(const Duration(seconds: 2), () {
      _counter = 0;
    });
    return false; // Prevent app exit
  }
}
